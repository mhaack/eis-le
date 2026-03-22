import { createClient } from '@supabase/supabase-js';

const supabaseUrl = import.meta.env.SUPABASE_URL;
const supabaseAnonKey = import.meta.env.SUPABASE_ANON_KEY;
const googleApiKey = import.meta.env.GOOGLE_PLACES_API_KEY;

if (!supabaseUrl || !supabaseAnonKey) {
  throw new Error('Missing SUPABASE_URL or SUPABASE_ANON_KEY environment variables');
}

const supabase = createClient(supabaseUrl, supabaseAnonKey);

const PLACEHOLDER_IMG = 'https://images.unsplash.com/photo-1501443762994-82bd5dace89a?w=600&h=400&fit=crop';

/**
 * Converts a Google Places photo resource name to a usable image URL.
 * At build time, resolves the redirect to get a stable CDN URL.
 * Falls back to the API URL (with key) or a placeholder.
 */
async function resolvePhotoUrl(resourceName: string, maxHeight = 600): Promise<string> {
  if (!googleApiKey) return PLACEHOLDER_IMG;

  const apiUrl = `https://places.googleapis.com/v1/${resourceName}/media?maxHeightPx=${maxHeight}&key=${googleApiKey}`;

  try {
    const res = await fetch(apiUrl, { redirect: 'manual' });
    const location = res.headers.get('location');
    if (location) return location;
    // If no redirect, the response itself may be the image (unlikely)
    return apiUrl;
  } catch {
    return apiUrl;
  }
}

/**
 * Resolves all photo resource names for a shop into usable URLs.
 */
export async function resolveShopPhotos(photos: string[] | null): Promise<string[]> {
  if (!photos || photos.length === 0) return [PLACEHOLDER_IMG];

  const resolved = await Promise.all(
    photos.map(name =>
      name.startsWith('http') ? Promise.resolve(name) : resolvePhotoUrl(name)
    )
  );

  return resolved.length > 0 ? resolved : [PLACEHOLDER_IMG];
}

/**
 * Resolves the first photo URL for each shop in a list (for card grids).
 * Returns a Map of shop.id → photo URL.
 */
export async function resolveShopPhotoMap(shops: Shop[]): Promise<Map<string, string>> {
  const entries = await Promise.all(
    shops.map(async (shop) => {
      const firstPhoto = shop.photos?.[0];
      if (!firstPhoto) return [shop.id, PLACEHOLDER_IMG] as const;
      const url = firstPhoto.startsWith('http') ? firstPhoto : await resolvePhotoUrl(firstPhoto);
      return [shop.id, url] as const;
    })
  );
  return new Map(entries);
}

export interface Shop {
  id: string;
  google_place_id: string;
  name: string;
  slug: string;
  address: string;
  city: string;
  latitude: number;
  longitude: number;
  phone: string;
  website: string;
  google_maps_url: string;
  google_rating: number;
  google_review_count: number;
  price_level: number | null;
  opening_hours: Record<string, unknown>[] | null;
  photos: string[] | null;
  child_friendly: boolean;
  wait_time_typical: 'kurz' | 'mittel' | 'lang' | null;
  has_indoor_seating: boolean;
  has_outdoor_seating: boolean;
  ice_cream_type: string;
  is_handmade: boolean;
  flavor_list: { name: string; tag?: 'vegan' | 'signatur' | 'saisonal' | 'alkohol' | 'bio' | 'exotisch' | 'softeis' | 'sorbet' }[] | null;
  has_waffle_cones: boolean;
  has_sundaes: boolean;
  has_pastry: boolean;
  price_per_scoop: string;
  has_vegan_options: boolean;
  fully_vegan: boolean;
  has_lactose_free: boolean;
  has_gluten_free: boolean;
  is_organic: boolean;
  atmosphere_tags: string[];
  open_after_8pm: boolean;
  has_coffee: boolean;
  has_car_parking: boolean;
  has_bike_parking: boolean;
  near_public_transport: boolean;
  neighborhood_id: string | null;
  neighborhood: { id: string; name: string; slug: string; description: string | null } | null;
  near_park: string;
  near_water: string;
  near_playground: string;
  location_description: string;
  lvz_rank: number | null;
  lvz_year: number | null;
  our_rating: number | null;
  our_review: string;
  highlights: { icon: string; title: string; text: string }[] | null;
  specialty: string;
  payment_methods: string[];
  listing_status: 'published' | 'draft' | 'archived';
}

// Base query: only published shops, sorted by LVZ rank first, then rating
async function fetchShops(filters?: (query: ReturnType<ReturnType<typeof supabase.from>['select']>) => typeof query): Promise<Shop[]> {
  let query = supabase
    .from('shops')
    .select('*, neighborhood:neighborhoods(*)')
    .eq('listing_status', 'published')
    .order('lvz_rank', { ascending: true, nullsFirst: false })
    .order('google_rating', { ascending: false });

  if (filters) {
    query = filters(query);
  }

  const { data, error } = await query;

  if (error) {
    console.error('Supabase query error:', error.message);
    return [];
  }

  return (data ?? []) as Shop[];
}

export async function getAllShops(): Promise<Shop[]> {
  return fetchShops();
}

export async function getShopBySlug(slug: string): Promise<Shop | undefined> {
  const { data, error } = await supabase
    .from('shops')
    .select('*, neighborhood:neighborhoods(*)')
    .eq('slug', slug)
    .eq('listing_status', 'published')
    .single();

  if (error || !data) return undefined;
  return data as Shop;
}

export async function getShopsByNeighborhood(neighborhoodSlug: string): Promise<Shop[]> {
  const { data: nbh } = await supabase
    .from('neighborhoods')
    .select('id')
    .eq('slug', neighborhoodSlug)
    .single();

  if (!nbh) return [];
  return fetchShops((q) => q.eq('neighborhood_id', nbh.id));
}

export async function getVeganShops(): Promise<Shop[]> {
  return fetchShops((q) => q.eq('has_vegan_options', true));
}

export async function getKidFriendlyShops(): Promise<Shop[]> {
  return fetchShops((q) => q.eq('child_friendly', true));
}

export async function getDateNightShops(): Promise<Shop[]> {
  return fetchShops((q) => q.eq('open_after_8pm', true));
}

export async function getBikeFriendlyShops(): Promise<Shop[]> {
  return fetchShops((q) => q.eq('has_bike_parking', true));
}

export async function getLVZShops(): Promise<Shop[]> {
  const { data, error } = await supabase
    .from('shops')
    .select('*, neighborhood:neighborhoods(*)')
    .eq('listing_status', 'published')
    .not('lvz_rank', 'is', null)
    .order('lvz_rank', { ascending: true });

  if (error) {
    console.error('Supabase query error:', error.message);
    return [];
  }

  return (data ?? []) as Shop[];
}

export interface Neighborhood {
  name: string;
  slug: string;
  latitude: number | null;
  longitude: number | null;
  count: number;
}

export async function getNeighborhoods(): Promise<Neighborhood[]> {
  const { data: neighborhoods, error } = await supabase
    .from('neighborhoods')
    .select('name, slug, latitude, longitude')
    .order('name');

  if (error || !neighborhoods) return [];

  const shops = await getAllShops();
  const counts = new Map<string, number>();
  for (const shop of shops) {
    const slug = shop.neighborhood?.slug;
    if (slug) counts.set(slug, (counts.get(slug) ?? 0) + 1);
  }

  return neighborhoods
    .map(n => ({ name: n.name, slug: n.slug, latitude: n.latitude, longitude: n.longitude, count: counts.get(n.slug) ?? 0 }))
    .filter(n => n.count > 0)
    .sort((a, b) => a.name.localeCompare(b.name, 'de'));
}

// --- Opening hours helpers ---

interface Period {
  open: { day: number; hour: number; minute?: number };
  close?: { day: number; hour: number; minute?: number };
}

const DAY_NAMES = ['So', 'Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa'];

function pad(n: number): string {
  return String(n).padStart(2, '0');
}

function formatTime(t: { hour: number; minute?: number }): string {
  return `${pad(t.hour)}:${pad(t.minute ?? 0)}`;
}

/**
 * Converts Google Places API periods array into grouped day/time strings.
 * e.g. [["Mo–Fr", "12:00–20:00"], ["Sa–So", "11:00–21:00"]]
 */
export function formatOpeningHours(periods: unknown): [string, string][] {
  if (!Array.isArray(periods) || periods.length === 0) return [];

  // Build per-day time strings
  const dayTimes: (string | null)[] = Array(7).fill(null);

  for (const p of periods as Period[]) {
    const dayIdx = p.open.day;
    const timeStr = p.close
      ? `${formatTime(p.open)}–${formatTime(p.close)}`
      : '24 Stunden';

    // Multiple periods per day: append
    if (dayTimes[dayIdx]) {
      dayTimes[dayIdx] += `, ${timeStr}`;
    } else {
      dayTimes[dayIdx] = timeStr;
    }
  }

  // Group consecutive days with the same hours
  // Reorder to start from Monday (1) through Sunday (0)
  const orderedDays = [1, 2, 3, 4, 5, 6, 0];
  const result: [string, string][] = [];
  let groupStart = -1;
  let groupEnd = -1;
  let groupTime = '';

  for (let i = 0; i < orderedDays.length; i++) {
    const dayIdx = orderedDays[i];
    const time = dayTimes[dayIdx];

    if (time === groupTime && groupStart !== -1) {
      groupEnd = dayIdx;
    } else {
      // Flush previous group
      if (groupStart !== -1) {
        const label = groupStart === groupEnd
          ? DAY_NAMES[groupStart]
          : `${DAY_NAMES[groupStart]}–${DAY_NAMES[groupEnd]}`;
        result.push([label, groupTime || 'Geschlossen']);
      }
      groupStart = dayIdx;
      groupEnd = dayIdx;
      groupTime = time ?? '';
    }
  }

  // Flush last group
  if (groupStart !== -1) {
    const label = groupStart === groupEnd
      ? DAY_NAMES[groupStart]
      : `${DAY_NAMES[groupStart]}–${DAY_NAMES[groupEnd]}`;
    result.push([label, groupTime || 'Geschlossen']);
  }

  // Add closed days if any are missing
  const coveredDays = new Set((periods as Period[]).map(p => p.open.day));
  const closedDays = orderedDays.filter(d => !coveredDays.has(d));
  if (closedDays.length > 0 && closedDays.length < 7) {
    // Group closed days too
    let cStart = closedDays[0];
    let cEnd = closedDays[0];
    for (let i = 1; i < closedDays.length; i++) {
      const prevIdx = orderedDays.indexOf(closedDays[i - 1]);
      const curIdx = orderedDays.indexOf(closedDays[i]);
      if (curIdx === prevIdx + 1) {
        cEnd = closedDays[i];
      } else {
        const label = cStart === cEnd ? DAY_NAMES[cStart] : `${DAY_NAMES[cStart]}–${DAY_NAMES[cEnd]}`;
        // Only add if not already covered in result
        if (!result.some(([l]) => l === label)) {
          result.push([label, 'Geschlossen']);
        }
        cStart = closedDays[i];
        cEnd = closedDays[i];
      }
    }
    const label = cStart === cEnd ? DAY_NAMES[cStart] : `${DAY_NAMES[cStart]}–${DAY_NAMES[cEnd]}`;
    if (!result.some(([l]) => l === label)) {
      result.push([label, 'Geschlossen']);
    }
  }

  return result;
}

/**
 * Checks if a shop is currently open based on its periods.
 * Uses Europe/Berlin timezone.
 */
export function isShopOpen(periods: unknown): boolean | null {
  if (!Array.isArray(periods) || periods.length === 0) return null;

  const now = new Date();
  const berlinTime = new Date(now.toLocaleString('en-US', { timeZone: 'Europe/Berlin' }));
  const currentDay = berlinTime.getDay(); // 0=Sun
  const currentMinutes = berlinTime.getHours() * 60 + berlinTime.getMinutes();

  for (const p of periods as Period[]) {
    const openDay = p.open.day;
    const openMinutes = p.open.hour * 60 + (p.open.minute ?? 0);

    if (!p.close) {
      // 24h open — check if this is the right day
      if (openDay === currentDay) return true;
      continue;
    }

    const closeDay = p.close.day;
    const closeMinutes = p.close.hour * 60 + (p.close.minute ?? 0);

    if (openDay === closeDay) {
      // Same day
      if (currentDay === openDay && currentMinutes >= openMinutes && currentMinutes < closeMinutes) {
        return true;
      }
    } else {
      // Wraps past midnight (e.g. open Fri 18:00, close Sat 02:00)
      if (currentDay === openDay && currentMinutes >= openMinutes) return true;
      if (currentDay === closeDay && currentMinutes < closeMinutes) return true;
    }
  }

  return false;
}

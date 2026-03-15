const API_KEY = process.env.GOOGLE_PLACES_API_KEY;
const BASE_URL = 'https://places.googleapis.com/v1/places';

if (!API_KEY) {
  throw new Error('Missing GOOGLE_PLACES_API_KEY');
}

const SEARCH_FIELD_MASK = [
  'places.id',
  'places.displayName',
  'places.formattedAddress',
].join(',');

const DETAILS_FIELD_MASK = [
  'id',
  'displayName',
  'formattedAddress',
  'location',
  'nationalPhoneNumber',
  'websiteUri',
  'googleMapsUri',
  'rating',
  'userRatingCount',
  'priceLevel',
  'regularOpeningHours',
  'photos',
  'reviews',
  'businessStatus',
  // Amenities
  'outdoorSeating',
  'restroom',
  'reservable',
  'liveMusic',
  // Offerings
  'servesCoffee',
  'servesDessert',
  'servesVegetarianFood',
  'takeout',
  'delivery',
  'dineIn',
  // Crowd & suitability
  'goodForChildren',
  'goodForGroups',
  'allowsDogs',
  // Parking
  'parkingOptions',
  // Payment
  'paymentOptions',
  // Accessibility
  'accessibilityOptions',
].join(',');

const PRICE_LEVEL_MAP = {
  PRICE_LEVEL_FREE: 0,
  PRICE_LEVEL_INEXPENSIVE: 1,
  PRICE_LEVEL_MODERATE: 2,
  PRICE_LEVEL_EXPENSIVE: 3,
  PRICE_LEVEL_VERY_EXPENSIVE: 4,
};

export async function textSearch(query) {
  const res = await fetch(`${BASE_URL}:searchText`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'X-Goog-Api-Key': API_KEY,
      'X-Goog-FieldMask': SEARCH_FIELD_MASK,
    },
    body: JSON.stringify({ textQuery: query }),
  });

  const data = await res.json();

  if (!res.ok) {
    throw new Error(`Places text search failed: ${data.error?.message ?? res.status}`);
  }

  return (data.places ?? []).map((p) => ({
    place_id: p.id,
    name: p.displayName?.text ?? '',
  }));
}

export async function placeDetails(placeId) {
  const res = await fetch(`${BASE_URL}/${placeId}`, {
    headers: {
      'X-Goog-Api-Key': API_KEY,
      'X-Goog-FieldMask': DETAILS_FIELD_MASK,
      'Accept-Language': 'de',
    },
  });

  const data = await res.json();

  if (!res.ok) {
    throw new Error(`Place details failed for ${placeId}: ${data.error?.message ?? res.status}`);
  }

  // Normalize price level from enum string to integer
  if (data.priceLevel) {
    data.priceLevel = PRICE_LEVEL_MAP[data.priceLevel] ?? null;
  }

  return data;
}

export function generateSlug(name) {
  return name
    .toLowerCase()
    .replace(/ä/g, 'ae')
    .replace(/ö/g, 'oe')
    .replace(/ü/g, 'ue')
    .replace(/ß/g, 'ss')
    .replace(/é/g, 'e')
    .replace(/è/g, 'e')
    .replace(/\s+/g, '-')
    .replace(/[^a-z0-9-]/g, '')
    .replace(/-+/g, '-')
    .replace(/^-|-$/g, '');
}

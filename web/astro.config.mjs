// @ts-check
import { defineConfig, passthroughImageService } from 'astro/config';
import tailwindcss from '@tailwindcss/vite';
import alpinejs from '@astrojs/alpinejs';
import cloudflare from '@astrojs/cloudflare';
import sitemap from '@astrojs/sitemap';
import { createClient } from '@supabase/supabase-js';
import { loadEnv } from 'vite';

const { SUPABASE_URL, SUPABASE_ANON_KEY } = loadEnv('', process.cwd(), '');

// Build a URL → lastmod map at build time from live DB data.
// Shops use data_changed_at; neighborhoods use updated_at (trigger-maintained).
const sitemapDates = await (async () => {
  if (!SUPABASE_URL || !SUPABASE_ANON_KEY) return /** @type {Map<string, Date>} */ (new Map());

  const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

  const [{ data: shops }, { data: neighborhoods }] = await Promise.all([
    supabase
      .from('shops')
      .select('slug, data_changed_at, has_vegan_options, child_friendly, open_after_8pm, has_bike_parking, lvz_rank')
      .eq('listing_status', 'published'),
    supabase
      .from('neighborhoods')
      .select('slug, updated_at'),
  ]);

  /** @param {Array<{data_changed_at?: string|null, updated_at?: string|null}>} rows */
  const maxDate = (rows) => {
    const dates = rows
      .map(r => r.data_changed_at ?? r.updated_at)
      .filter(Boolean)
      .map(d => new Date(/** @type {string} */ (d)).getTime());
    return dates.length ? new Date(Math.max(...dates)) : null;
  };

  const allShops = shops ?? [];
  const allNbh = neighborhoods ?? [];
  const globalMax = maxDate(allShops);

  /** @type {Map<string, Date>} */
  const map = new Map();

  if (globalMax) {
    map.set('https://eis-le.de/', globalMax);
    map.set('https://eis-le.de/karte', globalMax);
  }

  // Filtered pages: use max of their specific subset
  /** @type {[string, (s: typeof allShops[number]) => boolean][]} */
  const filteredPages = [
    ['https://eis-le.de/veganes-eis',       s => !!s.has_vegan_options],
    ['https://eis-le.de/eis-mit-kindern',   s => !!s.child_friendly],
    ['https://eis-le.de/date-night-eis',    s => !!s.open_after_8pm],
    ['https://eis-le.de/eis-fuer-radfahrer', s => !!s.has_bike_parking],
    ['https://eis-le.de/beste-eisdielen-lvz', s => s.lvz_rank != null],
  ];
  for (const [url, predicate] of filteredPages) {
    const d = maxDate(allShops.filter(predicate));
    if (d) map.set(url, d);
  }

  // Shop detail pages
  for (const shop of allShops) {
    if (shop.slug && shop.data_changed_at) {
      map.set(`https://eis-le.de/${shop.slug}`, new Date(shop.data_changed_at));
    }
  }

  // Neighborhood index + detail pages
  const nbhMax = maxDate(allNbh);
  if (nbhMax) map.set('https://eis-le.de/stadtteile', nbhMax);
  for (const n of allNbh) {
    if (n.slug && n.updated_at) {
      map.set(`https://eis-le.de/stadtteil/${n.slug}`, new Date(n.updated_at));
    }
  }

  return map;
})();

const SITEMAP_EXCLUDE = new Set([
  'https://eis-le.de/datenschutz',
  'https://eis-le.de/impressum',
]);

// Strip any leading dots from generated Rollup chunk filenames. lucide-astro
// ships an internal template file at dist/.Layout.astro (leading dot, chosen
// to avoid colliding with its `Layout` icon). When Rollup splits it into its
// own chunk, the dot is preserved and the file is emitted as a hidden .mjs,
// which the @astrojs/cloudflare prerender worker (miniflare/workerd) cannot
// resolve, failing the build with "No such module ... .Layout_*.mjs".
const stripLeadingDot = (chunkInfo) => {
  const name = (chunkInfo.name ?? 'chunk').replace(/^\.+/, '_');
  return `chunks/${name}_[hash].mjs`;
};

// https://astro.build/config
export default defineConfig({
  site: 'https://eis-le.de',
  trailingSlash: 'never',
  output: 'static',
  adapter: cloudflare(),
  vite: {
    plugins: [tailwindcss()],
    build: {
      rollupOptions: {
        output: {
          chunkFileNames: stripLeadingDot,
        },
      },
    },
  },
  integrations: [
    alpinejs(),
    sitemap({
      filter: (page) => !SITEMAP_EXCLUDE.has(page),
      serialize: (item) => ({ ...item, lastmod: sitemapDates.get(item.url) }),
    }),
  ],
  image: {
    service: passthroughImageService(),
  },
});
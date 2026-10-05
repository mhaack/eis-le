/**
 * Central site configuration.
 *
 * The canonical base URL is defined once in `astro.config.mjs` (`site`) and
 * surfaced here via `import.meta.env.SITE`, so both `.astro` pages and plain
 * `.ts` modules share a single source of truth. Change the domain in
 * astro.config.mjs — never hard-code it in a page.
 */
export const SITE_URL = (import.meta.env.SITE ?? 'https://eis-le.de').replace(/\/+$/, '');

/**
 * Neighborhood pages with fewer published shops than this are thin (intro + one
 * card) and get `noindex` + are left out of the sitemap. Mirrored in
 * astro.config.mjs (SITEMAP_MIN_NBH_SHOPS) — keep both in sync.
 */
export const MIN_SHOPS_TO_INDEX_NEIGHBORHOOD = 2;

/**
 * Absolute canonical URL for a site-relative path.
 *   pageUrl()            -> "https://eis-le.de/"
 *   pageUrl('/karte')    -> "https://eis-le.de/karte"
 *   pageUrl('/karte/')   -> "https://eis-le.de/karte"   (trailingSlash: 'never')
 */
export function pageUrl(path: string = '/'): string {
  const p = String(path);
  if (p === '' || p === '/') return `${SITE_URL}/`;
  return `${SITE_URL}/${p.replace(/^\/+/, '').replace(/\/+$/, '')}`;
}

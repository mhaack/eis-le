# CLAUDE.md — web/ (Astro frontend)

## Site URL lives in one place (web/src/lib/site.ts)

The canonical base URL is defined once in `web/astro.config.mjs` (`site: 'https://eis-le.de'`) and surfaced via `web/src/lib/site.ts`:

- `SITE_URL` — the base, read from `import.meta.env.SITE`.
- `pageUrl(path)` — absolute canonical URL for a site-relative path, honoring `trailingSlash: 'never'`. Use it for every `canonical`, `og:url`, and JSON-LD `url`. Never hard-code `https://eis-le.de` in a page.

## BaseLayout always emits canonical + Open Graph tags

`web/src/layouts/BaseLayout.astro` renders `<link rel="canonical">`, `og:url`, `og:image`, and `twitter:image` on **every** page. Pages pass optional `canonical` and `image` props to override; otherwise they default to the current page URL (`pageUrl(Astro.url.pathname)`) and the brand image (`/android-chrome-512x512.png`). Curated-list pages pass a representative shop photo as `image`.

## Meta descriptions are length-capped, not raw specialty

Shop detail pages (`[slug].astro`) feed `truncateMeta(shop.specialty)` into the `description` prop — `specialty` is editorial prose (often 200–450 chars) and would otherwise blow past the ~160-char SERP limit. `truncateMeta` (in `web/src/lib/data.ts`) clamps to ~155 chars on a word boundary; the full `specialty` is still shown on-page. Static pages set their own unique `description` so no two pages share one.

---


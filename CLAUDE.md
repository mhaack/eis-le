# CLAUDE.md — eis-le.de

## Project purpose

**eis-le.de** — a Leipzig ice cream shop directory. The pipeline seeds a Supabase `shops` table from Google Places API (New), enriches records using Claude, and runs weekly via GitHub Actions.

---

## Data model overview

Two tables: `shops` and `neighborhoods`. Shops reference neighborhoods via `neighborhood_id` FK.

`neighborhoods` is **manual-only** — not written by any script (schema: `sql/20260321000001_neighborhoods.sql`).

For `shops`, the Google-sourced columns and their API field mapping live in `mapPlaceToShop` (`scripts/utils/change-detection.js`) — read that function, don't trust a copy. The Claude-enrichment columns are defined by the prompt schema in `scripts/enrich-with-claude.js`. The columns below are the ones **no script writes**:

### Manual-only columns

| Column | Notes |
|---|---|
| `neighborhood_id` | FK to `neighborhoods.id` — set manually |
| `has_indoor_seating` | Claude may fill this, but editorial can override |
| `slug` | Set on import via `generateSlug()`; never overwritten by weekly update |
| `listing_status` | Set to `draft` on import; manually promoted to `published` |
| `lvz_rank`, `lvz_year` | LVZ newspaper rankings — manual |
| `our_rating`, `our_review` | Editorial ratings — manual |
| `highlights` | JSONB editorial highlights — manual. Each entry: `{ icon, title, text }`. Supported icons: `star`, `award`, `truck`, `refresh-cw`, `heart`, `leaf`, `sparkles`, `coffee`, `map-pin`, `clock`, `gift`, `smile`, `thumbs-up`, `zap`, `sun`, `snowflake`, `music`, `camera`, `dog`, `popsicle`, `dessert`, `cup-soda`, `vegan`, `circle-parking`, `utensils`, `cake`, `cake-slice`, `chef-hat`, `ice-cream-bowl`, `ice-cream-cone`. Unknown strings render as emoji fallback. |
| `flavor_list` | JSONB flavor list with tags (signatur, vegan, saisonal, alkohol, bio, exotisch, softeis, sorbet) — manual |
| `last_visited_at` | Manual |
| `price_per_scoop` | Manual |
| `wait_time_typical` | Manual (kurz / mittel / lang) |
| `city` | Defaults to 'Leipzig'; not returned by `mapPlaceToShop` |

---

## Key design decisions

### Uses Places API (New), not the old API

All HTTP calls go to `https://places.googleapis.com/v1/places`. Field masks are passed via the `X-Goog-FieldMask` header, not query params. The old `maps.googleapis.com/maps/api/place` endpoints are not used anywhere. Do not introduce them.

### open_after_8pm is calculated, not AI-generated

`calcOpenAfter8pm(periods)` in `change-detection.js` inspects `regularOpeningHours.periods` from the API. Each period uses integer `hour`/`minute` fields (not HHMM strings). A missing `close` object means 24-hour operation. This field is computed inside `mapPlaceToShop` and refreshed on every weekly update.

### atmosphere_tags: Google booleans merged with Claude vibe tags

`mapAtmosphereTags(details)` in `change-detection.js` produces Google-sourced tags: `live-music`, `good-for-groups`. Claude's enrichment produces subjective vibe tags from the allowed set: `casual`, `cozy`, `quiet`, `trendy`, `lively`, `romantic`, `modern`, `traditional`, `upscale`, `rustic` (max 3). In `enrich-with-claude.js` the two arrays are merged with `[...new Set([...googleAtmosphereTags, ...vibeTags])]` before being written to the database.

### child_friendly comes from goodForChildren

Mapped directly in `mapPlaceToShop`: `child_friendly: details.goodForChildren ?? null`. Not inferred by Claude.

### listing_status = 'ignored' skips a shop from everything

Both `initial-import.js` and `weekly-update.js` filter out `listing_status IN ('archived', 'ignored')`. The initial import additionally loads all ignored place IDs upfront so they are never re-inserted. Set a shop to `ignored` when it is a false positive (e.g. a supermarket ice cream counter) that keeps appearing in search results.

### enrich-with-claude.js --all re-processes every shop

Default mode: `WHERE specialty IS NULL AND listing_status NOT IN ('archived', 'ignored')`. With `--all`: removes the `specialty IS NULL` filter, re-running Claude on everything. Use `--all` sparingly — it costs API credits.

### weekly-update.js uses mapPlaceToShop for all field derivation

`mapPlaceToShop` is the single source of truth for mapping Google API fields to DB columns. It auto-calculates `open_after_8pm`, derives `payment_methods`, derives `has_car_parking`, etc. Changes to how Google data maps to DB columns should be made here, not in the individual scripts.

---

## Running the scripts

`package.json` defines `import`, `enrich`, `update`, `update:search-new` and `alerts`. Not covered there:

- `node scripts/enrich-with-claude.js --all` — re-enrich every shop (costs API credits)
- `node admin/server.js` — local admin UI

All scripts need environment variables from `.env`. Load them with `dotenv` or export them manually before running.

---

## What NOT to do

- **Do not add `editorialSummary` back to the Places API field mask.** It was removed intentionally — the field is unreliable and polluted Claude's enrichment prompts.
- **Do not use the old Places API** (`maps.googleapis.com/maps/api/place`). The codebase is fully on Places API (New).
- **Do not overwrite `slug` in the weekly update.** `mapPlaceToShop` only sets `slug` when a `slug` option is passed explicitly (only done at import time). Weekly updates intentionally omit it.
- **Do not hard-code `https://eis-le.de` in the frontend.** Use `pageUrl()` / `SITE_URL` from `web/src/lib/site.ts` so the domain stays in one place (`astro.config.mjs`).

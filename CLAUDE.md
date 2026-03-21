# CLAUDE.md — eisleipzig.de

## Project purpose

**eisleipzig.de** — a Leipzig ice cream shop directory. The repo contains:

- **`web/`** — Astro SSG frontend, deployed as a Cloudflare Worker
- **`scripts/`** — Data pipeline (seed, enrich, weekly update) run as one-offs or by CI
- **`admin/`** — Local admin UI (plain HTML + Alpine.js) with a Node proxy server for Supabase
- **`sql/`** — Database migrations

The pipeline seeds a Supabase `shops` table from Google Places API (New), enriches records using Claude, and runs weekly via GitHub Actions.

---

## Data model overview

Two tables: `shops` and `neighborhoods`. Shops reference neighborhoods via `neighborhood_id` FK.

### `neighborhoods` table (manual-only)

| Column | Notes |
|---|---|
| `id` | uuid PK |
| `name` | e.g. "Connewitz" (unique) |
| `slug` | e.g. "connewitz" (unique) |
| `description` | Optional editorial blurb |
| `latitude`, `longitude` | Center point for map views |

Neighborhoods are managed manually — not written by any script.

### `shops` table

Key column groups:

### From Google Places API (auto-updated weekly)

| Column | Notes |
|---|---|
| `google_place_id` | Unique key for deduplication (`onConflict`) |
| `name` | `displayName.text` |
| `address` | `formattedAddress` |
| `latitude`, `longitude` | `location.latitude/longitude` |
| `phone` | `nationalPhoneNumber` |
| `website` | `websiteUri` |
| `google_maps_url` | `googleMapsUri` |
| `google_rating` | float |
| `google_review_count` | integer |
| `price_level` | 0–4 integer, mapped from enum string |
| `opening_hours` | `regularOpeningHours.periods` as JSONB |
| `photos` | up to 5 photo resource names as JSONB |
| `last_scraped_at` | set on every update |
| `data_changed_at` | set only when a meaningful change is detected |
| `open_after_8pm` | **calculated** from `opening_hours`, not stored by Google |
| `child_friendly` | `goodForChildren` |
| `has_outdoor_seating` | `outdoorSeating` |
| `has_coffee` | `servesCoffee` |
| `has_pastry` | `servesDessert` |
| `has_vegan_options` | `servesVegetarianFood` |
| `has_car_parking` | derived from `parkingOptions` (any truthy value → true) |
| `payment_methods` | derived from `paymentOptions` (text array: Bar, Kreditkarte, EC-Karte, Kontaktlos) |

### From Claude enrichment (enrich-with-claude.js)

| Column | Notes |
|---|---|
| `specialty` | One sentence about what makes the shop special |
| `location_description` | One sentence about the location |
| `ice_cream_type` | Eiscafé / Eisdiele / Gelateria / Softeis / Eisautomat / Frozen Yogurt / other |
| `signature_flavors` | text[] |
| `near_park`, `near_water`, `near_playground` | Specific names only, not guesses |
| `has_vegan_options` | May be set by Claude if Google didn't supply it |
| `fully_vegan` | Claude only |
| `is_handmade` | Claude only |
| `has_waffle_cones` | Claude only |
| `has_sundaes` | Claude only |
| `has_lactose_free` | Claude only |
| `has_gluten_free` | Claude only |
| `is_organic` | Claude only |
| `has_bike_parking` | Claude only |
| `near_public_transport` | Claude only |
| `atmosphere_tags` | Merged: Google booleans + Claude vibe tags (see below) |

### Manual-only columns

| Column | Notes |
|---|---|
| `neighborhood_id` | FK to `neighborhoods.id` — set manually |
| `has_indoor_seating` | Claude may fill this, but editorial can override |
| `slug` | Set on import via `generateSlug()`; never overwritten by weekly update |
| `listing_status` | Set to `draft` on import; manually promoted to `published` |
| `lvz_rank`, `lvz_year` | LVZ newspaper rankings — manual |
| `our_rating`, `our_review` | Editorial ratings — manual |
| `highlights` | JSONB editorial highlights — manual |
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

## How to run each script

```bash
# Seed the database (one-time)
node scripts/initial-import.js

# Enrich un-enriched shops (specialty IS NULL)
node scripts/enrich-with-claude.js

# Re-enrich all shops (ignores specialty IS NULL filter)
node scripts/enrich-with-claude.js --all

# Weekly refresh (existing shops only)
node scripts/weekly-update.js

# Weekly refresh + discover new shops
node scripts/weekly-update.js --search-new

# Send email alert for changes written by weekly-update.js
node scripts/send-alerts.js

# Local admin UI (reads .env from project root)
node admin/server.js

# Frontend dev server
cd web && npx astro dev
```

All scripts require environment variables from `.env`. Load them with `dotenv` or export them manually before running.

---

## SQL migration naming convention

Files in `sql/` follow the pattern:

```
YYYYMMDDNNNNNN_description.sql
```

Example: `20260321000001_neighborhoods.sql`

The leading date + sequence number ensures migrations apply in the correct order. The initial schema is `01_shops.sql` (legacy name, predates the convention).

---

## What NOT to do

- **Do not add `editorialSummary` back to the Places API field mask.** It was removed intentionally — the field is unreliable and polluted Claude's enrichment prompts.
- **Do not use the old Places API** (`maps.googleapis.com/maps/api/place`). The codebase is fully on Places API (New).
- **Do not overwrite `slug` in the weekly update.** `mapPlaceToShop` only sets `slug` when a `slug` option is passed explicitly (only done at import time). Weekly updates intentionally omit it.

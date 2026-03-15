# eisleipzig-pipeline

Data pipeline for [eisleipzig.de](https://eisleipzig.de) — a directory of ice cream shops in Leipzig. Pulls structured data from the Google Places API (New), stores it in Supabase, enriches it with Claude, and runs weekly via GitHub Actions.

---

## Architecture

```
Google Places API (New)
        │
        ▼
  initial-import.js          ← one-time seeding of the database
        │
        ▼
    Supabase (shops table)
        │
        ▼
  enrich-with-claude.js      ← analyses reviews, fills specialty/tags/etc.
        │
        ▼
  weekly-update.js            ← every Monday: refresh data, detect changes
        │
        ▼
  send-alerts.js              ← email summary of changes via Resend
```

The GitHub Actions workflow runs steps 3–5 automatically every Monday at 06:00 UTC.

---

## Repo structure

```
.
├── .env.example                  Environment variable template
├── .github/
│   └── workflows/
│       └── weekly-scrape.yml     GitHub Actions workflow (weekly pipeline)
├── scripts/
│   ├── initial-import.js         One-time import: searches Google, seeds Supabase
│   ├── enrich-with-claude.js     Enriches shops using Claude (reviews → structured fields)
│   ├── weekly-update.js          Weekly refresh of existing shops + optional new-shop discovery
│   ├── send-alerts.js            Reads change file, sends email alert via Resend
│   └── utils/
│       ├── google-places.js      Places API (New) client: textSearch, placeDetails, generateSlug
│       ├── change-detection.js   detectChanges, mapPlaceToShop, calcOpenAfter8pm, mapAtmosphereTags
│       └── supabase.js           Supabase client initialisation
├── sql/
│   └── 01_shops.sql              Initial schema migration (shops table + indexes + trigger)
└── package.json
```

---

## Setup

### Prerequisites

- Node.js 20+
- A [Google Cloud](https://console.cloud.google.com) project with the **Places API (New)** enabled
- A [Supabase](https://supabase.com) project
- An [Anthropic](https://console.anthropic.com) API key
- A [Resend](https://resend.com) account for email alerts

### Environment variables

Copy `.env.example` to `.env` and fill in all values:

```
GOOGLE_PLACES_API_KEY=AIza...
SUPABASE_URL=https://xxxxx.supabase.co
SUPABASE_ANON_KEY=eyJ...
SUPABASE_SERVICE_KEY=eyJ...
CLAUDE_API_KEY=sk-ant-...
RESEND_API_KEY=re_...
ALERT_EMAIL=your-email@example.com
```

The scripts use `SUPABASE_SERVICE_KEY` (service role key) to bypass RLS. `SUPABASE_ANON_KEY` is kept in `.env` for use by the frontend, not by these scripts.

### Database migration

Apply the schema with the Supabase CLI:

```bash
supabase db push
# or run directly against your project:
psql "$DATABASE_URL" -f sql/01_shops.sql
```

### Install dependencies

```bash
npm install
```

### Initial import

Run once to seed the database with Leipzig ice cream shops from Google:

```bash
npm run import
```

This runs four text searches (`Eisdiele Leipzig`, `Eiscafé Leipzig`, `Gelateria Leipzig`, `Softeis Leipzig`), fetches full place details for each result, and upserts them into Supabase with `listing_status = 'draft'`. Shops already marked `ignored` are skipped.

### Enrichment

After importing, run Claude enrichment to fill in specialty, ice cream type, atmosphere tags, dietary flags, and neighbourhood data:

```bash
npm run enrich
```

By default this only processes shops where `specialty IS NULL`. To re-process all shops:

```bash
node scripts/enrich-with-claude.js --all
```

---

## Available npm scripts

| Script | Command | Description |
|---|---|---|
| `import` | `node scripts/initial-import.js` | One-time Google Places import |
| `enrich` | `node scripts/enrich-with-claude.js` | Enrich shops with Claude (specialty=null only) |
| `update` | `node scripts/weekly-update.js` | Refresh existing shop data from Google |
| `update:search-new` | `node scripts/weekly-update.js --search-new` | Refresh + discover new shops |
| `alerts` | `node scripts/send-alerts.js` | Send email alert for detected changes |

---

## Weekly pipeline

The GitHub Actions workflow (`.github/workflows/weekly-scrape.yml`) runs every Monday at 06:00 UTC:

1. **Update existing shops** — fetches fresh place details from Google for every non-archived, non-ignored shop. Detects changes in rating (≥ 0.2 delta), opening hours, and business status. Writes detected changes to `/tmp/eisleipzig-changes.json`.
2. **Search for new shops** — runs the same four text queries; any place ID not already in the database is inserted as a `draft`.
3. **Enrich new shops with Claude** — runs `enrich-with-claude.js` (default mode: `specialty IS NULL` only), so only freshly imported shops are processed.
4. **Send change alerts** — reads the changes file and sends an HTML email via Resend if anything changed.

The workflow can also be triggered manually from the GitHub Actions UI via `workflow_dispatch`.

---

## GitHub Secrets

These secrets must be set in the repository settings under **Settings → Secrets and variables → Actions**:

| Secret | Used by |
|---|---|
| `GOOGLE_PLACES_API_KEY` | weekly-update.js, enrich-with-claude.js |
| `SUPABASE_URL` | all scripts |
| `SUPABASE_SERVICE_KEY` | all scripts |
| `CLAUDE_API_KEY` | enrich-with-claude.js |
| `RESEND_API_KEY` | send-alerts.js |
| `ALERT_EMAIL` | send-alerts.js |

---

## listing_status values

| Value | Meaning |
|---|---|
| `draft` | Imported from Google, not yet reviewed or published |
| `published` | Live on eisleipzig.de, visible to visitors |
| `archived` | Previously published, now hidden (e.g. shop closed) |
| `ignored` | False positive or out-of-scope place; skipped by all scripts |

Shops with `listing_status = 'ignored'` are never updated by the weekly pipeline and are never re-imported by the initial import script.

---

## Adding shops manually

1. Insert a row directly in Supabase (Table Editor or SQL):
   ```sql
   insert into shops (name, slug, listing_status)
   values ('Mein Eisladen', 'mein-eisladen', 'draft');
   ```
2. Fill in `google_place_id` if the shop exists on Google Maps — the weekly update will then keep it in sync.
3. Leave `google_place_id` as NULL for shops without a Google listing; they will be ignored by all Google-dependent scripts but remain in the database.
4. Set `listing_status = 'published'` when the entry is ready to go live.

# eis-le.de

A directory of ice cream shops in Leipzig — [eis-le.de](https://eis-le.de).

---

## Architecture

```
                 Google Places API (New)
                         │
          ┌──────────────┼──────────────┐
          ▼              ▼              ▼
  initial-import.js   weekly-update.js   enrich-with-claude.js
          │              │              │
          └──────────────┼──────────────┘
                         ▼
                 Supabase (shops table)
                         │
              ┌──────────┼──────────┐
              ▼          ▼          ▼
         web/ (Astro)  admin/    send-alerts.js
              │
              ▼
       Cloudflare Pages
```

---

## Repo structure

```
.
├── web/                             Astro SSG frontend (Cloudflare Worker)
│   ├── src/
│   │   ├── pages/                   Astro pages (shop detail, curated lists, map, legal)
│   │   ├── components/              Astro components (ShopCard, FlavorList, HighlightList, etc.)
│   │   ├── layouts/                 BaseLayout with Nav + Footer
│   │   ├── lib/                     Data fetching (Supabase client, Shop type)
│   │   ├── content/                 Markdown content (Impressum, Datenschutz)
│   │   ├── styles/                  Global CSS (Tailwind + design tokens)
│   │   └── data/                    Static fallback data (shops.json)
│   ├── public/                      Static assets (favicon, icons)
│   ├── astro.config.mjs
│   └── package.json
├── admin/                           Local admin UI
│   ├── index.html                   Single-page app (Alpine.js)
│   ├── server.js                    Node proxy server for Supabase API
│   └── config.js                    Configuration
├── scripts/                         Data pipeline
│   ├── initial-import.js            One-time import from Google Places
│   ├── enrich-with-claude.js        AI enrichment (reviews → structured fields)
│   ├── weekly-update.js             Weekly refresh + new-shop discovery
│   ├── send-alerts.js               Email change alerts via Resend
│   └── utils/
│       ├── google-places.js         Places API (New) client
│       ├── change-detection.js      Change detection, field mapping, derived fields
│       └── supabase.js              Supabase client
├── sql/                             Database migrations
│   ├── 01_shops.sql                 Initial schema (legacy name)
│   └── YYYYMMDDNNNNNN_*.sql         Numbered migrations
├── supabase/                        Supabase CLI config + migrations
├── .github/workflows/
│   └── weekly-scrape.yml            GitHub Actions (weekly pipeline)
├── CLAUDE.md                        AI assistant context
└── package.json
```

---

## Frontend (web/)

Built with [Astro](https://astro.build), styled with [Tailwind CSS](https://tailwindcss.com), icons from [Lucide](https://lucide.dev). Deployed as a static site to Cloudflare Pages.

### Pages

- **`/`** — Homepage with filterable shop grid
- **`/[slug]`** — Shop detail page (highlights, flavors, opening hours, map)
- **`/karte`** — Full map view of all shops
- **`/veganes-eis`**, **`/eis-mit-kindern`**, **`/date-night-eis`**, **`/eis-fuer-radfahrer`** — Curated lists
- **`/beste-eisdielen-lvz`** — LVZ newspaper ranking
- **`/stadtteil/[slug]`** — Neighborhood pages
- **`/impressum`**, **`/datenschutz`** — Legal pages

### Dev server

```bash
cd web
npm install
npx astro dev
```

### Build & deploy

```bash
cd web
npm run build
```

Deployment happens automatically via Cloudflare Pages on push to `main`.

---

## Admin UI (admin/)

A local-only single-page admin tool for managing shop data. Built with plain HTML and [Alpine.js](https://alpinejs.dev). Communicates with Supabase through a Node.js proxy server.

```bash
# Start the admin server (reads .env from project root)
node admin/server.js
# Open http://localhost:3000
```

Features: browse/filter shops, edit all fields (booleans, text, JSONB highlights/flavors), manage listing status.

---

## Data pipeline (scripts/)

### Prerequisites

- Node.js 22+
- [Google Cloud](https://console.cloud.google.com) project with **Places API (New)** enabled
- [Supabase](https://supabase.com) project
- [Anthropic](https://console.anthropic.com) API key
- [Resend](https://resend.com) account for email alerts

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

### Scripts

| Script | Command | Description |
|---|---|---|
| `import` | `node scripts/initial-import.js` | One-time Google Places import |
| `enrich` | `node scripts/enrich-with-claude.js` | Enrich shops with Claude (specialty=null only) |
| `update` | `node scripts/weekly-update.js` | Refresh existing shop data from Google |
| `update:search-new` | `node scripts/weekly-update.js --search-new` | Refresh + discover new shops |
| `alerts` | `node scripts/send-alerts.js` | Send email alert for detected changes |

### Weekly pipeline

The GitHub Actions workflow (`.github/workflows/weekly-scrape.yml`) runs every Monday at 06:00 UTC:

1. **Update existing shops** — fetches fresh place details from Google, detects changes in rating (≥ 0.2 delta), opening hours, and business status
2. **Search for new shops** — runs text queries; new place IDs are inserted as `draft`
3. **Enrich new shops** — runs Claude enrichment on shops where `specialty IS NULL`
4. **Send change alerts** — sends an HTML email via Resend if anything changed

Can also be triggered manually via `workflow_dispatch`.

---

## Database

Hosted on [Supabase](https://supabase.com) (PostgreSQL). Two tables: `shops` and `neighborhoods`.

### Migrations

```bash
# Apply a migration
npx supabase db query --linked -f sql/YYYYMMDDNNNNNN_description.sql
```

Migration files in `sql/` follow the naming pattern `YYYYMMDDNNNNNN_description.sql`.

### listing_status values

| Value | Meaning |
|---|---|
| `draft` | Imported from Google, not yet reviewed or published |
| `published` | Live on eis-le.de, visible to visitors |
| `archived` | Previously published, now hidden (e.g. shop closed) |
| `ignored` | False positive or out-of-scope; skipped by all scripts |

---

## GitHub Secrets

| Secret | Used by |
|---|---|
| `GOOGLE_PLACES_API_KEY` | weekly-update.js |
| `SUPABASE_URL` | all scripts |
| `SUPABASE_SERVICE_KEY` | all scripts |
| `CLAUDE_API_KEY` | enrich-with-claude.js |
| `RESEND_API_KEY` | send-alerts.js |
| `ALERT_EMAIL` | send-alerts.js |

---

## License

See [LICENSE](LICENSE).

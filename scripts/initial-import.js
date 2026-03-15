/**
 * One-time script: pulls ice cream shops from Google Places and upserts them
 * into Supabase as draft listings.
 *
 * Run: node scripts/initial-import.js
 */

import { textSearch, placeDetails, generateSlug } from './utils/google-places.js';
import { mapPlaceToShop } from './utils/change-detection.js';
import { supabase } from './utils/supabase.js';

const SEARCH_QUERIES = [
  'Eisdiele Leipzig',
  'Eiscafé Leipzig',
  'Gelateria Leipzig',
  'Softeis Leipzig',
];

async function run() {
  // Load ignored place IDs so we never re-import false positives
  const { data: ignoredRows } = await supabase
    .from('shops')
    .select('google_place_id')
    .eq('listing_status', 'ignored');
  const ignoredIds = new Set((ignoredRows ?? []).map((r) => r.google_place_id));

  const seen = new Set();
  let imported = 0;
  let skipped = 0;
  let ignored = 0;

  for (const query of SEARCH_QUERIES) {
    console.log(`\nSearching: "${query}"`);
    const results = await textSearch(query);
    console.log(`  Found ${results.length} results`);

    for (const place of results) {
      if (seen.has(place.place_id)) {
        skipped++;
        continue;
      }
      seen.add(place.place_id);

      if (ignoredIds.has(place.place_id)) {
        console.log(`  [ignored] ${place.name}`);
        ignored++;
        continue;
      }

      let details;
      try {
        details = await placeDetails(place.place_id);
      } catch (err) {
        console.warn(`  Skipping ${place.name}: ${err.message}`);
        continue;
      }

      const slug = generateSlug(details.name);
      const shop = {
        ...mapPlaceToShop(details, { slug }),
        listing_status: 'draft',
      };

      const { error } = await supabase
        .from('shops')
        .upsert(shop, { onConflict: 'google_place_id' });

      if (error) {
        console.error(`  Error upserting ${details.name}:`, error.message);
      } else {
        console.log(`  [OK] ${details.name} (${slug})`);
        imported++;
      }

      // Respect rate limits
      await sleep(200);
    }
  }

  console.log(`\nDone. Imported/updated: ${imported}, duplicates skipped: ${skipped}, ignored: ${ignored}`);
}

function sleep(ms) {
  return new Promise((r) => setTimeout(r, ms));
}

run().catch((err) => {
  console.error(err);
  process.exit(1);
});

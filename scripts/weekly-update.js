/**
 * Weekly update script — run by GitHub Actions every Monday.
 *
 * Default mode: refreshes core data (rating, hours) for all existing shops.
 * With --search-new: also runs text searches to discover new shops.
 *
 * Detected changes are written to a JSON file so send-alerts.js can read them.
 *
 * Run: node scripts/weekly-update.js
 *      node scripts/weekly-update.js --search-new
 */

import { writeFileSync } from 'fs';
import { textSearch, placeDetails, generateSlug } from './utils/google-places.js';
import { detectChanges, mapPlaceToShop } from './utils/change-detection.js';
import { supabase } from './utils/supabase.js';

const SEARCH_QUERIES = [
  'Eisdiele Leipzig',
  'Eiscafé Leipzig',
  'Gelateria Leipzig',
  'Softeis Leipzig',
];

const CHANGES_FILE = '/tmp/eisleipzig-changes.json';
const searchNew = process.argv.includes('--search-new');

async function updateExistingShops() {
  const { data: shops, error } = await supabase
    .from('shops')
    .select('id, name, google_place_id, google_rating, opening_hours')
    .not('google_place_id', 'is', null)
    .not('listing_status', 'in', '("archived","ignored")');

  if (error) throw error;

  console.log(`Updating ${shops.length} existing shops`);
  const allChanges = [];

  for (const shop of shops) {
    let fresh;
    try {
      fresh = await placeDetails(shop.google_place_id);
    } catch (err) {
      console.warn(`  Skipping ${shop.name}: ${err.message}`);
      continue;
    }

    const changes = detectChanges(shop, fresh);
    allChanges.push(...changes);

    const update = {
      ...mapPlaceToShop(fresh),
      ...(changes.length > 0 ? { data_changed_at: new Date().toISOString() } : {}),
    };

    const { error: updateError } = await supabase
      .from('shops')
      .update(update)
      .eq('id', shop.id);

    if (updateError) {
      console.error(`  Update failed for ${shop.name}: ${updateError.message}`);
    } else if (changes.length > 0) {
      console.log(`  [CHANGED] ${shop.name}: ${changes.map((c) => c.field).join(', ')}`);
    } else {
      console.log(`  [OK] ${shop.name}`);
    }

    await sleep(200);
  }

  return allChanges;
}

async function searchForNewShops() {
  console.log('\nSearching for new shops');

  const { data: existing } = await supabase
    .from('shops')
    .select('google_place_id');

  const knownIds = new Set(existing.map((s) => s.google_place_id));
  const newShops = [];

  for (const query of SEARCH_QUERIES) {
    const results = await textSearch(query);

    for (const place of results) {
      if (knownIds.has(place.place_id)) continue;

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

      if (!error) {
        console.log(`  [NEW] ${details.name}`);
        newShops.push({ shop: details.name, field: 'new_shop', old: null, new: 'draft' });
        knownIds.add(place.place_id);
      }

      await sleep(200);
    }
  }

  return newShops;
}

async function run() {
  const changes = await updateExistingShops();

  if (searchNew) {
    const newShopChanges = await searchForNewShops();
    changes.push(...newShopChanges);
  }

  writeFileSync(CHANGES_FILE, JSON.stringify(changes, null, 2));
  console.log(`\nWrote ${changes.length} change(s) to ${CHANGES_FILE}`);
}

function sleep(ms) {
  return new Promise((r) => setTimeout(r, ms));
}

run().catch((err) => {
  console.error(err);
  process.exit(1);
});

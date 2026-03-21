/**
 * Enriches shops that haven't been processed yet by analysing their
 * Google reviews with Claude and pre-filling several fields.
 *
 * Safe to run repeatedly — only touches rows where `specialty` is NULL.
 *
 * Run: node scripts/enrich-with-claude.js
 */

import Anthropic from '@anthropic-ai/sdk';
import { placeDetails } from './utils/google-places.js';
import { extractReviews, mapAtmosphereTags } from './utils/change-detection.js';
import { supabase } from './utils/supabase.js';

const claude = new Anthropic({ apiKey: process.env.CLAUDE_API_KEY });
const forceAll = process.argv.includes('--all');

const PROMPT = (shopName, reviews) => `\
Analyse the following Google data for the ice cream shop "${shopName}" in Leipzig.
Extract a JSON object with only the fields you can determine with reasonable confidence. Omit fields you cannot determine.

Allowed fields and expected values:
{
  "signature_flavors": ["Flavor 1", "Flavor 2"],
  "has_vegan_options": true,
  "fully_vegan": false,
  "ice_cream_type": "Eiscafé | Eisdiele | Gelateria | Softeis | Eisautomat | Frozen Yogurt | other",
  "specialty": "One sentence about what makes this place special",
  "location_description": "One sentence about the location",

  "has_indoor_seating": true,
  "is_handmade": true,
  "has_waffle_cones": true,
  "has_sundaes": true,
  "has_lactose_free": true,
  "has_gluten_free": true,
  "is_organic": true,
  "has_bike_parking": true,
  "near_public_transport": true,
  "has_dog_ice_cream": true,

  "near_park": "Name of nearby park if mentioned",
  "near_water": "Name of nearby water if mentioned",
  "near_playground": "Description of nearby playground if mentioned",

  "atmosphere_tags": ["casual", "cozy"]
}

Notes:
- Only set boolean fields when confident — omit rather than guess.
- near_* fields: only fill in when a concrete name or place is mentioned.
- atmosphere_tags: pick only from these allowed values based on the overall vibe:
  casual, cozy, quiet, trendy, lively, romantic, modern, traditional, upscale, rustic
  Use at most 3 tags. Only include tags that are clearly supported by the reviews or summary.

Respond with only the JSON object, no comments.
Reviews:
${reviews.map((r, i) => `[${i + 1}] ${r}`).join('\n')}`;

async function run() {
  let query = supabase
    .from('shops')
    .select('id, name, google_place_id')
    .not('google_place_id', 'is', null)
    .not('listing_status', 'in', '("archived","ignored")');

  if (!forceAll) query = query.is('specialty', null);

  const { data: shops, error } = await query;

  if (error) throw error;

  console.log(`Found ${shops.length} shops to enrich`);

  for (const shop of shops) {
    console.log(`\nEnriching: ${shop.name}`);

    let reviews = [];
    let googleAtmosphereTags = [];
    try {
      const details = await placeDetails(shop.google_place_id);
      reviews = extractReviews(details);
      googleAtmosphereTags = mapAtmosphereTags(details) ?? [];
    } catch (err) {
      console.warn(`  Could not fetch details: ${err.message}`);
    }

    if (reviews.length === 0) {
      console.log('  No data available, skipping');
      continue;
    }

    let enriched;
    try {
      const response = await claude.messages.create({
        model: 'claude-sonnet-4-5',
        max_tokens: 1200,
        messages: [{ role: 'user', content: PROMPT(shop.name, reviews) }],
      });

      const raw = response.content[0].text.replace(/^```json\s*/i, '').replace(/```\s*$/i, '').trim();
      enriched = JSON.parse(raw);

      // Merge Google boolean tags (live-music, good-for-groups) with Claude vibe tags
      const vibeTags = enriched.atmosphere_tags ?? [];
      const merged = [...new Set([...googleAtmosphereTags, ...vibeTags])];
      enriched.atmosphere_tags = merged.length ? merged : undefined;
    } catch (err) {
      console.warn(`  Claude error: ${err.message}`);
      continue;
    }

    const { error: updateError } = await supabase
      .from('shops')
      .update(enriched)
      .eq('id', shop.id);

    if (updateError) {
      console.error(`  Update failed: ${updateError.message}`);
    } else {
      console.log(`  [OK] Updated ${Object.keys(enriched).join(', ')}`);
    }

    // Stay within rate limits
    await sleep(500);
  }

  console.log('\nEnrichment complete.');
}

function sleep(ms) {
  return new Promise((r) => setTimeout(r, ms));
}

run().catch((err) => {
  console.error(err);
  process.exit(1);
});

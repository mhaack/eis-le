/**
 * Compares a fresh Places API (New) result against the stored shop row.
 * Returns an array of change objects (empty if nothing meaningful changed).
 */
export function detectChanges(shop, fresh) {
  const changes = [];

  if (
    fresh.rating != null &&
    shop.google_rating != null &&
    Math.abs(fresh.rating - shop.google_rating) >= 0.2
  ) {
    changes.push({
      shop: shop.name,
      field: 'rating',
      old: shop.google_rating,
      new: fresh.rating,
    });
  }

  const oldHours = JSON.stringify(shop.opening_hours ?? null);
  const newHours = JSON.stringify(fresh.regularOpeningHours?.periods ?? null);
  if (oldHours !== newHours) {
    changes.push({
      shop: shop.name,
      field: 'opening_hours',
      old: 'previous',
      new: 'updated',
    });
  }

  if (
    fresh.businessStatus === 'CLOSED_PERMANENTLY' ||
    fresh.businessStatus === 'CLOSED_TEMPORARILY'
  ) {
    changes.push({
      shop: shop.name,
      field: 'business_status',
      old: 'open',
      new: fresh.businessStatus,
    });
  }

  return changes;
}

/**
 * Returns true if any opening period closes after 20:00 (or runs past midnight).
 * New Places API uses integer hour/minute fields (not HHMM strings).
 * A missing close object means open 24h.
 */
export function calcOpenAfter8pm(periods) {
  if (!periods?.length) return null;
  return periods.some((p) => {
    if (!p.close) return true; // 24h open
    const { hour, minute = 0, day: closeDay } = p.close;
    const wraps = closeDay !== p.open.day;
    return wraps || hour > 20 || (hour === 20 && minute > 0);
  });
}

/**
 * Derives payment_methods text[] from paymentOptions object.
 */
function mapPaymentMethods(opts) {
  if (!opts) return null;
  const methods = [];
  if (opts.acceptsCashOnly) methods.push('Bar');
  if (opts.acceptsCreditCards) methods.push('Kreditkarte');
  if (opts.acceptsDebitCards) methods.push('EC-Karte');
  if (opts.acceptsNfc) methods.push('Kontaktlos');
  return methods.length ? methods : null;
}

/**
 * Builds atmosphere_tags from Google's boolean atmosphere attributes.
 */
/**
 * Builds atmosphere_tags from Google's structured boolean fields.
 * Subjective vibe tags (casual, cozy, quiet, trendy) are added by Claude
 * via enrich-with-claude.js since Google doesn't expose them in the API.
 */
export function mapAtmosphereTags(details) {
  const tags = [];
  if (details.liveMusic)     tags.push('live-music');
  if (details.goodForGroups) tags.push('good-for-groups');
  return tags.length ? tags : null;
}

/**
 * Returns true if any parking option is present.
 */
function hasParking(opts) {
  if (!opts) return null;
  return Object.values(opts).some(Boolean) || null;
}

/**
 * Maps a Places API (New) details result to our shops schema.
 */
export function mapPlaceToShop(details, { slug } = {}) {
  const periods = details.regularOpeningHours?.periods ?? null;

  // payment_methods: only set if we got data
  const payment_methods = mapPaymentMethods(details.paymentOptions);

  return {
    // Core
    google_place_id: details.id,
    name: details.displayName?.text ?? details.name,
    ...(slug ? { slug } : {}),
    address_street: details.formattedAddress ?? null,
    latitude: details.location?.latitude ?? null,
    longitude: details.location?.longitude ?? null,
    phone: details.nationalPhoneNumber ?? null,
    website: details.websiteUri ?? null,
    google_maps_url: details.googleMapsUri ?? null,
    google_rating: details.rating ?? null,
    google_review_count: details.userRatingCount ?? null,
    price_level: details.priceLevel ?? null,
    opening_hours: periods,
    photos: details.photos?.slice(0, 5).map((p) => p.name) ?? null,
    last_scraped_at: new Date().toISOString(),

    // Calculated from opening hours
    open_after_8pm: calcOpenAfter8pm(periods),

    // Family
    child_friendly: details.goodForChildren ?? null,

    // Seating & amenities (from Google structured data)
    has_outdoor_seating: details.outdoorSeating ?? null,

    // Offerings (from Google structured data)
    has_coffee: details.servesCoffee ?? null,
    has_pastry: details.servesDessert ?? null,
    has_vegan_options: details.servesVegetarianFood ?? null,

    // Parking & payment (from Google structured data)
    has_car_parking: hasParking(details.parkingOptions),
    ...(payment_methods ? { payment_methods } : {}),
  };
}

/**
 * Extracts review texts from a Places API (New) details result.
 */
export function extractReviews(details) {
  return (details.reviews ?? [])
    .filter((r) => r.text?.text?.trim())
    .map((r) => r.text.text.trim())
    .slice(0, 10);
}

ALTER TABLE shops
  ADD COLUMN IF NOT EXISTS gallery_images jsonb DEFAULT NULL;

COMMENT ON COLUMN shops.gallery_images IS
  'Ordered array of image filenames (max 5), e.g. ["hero.jpg","interior.jpg"]. Paths resolve to shop-images/{slug}/{filename} in Supabase Storage.';

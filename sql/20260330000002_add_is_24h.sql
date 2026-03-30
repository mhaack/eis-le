-- Add is_24h column for shops open 24/7 (e.g. Eisautomaten)
-- Calculated from opening_hours by weekly update, but can be set manually.
ALTER TABLE shops ADD COLUMN is_24h boolean DEFAULT false;

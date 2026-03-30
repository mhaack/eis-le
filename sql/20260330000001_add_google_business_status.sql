-- Add google_business_status column to track Google's business status
ALTER TABLE shops ADD COLUMN google_business_status text DEFAULT 'OPERATIONAL';

-- Set all existing shops to OPERATIONAL
UPDATE shops SET google_business_status = 'OPERATIONAL' WHERE google_business_status IS NULL;

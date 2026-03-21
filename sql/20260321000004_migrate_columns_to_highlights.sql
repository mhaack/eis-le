/* Migrate has_alcohol_flavors, has_dog_ice_cream, has_loyalty_program to highlights */

/* Vanille & Zimt: append loyalty to existing highlights */
UPDATE shops SET highlights = highlights || '[{"icon": "gift", "title": "Treueprogramm", "text": "Treueprogramm für Stammkunden"}]'::jsonb
WHERE id = 'b3f893ef-e682-47fd-ac76-2d7ca992bf2e';

/* Mein Eis Leipzig: dog ice cream */
UPDATE shops SET highlights = '[{"icon": "heart", "title": "Hundeeis", "text": "Eis speziell für Hunde"}]'::jsonb
WHERE id = '9049bdf9-493c-4ff5-b46d-7fd845a2e720';

/* Erikas Eiscafe Eutritzsch: alcohol flavors */
UPDATE shops SET highlights = '[{"icon": "sparkles", "title": "Alkohol-Sorten", "text": "Eissorten mit Alkohol im Angebot"}]'::jsonb
WHERE id = 'f9cc49b2-2aed-4a44-8cf5-2f403051833d';

/* BECHER.ODER.WAFFEL: dog ice cream */
UPDATE shops SET highlights = '[{"icon": "heart", "title": "Hundeeis", "text": "Eis speziell für Hunde"}]'::jsonb
WHERE id = '6e55bd4a-a498-4e0d-badd-a730a8708ef9';

/* Streits Gelato: dog ice cream */
UPDATE shops SET highlights = '[{"icon": "heart", "title": "Hundeeis", "text": "Eis speziell für Hunde"}]'::jsonb
WHERE id = '6ea22c6e-d9c6-4200-9f78-d3ae9fe4ace5';

/* Il buon Gelato: dog ice cream */
UPDATE shops SET highlights = '[{"icon": "heart", "title": "Hundeeis", "text": "Eis speziell für Hunde"}]'::jsonb
WHERE id = '5bd3e067-113b-4111-a447-05e67f6e4c66';

/* Eisdiele am See: dog ice cream */
UPDATE shops SET highlights = '[{"icon": "heart", "title": "Hundeeis", "text": "Eis speziell für Hunde"}]'::jsonb
WHERE id = 'e5145fdb-a740-4b6e-b335-afda359cdccf';

/* Eisbrennerei: alcohol flavors */
UPDATE shops SET highlights = '[{"icon": "sparkles", "title": "Alkohol-Sorten", "text": "Eissorten mit Alkohol im Angebot"}]'::jsonb
WHERE id = 'a12b4cb2-9e24-4920-80dd-614d4cec8c7c';

/* Drop the columns */
ALTER TABLE shops DROP COLUMN has_alcohol_flavors;
ALTER TABLE shops DROP COLUMN has_dog_ice_cream;
ALTER TABLE shops DROP COLUMN has_loyalty_program;
ALTER TABLE shops DROP COLUMN editorial_tags;

-- Drop legacy neighborhood text columns (now using neighborhood_id FK)
drop index if exists idx_shops_neighborhood;
alter table shops drop column neighborhood;
alter table shops drop column neighborhood_slug;

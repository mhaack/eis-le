alter table shops
  drop constraint shops_listing_status_check;

alter table shops
  add constraint shops_listing_status_check
  check (listing_status in ('published', 'draft', 'archived', 'ignored'));

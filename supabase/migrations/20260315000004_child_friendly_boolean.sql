alter table shops
  drop column child_friendly_score;

alter table shops
  add column child_friendly boolean;

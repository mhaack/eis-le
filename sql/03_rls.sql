-- Shops: public read, service-key write
alter table shops enable row level security;
create policy "Shops are publicly readable"
  on shops for select using (true);

-- User ratings: public read + anonymous insert
alter table user_ratings enable row level security;
create policy "Ratings are publicly readable"
  on user_ratings for select using (true);
create policy "Anyone can submit a rating"
  on user_ratings for insert with check (true);

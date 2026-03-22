create table shops (
  -- Core data (Google Places)
  id uuid primary key default gen_random_uuid(),
  google_place_id text unique,
  name text not null,
  slug text unique not null,
  address_street text,
  address_zip text,
  address_city text default 'Leipzig',
  latitude float,
  longitude float,
  phone text,
  website text,
  google_maps_url text,
  google_rating float,
  google_review_count integer,
  price_level integer,
  opening_hours jsonb,
  photos jsonb,
  last_scraped_at timestamptz,
  data_changed_at timestamptz,

  -- Family-friendliness
  child_friendly_score integer check (child_friendly_score between 0 and 5),
  wait_time_typical text check (wait_time_typical in ('kurz', 'mittel', 'lang')),
  has_indoor_seating boolean,
  has_outdoor_seating boolean,

  -- Ice cream, flavors & dietary
  ice_cream_type text,
  is_handmade boolean,
  flavor_list jsonb,
  has_waffle_cones boolean,
  has_sundaes boolean,
  has_pastry boolean,
  price_per_scoop text,
  has_vegan_options boolean,
  fully_vegan boolean,
  has_lactose_free boolean,
  has_gluten_free boolean,
  is_organic boolean,

  -- Atmosphere
  atmosphere_tags text[],
  open_after_8pm boolean,
  has_coffee boolean,
  has_alcohol_flavors boolean,

  -- Accessibility & transport
  has_car_parking boolean,
  has_bike_parking boolean,
  near_public_transport boolean,

  -- Pets
  dogs_allowed boolean,
  has_dog_ice_cream boolean,

  -- Neighborhood & location
  neighborhood text,
  neighborhood_slug text,
  near_park text,
  near_water text,
  near_landmark text,
  near_playground text,
  location_description text,

  -- LVZ ranking & ratings
  lvz_rank integer,
  lvz_year integer,
  our_rating float check (our_rating between 1.0 and 5.0),
  our_review text,
  user_rating_avg float,

  -- Specials & insider knowledge
  highlights jsonb,
  specialty text,
  has_loyalty_program boolean,
  payment_methods text[],
  editorial_tags text[],
  last_visited_at date,
  listing_status text default 'draft' check (listing_status in ('published', 'draft', 'archived')),

  -- Timestamps
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

create index idx_shops_neighborhood on shops(neighborhood);
create index idx_shops_lvz_rank on shops(lvz_rank) where lvz_rank is not null;
create index idx_shops_listing_status on shops(listing_status);
create index idx_shops_slug on shops(slug);

create or replace function update_updated_at()
returns trigger as $$
begin
  new.updated_at = now();
  return new;
end;
$$ language plpgsql;

create trigger shops_updated_at
  before update on shops
  for each row execute function update_updated_at();
create table user_ratings (
  id uuid primary key default gen_random_uuid(),
  shop_id uuid references shops(id) on delete cascade,
  rating integer not null check (rating between 1 and 5),
  comment text,
  created_at timestamptz default now()
);

create index idx_ratings_shop on user_ratings(shop_id);
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

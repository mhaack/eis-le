-- Create neighborhoods table (step 1 of 2)
-- Step 2 will populate neighborhoods, backfill neighborhood_id, and drop old columns.

-- 1. Create the neighborhoods table
create table neighborhoods (
  id uuid primary key default gen_random_uuid(),
  name text not null unique,
  slug text not null unique,
  description text,
  latitude float,
  longitude float,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

create index idx_neighborhoods_slug on neighborhoods(slug);

-- 2. RLS: public read, service-key write
alter table neighborhoods enable row level security;
create policy "Neighborhoods are publicly readable"
  on neighborhoods for select using (true);

-- 3. Auto-update updated_at
create trigger neighborhoods_updated_at
  before update on neighborhoods
  for each row execute function update_updated_at();

-- 4. Add FK column to shops (nullable, will be linked in step 2)
alter table shops add column neighborhood_id uuid references neighborhoods(id);
create index idx_shops_neighborhood_id on shops(neighborhood_id);

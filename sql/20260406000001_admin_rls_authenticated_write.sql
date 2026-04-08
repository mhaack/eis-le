-- Allow authenticated users (admin) to write shops and neighborhoods.
-- Reads remain publicly accessible (existing policies unchanged).

create policy "Authenticated users can update shops"
  on shops for update
  using (auth.role() = 'authenticated')
  with check (auth.role() = 'authenticated');

create policy "Authenticated users can update neighborhoods"
  on neighborhoods for update
  using (auth.role() = 'authenticated')
  with check (auth.role() = 'authenticated');

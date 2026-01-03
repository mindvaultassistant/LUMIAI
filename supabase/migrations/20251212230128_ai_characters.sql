-- AI Characters + User Profiles (safe / idempotent)

-- 1) Ensure ai_characters has required columns (even if table already existed)
create table if not exists public.ai_characters (
  id uuid primary key default gen_random_uuid()
);

alter table public.ai_characters
  add column if not exists code text,
  add column if not exists name text,
  add column if not exists description text,
  add column if not exists system_prompt text,
  add column if not exists is_active boolean not null default true,
  add column if not exists created_at timestamptz not null default now();

-- backfill code if missing (only for existing rows)
update public.ai_characters
set code = coalesce(code, lower(regexp_replace(coalesce(name,'character'), '\s+', '_', 'g')))
where code is null;

-- unique code
create unique index if not exists ai_characters_code_uq on public.ai_characters (code);

-- 2) user_profiles
create table if not exists public.user_profiles (
  user_id uuid primary key references auth.users(id) on delete cascade,
  active_character_id uuid references public.ai_characters(id),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- 3) Trigger function: also creates wallet + profile on signup
create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
as $$
declare
  default_char_id uuid;
begin
  select id into default_char_id
  from public.ai_characters
  where is_active = true
  order by created_at asc
  limit 1;

  insert into public.users (id, email)
  values (new.id, new.email)
  on conflict (id) do nothing;

  insert into public.tokens_wallet (user_id, balance)
  values (new.id, 0)
  on conflict (user_id) do nothing;

  insert into public.user_profiles (user_id, active_character_id)
  values (new.id, default_char_id)
  on conflict (user_id) do nothing;

  return new;
end;
$$;

-- 4) Seed characters (neutral names, not "CEO")
insert into public.ai_characters (code, name, description, system_prompt, is_active)
values
  ('lumi_strategist', 'Strategist', 'Net, planlı, sonuç odaklı.', 'You are LumiAI Strategist. Be concise, structured, and execution-oriented.', true),
  ('lumi_creator',    'Creator',    'Üretim odaklı, yaratıcı, hızlı.', 'You are LumiAI Creator. Produce high-quality, ready-to-use outputs.', true),
  ('lumi_tech',       'Tech',       'Teknik, hatasız, sistematik.', 'You are LumiAI Tech. Be precise, safe, and production-minded.', true)
on conflict (code) do nothing;

-- 5) Ensure everyone has an active character
update public.user_profiles
set active_character_id = (
  select id from public.ai_characters where is_active=true order by created_at asc limit 1
),
updated_at = now()
where active_character_id is null;

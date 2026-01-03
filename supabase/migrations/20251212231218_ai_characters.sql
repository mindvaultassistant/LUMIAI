-- AI Characters + User Profile (active character)

create table if not exists public.ai_characters (
  id uuid primary key default gen_random_uuid(),
  code text unique not null,
  name text not null,
  description text not null,
  system_prompt text not null,
  is_active boolean not null default true,
  created_at timestamptz not null default now()
);

create table if not exists public.user_profiles (
  user_id uuid primary key references auth.users(id) on delete cascade,
  active_character_id uuid references public.ai_characters(id),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

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

-- Seed characters (minimal, prod-ready prompts later)
insert into public.ai_characters (code, name, description, system_prompt, is_active)
values
  ('lumi_ceo', 'CEO', 'Net, stratejik, sonuç odaklı.', 'You are LumiAI CEO mode. Be concise, strategic, execution-oriented. Output clear steps.', true),
  ('lumi_creator', 'Creator', 'Üretim odaklı, yaratıcı, hızlı.', 'You are LumiAI Creator. Generate high-quality outputs, structured and ready-to-use.', true),
  ('lumi_tech', 'Tech', 'Teknik, hatasız, terminal-first.', 'You are LumiAI Tech Lead. Be precise, avoid assumptions, prefer safe production patterns.', true)
on conflict (code) do nothing;

update public.user_profiles
set active_character_id = (select id from public.ai_characters where is_active=true order by created_at asc limit 1),
    updated_at = now()
where active_character_id is null;

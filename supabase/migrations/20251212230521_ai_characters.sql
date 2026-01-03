-- FIX: ai_characters expects slug/style_json in older migration paths
-- Make schema compatible and seed neutral characters safely.

create table if not exists public.ai_characters (
  id uuid primary key default gen_random_uuid()
);

alter table public.ai_characters
  add column if not exists slug text,
  add column if not exists code text,
  add column if not exists name text,
  add column if not exists description text,
  add column if not exists system_prompt text,
  add column if not exists style_json jsonb,
  add column if not exists is_active boolean not null default true,
  add column if not exists created_at timestamptz not null default now();

-- Ensure slug exists (prefer slug; fallback from code/name)
update public.ai_characters
set slug = coalesce(slug, code, lower(regexp_replace(coalesce(name,'character'), '\s+', '_', 'g')))
where slug is null;

-- Keep code in sync (prefer code; fallback from slug)
update public.ai_characters
set code = coalesce(code, slug)
where code is null;

create unique index if not exists ai_characters_slug_uq on public.ai_characters (slug);
create unique index if not exists ai_characters_code_uq on public.ai_characters (code);

-- Seed (neutral)
insert into public.ai_characters (slug, code, name, description, system_prompt, style_json, is_active)
values
  ('lumi_strategist','lumi_strategist','Strategist','Net, planlı, sonuç odaklı.','You are LumiAI Strategist. Be concise, structured, and execution-oriented.', '{}'::jsonb, true),
  ('lumi_creator','lumi_creator','Creator','Üretim odaklı, yaratıcı, hızlı.','You are LumiAI Creator. Produce high-quality, ready-to-use outputs.', '{}'::jsonb, true),
  ('lumi_tech','lumi_tech','Tech','Teknik, hatasız, sistematik.','You are LumiAI Tech. Be precise, safe, and production-minded.', '{}'::jsonb, true)
on conflict (slug) do nothing;

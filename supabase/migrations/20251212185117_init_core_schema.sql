-- LumiAI core schema (v1)

-- USERS
create table if not exists public.users (
  id uuid primary key default gen_random_uuid(),
  email text unique,
  created_at timestamptz default now()
);

-- TOKENS WALLET
create table if not exists public.tokens_wallet (
  user_id uuid references public.users(id) on delete cascade,
  balance int not null default 0,
  updated_at timestamptz default now(),
  primary key (user_id)
);

-- AI GENERATIONS
create table if not exists public.ai_generations (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references public.users(id) on delete cascade,
  prompt text not null,
  result text,
  created_at timestamptz default now()
);

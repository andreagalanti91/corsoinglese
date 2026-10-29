-- UX English: database per account e progressi.
-- Incolla tutto nel SQL Editor del progetto Supabase ed esegui (Run). Si può rieseguire senza danni.

-- Chi sei: nome ed email di ogni account
create table if not exists public.profiles (
  id uuid primary key references auth.users on delete cascade,
  name text,
  email text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- Tutti i dati del corso: lezioni, esercizi visti, ripasso, XP, serie, impostazioni
create table if not exists public.progress (
  user_id uuid primary key references auth.users on delete cascade,
  data jsonb not null,
  xp integer not null default 0,
  best_streak integer not null default 0,
  lessons_done integer not null default 0,
  updated_at timestamptz not null default now()
);

-- Ognuno vede e modifica solo i propri dati
alter table public.profiles enable row level security;
alter table public.progress enable row level security;

drop policy if exists "profilo personale" on public.profiles;
create policy "profilo personale" on public.profiles
  for all using (auth.uid() = id) with check (auth.uid() = id);

drop policy if exists "progressi personali" on public.progress;
create policy "progressi personali" on public.progress
  for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

-- Il profilo nasce in automatico alla registrazione
create or replace function public.handle_new_user()
returns trigger language plpgsql security definer set search_path = public as $$
begin
  insert into public.profiles (id, name, email)
  values (new.id, new.raw_user_meta_data->>'name', new.email)
  on conflict (id) do nothing;
  return new;
end $$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();

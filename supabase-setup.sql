-- Practice Room: one-time setup for cloud sync.
-- Paste this whole file into Supabase → SQL Editor → New query, then press Run.

-- Pieces, collections and settings (one JSON row each)
create table if not exists public.items (
  user_id     uuid not null default auth.uid() references auth.users on delete cascade,
  kind        text not null,                 -- 'piece' | 'collection' | 'settings'
  id          text not null,
  data        jsonb not null,
  updated     bigint not null,               -- edit time from the device (ms)
  deleted     boolean not null default false,
  modified_at timestamptz not null default now(),
  primary key (user_id, kind, id)
);

-- Score (MusicXML) and MIDI files, one row per file
create table if not exists public.files (
  user_id     uuid not null default auth.uid() references auth.users on delete cascade,
  id          text not null,                 -- '<pieceId>:xml' or '<pieceId>:midi'
  content     text not null,
  modified_at timestamptz not null default now(),
  primary key (user_id, id)
);

-- Each signed-in user can only see and change their own rows
alter table public.items enable row level security;
alter table public.files enable row level security;
drop policy if exists "own items" on public.items;
drop policy if exists "own files" on public.files;
create policy "own items" on public.items for all to authenticated using (user_id = auth.uid()) with check (user_id = auth.uid());
create policy "own files" on public.files for all to authenticated using (user_id = auth.uid()) with check (user_id = auth.uid());
grant select, insert, update, delete on public.items, public.files to authenticated;

-- Server-side change time, so devices can ask "what changed since I last looked?"
create or replace function public.touch_modified_at() returns trigger language plpgsql as $$
begin new.modified_at = now(); return new; end $$;
drop trigger if exists items_touch on public.items;
drop trigger if exists files_touch on public.files;
create trigger items_touch before update on public.items for each row execute function public.touch_modified_at();
create trigger files_touch before update on public.files for each row execute function public.touch_modified_at();
create index if not exists items_modified on public.items (user_id, modified_at);

create table public.profiles (
    id uuid references auth.users on delete cascade primary key,
    display_name text,
    avatar_url text,
    handle text unique,
    created_at timestamptz default now(),
);

create table public.study_sessions (
    id uuid primary key default gen_random_uuid(),
    user_id uuid references public.profiles(id) on delete cascade not null,
    title text,
    description text,
    duration_seconds integer not null, 
    subject text,
    created_at timestamptz default now()
);
alter table public.profiles enable row level security;
alter table public.study_sessions enable row level security;

create policy "Users can manage their own sessions" 
on public.study_sessions 
for all 
using (auth.uid() = user_id);

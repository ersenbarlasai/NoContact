-- NoContact Initial Schema
-- Features: Profiles, Recovery Profiles, SOS Sessions
-- Security: RLS enabled for all tables

-- 1. Profiles Table (Extends Auth.Users)
create table if not exists public.profiles (
    id uuid primary key references auth.users(id) on delete cascade,
    created_at timestamptz default now() not null,
    updated_at timestamptz default now() not null,
    display_name text,
    locale text default 'tr_TR' not null,
    onboarding_completed boolean default false not null
);

-- 2. Recovery Profiles Table
create table if not exists public.recovery_profiles (
    id uuid primary key default gen_random_uuid(),
    user_id uuid references auth.users(id) on delete cascade not null,
    created_at timestamptz default now() not null,
    updated_at timestamptz default now() not null,
    preferred_name text,
    reason_for_joining text,
    relationship_duration text,
    time_since_breakup text,
    ended_by text,
    no_contact_start_date date,
    dominant_emotion text,
    contact_triggers text[] default '{}' not null,
    main_goal text,
    commitment_accepted_at timestamptz,
    app_disclaimer_seen boolean default false not null,
    
    -- Ensure one recovery profile per user for now
    constraint unique_user_recovery_profile unique(user_id)
);

-- 3. SOS Sessions Table
create table if not exists public.sos_sessions (
    id uuid primary key default gen_random_uuid(),
    user_id uuid references auth.users(id) on delete cascade not null,
    created_at timestamptz default now() not null,
    started_at timestamptz,
    completed_at timestamptz,
    dominant_emotion text,
    strongest_trigger text,
    selected_outcome text, -- 'maintained_nc', 'still_struggling'
    needed_extra_support boolean default false not null,
    urge_text_saved boolean default false not null,
    urge_text_preview text null -- Strictly for safe, non-sensitive previews if implemented
);

-- 4. RLS Configuration
alter table public.profiles enable row level security;
alter table public.recovery_profiles enable row level security;
alter table public.sos_sessions enable row level security;

-- Policies for Profiles
create policy "Users can view own profile" on public.profiles
    for select using (auth.uid() = id);

create policy "Users can update own profile" on public.profiles
    for update using (auth.uid() = id);

-- Policies for Recovery Profiles
create policy "Users can view own recovery profile" on public.recovery_profiles
    for select using (auth.uid() = user_id);

create policy "Users can insert own recovery profile" on public.recovery_profiles
    for insert with check (auth.uid() = user_id);

create policy "Users can update own recovery profile" on public.recovery_profiles
    for update using (auth.uid() = user_id);

-- Policies for SOS Sessions
create policy "Users can view own sos sessions" on public.sos_sessions
    for select using (auth.uid() = user_id);

create policy "Users can insert own sos sessions" on public.sos_sessions
    for insert with check (auth.uid() = user_id);

-- 5. Updated At Triggers
create or replace function public.handle_updated_at()
returns trigger as $$
begin
    new.updated_at = now();
    return new;
end;
$$ language plpgsql;

create trigger profiles_updated_at
    before update on public.profiles
    for each row execute function public.handle_updated_at();

create trigger recovery_profiles_updated_at
    before update on public.recovery_profiles
    for each row execute function public.handle_updated_at();

-- 6. Privacy & Sensitive Data Note
comment on column public.sos_sessions.urge_text_preview is 'Intentionally restricted. Do not store full unsent message content here for privacy reasons.';
comment on table public.sos_sessions is 'Tracks SOS tool usage without persisting sensitive unsent message text.';

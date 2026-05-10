-- Beta Feedback Table
create table public.beta_feedback (
    id uuid default gen_random_uuid() primary key,
    user_id uuid references auth.users(id) on delete set null,
    created_at timestamptz default now() not null,
    
    app_version text,
    platform text,
    source_screen text,
    
    overall_rating integer check (overall_rating >= 1 and overall_rating <= 5),
    first_impression text,
    onboarding_feedback text,
    sos_feedback text,
    mood_journal_feedback text,
    letters_vault_feedback text,
    message_analysis_feedback text,
    ai_value_feedback text,
    payment_feedback text,
    safety_or_discomfort text,
    most_valuable_feature text,
    missing_feature text,
    extra_notes text
);

-- Enable RLS
alter table public.beta_feedback enable row level security;

-- Only allow insert (append-only) for authenticated users or anonymous users if they somehow bypass
-- Note: user_id IS NULL logic lets unauthenticated submissions theoretically happen if we want,
-- but the prompt specifies auth.uid() = user_id OR user_id IS NULL.
create policy "Users can insert their own beta feedback"
    on public.beta_feedback
    for insert
    with check (auth.uid() = user_id OR user_id IS NULL);

-- Do not create SELECT, UPDATE, or DELETE policies.
-- Normal users cannot read, edit, or delete feedback. Only Service Role / Admin can view.

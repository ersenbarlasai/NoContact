# Schema Outline

## Core Tables

### profiles
- id: uuid (pk, references auth.users)
- display_name: text
- avatar_url: text
- created_at: timestamptz

### recovery_profiles
- id: uuid (pk, references profiles.id)
- breakup_date: timestamptz
- relationship_length_months: int
- attachment_pattern: text
- primary_reason: text
- risky_times: text[] (e.g. ['late_night', 'weekends'])

### no_contact_periods
- id: uuid (pk)
- user_id: uuid (references profiles.id)
- start_date: timestamptz
- end_date: timestamptz (nullable)
- status: text (active, broken, completed)

### mood_entries
- id: uuid (pk)
- user_id: uuid (references profiles.id)
- mood_score: int (1-5)
- note: text (encrypted?)
- triggers: text[]
- created_at: timestamptz

### sos_sessions
- id: uuid (pk)
- user_id: uuid (references profiles.id)
- start_time: timestamptz
- duration_seconds: int
- outcome: text (contacted, avoided)
- reflection: text

### message_analyses
- id: uuid (pk)
- user_id: uuid (references profiles.id)
- raw_message: text (sensitive)
- ai_analysis: jsonb
- safety_classification: text
- created_at: timestamptz

### unsent_letters
- id: uuid (pk)
- user_id: uuid (references profiles.id)
- content: text (encrypted)
- status: text (draft, archived, deleted)
- created_at: timestamptz

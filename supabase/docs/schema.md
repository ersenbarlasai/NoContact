# Supabase Database Schema

## Tables

### 1. `profiles`
Extends the internal `auth.users` table with application-specific metadata.

| Column | Type | Default | Description |
| --- | --- | --- | --- |
| `id` | `uuid` | (references auth.users) | Primary Key |
| `display_name` | `text` | `NULL` | User's public name |
| `locale` | `text` | `'tr_TR'` | Preferred language/locale |
| `onboarding_completed` | `boolean` | `false` | Status of onboarding flow |
| `created_at` | `timestamptz` | `now()` | |
| `updated_at` | `timestamptz` | `now()` | |

### 2. `recovery_profiles`
Stores the user's breakup recovery context and commitments.

| Column | Type | Description |
| --- | --- | --- |
| `id` | `uuid` | Primary Key |
| `user_id` | `uuid` | Owner of the profile |
| `preferred_name` | `text` | Name used in app personalization |
| `reason_for_joining` | `text` | User's primary motivation |
| `relationship_duration`| `text` | Duration of the past relationship |
| `time_since_breakup` | `text` | Time elapsed since separation |
| `ended_by` | `text` | Who initiated the breakup |
| `no_contact_start_date`| `date` | Start date for NC counter |
| `dominant_emotion` | `text` | Primary feeling during onboarding |
| `contact_triggers` | `text[]` | Situations that trigger contact urges |
| `commitment_accepted_at`| `timestamptz`| When the NC contract was signed |
| `app_disclaimer_seen` | `boolean` | Safety disclaimer confirmation |

### 3. `sos_sessions`
Logs of SOS crisis tool usage.

| Column | Type | Description |
| --- | --- | --- |
| `id` | `uuid` | Primary Key |
| `user_id` | `uuid` | Owner of the session |
| `started_at` | `timestamptz` | Session start timestamp |
| `completed_at` | `timestamptz` | Session end timestamp |
| `dominant_emotion` | `text` | Contextual emotion at start |
| `strongest_trigger` | `text` | Primary trigger identified |
| `selected_outcome` | `text` | Outcome (e.g., 'maintained_nc') |
| `needed_extra_support` | `boolean` | If grounding actions were used |
| `urge_text_saved` | `boolean` | Flag for local-only text |
| `urge_text_preview` | `text` | Non-sensitive preview (Optional) |
| `created_at` | `timestamptz` | |

### 4. `mood_entries` (Planned)
Daily emotional check-ins. Note: Content will be local-first or end-to-end encrypted.

| Column | Type | Description |
| --- | --- | --- |
| `id` | `uuid` | Primary Key |
| `user_id` | `uuid` | Owner of the entry |
| `entry_date` | `date` | The day of the entry |
| `mood` | `text` | Primary emotional state |
| `intensity` | `integer` | Scale 1-5 |
| `triggers` | `text[]` | Triggers active during that day |
| `note` | `text` | Private note (Potential Local-only) |
| `created_at` | `timestamptz` | |
| `updated_at` | `timestamptz` | |

---

## Privacy Policy on Data Storage
**Important**: The full content of "Write Here Instead" (the unsent message) is **NEVER** stored in the database. Only the fact that a message was written (`urge_text_saved`) is recorded to protect user privacy and emotional safety.

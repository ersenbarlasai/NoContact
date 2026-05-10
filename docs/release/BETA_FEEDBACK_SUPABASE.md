# Beta Feedback - Supabase Integration

## 1. Table Schema (`beta_feedback`)
The `beta_feedback` table is designed to capture structured product feedback from MVP early testers while strictly avoiding highly sensitive personal data.

**Columns:**
- `id` (uuid, PK)
- `user_id` (uuid, FK to auth.users, nullable)
- `created_at` (timestamptz)
- `app_version`, `platform`, `source_screen` (text)
- `overall_rating` (integer 1-5)
- `first_impression`, `onboarding_feedback`, `sos_feedback`, `mood_journal_feedback`, `letters_vault_feedback`, `message_analysis_feedback`, `ai_value_feedback`, `payment_feedback`, `safety_or_discomfort`, `most_valuable_feature`, `missing_feature`, `extra_notes` (text)

## 2. Row Level Security (RLS)
The table has RLS enabled with an "append-only" policy:
- **INSERT:** Allowed if `auth.uid() = user_id OR user_id IS NULL`. This allows both authenticated and unauthenticated test submissions without exposing existing rows.
- **SELECT / UPDATE / DELETE:** Blocked for all normal users.

## 3. Privacy Boundaries
- The form explicitly warns users: *"Lütfen bu forma gerçek isim, telefon numarası, eski partner bilgisi, özel mesaj içerikleri veya çok hassas kişisel bilgiler yazma."*
- The Flutter client **does not** automatically attach existing journal entries, letters, or SOS logs to the feedback payload.
- No real AI processing occurs; the form just asks for the user's *opinion* on the mock AI.

## 4. Administration
- **Viewing Feedback:** Use the Supabase Dashboard Table Editor to view incoming feedback rows. Only Service Role / Admin accounts can read this table.
- **Exporting:** You can export the `beta_feedback` table to CSV directly from the Supabase Dashboard.
- **Removal for Production:** Once the beta phase ends, you can TRUNCATE the `beta_feedback` table or DROP it entirely if you transition to a third-party CRM or feedback tool for production.

# RLS Policy Notes

## General Principle
- Users can only read and write their own data.
- `auth.uid()` must match `user_id` or `id` (for profiles).

## Table Specifics

### profiles
- SELECT: auth.uid() = id
- UPDATE: auth.uid() = id
- INSERT: (handled by trigger on auth.users creation)

### recovery_profiles, no_contact_periods, mood_entries, sos_sessions, message_analyses, unsent_letters
- SELECT: auth.uid() = user_id
- INSERT: auth.uid() = user_id
- UPDATE: auth.uid() = user_id
- DELETE: auth.uid() = user_id

## Security Audit
- Ensure no public access to any table.
- Use `restrict` on foreign keys to prevent accidental data loss if a profile is not correctly handled, though CASCADE might be preferred for account deletion.

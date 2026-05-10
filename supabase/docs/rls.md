# Row Level Security (RLS) Policies

All tables in the NoContact database are protected by RLS to ensure users can only access their own data.

## `profiles`
- **Select**: `auth.uid() = id`
- **Update**: `auth.uid() = id`
- **Insert**: Not allowed via public API (handled by triggers or system).
- **Delete**: `auth.uid() = id`

## `recovery_profiles`
- **Select**: `auth.uid() = user_id`
- **Insert**: `auth.uid() = user_id`
- **Update**: `auth.uid() = user_id`
- **Delete**: `auth.uid() = user_id`

## `sos_sessions`
- **Select**: `auth.uid() = user_id`
- **Insert**: `auth.uid() = user_id`
- **Update**: `auth.uid() = user_id`
- **Delete**: `auth.uid() = user_id`

## Global Rules
1. `user_id` must always match the authenticated user's ID.
2. CASCADE delete is enabled on all `user_id` foreign keys; deleting an account removes all associated recovery data and SOS logs.

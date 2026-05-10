# Technical Direction

# Stack
- Flutter for iOS and Android.
- Dart with strict analysis options.
- Supabase for auth, Postgres, storage, edge functions, realtime when needed.
- Riverpod or Bloc for state management. Prefer Riverpod unless the generated Flutter project already establishes another pattern.
- GoRouter for navigation.
- Freezed/json_serializable for immutable models and typed API payloads.
- Flutter localization from day one.

# Storage Strategy
- **Supabase**: Primary remote persistence for profiles, sessions, and non-sensitive metrics.
- **Shared Preferences**: Local-first caching and fallback for non-sensitive data (e.g., recovery profile metadata, managed urge counts).
- **Secure Storage**: `flutter_secure_storage` for sensitive, local-only reflections (e.g., mood journal notes, unsent letters). Data is encrypted at rest using platform-specific hardware security (Keychain/Keystore).

# Suggested App Structure
```text
app/
  mobile/
    lib/
      app/
        router/
        theme/
        localization/
        bootstrap/
      core/
        config/
        errors/
        logging/
        security/
        widgets/
      features/
        auth/
        onboarding/
        home/
        sos/
        message_analysis/
        mood_journal/
        letters_vault/
        recovery_path/
        subscription/
        settings/
      data/
        supabase/
        repositories/
        models/
      main.dart
    test/
    integration_test/
  supabase/
    migrations/
    functions/
    seed/
  tooling/
    scripts/
```

# Supabase First Tables
- profiles
- recovery_profiles
- no_contact_periods
- mood_entries
- sos_sessions
- message_analyses
- unsent_letters
- recovery_exercises
- exercise_progress
- subscriptions
- audit_events

# Backend Rules
- Every table has RLS before production use.
- Sensitive free text should be minimized, encrypted where feasible, and deletable by user.
- AI calls should go through edge functions, not directly from the client.
- Prompts and model configuration should be versioned.
- Store AI safety classifications separately from raw text where possible.

# Testing Baseline
- Unit tests for repositories, models, and safety classifiers.
- Widget tests for SOS, home, onboarding, paywall.
- Integration test for first-run onboarding to home.
- Release checklist must include Flutter analyze, tests, build smoke check, and Supabase migration review.


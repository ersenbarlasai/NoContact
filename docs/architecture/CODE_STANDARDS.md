# Code Standards

# Dart / Flutter
- Enable strict analyzer rules.
- Prefer feature-first architecture.
- Keep UI widgets free of business logic.
- Keep Supabase calls inside repositories or data sources.
- Use typed models for network/database payloads.
- Add tests for changed behavior.
- Avoid one-off visual styles; use design tokens.

# Naming
- Files: `snake_case.dart`.
- Classes: `PascalCase`.
- Providers/controllers: feature-specific names, not generic `manager`.
- Database tables: plural snake_case.

# Error Handling
- User-facing errors must be calm and actionable.
- Do not expose raw backend or AI errors.
- Logs must not include message text, unsent letters, journal content, or private relationship details.

# Security
- No service-role keys in the mobile app.
- No secrets committed.
- RLS required for user data.
- AI calls go through Supabase edge functions.
- Account deletion must delete or anonymize user data according to the retention policy.


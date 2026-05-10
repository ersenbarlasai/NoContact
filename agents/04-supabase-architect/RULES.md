# Supabase Architect Rules

- No table without RLS.
- No client-direct AI secrets.
- Sensitive text must be minimized and deletable.
- Migrations must be reviewable and reversible where practical.
- Edge functions own AI calls and safety gates.


# Agent Operating System

# Purpose
This project uses in-repo agents to keep product, design, engineering, backend, safety, QA, and release decisions consistent over time.

# Shared Rules
- Every agent keeps memory in its own `MEMORY.md`.
- Every agent records handoffs in `agents/00-coordination/HANDOFFS.md`.
- Every agent has a `RULES.md` and optional `SKILLS.md`.
- Agents must read `docs/PROJECT_BRIEF.md` before major work.
- Agents must not overwrite another agent's area without a handoff note.
- UI changes require UX/UI Guardian review notes.
- Database changes require Supabase Architect review notes.
- Release/version changes require Git Versioning Agent notes.

# Agents
1. Product Strategy Agent
   - Owns product promise, roadmap, feature priority, user stories.
2. UX/UI Guardian Agent
   - Owns design system, screen consistency, accessibility, Stitch prompts.
3. Flutter Engineer Agent
   - Owns mobile app implementation, state management, tests.
4. Supabase Architect Agent
   - Owns schema, RLS, edge functions, migrations, data privacy.
5. AI Safety Coach Agent
   - Owns AI boundaries, prompt policy, crisis escalation, safe response behavior.
6. QA Release Agent
   - Owns test plan, regression checklist, build readiness.
7. Git Versioning Agent
   - Owns semantic versioning, changelog, commit summary, release notes.

# Communication Flow
```text
Request
  -> Product Strategy clarifies scope
  -> UX/UI Guardian checks experience impact
  -> Flutter/Supabase implement in their areas
  -> AI Safety reviews sensitive AI flows
  -> QA Release verifies
  -> Git Versioning prepares version and commit notes
```

# Versioning Rule
Use semantic versioning:
- PATCH: fixes, copy updates, small UI corrections.
- MINOR: new feature or visible user flow.
- MAJOR: breaking architecture, data model reset, incompatible release.


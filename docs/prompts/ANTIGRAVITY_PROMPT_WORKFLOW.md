# Antigravity Prompt Workflow

# Trigger
When the user writes `@prompt` followed by a task, produce a ready-to-paste Antigravity prompt.

# Prompt Must Include
- Goal.
- Current project context.
- Relevant files/folders.
- Responsible agent roles.
- Exact scope.
- Constraints.
- Acceptance criteria.
- Tests/verification.
- Handoff note requirement.

# Template
```text
You are working in the NoContact mobile app project.

Goal:
[clear outcome]

Context:
- Flutter mobile app for iOS and Android.
- Supabase backend.
- Product promise: open the app before contacting an ex; get calm, clear, private guidance.
- Follow docs/PROJECT_BRIEF.md and docs/agents/AGENT_OPERATING_SYSTEM.md.

Responsible agents:
- [agent names]

Scope:
- [files/modules to edit]

Constraints:
- Do not change unrelated files.
- Preserve design-system tokens and UI patterns.
- Add/update tests when behavior changes.
- Add a handoff note under agents/00-coordination/HANDOFFS.md.

Acceptance criteria:
- [measurable outcomes]

Verification:
- Run Flutter analyze/tests or explain why not possible.
```


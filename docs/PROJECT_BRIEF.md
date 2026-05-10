# Project Brief

# Working Title
NoContact yeniden gelistirme projesi: ayrilik sonrasi kullanicinin en kirilgan aninda dusunmeden mesaj atmasini yavaslatan, iyilesme surecini takip eden ve guvenli AI destek sunan mobil uygulama.

# Product Promise
Kullanici ilk ekranda sunu hissetmeli: "Eski sevgilime yazmadan once buraya gelmeliyim. Burası beni yargilamadan sakinlestiriyor, ne yapacagimi netlestiriyor ve ilerledigimi gosteriyor."

# Platforms
- Flutter mobile app: iOS and Android first.
- Supabase backend: Auth, database, storage, edge functions, realtime where needed.
- Later: marketing site, PWA, therapist/coach dashboard.

# Core Principles
- Crisis-first: SOS mode is always one tap away.
- Privacy-first: emotionally sensitive content must be treated as highly sensitive data.
- AI-with-boundaries: AI is a coach and reflection tool, not a therapist or emergency service.
- Localized from day one: Turkish first, English-ready architecture.
- Design consistency: the app must feel calm, premium, trustworthy, and never randomly redesigned.
- Agent-governed development: every major workstream has a named agent, memory, rules, and handoff notes.

# MVP Feature Set
1. Onboarding and personal recovery profile:
   - breakup date, relationship length, contact risk times, attachment pattern, personal reasons for no-contact.
2. Home screen:
   - no-contact day counter, today mood check-in, next recommended action, SOS button.
3. SOS mode:
   - 90-second breathing, urge timer, personal rules, "write here instead" draft area, post-SOS reflection.
4. AI message analysis:
   - paste incoming message, detect tone/manipulation risk, suggest no-reply or healthy reply.
5. Mood journal:
   - daily mood, triggers, notes, trend chart, weekly insight.
6. Unsent letters vault:
   - private writing area, optional ritual archive/delete flow.
7. Guided recovery path:
   - staged exercises with progress, not a rigid medical diagnosis.
8. Safety and transparency:
   - AI limitations, crisis resources, data privacy explanation, account/data deletion.
9. Freemium structure:
   - free: tracker, limited journal, basic SOS.
   - premium: AI coach, message analysis, advanced insights, full exercises, voice later.

# Differentiators We Should Add
- SOS follow-up score: did the user contact or not, what helped, what triggered the urge.
- Predictive support: user-defined risky times and mood trends trigger timely reminders.
- Consent-driven privacy: explain what is stored, what is local, what is sent to AI.
- Anonymous micro-support later: heavily constrained peer support, not an open chaotic forum.
- Glow-up mode after recovery: confidence, routines, hobbies, social rebuilding.

# Non-Negotiables
- No manipulative "get your ex back" promise in core product positioning.
- No claim that AI replaces therapy.
- No inconsistent UI experiments without design-system approval.
- No backend table without RLS policy.
- No release without version note and changelog.


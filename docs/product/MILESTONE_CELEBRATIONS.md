# Milestone Celebrations (Kilometre Taşları)

Milestone Celebrations are quiet, reflective moments designed to acknowledge user progress in their recovery journey. They follow the "Still" design philosophy—prioritizing emotional maturity and long-term grounding over short-term dopamine hits.

## Philosophy
- **Quiet Recognition**: Acknowledgment should feel like a warm, supportive nod, not a noisy celebration.
- **No Confetti**: Avoid bright, fast, or flashy animations. Use soft fades and subtle shifts.
- **Reflective Copy**: Use Turkish messaging that emphasizes awareness and self-kindness.
- **Literata Typography**: Use the serif Literata font for milestone titles to evoke a journal-like, mature feel.

## Milestone Triggers
Milestones are triggered deterministically based on local app state:

### 1. Persistence Milestones (İletişimsizlik)
- **3 Days**: The first hurdle.
- **7 Days**: Building a rhythm.
- **14 Days**: Deepening the habit.
- **30 Days**: A major milestone of transformation.

### 2. Action Milestones (İlk Adımlar)
- **First SOS**: Managing the first major urge.
- **First Mood Journal**: The start of emotional awareness.
- **First Unsent Letter**: Catharsis without breaking contact.

### 3. Growth Milestones (Yolculuk)
- **Phase Completion**: Transitioning between the 5 phases of the Recovery Path.

## Technical Implementation
- **Storage**: State is stored locally via `MilestoneRepository`. No sensitive data (journal/letter content) is tracked.
- **Triggering**: `MilestoneService` checks for new milestones whenever the recovery state updates.
- **Presentation**: `MilestoneOverlay` is a non-intrusive layer in `MainScaffold`.

## UI/UX Rules
- **Palette**: Use Sage, Cream, and Terracotta.
- **Motion**: Respect system reduced-motion settings.
- **Interaction**: Never block the user. The "Yoluma Dön" (Return to my journey) button should be the primary action.

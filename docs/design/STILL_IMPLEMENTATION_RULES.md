# Still Implementation Rules

## Components

### 1. Buttons
- **Primary:** Pill-shaped, Sage background (#53624f), white text.
- **Secondary:** Pill-shaped, transparent or tonal background, Manrope bold.
- **Tertiary/Accent:** Terracotta (#8b4e3d) reserved for human/emotional actions (like letters or SOS).

### 2. Cards
- Large radius (lg: 16px or xl: 24px).
- Low-opacity organic shadows (no heavy black shadows).
- Tonal background (surface-container-low).

### 3. SOS Styling
- **Visible but not aggressive.**
- Use Terracotta accents.
- Avoid bright red alert colors.
- Focused, distraction-free layout.

### 4. Mood Journal
- Mature markers, avoid childish emojis.
- Journal-like feel with Literata support text.
- Restricted color palette for emotions.

## UI/UX Dos and Don'ts

### Do
- Use **Literata** for reflective or high-level headings.
- Use **Manrope** for functional UI, buttons, and dense information.
- Use **Tonal Layering** (surface levels) to create hierarchy.
- Use **Pill shapes** for all action elements.
- Keep privacy copy prominent and accurate.

### Don't
- Use **Broken-heart clichés**.
- Use **Neon colors** or high-arousal contrasts.
- Use **Negative letter spacing** in implementation.
- Over-engineer components.
- Make it look like a dating app.

## Motion & Transitions

- **Low Arousal:** Transitions should be subtle and purposeful. Avoid bouncy, rapid, or high-contrast animations.
- **Calm Pacing:** Use durations between 200ms and 400ms.
- **Curves:** Prefer `Curves.easeOutCubic` for a soft deceleration feel.
- **Technique:**
  - Use `StillPageTransition` helper for all main route changes.
  - **Fade-through:** Standard for lateral navigation (e.g., between dashboard and journal).
  - **Shared Axis Vertical:** Used for deep progression (e.g., opening the Recovery Path).
  - **Immediate Fade:** Used for critical actions (e.g., SOS) to ensure speed without abruptness.
- **Reduced Motion:** Always respect `MediaQuery.of(context).disableAnimations` by falling back to instant transitions.

## Accessibility
- Contrast ratios must meet WCAG AA at minimum.
- Letter spacing should be 0 or positive.
- Minimum touch target 44x44px.

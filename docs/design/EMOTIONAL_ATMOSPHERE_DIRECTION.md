# Emotional Atmosphere Design Direction

This document outlines the visual and emotional evolution of the Still (NoContact) app, moving from a clean functional interface to a tactile, atmospheric, and deeply supportive digital sanctuary.

## Visual Mood Summary
The "Emotional Atmosphere" transition is inspired by misty landscapes, organic light, and the quiet dignity of internal healing. 

- **Key Textures**: Mist, soft grain, tactile paper, layered transparencies.
- **Color Palette**: Sage (sage), cream (kaymak), sand (kum), charcoal (is), and muted terracotta (toprak).
- **Light Direction**: Soft, diffused dawn light. No harsh shadows or direct artificial light sources.

---

## Design Tokens & System

### 1. Emotional Background Gradients
Gradients should be implemented as large, soft mesh gradients that feel like weather patterns rather than digital fills.

| Context | Gradient Direction | Feel |
| :--- | :--- | :--- |
| **Onboarding** | Soft Sand to Warm Cream | Hopeful, spacious, a new beginning. |
| **Home** | Misty Sage to Light Cream | Calm, alive, a safe refuge. |
| **SOS** | Charcoal to Deep Sage | Protective, grounding, holding space. |
| **Mood Journal** | Morphing Pastel Hues | Fluid, non-judgmental, acknowledging change. |
| **Quiet Library** | Muted Moss to Sand | Studious, serene, focused. |
| **Recovery Path** | Misty Blue/Grey to Charcoal | The dignity of the climb, resilience. |

### 2. Tactile Interaction Rules
- **Pressed States**: Instead of simple color changes, use a "soft press" effect—subtle scaling (0.98) combined with a slight increase in background blur.
- **Haptic Feedback**: Implement light haptics for navigation and medium haptics for "commitment" actions (e.g., 24-hour pause).
- **Surface Overlays**: Cards should feel like heavy paper or frosted glass resting on the misty background.

### 3. Typography Evolution
- **Literata (Serif)**: For all headlines and poetic moments. Increased letter spacing for a more editorial feel.
- **Manrope (Sans)**: For functional labels and data, ensuring high readability without breaking the mood.

---

## Light Atmospheric Image System (REVISED)

The direction is now shifted toward a **Light Atmospheric Image System**, utilizing custom generated assets for each state of mind.

### 1. Vision
Light, airy, and high-key atmospheric images provide a sense of "open space" and "breathability." Combined with translucent "Glass" surfaces, the UI feels lightweight and modern.

### 2. Time-of-Day Logic (Home Screen)
The Home screen background reflects the user's local time:
- **06:00 - 11:00 (Morning Mist)**: `home_morning_mist.png`
- **11:00 - 17:00 (Soft Daylight)**: `home_soft_daylight.png`
- **17:00 - 21:00 (Evening Sand)**: `home_evening_sand.png`
- **21:00 - 06:00 (Night Shelter)**: `home_night_shelter.png`

### 3. Screen Mapping
- **Onboarding**: `onboarding_dawn.png`
- **SOS**: `sos_shelter_light.png`
- **Mood Journal**: `journal_aura.png`
- **Recovery Path**: `recovery_horizon.png`

### 4. Glass Surfaces (StillGlassCard)
- **Blur**: 20px
- **Opacity**: 0.7 (Cream/White)
- **Border**: 0.55 alpha White
- **Readability**: Scrim overlay applied to backgrounds (0.35 - 0.45 alpha white) to ensure text contrast.

---
*Note: Light Atmospheric Image System asset integration completed.*

## Screen-by-Screen Direction

### Home Dashboard
- **Background**: A very light, misty sage mesh gradient.
- **Bento Cards**: Slightly more transparent (alpha 0.15 to 0.2) with a background blur filter.
- **Bugünün Desteği**: Should feel like a glowing lantern or a warm spot in the mist.

### SOS & Breathing Guide
- **Atmosphere**: Deep charcoal and sage. The screen should feel "low light" to reduce visual stress.
- **Breathing Circle**: Replace the geometric circle with a morphing organic shape (resembling a soft cloud or a pulsing light).
- **Audio**: Optional soft ambient pad (non-looping feeling) and a subtle breathing guide sound (ocean-like inhalation/exhalation).

### Mood Journal
- **Abstract Forms**: Replace emojis with organic shapes. High pleasantness = brighter, more expansive shapes. Low pleasantness = denser, more grounded shapes.
- **Interaction**: A slider that morphs the shape in real-time as the user moves from "Unpleasant" to "Pleasant".

### Letters Vault
- **Atmosphere**: Tactile paper textures. The "Locked" state should feel like a sealed envelope rather than a digital padlock.
- **Color**: Sand and charcoal.

### Recovery Path (30 Günlük Yol)
- **Metaphor**: A misty mountain path. Each milestone is a "resting stone" or a "viewpoint".
- **Visuals**: Low-contrast vertical line representing the path, disappearing into soft mist at the top.

---

## Icon Refresh Direction
- **Stroke**: 2px weight, rounded caps and joins.
- **Organic Ends**: Subtle "tapering" at the ends of lines where possible.
- **Symbols**:
    - **Support**: A lighthouse or a soft shield.
    - **Pause**: A gentle vertical break, not a digital "||".
    - **Path**: A winding organic line.

---

## Optional SOS Audio Concept
To enhance the grounding experience, we will introduce a "Sound Atmosphere" layer:
- **Sounds**: Soft ambient pads, rain, or distant waves.
- **Control**: Always starts muted. A single, elegant "Sound" toggle on the SOS screen.
- **Privacy**: No audio recording. Audio is synthesized or triggered locally.

---

## Accessibility Rules
- **Atmosphere vs. Clarity**: Atmosphere must never reduce action clarity. Primary actions remain visibly tappable with clear fills and high-contrast text.
- **Contrast**: Even with soft gradients, all text must maintain WCAG 2.1 AA contrast ratios.
- **Motion**: Respect the user's "Reduced Motion" settings. Gradients should be static if reduced motion is on.
- **Typography**: Minimum body text size remains 16pt.

---

## Implementation Plan

### Phase A: Token & Background System [DONE]
- [x] Define the Mesh Gradient utility (`EmotionalGradients`).
- [x] Update `AppColors` with the expanded "Atmosphere" palette via `emotional_tokens.dart`.
- [x] Implement the `EmotionalBackground` wrapper.
- [x] Implement `StillTactilePress` and integrate it into core `Still` widgets.

**Tokens Implemented:**
- `EmotionalGradients`: `homeMist`, `onboardingDawn`, `sosShelter`, etc.
- `EmotionalTokens`: `pressedScale` (0.98), `tactileDuration` (150ms), `surfaceBlur` (12.0).

**Widget Usage:**
```dart
EmotionalBackground(
  variant: EmotionalVariant.home,
  child: Scaffold(...),
)
```
### Phase B: Home & SOS Refresh [DONE]
- [x] Apply misty backgrounds to Home.
- [x] Redesign SOS with the protective charcoal gradient.
- [x] Implement the organic soft aura for the breathing guide.
- [x] Refine "Bugünün Desteği" visual priority on the home dashboard.

### Phase C: Onboarding & Mood Journal
- [ ] Update Onboarding flow with the "Dawn" atmosphere.
- [ ] Implement morphing organic shapes for mood tracking.

### Phase D: Icon Refresh
- [ ] Audit and replace current icons with the refined 2px organic set.

### Phase E: Ambient Audio
- [ ] Integrate the non-invasive SOS audio player.

---
*Note: This plan preserves all existing business logic while elevating the emotional resonance of the user experience.*

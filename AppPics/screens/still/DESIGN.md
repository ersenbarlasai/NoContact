---
name: Still
colors:
  surface: '#f9f9fa'
  surface-dim: '#dadadb'
  surface-bright: '#f9f9fa'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f3f3f4'
  surface-container: '#eeeeef'
  surface-container-high: '#e8e8e9'
  surface-container-highest: '#e2e2e3'
  on-surface: '#1a1c1d'
  on-surface-variant: '#444841'
  inverse-surface: '#2f3132'
  inverse-on-surface: '#f0f1f1'
  outline: '#747871'
  outline-variant: '#c4c8bf'
  surface-tint: '#53624f'
  primary: '#53624f'
  on-primary: '#ffffff'
  primary-container: '#8a9a84'
  on-primary-container: '#243221'
  inverse-primary: '#bbcbb3'
  secondary: '#605e57'
  on-secondary: '#ffffff'
  secondary-container: '#e6e2d8'
  on-secondary-container: '#66645d'
  tertiary: '#8b4e3d'
  on-tertiary: '#ffffff'
  tertiary-container: '#cb836f'
  on-tertiary-container: '#501f11'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#d7e7cf'
  primary-fixed-dim: '#bbcbb3'
  on-primary-fixed: '#121f10'
  on-primary-fixed-variant: '#3c4b38'
  secondary-fixed: '#e6e2d8'
  secondary-fixed-dim: '#cac6bd'
  on-secondary-fixed: '#1c1c16'
  on-secondary-fixed-variant: '#484740'
  tertiary-fixed: '#ffdbd1'
  tertiary-fixed-dim: '#ffb5a1'
  on-tertiary-fixed: '#380d03'
  on-tertiary-fixed-variant: '#6f3728'
  background: '#f9f9fa'
  on-background: '#1a1c1d'
  surface-variant: '#e2e2e3'
typography:
  display-lg:
    fontFamily: literata
    fontSize: 40px
    fontWeight: '600'
    lineHeight: 48px
    letterSpacing: -0.02em
  headline-md:
    fontFamily: literata
    fontSize: 28px
    fontWeight: '500'
    lineHeight: 36px
  headline-sm:
    fontFamily: literata
    fontSize: 22px
    fontWeight: '500'
    lineHeight: 30px
  body-lg:
    fontFamily: manrope
    fontSize: 18px
    fontWeight: '400'
    lineHeight: 28px
  body-md:
    fontFamily: manrope
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  label-md:
    fontFamily: manrope
    fontSize: 14px
    fontWeight: '600'
    lineHeight: 20px
    letterSpacing: 0.01em
  support-text:
    fontFamily: literata
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  unit: 8px
  margin-mobile: 24px
  margin-desktop: 64px
  gutter: 16px
  section-gap: 48px
---

## Brand & Style

The brand personality of this design system is centered on the concept of "The Quiet Companion." It is designed to feel like a steady exhale—providing a safe, non-judgmental space for users navigating the emotional volatility of a breakup. The visual direction rejects the high-energy gamification of dating apps and the sterile detachment of medical platforms in favor of a **Warm Minimalist** aesthetic.

This design system uses organic influence and soft transitions to evoke emotional intelligence. It prioritizes grounding the user through "Visual Silence"—limiting distractions and using generous negative space to prevent cognitive overwhelm. The experience should feel tactile and human, moving away from digital coldness toward the texture of a high-quality linen journal or a calm morning.

## Colors

The color strategy uses a low-arousal palette to promote physiological de-escalation.

- **Primary (Sage Green):** Used for primary actions and progress indicators. It represents growth and grounding.
- **Secondary (Warm Sand/Cream):** The foundation of the UI. Used for large surfaces to create a soft, inviting environment that feels warmer than pure white.
- **Accent (Soft Terracotta):** Reserved for human touches, such as mood tracking, highlighting "aha" moments, and gentle reminders.
- **Neutral (Deep Charcoal):** Provides high-contrast clarity for text, ensuring the interface feels trustworthy and authoritative without being harsh.
- **SOS/Alert:** A muted version of the accent color is used for "Help" or "SOS" features. It must be visible enough to find instantly but lacks the aggressive "emergency" vibration of standard red.

## Typography

The typographic system utilizes a dual-font approach to balance function and feeling.

- **Supportive Serif (Literata):** Used for headlines, affirmations, and reflective content. This font feels bookish and scholarly, providing a sense of wisdom and human presence.
- **Functional Sans-Serif (Manrope):** Used for navigation, labels, and instructional text. It is modern and highly legible, ensuring the user never struggles to understand how to move through the app.

Scale is used to create a clear hierarchy; supportive messages are given more weight and space to breathe, while functional elements remain tucked away until needed.

## Layout & Spacing

This design system employs a **Fluid-Floating Layout** philosophy. Content is rarely cramped; instead, it sits in clear "islands" of information with generous padding.

- **Rhythm:** An 8px base grid is used, but the "Section Gap" is intentionally large (48px+) to force a slower scrolling pace.
- **Margins:** 24px side margins on mobile ensure that content does not feel squeezed against the glass edge.
- **Reflow:** On larger screens, the content width is capped at 720px for readability, maintaining the intimate feeling of a handheld journal even on desktop devices.

## Elevation & Depth

To maintain the "grounded" feel, this design system avoids floating elements or high-altitude shadows. 

1.  **Ambient Depth:** Surfaces use extremely soft, diffused shadows (Blur: 20px-40px) with very low opacity (5-8%). The shadow color should be tinted with a hint of Sage or Terracotta rather than pure black to keep the look organic.
2.  **Tonal Layering:** Depth is primarily created through color shifts. A slightly darker "Sand" surface might sit on a lighter "Cream" background.
3.  **Soft Focus:** Background blurs (10px) are used behind modals to keep the user's current emotional context visible while focusing on the new task.

## Shapes

The shape language is defined by "The Pebble" philosophy—elements should look like stones worn smooth by water. 

- **Containers:** Use a large radius (16px to 24px) to remove any visual "sharpness" or perceived threat.
- **Interactive Elements:** Buttons and chips use the highest roundedness settings (Pill-shaped) to invite touch and feel approachable.
- **Icons:** Icons should be drawn with rounded terminals and thick strokes (2px) to match the mature, expressive aesthetic.

## Components

- **Buttons:** Primary buttons are Sage Green with white text; secondary buttons use a ghost style with a Soft Terracotta border. Always use generous internal padding.
- **SOS Component:** A dedicated "Breath" or "Panic" button, styled as a soft-glowing circular element. It should be pinned but use a subtle pulse animation rather than a flashing alert.
- **Mood Expressors:** Instead of "childish" emojis, use abstract, mature icons or tonal gradients to represent complex emotions.
- **Cards:** Used for journal entries or lessons. Cards should have no border, using only a subtle shadow and a color-fill change to indicate their boundaries.
- **Input Fields:** Fields should feel like a writing line in a journal. Use a soft underline or a very light background fill rather than a heavy box.
- **Progress Tiers:** Use organic, non-linear shapes (like a growing vine or tide marks) rather than industrial bars to track healing progress.
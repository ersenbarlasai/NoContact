# App Icon Production Specification

## 1. Source Requirements
- Create the master vector file (e.g., SVG, AI, Figma) inside `assets_store/icon/source/`.
- Must adhere to the approved `pause_reflect_icon` concept.

## 2. Colors & Shapes
- **Background:** Sage Green (`#849A89`).
- **Foreground:** Cream (`#FAF9F6`) or subtle Terracotta.
- **Motif:** A soft circular ring with a minimalist "pause" symbol inside.
- **What to Avoid:** No text, no dating/broken heart icons, no medical crosses, no chat bubbles, no "AI" badges.

## 3. iOS Icon Checklist
Target folder: `assets_store/icon/ios/`
- [ ] Export size: `1024x1024` pixels.
- [ ] Format: PNG, 24-bit.
- [ ] Transparency: None (No alpha channel).
- [ ] Corners: Square (Do not pre-round corners; iOS handles the mask).

## 4. Android Adaptive Icon Guidance
Target folder: `assets_store/icon/adaptive/`
- Android 8.0+ requires adaptive icons consisting of a background layer and a foreground layer.
- **Background Layer:** `108x108 dp` (Export as vector or large PNG), containing just the Sage background.
- **Foreground Layer:** `108x108 dp` (Export as vector or large PNG with transparent background), containing the ring and pause symbol.
- **Safe Zone:** Keep the primary motif within the central `72x72 dp` area to ensure it is not cut off by device-specific masking (circle, squircle, teardrop).

## 5. Play Store Icon Checklist
Target folder: `assets_store/icon/android/`
- [ ] Export size: `512x512` pixels.
- [ ] Format: PNG, 32-bit (Alpha allowed).
- [ ] Max File Size: 1 MB.
- [ ] Corners: Square (Google Play handles the rounding).

## 6. Acceptance Criteria
- Icon reads clearly at small sizes (e.g., 16x16 px).
- Visually calming, matching the "Still" philosophy.
- Passes both iOS and Android format requirements.

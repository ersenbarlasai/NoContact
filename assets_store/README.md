# Store Assets Production Guide

Welcome to the `assets_store` directory. This is the centralized hub for all final graphic assets destined for the App Store and Google Play Store for the NoContact ("Still") MVP.

## 1. Approved Directions
- **Primary Icon:** `pause_reflect_icon` (Sage background, soft circular ring, pause symbol, no text, no clichés).
- **Screenshot Style:** `SOS mode visual` style. Spacious, minimal, using the Still design tokens (Sage, Cream, Terracotta).

## 2. Directory Structure
- `/icon`: Source files and exports for iOS (`1024x1024` PNG) and Android (Adaptive vectors/PNGs).
- `/screenshots`: Source files and exports grouped by target store (`app_store` and `play_store`).
- `/previews`: Temporary review exports for stakeholders.

## 3. General Rules & Constraints
- **Turkish Text Requirement:** ALL visible in-phone UI text and overlay text MUST be localized to Turkish. No English placeholders.
- **Privacy-Safe Data:** Use only safe, non-identifiable mock text in the screenshot UI. Never use real user journal entries, letters, or message content.
- **Prohibited Claims:** Do not make any visual or textual claims of "guaranteed healing", "therapy", or "emergency medical support". Do not present mock AI features as real production AI.
- **No HTML/CSS Copying:** The Stitch HTML references are visual guides only. Do not copy their code into the Flutter app.

## 4. File Naming Conventions
- `iOS_67_01_Home.png`
- `Android_01_Home.png`
- `Icon_1024.png`

## 5. Final Review
Before finalizing assets, always run through the `FINAL_ASSET_REVIEW_CHECKLIST.md` located in the `/previews` folder.

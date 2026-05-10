# MVP Release Checklist - NoContact

## 1. Flutter Build Readiness
- [ ] Run `flutter analyze` and resolve any critical errors.
- [ ] Run `flutter test` and ensure all 36+ tests pass.
- [ ] Verify `AppStartupController` handles both first-launch and offline returning users correctly.
- [ ] Verify local notification permissions work on iOS and Android.

## 2. Android Package & Signing
- [ ] Update `pubspec.yaml` version code (e.g., `1.0.0+1`).
- [ ] Set up `keystore.jks` for Android app signing.
- [ ] Update `android/app/build.gradle` with signing configs.
- [ ] Generate Android App Bundle (`flutter build appbundle --release`).

## 3. iOS Bundle & Signing
- [ ] Update `pubspec.yaml` version code.
- [ ] Update `ios/Runner/Info.plist` with necessary permissions (FaceID, Notifications).
- [ ] Set up Apple Developer account, Certificates, and Provisioning Profiles in Xcode.
- [ ] Generate iOS Archive and upload to App Store Connect (`flutter build ipa --release`).

## 4. Supabase Environment
- [ ] Ensure Supabase URL and Anon Key in `.env` point to production (if applicable) or a stable MVP backend.
- [ ] Verify Row Level Security (RLS) is enabled on all tables, even if unused by MVP.

## 5. Privacy Policy
- [ ] Publish Privacy Policy to a live URL (e.g., `stillapp.com/privacy`).
- [ ] Ensure the policy accurately reflects local-only storage of sensitive data.

## 6. Store Listings
- [ ] Complete App Store Connect metadata (TR language).
- [ ] Complete Google Play Console metadata (TR language).
- [ ] Fill out the Data Safety forms in both stores accurately (No sensitive user data collected).
- [ ] Submit App Icon (1024x1024).

## 7. Screenshots
- [ ] Generate 6-8 localized (TR) screenshots matching `SCREENSHOT_PLAN.md`.
- [ ] Format for 6.5" iPhone, 5.5" iPhone, and standard Android sizes.

## 8. Known Limitations (Document for Internal / Review)
- AI Message Analysis is currently a local mock engine.
- Subscriptions are in placeholder mode; no real billing occurs.

## 9. Pre-release Manual QA Checklist
- [ ] Install release build on physical iOS device.
- [ ] Install release build on physical Android device.
- [ ] Complete Onboarding.
- [ ] Add a Mood Journal entry, verify it saves.
- [ ] Add a Letter, verify it saves.
- [ ] Open Settings, enable Biometric Lock, close app, reopen, verify lock appears.
- [ ] Enable Daily Rhythm, verify notification schedules without crashing.
- [ ] Press SOS, navigate flow, exit gracefully.
- [ ] Clear Local Data from Settings, verify app resets to Onboarding.

# Web Beta / Vercel Deployment Plan

**Purpose:** Provide early access to the NoContact (Still) MVP for test users to gather product feedback without needing to install an app from the App Store or Play Store.

## 1. What Can Be Tested
- The core "Still" design philosophy (Sage, Cream, Terracotta palette).
- The Onboarding flow.
- The Home Dashboard and basic navigation.
- The SOS Mode flow (breathing exercise, urge logging).
- The Mood Journal and Letters Vault interfaces.
- The Quiet Growth Insights.
- The mock AI Message Analysis flow.

## 2. Web Limitations (What Cannot Be Fully Tested)
- **Biometric Lock:** `local_auth` is not supported seamlessly on web. It is disabled in the web beta.
- **Local Notifications (Daily Rhythm):** Scheduled local notifications via `flutter_local_notifications` do not work on web. It is disabled or noted as "Mobil uygulamada aktif olacak".
- **Encrypted Storage:** `flutter_secure_storage` uses web storage mechanisms which are not as secure as native KeyChain/Keystore. Users are warned not to enter highly sensitive real data.
- **Offline Reliability:** While Flutter Web can cache, it is not as reliable as native offline mode.

## 3. Privacy Warnings
The beta version includes clear warnings:
- "Bu erken web test sürümüdür. Gerçek mobil deneyimde bildirimler, biyometrik kilit ve cihaz güvenliği farklı çalışır."
- "Web test sürümünde veriler tarayıcıda geçici olarak saklanabilir. Lütfen gerçek hassas içerik girmeyin."
- No real AI calls are made.
- No real billing or payments are active.

## 4. Recommended Test User Flow
1. Open the Vercel URL.
2. Complete onboarding.
3. Tap SOS to experience the crisis flow.
4. Try writing a test mood or test letter.
5. Go to Settings and tap "Beta geri bildirimi gönder" to fill out the feedback form.

## 5. Feedback Collection
A simple external URL (`BETA_FEEDBACK_FORM_URL`) is linked from the Settings page to collect structured feedback. See `BETA_FEEDBACK_FORM_QUESTIONS.md` for the questions.

## 6. Vercel Deployment Steps
1. Push the repository to GitHub.
2. In Vercel, import the project.
3. Set the Root Directory to `app/mobile` (if Vercel doesn't auto-detect).
4. Build Command: `flutter build web --release`
5. Output Directory: `build/web`
6. Deploy.

*Note: The `vercel.json` file handles routing all paths to `index.html` to support Flutter's routing.*

## 7. Rollback / Removal Plan
Once the mobile apps are launched in the App Store/Play Store, the Vercel project will be deleted or redirected to the official landing page to prevent users from accidentally using the less-secure web version for real emotional journaling.

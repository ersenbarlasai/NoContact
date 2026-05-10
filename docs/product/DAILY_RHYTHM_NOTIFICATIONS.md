# Daily Rhythm & Local Notifications (Günlük Ritim)

Daily Rhythm is an opt-in system that provides gentle reminders to help users stay grounded in their recovery without pressure or manipulative urgency.

## Philosophy
- **Gentle Presence**: Notifications should feel like a soft tap on the shoulder, not a demand.
- **No Guilt**: Avoid streak-based pressure or language that implies failure if a day is missed.
- **Visual & Verbal Silence**: Short, calm copy in Turkish.
- **Absolute Privacy**: No sensitive data (names, notes, SOS text) ever leaves the device or appears in the notification preview.

## Key Features
- **Daily Check-in**: A reminder to visit the app for a mood journal entry or a moment of reflection.
- **Custom Schedule**: Users can choose exactly when they want to be nudged.
- **Easy Opt-out**: Notifications can be toggled off at any time from Settings.
- **Permission Respect**: Permissions are requested only when the user explicitly enables the rhythm, not on first launch.

## Copy Rules
- **Encouraged**:
  - “Bugün kendini bir cümleyle yoklamak ister misin?”
  - “Küçük bir duraklama iyi gelebilir.”
  - “Bugün de kendini seçtiğin anları fark et.”
- **Strictly Forbidden**:
  - “Streak’in bozulacak!”
  - “Hemen gir ve yaz!”
  - “Neden bugün yazmadın?”
  - Mentioning specific people or events.

## Data & Privacy
- **Local-Only**: All scheduling happens on the device using `flutter_local_notifications`.
- **No Cloud Sync**: Notification preferences are stored in local storage and not synced to Supabase.
- **Payload Safety**: Notification bodies are generic and supportive, never containing user-generated content.

## Technical Details
- **Infrastructure**: `NotificationService` (Wrapper around `flutter_local_notifications`).
- **Timezone Support**: `TimezoneHelper` ensures notifications fire at the correct local time.
- **Controller**: `RhythmController` manages state and schedules/cancels reminders based on user settings.

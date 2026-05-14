# Daily Rhythm & Local Notifications (Günlük Ritim)

Daily Rhythm is an opt-in system that provides gentle reminders to help users stay grounded in their recovery without pressure or manipulative urgency.

---

## Still Notification Philosophy

The notification system in Still is designed to feel like a **quiet companion**, not a productivity app. Every design decision follows these core principles:

| Principle | Description |
|---|---|
| **Local-Only** | All notifications are scheduled on-device via `flutter_local_notifications`. Zero cloud involvement. |
| **Opt-In** | Only the main daily reminder is available by default. All sub-rhythms (morning, midday, evening) and contextual notifications are explicitly toggled on by the user. |
| **Privacy-Safe** | No sensitive content (partner name, letter body, SOS text, mood note, diary entry) ever appears in a notification payload. |
| **Low Frequency** | The system is designed to send at most 1 scheduled daily notification by default, expandable to 4 if all sub-rhythms are enabled — but never more. |
| **Context-Aware** | Key events (SOS completion, 24h pause, silent reply to vault) can trigger a single follow-up notification the next day. |
| **No Manipulation** | Language never uses streaks, failure framing, or urgency. It opens a door — it does not push. |
| **Custom Soft Sound** | Android notifications use the bundled `still_soft_chime.wav` sound from `android/app/src/main/res/raw/`. It is short, soft, and intentionally non-alarming. |

---

## Notification Types & IDs

| ID | Name | Trigger | Copy |
|---|---|---|---|
| 1 | **Daily** | Daily at user-chosen time (default 20:30) | "Bugün kendini bir cümleyle yoklamak ister misin?" |
| 2 | **Morning** | Opt-in · Every day ~08:00 | "Bugün kendine sert davranmadan ilerleyebilirsin." |
| 3 | **Midday** | Opt-in · Every day ~12:30 | "Bir an durup bedenini fark etmek ister misin?" |
| 4 | **Evening** | Opt-in · Every day ~21:00 | "Bugün içinden geçenleri güvenli bir yere bırakabilirsin." |
| 10 | **24h Pause Follow-Up** | Contextual · 24 hours after 24h pause started | "Dün kendine bir alan açmıştın. Şimdi daha sakin bir yerden bakabilirsin." |
| 11 | **Post-SOS Follow-Up** | Contextual · Next day at 10:00 after SOS completed | "Dün zor bir anı atlattın. Bugün biraz daha yavaş ilerleyebilirsin." |
| 12 | **Silent Reply Follow-Up** | Contextual · Same day 22:00 or next day 09:00 after vault save | "Göndermeden bıraktığın şey hâlâ güvende." |
| 9999 | **Debug Test** | kDebugMode only · 1 minute delay | Internal test only |

---

## Settings UI (Ayarlar > Günlük Ritim)

```
[✓] Günlük Ritim              ← Ana toggle. Kapatınca tüm ritim bildirimleri iptal edilir.
    Ana Hatırlatma Saati: 20:30 ← Tıklanabilir saat seçici
    ─────────────────────────
    [ ] Sabah Nazik Başlangıç  ← Opt-in, ~08:00
    [ ] Öğlen Kısa Duraklama   ← Opt-in, ~12:30
    [ ] Akşam Yansıması        ← Opt-in, ~21:00
    ─────────────────────────
    [✓] Bağlama Göre Hatırlatmalar  ← SOS/24h/Sessiz Cevap sonrası nazik takip
```

All sub-rhythm and contextual toggles are **only visible when the main rhythm is enabled**.

---

## Copy Rules

### ✅ Encouraged Language
- "Bugün kendini bir cümleyle yoklamak ister misin?"
- "Küçük bir duraklama iyi gelebilir."
- "Bugün de kendini seçtiğin anları fark et."
- "Temas etmemek de bir seçimdir."
- "Şu an güçlü hissetmek zorunda değilsin."

### 🚫 Strictly Forbidden
- "Streak kaybettin" / "Streak'in bozulacak!"
- "Başarısız oldun" / "Neden bugün yazmadın?"
- "Ex", eski partner adı, herhangi bir özel isim
- "Hemen gir!" / "Son şansın!"
- "Terapi" veya klinik dil
- "İyileşeceğin garanti" veya spekülatif vaat
- Kullanıcının yazdığı herhangi bir özel metin

---

## Technical Architecture

### NotificationService (`lib/core/notifications/notification_service.dart`)

```dart
// Sabit ID haritası
NotificationIds.daily         = 1
NotificationIds.morning       = 2
NotificationIds.midday        = 3
NotificationIds.evening       = 4
NotificationIds.pauseFollowUp = 10
NotificationIds.postSos       = 11
NotificationIds.silentReply   = 12

// Ritim metodları
scheduleDailyReminder()
scheduleMorningReminder()
scheduleMiddayReminder()
scheduleEveningReflectionReminder()

// Bağlamsal metodlar
schedule24hPauseFollowUp()     ← 24 saat sonra, tek seferlik
schedulePostSosFollowUp()      ← Ertesi gün 10:00, tek seferlik
scheduleSilentReplyFollowUp()  ← Aynı gün 22:00 veya ertesi gün 09:00
scheduleContextualReminder()   ← Genel amaçlı tek seferlik, delay ile

// İptal metodları
cancelById(int id)             ← Tek ID iptali
cancelDailyRhythm()            ← ID 1-4 toplu iptal
cancelContextualReminders()    ← ID 10-12 toplu iptal
cancelAll()                    ← Tüm bildirimleri iptal et
```

### RhythmSettings (Freezed model)

```dart
bool isEnabled            // Ana toggle
int hour, minute          // Ana hatırlatma saati (default 20:30)
bool hasRequestedPermission
bool morningEnabled       // Sabah opt-in
bool middayEnabled        // Öğlen opt-in
bool eveningEnabled       // Akşam opt-in
bool contextualEnabled    // Bağlamsal bildirimler (default: true)
```

### Contextual Notification Guard

Bağlamsal bildirimler yalnızca şu koşulların **tamamı** sağlandığında planlanır:

1. `rhythmSettings.isEnabled == true` (Günlük Ritim açık)
2. `rhythmSettings.contextualEnabled == true` (Bağlamsal bildirimler açık)
3. İlgili olay gerçekleşti (SOS tamamlandı / 24h pause başladı / vault kayıt yapıldı)

### Custom Sound

- Android: `android/app/src/main/res/raw/still_soft_chime.wav`
  - `AndroidNotificationChannel(sound: RawResourceAndroidNotificationSound('still_soft_chime'))`
  - `AndroidNotificationDetails(sound: RawResourceAndroidNotificationSound('still_soft_chime'))`
  - Channel ID: `daily_rhythm_soft`
- iOS: `Runner/still_soft_chime.aiff`
  - `DarwinNotificationDetails(sound: 'still_soft_chime.aiff')`
  - Current iOS behavior: system default sound until the iOS bundle asset is added.
- Hedef ses karakteri: kısa (1-2sn), yumuşak, hafif cam/seramik tınısı. Alarm değil, nazik farkındalık.

---

## Data & Privacy

- **Local-Only**: All scheduling happens on-device using `flutter_local_notifications`.
- **No Cloud Sync**: Notification preferences are stored in `LocalStorageService` (SharedPreferences) and never synced to Supabase.
- **Payload Safety**: Notification bodies are generic and privacy-safe. No user-generated content, no PII, no contextual event details.
- **Android 13+**: `POST_NOTIFICATIONS` runtime permission is requested only when the user explicitly enables the rhythm.
- **Schedule Mode**: `AndroidScheduleMode.inexactAllowWhileIdle` — battery-friendly, Doze-compatible, no exact alarm permission required.

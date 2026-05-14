# Still / NoContact Developer Teknik Dokuman

Bu dokuman Still / NoContact uygulamasinin teknik mimarisini, veri isleme ve saklama politikasini, ekran akislari ile moduller arasi entegrasyonlari aciklar. Amac yeni bir geliştiricinin uygulamayi guvenli sekilde anlamasi, degistirmesi ve Android/iOS derlemelerine hazirlamasidir.

## 1. Proje Ozeti

Still / NoContact, Flutter ile gelistirilen Android/iOS odakli bir mobil uygulamadir. Uygulama ayrilik sonrasi "temas etmeme" kararini destekleyen yerel, gizlilik odakli araclar sunar.

Temel teknik tercih:

- **Frontend:** Flutter
- **State management:** Riverpod / StateNotifier
- **Navigation:** GoRouter + custom Still page transitions
- **Local non-sensitive storage:** `shared_preferences` uzerinden `LocalStorageService`
- **Sensitive local storage:** `flutter_secure_storage` uzerinden `EncryptedStorageService`
- **Backend:** Supabase, opsiyonel ve dart-define ile etkinlestirilir
- **Notifications:** `flutter_local_notifications`, `timezone`, `flutter_timezone`
- **Biometric/device lock:** `local_auth`
- **Models:** Freezed + JsonSerializable

Uygulama Supabase anahtarlari olmadan da calisacak sekilde tasarlanmistir. Bu durumda profil ve temel ilerleme yerel cihazda tutulur.

## 2. Klasor Yapisi

Ana mobil uygulama:

```text
app/mobile/
  lib/
    app/
      bootstrap/
      router/
      theme/
      presentation/
    core/
      design_system/
      navigation/
      notifications/
      services/
      storage/
    data/
      models/
      repositories/
    features/
      home/
      onboarding/
      sos/
      support_system/
      silent_reply/
      letters_vault/
      mood_journal/
      library/
      recovery_path/
      insights/
      milestones/
      daily_rhythm/
      privacy_lock/
      subscription/
      settings/
      splash/
      message_analysis/
```

Backend ve dokumantasyon:

```text
supabase/
  migrations/
  docs/

docs/
  product/
  architecture/
  release/
  store/
```

Koordinasyon:

```text
agents/00-coordination/HANDOFFS.md
```

## 3. Uygulama Baslatma Sirasi

Giris noktasi:

```text
app/mobile/lib/main.dart
```

Baslatma sirasi:

1. `WidgetsFlutterBinding.ensureInitialized()`
2. `SupabaseService.initialize()`
3. `LocalStorageService.init()`
4. `TimezoneHelper.init()`
5. `NotificationService.init()`
6. `ProviderScope`
7. `NoContactApp`

`SupabaseService.initialize()` su dart-define degerlerini okur:

```bash
SUPABASE_URL
SUPABASE_ANON_KEY
```

Bu degerler yoksa debug modda su uyari beklenir:

```text
Supabase configuration missing. Persistence will be disabled.
```

Bu bir crash degildir. Uygulama yerel modda devam eder.

## 4. Routing ve Ekran Haritasi

Router:

```text
app/mobile/lib/app/router/app_router.dart
```

Ana rotalar:

| Route | Ekran | Amac |
| --- | --- | --- |
| `/splash` | SplashScreen | Baslangic kontrolu |
| `/onboarding` | OnboardingScreen | Ilk kurulum ve profil toplama |
| `/` | HomeScreen | Ana dashboard |
| `/sos` | SosScreen | Kriz ani / nefes / temas etmeme destegi |
| `/mood-journal` | MoodJournalScreen | Gunluk duygu yansimasi |
| `/letters-vault` | LettersVaultScreen | Gonderilmeyen mektuplar |
| `/letters-vault/editor` | LetterEditorScreen | Mektup olusturma/duzenleme |
| `/settings` | SettingsScreen | Ayarlar, gizlilik, bildirimler |
| `/support-center` | SupportCenterScreen | Bugunun Destegi |
| `/library` | LibraryScreen | Sessiz Kutuphane |
| `/library/:id` | LibraryDetailScreen | Kutuphane icerik detayi |
| `/silent-reply` | SilentReplyScreen | Gondermeden cevap yazma |
| `/recovery-path` | RecoveryPathScreen | 30 gunluk yol / iyilesme yolu |
| `/insights` | InsightsScreen | Sessiz gelisim ozetleri |
| `/subscription` | SubscriptionScreen | Plan/limit placeholder |
| `/beta-feedback` | BetaFeedbackScreen | Supabase destekli beta geri bildirim |
| `/message-analysis` | MessageAnalysisScreen | Ertelenmis/ikincil mesaj analizi alani |

Startup redirect mantigi:

- `AppStartupStatus.loading` iken kullanici `/splash` rotasinda tutulur.
- Onboarding tamamlanmissa `/` rotasina yonlendirilir.
- Profil yoksa veya onboarding tamamlanmamissa `/onboarding` rotasina yonlendirilir.

## 5. State Management

Projede Riverpod `Provider`, `FutureProvider` ve `StateNotifierProvider` kullanilir.

Ornek provider kaynaklari:

```text
app/mobile/lib/data/repositories/providers.dart
```

Onemli controller'lar:

| Controller | Gorev |
| --- | --- |
| `AppStartupController` | Oturum/profil geri yukleme ve ilk rota karari |
| `OnboardingController` | RecoveryProfile toplama ve kaydetme |
| `SosController` | SOS oturumu ve tamamlanma davranisi |
| `SupportController` | Kriz kartlari, tek cumle not, 24 saat bekleme |
| `SilentReplyController` | Sessiz Cevap akisi, kasa/24h/SOS cikislari |
| `LettersVaultController` | Mektup CRUD, arsiv, silme |
| `MoodJournalController` | Gunluk yansima, streak, 7 gunluk ozet |
| `RecoveryPathController` | Yol adimlari ve gunluk gorev |
| `InsightsController` | Lokal metriklerin toplanmasi |
| `MilestoneController` | Sessiz kilometre taslari |
| `RhythmController` | Bildirim ayarlari ve planlama |
| `PrivacyLockController` | Hassas ekran kilidi |
| `EntitlementController` | Yerel plan/limit sistemi |

## 6. Veri Siniflari ve Saklama Matrisi

| Veri | Model / Kaynak | Saklama | Hassasiyet | Bulut |
| --- | --- | --- | --- | --- |
| Recovery profile | `RecoveryProfile` | LocalStorage + opsiyonel Supabase | Orta | Supabase varsa |
| Onboarding tamamlandi | `RecoveryProfile.isOnboardingCompleted` | LocalStorage + opsiyonel Supabase | Dusuk/orta | Supabase varsa |
| SOS metadata | `SosSession` | Local/Supabase repository | Orta | Supabase varsa metadata |
| SOS ham yazisi | UI memory | Kaydedilmez | Yuksek | Hayir |
| Mood entry | `MoodEntry` | EncryptedStorageService | Yuksek | Hayir |
| Mood note | `MoodEntry.note` | EncryptedStorageService | Yuksek | Hayir |
| Unsent letter | `UnsentLetter` | EncryptedStorageService | Yuksek | Hayir |
| Crisis cards | `CrisisCard` | EncryptedStorageService | Yuksek | Hayir |
| 24h pause timestamp | `LocalSupportRepository` | LocalStorageService | Dusuk | Hayir |
| Managed urge event | `ManagedUrgeEvent` | LocalStorageService | Dusuk metadata | Hayir |
| Rhythm settings | `RhythmSettings` | LocalStorageService | Dusuk | Hayir |
| Milestone seen status | `MilestoneRepository` | LocalStorageService | Dusuk | Hayir |
| Beta feedback | `BetaFeedback` | Supabase | Orta | Evet |
| Subscription/usage placeholder | Entitlement models | LocalStorageService | Dusuk | Gelecek |

Not: `ManagedUrgeEvent` yalnizca `id`, `source`, `createdAt` tutar. Metin, isim, duygu detayi veya kullanici girdisi saklamaz. Bu nedenle su an `LocalStorageService` uzerindedir. Ileride metrik hassas kabul edilirse `EncryptedStorageService`e tasinabilir.

## 7. Local Storage Servisleri

### LocalStorageService

Dosya:

```text
app/mobile/lib/core/storage/local_storage_service.dart
```

`shared_preferences` sarmalayicisidir. String, int, bool, JSON ve JSON list destekler.

Kullanim alanlari:

- Onboarding profili local fallback.
- 24 saat bekleme timestamp.
- Bildirim ayarlari.
- Managed urge metadata.
- Milestone durumlari.

### EncryptedStorageService

Dosya:

```text
app/mobile/lib/core/storage/encrypted_storage_service.dart
```

`flutter_secure_storage` sarmalayicisidir.

Android:

- `EncryptedSharedPreferences`

iOS:

- Keychain, `first_unlock` accessibility.

Kullanim alanlari:

- Gunluk notlari.
- Mektup kasasi.
- Kriz kartlari ve kisisel destek notlari.

## 8. Supabase Mimari Ozeti

Supabase opsiyoneldir. Yapilandirma yoksa uygulama yerel calisir.

Baslatma:

```text
app/mobile/lib/core/services/supabase_service.dart
```

Remote repository'ler:

```text
app/mobile/lib/data/repositories/recovery_profile_repository.dart
app/mobile/lib/data/repositories/sos_session_repository.dart
app/mobile/lib/data/repositories/beta_feedback_repository.dart
app/mobile/lib/data/repositories/auth_repository.dart
```

Migration dosyalari:

```text
supabase/migrations/20260510000000_init_schema.sql
supabase/migrations/20260510000001_beta_feedback.sql
```

Temel tablolar:

- `profiles`
- `recovery_profiles`
- `sos_sessions`
- `beta_feedback`

RLS prensibi:

- Kullanici kendi profil/recovery/SOS verisini gorebilir ve yazabilir.
- Beta feedback icin uygulama tarafindan insert yapilir; kullanicilar diger geri bildirimleri okuyamaz.

Anonim auth:

- Onboarding tamamlanirken Supabase aktifse `AuthRepository.signInAnonymously()` cagrilir.
- Kullaniciya e-posta/sifre UI'i gosterilmez.
- Remote upsert islemi anonim user id uzerinden yapilir.

## 9. Onboarding Akisi

Dosyalar:

```text
app/mobile/lib/features/onboarding/presentation/onboarding_screen.dart
app/mobile/lib/features/onboarding/presentation/onboarding_controller.dart
app/mobile/lib/data/models/recovery_profile.dart
```

Toplanan alanlar:

- `name`
- `reason`
- `relationshipDuration`
- `timeSinceBreakup`
- `whoEnded`
- `noContactStartDate`
- `dominantEmotion`
- `contactTriggers`
- `commitmentAcceptedAt`
- `isOnboardingCompleted`
- `appDisclaimerSeen`
- `aiConsentAccepted`

Kaydetme sirasi:

1. State `isOnboardingCompleted: true` yapilir.
2. Profil once local repository'ye yazilir.
3. Supabase aktifse anonim auth yapilir.
4. Profil remote repository ile upsert edilir.
5. Remote hata olsa bile local profil korunur.

## 10. Ana Ekran

Dosya:

```text
app/mobile/lib/features/home/presentation/home_screen.dart
```

Ana ekran su provider/controller'lardan beslenir:

- `onboardingControllerProvider`
- `supportControllerProvider`
- `managedUrgeCountProvider`
- Mood journal state
- Letters vault state
- Recovery/daily path state

Ana sorumluluklar:

- Iletisimsiz gun sayisini gostermek.
- Bugunun Destegi dinamik durumunu gostermek.
- 24 saat bekleme aktifse kalan sureyi gostermek.
- Kucuk arac kartlari ile ilgili ekranlara yonlendirmek.
- Floating SOS butonunu her zaman erisilebilir tutmak.

## 11. SOS Modulu

Dosyalar:

```text
app/mobile/lib/features/sos/presentation/sos_screen.dart
app/mobile/lib/features/sos/presentation/sos_controller.dart
app/mobile/lib/data/models/sos_session.dart
```

Akis:

1. Breathe
2. Remember
3. Write here instead
4. Choose yourself

Gizlilik:

- Ham yazilan SOS metni persist edilmez.
- Tamamlama metadata'si local/remote repository'ye gidebilir.
- Managed urge event olarak `source: 'sos'` kaydedilir.
- Bildirim ayari aciksa ertesi gun 10:00 icin post-SOS follow-up planlanir.

## 12. Trustworthy Support System

Dosyalar:

```text
app/mobile/lib/features/support_system/presentation/support_center_screen.dart
app/mobile/lib/features/support_system/presentation/support_controller.dart
app/mobile/lib/features/support_system/data/local_support_repository.dart
app/mobile/lib/features/support_system/domain/crisis_card.dart
```

Ozellikler:

- Neden baslamistim?
- Tek cumle not
- 24 saat bekleme
- Kriz kartlari

Saklama:

- Kriz kartlari encrypted storage.
- 24 saat bekleme timestamp local storage.
- 24 saat bekleme baslatilirsa `source: 'support_wait'` managed urge event kaydedilir.
- Contextual notifications aciksa 24 saat sonrasi follow-up planlanir.

## 13. Sessiz Cevap

Dosyalar:

```text
app/mobile/lib/features/silent_reply/presentation/silent_reply_screen.dart
app/mobile/lib/features/silent_reply/presentation/silent_reply_controller.dart
app/mobile/lib/features/silent_reply/domain/silent_reply_need.dart
```

Akis:

1. Kullanici gondermek istedigi cevabi yazar.
2. Yazma ihtiyacini secer.
3. Guvenli cikis secer.

Cikislar:

- Kasaya birak: `LettersVaultController.saveLetter()` uzerinden sifreli mektup kaydi.
- 24 saat beklet: Support 24h pause baslatma.
- SOS'a gec: `/sos`
- Sakin alternatif: Statik, manipule etmeyen sinir dili.

Managed urge kaynaklari:

- `silent_reply_vault`
- `silent_reply_wait`

Sessiz Cevap ham metni sadece kullanici "Kasaya birak" dediginde `UnsentLetter` olarak sifreli saklanir.

## 14. Mektup Kasasi

Dosyalar:

```text
app/mobile/lib/features/letters_vault/presentation/letters_vault_screen.dart
app/mobile/lib/features/letters_vault/presentation/letter_editor_screen.dart
app/mobile/lib/features/letters_vault/presentation/letters_vault_controller.dart
app/mobile/lib/data/repositories/local_letters_vault_repository.dart
app/mobile/lib/data/models/unsent_letter.dart
```

Repository davranisi:

- `fetchLetters()` deleted olmayan mektuplari getirir.
- `archiveLetter()` `archivedAt` set eder.
- `restoreLetter()` `archivedAt` temizler.
- `deleteLetter()` soft delete icin `deletedAt` set eder.
- `hardDeleteLetter()` listeden tamamen cikarir.
- `clearLetters()` encrypted storage key'ini siler.

Onemli entegrasyon:

- Sessiz Cevap'tan kasa kaydi dogrudan repository yerine `LettersVaultController` uzerinden yapilmalidir. Boylece UI state aninda guncellenir.

## 15. Mood Journal / Gunluk

Dosyalar:

```text
app/mobile/lib/features/mood_journal/presentation/mood_journal_screen.dart
app/mobile/lib/features/mood_journal/presentation/mood_journal_controller.dart
app/mobile/lib/data/repositories/local_mood_journal_repository.dart
app/mobile/lib/data/models/mood_entry.dart
```

Urun kurali:

- Takvim gunu bazlidir.
- Ayni gun kayit varsa edit modudur.
- Yeni gun basladiginda yeni yansima olusturulur.

Saklama:

- Mood entries encrypted storage'da tutulur.
- Eski plain shared_preferences verisi varsa migration ile encrypted storage'a tasinmasi desteklenmistir.
- Notlar buluta gonderilmez.

## 16. Sessiz Kutuphane

Dosyalar:

```text
app/mobile/lib/features/library/data/static_library_repository.dart
app/mobile/lib/features/library/presentation/library_screen.dart
app/mobile/lib/features/library/presentation/library_detail_screen.dart
app/mobile/lib/features/library/domain/library_item.dart
```

Icerik static ve localdir. Internet veya Supabase gerekmez.

Kategori ornekleri:

- Ilk gunler
- Durtu geldiginde
- Sosyal medya
- Ozlem dalgasi
- Sinir koymak
- Kendini suclama
- Geri donme dongusu
- Gece zorlanmalari

Her item:

- Baslik
- Kategori
- Okuma suresi
- Tip
- Govde metni
- Yansima sorusu
- Onerilen aksiyon

## 17. 30 Gunluk Yol ve Recovery Path

Dosyalar:

```text
app/mobile/lib/features/recovery_path/data/static_30_day_recovery_plan.dart
app/mobile/lib/features/recovery_path/application/recovery_path_builder.dart
app/mobile/lib/features/recovery_path/presentation/recovery_path_screen.dart
app/mobile/lib/features/recovery_path/domain/recovery_path_step.dart
app/mobile/lib/features/recovery_path/domain/daily_recovery_step.dart
```

Iki katman vardir:

1. **Static 30-day daily plan:** Her gun icin tema, gorev, soru, aksiyon.
2. **Dynamic recovery path:** Kullanici ilerlemesine gore completed/active/locked durumlari.

Deep-link davranisi:

- SOS ile ilgili adimlar `/sos`
- Gunluk adimlari `/mood-journal`
- Yazma adimlari `/silent-reply`
- Kutuphane adimlari `/library`
- Destek adimlari `/support-center`

Kilitli adimlar tiklanamaz.

## 18. Managed Urge Metrigi

Dosyalar:

```text
app/mobile/lib/data/models/managed_urge_event.dart
app/mobile/lib/data/repositories/local_managed_urge_repository.dart
app/mobile/lib/data/repositories/providers.dart
```

Kaynaklar:

- `sos`
- `silent_reply_vault`
- `silent_reply_wait`
- `support_wait`

Urun kurali:

- 2 dakika icinde gelen birden fazla guvenli cikis tek kriz aninin yonetilmesi sayilir.
- Bu nedenle sadece +1 event yazilir.
- Eski SOS sayaci legacy fallback olarak okunur ve toplam sayiya eklenir.
- Eski sayaç artik artirilmaz.

Provider:

```dart
managedUrgeCountProvider
```

Yeni event sonrasi ilgili controller provider'i invalidate etmelidir:

```dart
ref.invalidate(managedUrgeCountProvider);
```

## 19. Bildirim Sistemi

Dosyalar:

```text
app/mobile/lib/core/notifications/notification_service.dart
app/mobile/lib/core/notifications/timezone_helper.dart
app/mobile/lib/features/daily_rhythm/presentation/rhythm_controller.dart
app/mobile/lib/features/daily_rhythm/domain/rhythm_settings.dart
app/mobile/lib/features/daily_rhythm/data/rhythm_repository.dart
```

Android custom sound:

```text
app/mobile/android/app/src/main/res/raw/still_soft_chime.wav
```

Notification channel:

```text
daily_rhythm_soft
```

Bildirim ID haritasi:

| ID | Bildirim |
| --- | --- |
| 1 | Ana gunluk hatirlatma |
| 2 | Sabah hatirlatmasi |
| 3 | Oglen hatirlatmasi |
| 4 | Aksam yansimasi |
| 10 | 24 saat bekleme follow-up |
| 11 | SOS sonrasi follow-up |
| 12 | Sessiz Cevap sonrasi follow-up |
| 9999 | Debug test bildirimi |

`RhythmSettings` alanlari:

- `isEnabled`
- `hour`
- `minute`
- `hasRequestedPermission`
- `morningEnabled`
- `middayEnabled`
- `eveningEnabled`
- `contextualEnabled`

Guard kurali:

- Contextual bildirimler sadece `isEnabled && contextualEnabled` ise planlanmalidir.
- Ana toggle kapanirsa `NotificationService.cancelAll()` cagrilir.
- Contextual toggle kapanirsa yalnizca ID 10, 11, 12 iptal edilir.
- Bildirim metinleri sabittir; hassas veri icermez.

Android manifest izinleri:

- `USE_BIOMETRIC`
- `POST_NOTIFICATIONS`
- `RECEIVE_BOOT_COMPLETED`
- `VIBRATE`
- `USE_EXACT_ALARM`
- `SCHEDULE_EXACT_ALARM` max SDK 32

Not: Android notification channel sesi sistem tarafindan cache'lenebilir. Ses degistirildiyse test cihazinda uygulamayi tamamen kaldirip yeniden yuklemek gerekebilir.

## 20. Biyometrik Kilit

Dosyalar:

```text
app/mobile/lib/features/privacy_lock/presentation/privacy_lock_controller.dart
app/mobile/lib/features/privacy_lock/data/privacy_lock_repository.dart
```

Korunan alanlar:

- Mood Journal
- Letters Vault
- Letter Editor

Kilitlenmeyen alanlar:

- SOS
- Home
- Settings
- Support Center

Sebep: Kriz aninda yardima erisim engellenmemelidir.

Session timeout yaklasimi:

- Kisa sureli unlock penceresi vardir.
- Sure dolunca veya session temizlenince tekrar dogrulama istenir.
- Biometrik veri uygulamada saklanmaz.

## 21. Settings ve Veri Temizleme

Dosya:

```text
app/mobile/lib/features/settings/presentation/settings_screen.dart
```

Sorumluluklar:

- Profil ve plan alanlarina erisim.
- Beta geri bildirim.
- Gunluk Ritim ayarlari.
- Biyometrik kilit toggle.
- Yerel verileri temizleme.
- Kalici veri silme aksiyonu icin UI.

Yerel veri temizleme su alanlari kapsamalidir:

- Local recovery profile.
- Mood journal encrypted entries.
- Letters vault encrypted letters.
- Crisis cards.
- 24h pause state.
- Managed urge events.
- Rhythm settings.
- In-memory provider invalidation.

## 22. Beta Feedback

Dosyalar:

```text
app/mobile/lib/features/settings/presentation/beta_feedback_screen.dart
app/mobile/lib/features/settings/presentation/beta_feedback_controller.dart
app/mobile/lib/data/repositories/beta_feedback_repository.dart
app/mobile/lib/data/models/beta_feedback.dart
supabase/migrations/20260510000001_beta_feedback.sql
```

Bu akisin amaci test kullanicilarindan uygulama icinden geri bildirim toplamaktir.

RLS:

- Kullanici insert yapabilir.
- Kullanici diger geri bildirimleri okuyamaz.
- Admin Supabase panelinden geri bildirimleri inceleyebilir.

## 23. Subscription ve Limitler

Dosyalar:

```text
app/mobile/lib/features/subscription/
```

Mevcut durum:

- Yerel entitlement sistemi vardir.
- Free/Premium ayrimi placeholder olarak tutulur.
- Payment entegrasyonu aktif degildir.
- Gelecekte RevenueCat veya App Store / Play Store billing katmani eklenebilir.

## 24. Message Analysis Durumu

Kod tabaninda `message_analysis` feature'i bulunur; ancak ana release vaadi bu degildir.

Mevcut urun karari:

- Spekulatif veya kalitesiz mesaj analizi kullanici guvenini zedeleyebilir.
- Ana akista mesaj analizi yerine Trustworthy Support System, Sessiz Cevap, SOS ve yerel guvenli araclar one alinir.
- Gercek AI tekrar devreye alinacaksa ayri consent, maliyet kontrolu, kalite eval seti ve server-side rate limiting zorunludur.

Ilgili dokuman:

```text
docs/architecture/PRODUCTION_AI_MESSAGE_ANALYSIS.md
```

## 25. Design System

Temel dosyalar:

```text
app/mobile/lib/app/theme/app_theme.dart
app/mobile/lib/core/design_system/still_widgets.dart
app/mobile/lib/core/design_system/emotional_background.dart
app/mobile/lib/core/design_system/emotional_tokens.dart
app/mobile/lib/core/design_system/still_tactile.dart
```

Tasarim ilkeleri:

- Still / Quiet Companion.
- Dusuk uyaranli, sakin, yargisiz.
- Sage, cream, terracotta, charcoal tonlari.
- Atmosferik arka plan gorselleri.
- Glass card yuzeyleri.
- Tactile press etkisi.
- SOS erisimi her zaman belirgin ama agresif olmayan tonda.

Asset dizini:

```text
app/mobile/assets/backgrounds/
```

Android bildirim sesi:

```text
app/mobile/android/app/src/main/res/raw/still_soft_chime.wav
```

## 26. Android / iOS Build Notlari

Tum Flutter komutlari `app/mobile` dizininden calistirilmalidir.

Yanlis dizinde calistirilirsa beklenen hata:

```text
Error: No pubspec.yaml file found.
This command should be run from the root of your Flutter project.
```

Dogru dizin:

```powershell
cd C:\Users\barlas\Desktop\PROJELER\NoContact\app\mobile
```

Debug APK:

```powershell
flutter build apk --debug --target-platform android-arm64
```

Supabase aktif build:

```powershell
flutter build apk --release `
  --dart-define=SUPABASE_URL=YOUR_URL `
  --dart-define=SUPABASE_ANON_KEY=YOUR_ANON_KEY
```

Store release icin:

- Android signing config tamamlanmali.
- iOS bundle id, signing ve provisioning ayarlanmali.
- App icon ve screenshot assetleri final olmalidir.
- Data Safety / Privacy Nutrition bilgileri bu dokumandaki veri matrisiyle uyumlu doldurulmalidir.

## 27. Troubleshooting

### Pubspec hatasi

Komut `app/mobile` disinda calisiyor. Dizin degistirin.

### Supabase configuration missing

`SUPABASE_URL` veya `SUPABASE_ANON_KEY` verilmemis. Yerel mod icin normaldir.

### Bildirim gelmiyor

Kontrol listesi:

- Ayarlardan Gunluk Ritim aktif mi?
- Android 13+ icin bildirim izni verildi mi?
- Contextual bildirim icin `contextualEnabled` acik mi?
- Uygulama pil optimizasyonu tarafindan kisitlandi mi?
- Notification channel eski sesle cache'lenmis olabilir mi? Gerekirse uygulamayi kaldirip yeniden yukleyin.

### Mektup kasasi aninda guncellenmiyor

Sessiz Cevap veya baska bir akistan mektup kaydi yapiliyorsa `LocalLettersVaultRepository` yerine `LettersVaultController.saveLetter()` kullanilmalidir. Bu UI state'in aninda yenilenmesini saglar.

### Arka plan assetleri gorunmuyor

Asset eklendikten sonra hot reload yeterli olmayabilir. Full restart veya clean build gerekebilir.

### Turkish karakterler dokumanda bozuk gorunuyor

Bazi eski dosyalarda encoding bozulmalari bulunabilir. Yeni dokumanlar UTF-8 olarak tutulmalidir.

## 28. Gelistirme Kurallari

- Hassas metinleri loglama.
- Gunluk notu, mektup govdesi, SOS metni veya Sessiz Cevap ham metnini Supabase'e gonderme.
- SOS'u paywall veya biometric lock arkasina koyma.
- Yeni feature eklendiginde veri matrisi ve gizlilik metni guncellenmeli.
- Yeni bildirim eklenirse NotificationIds haritasina eklenmeli ve hassas veri icermedigi dogrulanmali.
- Yeni route eklendiginde GoRouter ve MainScaffold etkileri kontrol edilmeli.
- `StillGlassCard` gibi design system widget'larinin desteklemedigi parametreler dogrudan eklenmemeli; gerekiyorsa API tasarlanarak merkezi bileşen guncellenmeli.
- Build/test komutlari sadece kullanici izin verdiginde veya acikca istendiginde calistirilmali.

## 29. Referans Dokumanlar

Urun ve mimari kararlar icin:

```text
docs/product/TRUSTWORTHY_SUPPORT_SYSTEM.md
docs/product/SILENT_LIBRARY_AND_30_DAY_PATH.md
docs/product/SILENT_REPLY.md
docs/product/DAILY_RHYTHM_NOTIFICATIONS.md
docs/product/RECOVERY_PATH.md
docs/product/QUIET_GROWTH_INSIGHTS.md
docs/product/MILESTONE_CELEBRATIONS.md
docs/architecture/PRODUCTION_AI_MESSAGE_ANALYSIS.md
docs/release/MVP_RELEASE_READINESS_AUDIT.md
supabase/docs/schema.md
supabase/docs/rls.md
```


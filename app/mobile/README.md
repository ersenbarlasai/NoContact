# NoContact — Still

> *The Quiet Companion* · Duygusal iyileşme ve no-contact yolculuğu için yerel öncelikli mobil uygulama.

---

## Proje Genel Bakış

NoContact (Still), romantik ilişki sonrası iletişim kesmek isteyen bireylere yönelik, **gizlilik öncelikli**, **klinik dil kullanmayan**, **offline-first** bir Flutter uygulamasıdır.

---

## Mimari

```
lib/
├── app/                  # Router, tema, ana scaffold
├── core/
│   ├── design_system/    # Still widget kütüphanesi
│   ├── notifications/    # Local notification servisi
│   └── storage/          # SharedPreferences katmanı
├── data/
│   ├── models/           # Veri modelleri
│   └── repositories/     # Local repository'ler
├── features/
│   ├── home/             # Ana sayfa + timer
│   ├── onboarding/       # 11 adımlı akış
│   ├── sos/              # Kriz destek akışı
│   ├── mood_journal/     # Duygu günlüğü
│   ├── letters_vault/    # Mektup kasası
│   ├── silent_reply/     # Sessiz cevap akışı
│   ├── recovery_path/    # 30 günlük yol
│   ├── insights/         # İçgörüler
│   ├── message_analysis/ # Mesaj analizi (AI)
│   ├── settings/         # Ayarlar + veri yönetimi
│   └── support_system/   # 24h duraklama sistemi
└── l10n/                 # Lokalizasyon (TR + EN)
    ├── app_tr.arb        # Türkçe (template)
    ├── app_en.arb        # İngilizce
    ├── app_localizations.dart
    ├── app_localizations_tr.dart
    └── app_localizations_en.dart
```

---

## Lokalizasyon

Uygulama **`flutter gen-l10n`** altyapısını kullanır. Cihaz dili Türkçe ise Türkçe, diğer dillerde İngilizce görüntülenir.

### Yapılandırma

`l10n.yaml`:
```yaml
arb-dir: lib/l10n
template-arb-file: app_tr.arb
output-localization-file: app_localizations.dart
```

`pubspec.yaml`:
```yaml
flutter:
  generate: true
```

### Yeni Anahtar Ekleme

1. `lib/l10n/app_tr.arb` dosyasına Türkçe anahtarı ekle
2. `lib/l10n/app_en.arb` dosyasına İngilizce anahtarı ekle
3. `flutter pub get` çalıştır (otomatik üretim tetiklenir)
4. Ekranda `AppLocalizations.of(context).keyName` ile kullan

### Bildirim Lokalizasyonu

`NotificationService` BuildContext'e erişemediğinden ayrı bir `NotificationStrings` sınıfı kullanılır:

```dart
final strings = NotificationStrings.fromLanguageCode(languageCode);
await NotificationService.scheduleMorningReminder(languageCode: languageCode);
```

---

## Tasarım Sistemi — Still

Tüm UI bileşenleri `lib/core/design_system/still_widgets.dart` içindeki hazır widget'lar üzerinden oluşturulur:

| Widget | Kullanım |
|---|---|
| `StillPrimaryButton` | Ana aksiyon butonu |
| `StillSecondaryButton` | İkincil aksiyon |
| `StillGlassCard` | Cam efektli kart |
| `StillSectionHeader` | Bölüm başlığı |
| `StillTextField` | Metin girişi |
| `StillPrivacyNotice` | Gizlilik notu |
| `EmotionalBackground` | Arka plan gradyanı |

---

## Bildirimler

Tüm bildirimler **yereldir** — sunucuya hiçbir veri gönderilmez.

| ID | Tür | Tetikleyici |
|---|---|---|
| 1 | Günlük ritim | Kullanıcı seçimi |
| 2 | Sabah | 08:00 günlük |
| 3 | Öğle | 12:30 günlük |
| 4 | Akşam | 21:00 günlük |
| 10 | 24h takip | 24h duraklama sonrası |
| 11 | SOS takip | Ertesi gün 10:00 |
| 12 | Sessiz cevap | Aynı gün 22:00 |

---

## Geliştirme

```bash
# Bağımlılıkları yükle
flutter pub get

# Lokalizasyon üret
flutter pub get   # generate: true otomatik tetikler

# Geliştirme modunda çalıştır
flutter run

# Analiz
flutter analyze

# Testler
flutter test
```

---

## Gizlilik İlkeleri

- Tüm veriler **cihazda** saklanır (SharedPreferences)
- Mektup, günlük ve SOS içerikleri hiçbir sunucuya gönderilmez
- Bildirimler hassas içerik taşımaz
- Mesaj analizi için yalnızca kullanıcı onaylı geçici iletim yapılır

---

## Lisans

© 2025 NoContact. Tüm hakları saklıdır.

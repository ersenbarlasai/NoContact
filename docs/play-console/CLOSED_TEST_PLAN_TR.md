# Nosto Kapali Test Plani

Son guncelleme: 2026-05-16

Amaç: Google Play uretim erisimi oncesinde Nosto'yu en az 12 tester ile 14 ardışık gun kapali test etmek, kalite risklerini azaltmak ve basvuru icin somut geri bildirim toplamak.

## 1. Test Kapsami

Testerlar su akislari denemeli:

- Uygulamayi Play kapali test linkinden yukleme
- TR cihaz dilinde onboarding
- EN cihaz dilinde onboarding veya dil fallback kontrolu
- Home ekraninda Temassiz Gunler sayaci
- SOS akisi:
  - 90 Saniye Dur
  - Nefes Al / Nefes Ver
  - Gondermeden Yaz
  - Bugun Temas Etmeyecegim
- Ayarlar:
  - bildirim izni
  - biyometrik kilit
  - yerel veri temizleme
- Premium guard:
  - Duygu Gunlugu, Gonderilmeyen Mektuplar, 30 Gunluk Yol, Sessiz Cevap gibi alanlarda paywall dogru cikiyor mu?
- Bildirimler:
  - Gunluk Ritim acilabiliyor mu?
  - Bildirim metinleri rahatsiz edici mi?

## 2. Tester Grubu

Minimum:
- 12 opted-in tester
- 14 ardışık gun

Onerilen:
- 15-20 tester davet et
- En az 12 kisinin opt-in yaptigini Play Console'da dogrula
- Testerlarin farkli cihaz/Android surumleri kullanmasini sagla

Tester listesi takip tablosu:

| Tester | E-posta | Cihaz | Android surumu | Opt-in tarihi | Ilk kurulum | Geri bildirim | Not |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 1 |  |  |  |  |  |  |  |
| 2 |  |  |  |  |  |  |  |
| 3 |  |  |  |  |  |  |  |

## 3. Gunluk Test Ritmi

1. Gun:
- Uygulama kurulumu
- Onboarding
- Home ve SOS
- Ilk feedback formu

2-7. Gun:
- SOS ve bildirim testi
- Paywall davranisi
- Hata/taşma/crash gozlemi

8-14. Gun:
- Tekrar kullanim hissi
- Bildirimlerin rahatsiz edici olup olmadigi
- Uygulamanin isim/dil/marka guveni
- Son feedback formu

## 4. Tester Mesaji

Tester daveti icin metin:

```text
Merhaba,

Nosto'nun kapali testine davetlisin. Nosto, temas etme istegi geldiginde durmana, yazmadan once kendini duymana ve kendine geri donmene yardim eden sessiz bir mobil alandir.

Lutfen Play Store test linkinden uygulamayi yukle, onboarding'i tamamla ve ozellikle SOS, Temassiz Gunler sayaci, Ayarlar ve paywall davranisini dene.

Test suresi en az 14 gun. Her gun uzun kullanman gerekmiyor; ancak uygulamayi kurulu tutman, ara ara acman ve geri bildirim vermen bizim icin cok degerli.

Geri bildirim formu: [FORM_LINKI]
Tesekkurler.
```

## 5. Feedback Formu

Hazir soru listesi:
- `docs/play-console/CLOSED_TEST_FEEDBACK_FORM_TR.md`

## 6. Test Sirasinda Toplanacak Kanitlar

- Tester sayisi ve opt-in durumu ekran goruntusu
- Geri bildirim formu yanitlari
- Bulunan hatalar listesi
- Yapilan duzeltmeler listesi
- Yeni surum release notes kayitlari

## 7. Kapali Test Release Notes

Ilk kapali test surumu icin:

```text
Nosto kapali test surumu.

Lutfen su alanlari test edin:
- Onboarding
- Temassiz Gunler sayaci
- SOS akisi
- Ayarlar ve bildirim izinleri
- Premium paywall davranisi

Bu surumda AI mesaj analizi yoktur. Nosto terapi veya tibbi destek yerine gecmez.
```

Guncelleme surumu icin:

```text
Kapali test geri bildirimlerine gore iyilestirmeler:
- Metin ve marka tutarliligi kontrol edildi.
- Onboarding ve SOS akisi stabilite kontrolleri yapildi.
- Paywall yonlendirmeleri gozden gecirildi.
```


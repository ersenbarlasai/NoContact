# Nosto Google Play Console Kurulum Rehberi

Son guncelleme: 2026-05-16

Bu rehber, Nosto'nun Google Play Console uzerindeki ilk kurulumunu, dahili testini, kapali testini ve uretim erisimi basvurusunu hazirlamak icin kullanilir.

## 1. Once Dahili Test

Dahili test zorunlu degildir, ama AAB'nin Play uzerinden kurulup kurulmadigini hizlica gormek icin onerilir.

Yapilacaklar:
- Testing > Internal testing bolumune git.
- Tester e-posta listesini olustur.
- Yeni surum olustur.
- `app-release.aab` dosyasini yukle.
- Release notes ekle.
- Surumu onizle ve kullanima sun.
- Opt-in linkinden kendi cihazinda kurulum test et.

Release notes onerisi:

```text
Nosto ilk dahili test surumu.

Bu surumda:
- Nosto marka dili ve ikon seti eklendi.
- Onboarding, Temassiz Gunler sayaci ve SOS akisi test edilebilir.
- Gonderilmeyen Mektuplar, Duygu Gunlugu, 30 Gunluk Yol ve diger premium alanlar paywall arkasindadir.
- AI mesaj analizi yoktur.
```

## 2. Uygulama Kurulumu

Play Console'da "Uygulamanizin kurulumunu tamamlayin" bolumundeki alanlar doldurulur.

### Gizlilik Politikasi

Canli bir URL gerekir. Gecici olarak yayinlanacak sayfa su icerige dayanmalidir:

- Nosto hassas metin iceriklerini cihaz disina gondermez.
- Gonderilmeyen Mektuplar, Duygu Gunlugu ve SOS yazilari lokal saklanir.
- Biyometrik veri uygulama tarafindan okunmaz; cihaz dogrulama sonucu kullanilir.
- Bildirimler genel iceriklidir, ozel metin icermez.
- Nosto terapi, tibbi destek veya kriz mudahalesi yerine gecmez.

Hazir taslak:
- `docs/store/PRIVACY_DISCLOSURE_DRAFT.md`

### Uygulama Erisimi

Onerilen cevap:

```text
Uygulamanin temel acilisi, onboarding, ana ekran, Temassiz Gunler sayaci, SOS ve Ayarlar alanlari test kullanicilari tarafindan erisilebilir.

Bazi gelismis ozellikler Nosto Premium paywall arkasindadir. Mevcut test surumunde odeme entegrasyonu aktif degilse veya test icin dev premium modu kullaniliyorsa, test notlarinda nasil erisilecegi aciklanmalidir.
```

Eger Google inceleme ekibinin premium alanlari gormesi gerekiyorsa test notlarina su eklenir:

```text
Inceleme sirasinda premium ozellikleri gormek icin lutfen Ayarlar > Plan ve Limitler ekranini kullanin. Test build'inde gelistirme amacli premium toggle mevcutsa bu toggle ile premium alanlar acilabilir.
```

Not: Production surumunde dev toggle gorunur olmamali.

### Reklam

Nosto reklam icermiyorsa:

```text
Uygulama reklam icermiyor.
```

### Icerik Derecelendirme

Kategori onerisi:
- Health & Fitness veya Lifestyle ekseninde degerlendirilebilir.
- Nosto terapi veya tibbi hizmet sunmadigini acikca belirtir.

Icerik sorularinda:
- Soru gercek uygulama davranisina gore yanitlanmali.
- Siddet, cinsellik, kumar, finansal hizmet, kullanici uretimli herkese acik icerik yoktur.
- Hassas duygusal durum destegi vardir; fakat kriz mudahalesi veya tibbi tedavi yoktur.

### Hedef Kitle

Oneri:

```text
Hedef yas grubu: 18+
```

Gerekce:

```text
Uygulama ayrilik sonrasi temas etmeme, duygusal sinir koyma ve kisisel yazma alanlari uzerine kuruludur. Bu nedenle yetiskin kullanicilar icin konumlandirilmalidir.
```

### Veri Guvenligi

Detayli cevap taslagi:
- `docs/play-console/DATA_SAFETY_DRAFT_TR.md`

### Saglik

Onerilen konum:

```text
Nosto profesyonel terapi, tibbi tavsiye, tani, tedavi veya kriz mudahalesi sunmaz. Uygulama, kullanicinin temas etme istegi geldiginde durmasina, duygularini lokal olarak yazmasina ve kendi sinirini korumasina yardim eden self-regulation ve journaling aracidir.
```

Saglik sorulari uygulama davranisina gore yanitlanmali. Medikal iddia kurulmamali.

### Finans ile Ilgili Ozellikler

Nosto finansal urun sunmuyorsa:

```text
Uygulama finansal urun, kredi, yatirim, odeme hizmeti veya para transferi sunmaz.
```

### Resmi Kurum Uygulamasi

```text
Nosto resmi kurum uygulamasi degildir.
```

## 3. Kategori ve Iletisim

Kategori onerileri:
- Health & Fitness
- Lifestyle

Nosto'nun tonu ve store politikasi acisindan en guvenli konum:

```text
Lifestyle
```

Iletisim:
- Destek e-postasi: yayin oncesi netlestirilmeli.
- Gizlilik politikasi URL'si: yayin oncesi canli olmali.
- Web sitesi opsiyonel ama onerilir.

## 4. Magaza Girisi

Hazir metin:
- `docs/store/PLAY_STORE_COPY_TR.md`

Gerekli varliklar:
- App icon: `assets_store/icon/nosto_store_icon_1024.png`
- Screenshot plan: `docs/store/SCREENSHOT_PLAN.md`
- Screenshot metinleri: `docs/store/design/SCREENSHOT_COPY_FINAL_TR.md`

## 5. Fiyatlandirma

Ilk kapali testte uygulama ucretsiz dagitilabilir.

Production icin karar ayrica verilecek:
- Ucretsiz indirme + Nosto Premium abonelik onerilir.
- SOS, Ayarlar, Home ve Temassiz Gunler ucretsiz kalir.
- Diger ana ozellikler premium guard arkasindadir.

## 6. Kapali Test

Uretim erisimi icin kapali test gerekir.

Plan:
- Kapali test kanali olustur.
- En az 12 tester ekle.
- Testerlar opt-in linkinden teste katilsin.
- En az 14 ardışık gun kapali test sursun.
- Tester geri bildirimi topla.

Detayli plan:
- `docs/play-console/CLOSED_TEST_PLAN_TR.md`

## 7. Uretim Erisimi Basvurusu

14 gunluk kapali test tamamlandiktan sonra Google'in sorulari icin hazir cevap taslaklari:
- `docs/play-console/PRODUCTION_ACCESS_ANSWERS_TR.md`


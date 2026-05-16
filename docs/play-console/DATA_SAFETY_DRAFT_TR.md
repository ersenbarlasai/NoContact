# Nosto Veri Guvenligi Taslagi

Son guncelleme: 2026-05-16

Bu dokuman Google Play Console > Veri guvenligi bolumu doldurulurken referans olarak kullanilir. Son cevaplar, uygulamanin yayina girecek gercek build davranisina gore verilmelidir.

## Ozet

Nosto local-first bir uygulamadir. Hassas kullanici icerigi cihaz disina gonderilmez.

Hassas icerik ornekleri:
- Gonderilmeyen Mektuplar metinleri
- Duygu Gunlugu notlari
- SOS sirasinda yazilan metinler
- Sessiz Cevap metinleri

Bu icerikler kullanicinin cihazinda saklanir. Uygulama bu metinleri sunucuya, analiz servisine veya ucuncu taraflara gondermez.

## Toplanan Veri Beyani

Mevcut MVP icin onerilen cevap:

```text
Nosto, kullanicinin yazdigi hassas metin iceriklerini toplamaz veya cihaz disina gondermez. Gunluk, mektup ve SOS metinleri cihazda lokal olarak saklanir.
```

Eger Play Console "bu uygulama veri topluyor mu?" sorusunda SDK/abonelik/hesap davranisi nedeniyle veri beyanı gerekiyorsa, yalnizca gercekten toplanan teknik/hesap verileri isaretlenmelidir.

## Veri Turleri

### Kisisel bilgiler

Mevcut uygulama anonim/local kullanimdaysa:

```text
Kisisel bilgiler toplanmaz.
```

Eger Supabase auth veya abonelik hesabi aktif edilirse:

```text
Hesap yonetimi ve abonelik durumu icin sinirli hesap bilgileri islenebilir. Hassas gunluk veya mektup icerikleri bu kapsama dahil degildir.
```

### Saglik ve fitness

Nosto tibbi veri toplamaz. Kullanici duygu durumunu lokal olarak kaydedebilir.

Onerilen aciklama:

```text
Nosto tibbi tani, tedavi veya saglik hizmeti verisi toplamaz. Duygu gunlugu kayitlari kullanicinin cihazinda lokal kalir.
```

### Mesajlar

Nosto kullanicinin SMS, e-posta veya sohbet mesajlarina erismez.

```text
Uygulama kullanicinin cihazindaki mesajlara erismez. Kullanici kendi istegiyle yazdigi Gonderilmeyen Mektuplar ve SOS metinlerini lokal olarak saklar.
```

### Uygulama etkinligi

Mevcut build analytics kullanmiyorsa:

```text
Uygulama etkinligi analitik amacla toplanmaz.
```

Eger ileride analytics eklenirse veri guvenligi formu guncellenmelidir.

### Cihaz veya diger kimlikler

Mevcut build ucuncu taraf analytics/ads kullanmiyorsa:

```text
Cihaz kimligi reklam veya takip amaciyla toplanmaz.
```

## Veri Paylasimi

```text
Hassas kullanici icerikleri ucuncu taraflarla paylasilmaz.
```

Nosto reklam SDK'si icermiyorsa:

```text
Reklam amacli veri paylasimi yoktur.
```

## Sifreleme

```text
Ozel metinler cihazda lokal olarak saklanir. Uygulama, desteklenen alanlarda cihaz ici guvenli depolama ve biyometrik kilit kullanir.
```

## Veri Silme

Nosto Ayarlar ekraninda yerel veri temizleme ve kalici silme aksiyonlari sunar.

Onerilen cevap:

```text
Kullanici Ayarlar ekranindan yerel verilerini temizleyebilir veya kalici olarak silebilir. Hassas metin icerikleri sunucuda tutulmadigi icin cihazdan silindiklerinde uygulama tarafinda erisilemez hale gelir.
```

## Cocuklara Yonelik Degil

```text
Nosto cocuklara yonelik degildir. Hedef kitle 18+ yetiskin kullanicilardir.
```

## Google Play Icin Kisa Not

```text
Nosto privacy-first ve local-first tasarlanmistir. Kullanicinin yazdigi duygusal notlar, gonderilmeyen mektuplar ve SOS metinleri cihazdan disari cikmaz. Uygulama reklam icermez ve AI mesaj analizi yapmaz.
```


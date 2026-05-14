# Still / NoContact Son Kullanici Tanitim ve Kullanim Rehberi

Still, ayrilik sonrasi "temas etmeme" kararini korumak isteyen kullanicilar icin tasarlanmis sakin, gizlilik odakli bir mobil destek alanidir. Uygulama eski partneri geri getirme, mesaj yorumlama ya da terapi verme vaadi sunmaz. Amaci, zor anlarda kullanicinin kendi sinirini korumasina, duygusunu yazmasina, durup nefes almasina ve guvenli bir sonraki adimi secmesine yardim etmektir.

> Still profesyonel terapi, tibbi destek veya acil yardim yerine gecmez. Kendine ya da bir baskasina zarar verme riski varsa yerel acil yardim hatlarina veya guvendigin bir kisiye hemen ulasmalisin.

## Uygulama Kime Hitap Eder?

Still su durumlarda destek olmak icin tasarlanmistir:

- Eski partnere yazma, arama veya sosyal medyadan kontrol etme durtusu geldiginde.
- "Neden baslamistim?" sorusunu kendine tekrar hatirlatmak istediginde.
- Duygularini gunluk olarak takip etmek istediginde.
- Gonderilmeyecek mektuplar yazarak icinde kalanlari guvenli bir alana birakmak istediginde.
- Ilk 30 gunde kucuk, yonlendirici ve uygulanabilir adimlara ihtiyac duydugunda.

Still'in tonu bilerek yavas, sakin ve yargisizdir. Uygulama kullaniciyi yaristirmaz, suclu hissettirmez ve "basarisizlik" dili kullanmaz.

## Ilk Acilis ve Kisisellestirme

Uygulama ilk acildiginda kullanici onboarding akisi ile karsilanir. Bu akis kullaniciyi tanimak ve destegi daha kisisel hale getirmek icindir.

Onboarding sirasinda su bilgiler alinabilir:

- Kullanici adi veya uygulama icinde nasil hitap edilmesini istedigi.
- Temas etmeme kararina baslama nedeni.
- Iliskinin ne kadar surdugu.
- Ayriliktan bu yana gecen sure.
- Temas etmeme baslangic tarihi.
- Baskin duygu.
- Eski partnere ulasma istegini tetikleyen durumlar.
- Kullaniciya ait icsel soz / taahhut.

Bu bilgiler ana ekran, SOS akisi, "Neden baslamistim?" karti ve 30 gunluk yol gibi alanlarda kisisellestirme icin kullanilir.

## Hesap ve Kayit Sureci

Mevcut uygulama kullaniciyi klasik e-posta/sifre kaydina zorlamaz.

- Uygulama Supabase ile yapilandirilmamissa tamamen yerel modda calisir.
- Supabase yapilandirilmissa onboarding tamamlandiginda kullanici arka planda anonim olarak oturum acabilir.
- Anonim oturum, verileri belirli bir kullanici kimligiyle eslestirmek icindir; kullanicidan parola veya e-posta istemez.
- Hassas alanlarin buyuk bolumu yine cihazda saklanir.

Kullanici acisindan temel deneyim sudur: Uygulamayi ac, kisa kisisellestirmeyi tamamla, ana ekrandan ihtiyacin olan araca gec.

## Ana Ekran

Ana ekran uygulamanin merkezidir. Burada kullanici o gun icin en hizli destek alanlarina ulasir.

Ana ekranda bulunan baslica alanlar:

- **Iletisimsiz gecen gun sayaci:** Temas etmeme kararinin kac gundur surdugunu gosterir.
- **Bugunun Destegi:** Kullaniciya o an ihtiyaci olan kucuk adimi sectirir.
- **Bugunun Adimi:** 30 gunluk yoldaki mevcut gunun kucuk gorevine yonlendirir.
- **Sessiz Kutuphane:** Kisa, sakin ve sabit iceriklere erisim saglar.
- **Duygularin / Gunluk:** Gunluk duygu yansimasina gecis saglar.
- **Sessiz Cevap:** Gondermek istedigin cevabi gondermeden yazabilecegin guvenli alandir.
- **Durtu Yonetildi:** Temas etmeden atlatilan guvenli cikis anlarini sayar.
- **Mektup Kasasi:** Gonderilmeyen mektuplarin saklandigi alandir.
- **SOS butonu:** Ekranin sag altinda yer alan hizli kriz destegi butonudur.

Alt navigasyonda temel bolumler bulunur:

- **Ana Sayfa**
- **Gunluk**
- **Kasa**
- **Ayarlar**

## SOS: Zor Anlar Icin Koruma Alani

SOS, eski partnere yazma veya arama istegi cok guclendiginde kullanilacak hizli destek akisidir.

SOS akisi 4 adimdan olusur:

1. **Nefes:** Kullanici kisa bir nefes alanina girer. Amac hemen karar vermek degil, bedeni biraz sakinlestirmektir.
2. **Hatirla:** Kullanici kendi nedenlerini, icsel sozlerini ve kriz kartlarini gorur.
3. **Buraya Yaz, Ona Degil:** Kullanici gondermek istedigi seyi uygulama icinde yazar. Bu metin gonderilmez.
4. **Kendini Sec:** Kullanici temas etmeme kararini koruyup korumadigini belirtir veya ek destek alanlarina yonlendirilir.

SOS tamamlandiginda "Durtu Yonetildi" metriği artabilir. SOS icinde yazilan ham metin buluta gonderilmez.

## Bugunun Destegi

Bugunun Destegi, mesaj analizi gibi spekulatif bir yaklasim yerine kullanicinin kendi kararini korumasina yardim eden guvenilir araclar sunar.

Bu alanda uc ana destek vardir:

- **Neden baslamistim?** Kullanici onboarding sirasinda verdigi nedeni ve kendine verdigi sozu tekrar gorur.
- **Tek cumle not:** Kullanici o an kendine tek cumlelik kisa bir hatirlatma birakir.
- **24 saat bekle:** Kullanici bir mesaj veya karar icin 24 saatlik sakinlesme alani baslatir.

24 saat bekleme aktifken ana ekranda sakin bir geri sayim gorunur. Sure doldugunda uygulama kullaniciyi zorlamadan daha sakin bir noktadan tekrar bakmaya davet eder.

## Sessiz Cevap

Sessiz Cevap, kullanicinin eski partnere yazmak istedigi cevabi gercek dunyada gondermeden once guvenli bir alana dokmesini saglar.

Akis 3 adimlidir:

1. **Yaz:** Kullanici icinden gecen cevabi yazar.
2. **Fark et:** Bu cevabi yazma isteginin altindaki ihtiyaci secer. Ornek: rahatlamak, duyulmak, sinir koymak.
3. **Sec:** Kullanici guvenli bir cikis secer.

Guvenli cikislar:

- **Kasaya birak:** Metni Mektup Kasasi'na sifreli olarak kaydeder.
- **24 saat beklet:** Karari erteler.
- **SOS'a gec:** Daha yogun bir durtu varsa SOS alanina gider.
- **Sakin alternatif:** Manipulatif olmayan, sinir odakli sakin cumle ornekleri gosterir.

Sessiz Cevap AI kullanmaz ve "en dogru cevabi" iddia etmez. Amaci kullanicinin yazma ile gonderme arasina guvenli bir bosluk koymasidir.

## Mektup Kasasi

Mektup Kasasi, gonderilmeyecek mektuplar icin sifreli yerel alandir.

Kullanici burada:

- Yeni mektup yazabilir.
- Daha once yazdigi mektuplari gorebilir.
- Mektuplari arsive alabilir.
- Arsivden geri alabilir.
- Gerekirse tamamen silebilir.

**Arsivlemek ne demektir?**  
Arsive almak mektubu silmez. Sadece aktif listeden ayirir. Kullanici isterse daha sonra arsivden geri alabilir. Tam silme farklidir; silinen mektup geri getirilemeyebilir.

## Gunluk / Yansima

Gunluk bolumu, kullanicinin her gun kendine kisa bir duygu yansimasi birakmasi icindir.

Kullanici sunlari kaydedebilir:

- O gun baskin hissettigi duygu.
- Duygu yogunlugu.
- Tetikleyici durumlar.
- Istege bagli ozel not.

Gunluk mantigi takvim gunune gore calisir:

- Aynı gun icinde kayit varsa kullanici o gunun yansimasini duzenler.
- Yeni takvim gunu basladiginda yeni yansima olusturulur.
- Ozel notlar cihazda sifreli saklanir ve buluta gonderilmez.

## Sessiz Kutuphane

Sessiz Kutuphane, uygulama icinde yer alan sabit ve internet gerektirmeyen kisa icerik alanidir.

Kategoriler:

- Ilk gunler
- Durtu geldiginde
- Sosyal medya kontrolu
- Ozlem dalgasi
- Sinir koymak
- Kendini suclama
- Geri donme dongusu
- Gece zorlanmalari

Her icerik genellikle kisa bir okuma, bir yansima sorusu ve onerilen bir sonraki adim icerir.

## 30 Gunluk Yol

30 Gunluk Yol, temas etmeme surecinin ilk ayinda kullaniciya kucuk ve uygulanabilir adimlar sunar.

Her gun icin:

- Kisa tema
- Kucuk gorev
- Yansima sorusu
- Ilgili araca yonlendirme

Ornek:

- "Bugunku duygunu adlandir" adimi Gunluk'e yonlendirebilir.
- "Yaz ama gonderme" adimi Sessiz Cevap'a yonlendirebilir.
- "Ilk 24 saati koru" adimi SOS'a yonlendirebilir.

## Yansimalar / Sessiz Gelisim

Yansimalar alani kullanicinin ilerlemesine sakin bir ozet sunar.

Burada su tur ozetler gorulebilir:

- Iletisimsiz gun sayisi.
- Duygu serisi.
- Yonetilen durtu sayisi.
- Yol uzerindeki anlamli anlar.

Bu ekran hassas mektup veya gunluk metinlerini listelemez; sadece toplu ve guvenli metrikler gosterir.

## Gunluk Ritim Bildirimleri

Kullanici izin verirse uygulama nazik hatirlatmalar gonderebilir.

Bildirim turleri:

- Ana gunluk hatirlatma.
- Sabah nazik baslangic.
- Oglen kisa duraklama.
- Aksam yansimasi.
- 24 saat bekleme sonu hatirlatmasi.
- SOS sonrasi nazik takip.
- Sessiz Cevap sonrasi guvenli hatirlatma.

Bildirimler hassas icerik tasimaz. Eski partner adi, mektup metni, gunluk notu veya SOS metni bildirimde gosterilmez. Android tarafinda uygulamaya ozel yumusak bir bildirim sesi bulunur: `still_soft_chime`.

## Biyometrik Kilit

Kullanici isterse hassas alanlara ek koruma koyabilir.

Korunabilecek alanlar:

- Gunluk
- Mektup Kasasi
- Mektup duzenleyici

SOS, Ana Sayfa ve Ayarlar gibi hizli erisim gerektiren alanlar kilitlenmez. Biyometrik veri uygulama tarafindan saklanmaz; dogrulama cihaz isletim sistemi tarafindan yapilir.

## Ayarlar ve Veri Kontrolu

Ayarlar bolumunden:

- Profil ayarlari gorulebilir.
- Plan ve limitler bolumune gidilebilir.
- Beta geri bildirimi gonderilebilir.
- Gunluk Ritim bildirimleri acilip kapatilabilir.
- Biyometrik kilit yonetilebilir.
- Yerel veriler temizlenebilir.

Yerel verileri temizleme islemi uygulamadaki yerel ilerlemeyi ve hassas kayitlari sifirlar. Bu islem kullanici tarafindan bilincli yapilmalidir.

## Gizlilik Ozeti

Still'in temel gizlilik yaklasimi sudur:

- Mektuplar cihazda sifreli saklanir.
- Gunluk notlari cihazda sifreli saklanir.
- Kriz kartlari ve tek cumle notlar cihazda sifreli saklanir.
- SOS icinde yazilan ham metin buluta gonderilmez.
- Sessiz Cevap metni sadece kullanici "Kasaya birak" derse sifreli olarak saklanir.
- Bildirimlerde hassas icerik gosterilmez.
- Supabase yapilandirilmis olsa bile hassas mektup ve gunluk icerikleri varsayilan olarak buluta gonderilmez.

## Sik Sorulan Sorular

### Still mesajlarimi analiz ediyor mu?

Ana kullanici akisi mesaj analizi uzerine kurulu degildir. Still kullanicinin kendi kararini korumasina yardim eden yerel ve guvenilir araclar sunar. Mevcut ana deneyim "Bugunun Destegi", SOS, Sessiz Cevap, Gunluk, Mektup Kasasi ve 30 Gunluk Yol'dur.

### Mektuplarim baskalarina gider mi?

Hayir. Mektup Kasasi'na yazilan mektuplar gonderilmez. Sadece cihazda sifreli olarak saklanir.

### Uygulama internet olmadan calisir mi?

Evet. Ana destek araclari yerel calisir. Supabase yapilandirilmissa bazi profil veya geri bildirim verileri buluta yazilabilir; ancak hassas yazilar local-first kalir.

### Bildirimlerde ozel bilgilerim gorunur mu?

Hayir. Bildirim metinleri sabittir ve hassas kullanici girdisi icermez.

### Durtu Yonetildi sayisi nasil artar?

Kullanici SOS'u tamamladiginda, Sessiz Cevap'tan guvenli cikis yaptiginda veya 24 saat bekleme baslattiginda artabilir. Ayni kriz aninda arka arkaya birden fazla guvenli arac kullanilirsa sistem bunu tek bir yonetilen durtu olarak sayabilir.


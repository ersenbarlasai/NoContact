# Privacy Disclosure Draft - Nosto

**Başlık:** Nosto - Gizlilik Politikası Özeti
**Sürüm:** 1.0 (MVP)

## 1. Hangi Veriler Nerede Saklanır?
Nosto uygulaması, mahremiyetinize en yüksek düzeyde saygı göstermek üzere tasarlanmıştır ("Privacy-by-Design").

- **Lokal (Cihaz İçi) Saklanan Veriler:** 
  Duygu günlüğü kayıtlarınız, Gönderilmeyen Mektuplar alanına yazdığınız mektuplar, SOS modunda girdiğiniz metinler ve elde ettiğiniz gelişim izleri SADECE sizin cihazınızda (telefonunuzda) saklanır.
- **Şifrelenmiş Veriler:**
  Cihazınızda saklanan bu özel notlar ve mektuplar, uygulamanın yerel depolama altyapısında şifrelenir. Cihazınıza fiziksel olarak erişilse bile dışarıdan kolayca okunamaz.
- **Buluta Gönderilen Veriler (Supabase):**
  Şu anki sürümde (MVP), yazdığınız HİÇBİR hassas metin içeriği (günlükler, mektuplar, SOS notları) bulut sunucularımıza veya Supabase veritabanına gönderilmez. İleride profil oluşturma ve abonelik yönetimi için sadece temel hesap durumu bilgileri (örneğin; abonelik seviyesi) eşzamanlanabilir.

## 2. Asla Eşzamanlanmayan Veriler
Aşağıdaki veriler asla cihazınızdan dışarı çıkmaz:
- Duygu günlüğüne yazdığınız notlar.
- Göndermekten vazgeçtiğiniz mektup içerikleri.
- Sessiz Cevap (Silent Reply) alanına yazdığınız geçici mesajlar.
- SOS anında hissettiklerinizi yazdığınız geçici metinler.

## 3. Bildirim Gizliliği
"Günlük Ritim" hatırlatmaları tamamen cihazınızın kendi içinde (`local_notifications` kullanılarak) planlanır. Push notification (uzaktan bildirim) sistemi kullanılmaz. Bildirim içeriklerinde sadece destekleyici genel mesajlar ("Bugün kendini bir cümleyle yoklamak ister misin?") yer alır; yazdığınız özel metinler asla bildirim ekranına yansımaz.

## 4. Sessiz Cevap (Silent Reply) Gizliliği
Sessiz Cevap alanına yazdığınız metinler asla cihaz dışına çıkmaz. Kasaya kaydetmeyi seçerseniz yalnızca cihazınızda lokal olarak saklanır. Kaydedilmezse oturum kapandığında tamamen silinir.

## 5. Biyometrik Kilit (Privacy Lock)
Eğer ayarlardan aktif ederseniz, cihazınızın kendi Face ID veya Touch ID (Parmak İzi) sistemini kullanırız. Biyometrik verileriniz cihazın güvenli donanımında kalır; uygulama bu biyometrik verilere asla erişemez veya onları kopyalayamaz. Sadece cihazdan gelen "Başarılı" veya "Başarısız" sinyalini alırız.

## 6. Terapi ve Acil Destek Uyarısı
Nosto, profesyonel terapi, tıbbi destek, tanı, tedavi veya kriz müdahalesi yerine geçmez. Şiddetli duygusal zorlanma, kendine zarar verme düşüncesi veya acil güvenlik riski varsa lütfen yerel acil destek hattına veya bir sağlık uzmanına başvurun.


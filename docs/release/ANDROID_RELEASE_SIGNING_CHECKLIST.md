# Android Release Signing Checklist (Nosto)

Bu belge, Nosto uygulamasının Google Play Store'a gönderilmeden önce, güvenli bir şekilde nasıl imzalanıp Android App Bundle (AAB) olarak oluşturulacağını açıklamaktadır.

## ⚠️ Güvenlik Uyarıları

*   **ASLA** `key.properties` dosyasını, `.jks` veya `.keystore` dosyalarını git reposuna (version control) göndermeyin. Bu dosyalar `.gitignore` içerisinde tanımlıdır ve güvendedir.
*   Keystore şifrenizi ve alias'ı güvenli bir yerde (örneğin 1Password, Bitwarden gibi bir şifre yöneticisinde) saklayın. Keystore dosyasını kaybederseniz Google Play Store uygulamanızı güncelleyemezsiniz.
*   Production (Release) keystore dosyanızı ve şifrenizi asla kodun içine gömmeyin.

---

## 1. Production Keystore Oluşturma

Henüz bir keystore dosyanız yoksa, aşağıdaki komutu **kendi güvenli bilgisayarınızda** (terminal/komut satırı) çalıştırarak oluşturun. 

> *Tavsiye: Dosyayı projenin kök dizininde veya tamamen proje dışında güvenli bir klasörde oluşturabilirsiniz.*

```bash
keytool -genkey -v -keystore nosto_upload.jks -keyalg RSA -keysize 2048 -validity 10000 -alias nosto
```

*   Size şifre sorulacaktır. Güçlü bir şifre girin.
*   Ad, soyad, organizasyon gibi bilgileri doldurun.

---

## 2. `key.properties` Dosyasını Oluşturma

Projenizin içerisinde `app/mobile/android/key.properties` konumunda bir dosya oluşturun. İçerisini kendi oluşturduğunuz keystore bilgileriyle doldurun:

```properties
storePassword=SizinGucluSifreniz123
keyPassword=SizinGucluSifreniz123
keyAlias=nosto
storeFile=../../../nosto_upload.jks
```

> **Not:** `storeFile` yolu, `key.properties` dosyasına göreceli (relative) veya tam yol (absolute) olabilir. Eğer keystore dosyanızı projenin en üst klasörüne (Nosto-logo.png'nin yanına) koyduysanız `../../../nosto_upload.jks` doğru olacaktır. Dosyayı `app/mobile/android/` içine koyarsanız sadece `nosto_upload.jks` yazabilirsiniz.

---

## 3. Derleme (Build) İşlemi

Tüm hazırlıkları yaptıktan sonra, projenin kök veya `app/mobile` dizininde aşağıdaki komutları çalıştırarak Play Store'a yüklemeye hazır AAB dosyasını oluşturabilirsiniz:

```bash
flutter clean
flutter pub get
flutter build appbundle --release
```

**Başarı Durumu:**
Derleme bittikten sonra çıktı dosyası şurada bulunacaktır:
`build/app/outputs/bundle/release/app-release.aab`

Bu dosyayı Google Play Console üzerinden üretim (production) veya test (internal testing vb.) kanallarına yükleyebilirsiniz.

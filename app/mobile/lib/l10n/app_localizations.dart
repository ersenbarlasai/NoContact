import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('tr'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In tr, this message translates to:
  /// **'NOSTO'**
  String get appTitle;

  /// No description provided for @appTagline.
  ///
  /// In tr, this message translates to:
  /// **'Bırak. Kendine dön.'**
  String get appTagline;

  /// No description provided for @navHome.
  ///
  /// In tr, this message translates to:
  /// **'Ana Sayfa'**
  String get navHome;

  /// No description provided for @navJournal.
  ///
  /// In tr, this message translates to:
  /// **'Günlük'**
  String get navJournal;

  /// No description provided for @navVault.
  ///
  /// In tr, this message translates to:
  /// **'Mektuplar'**
  String get navVault;

  /// No description provided for @navSettings.
  ///
  /// In tr, this message translates to:
  /// **'Ayarlar'**
  String get navSettings;

  /// No description provided for @continueBtn.
  ///
  /// In tr, this message translates to:
  /// **'DEVAM ET'**
  String get continueBtn;

  /// No description provided for @cancelBtn.
  ///
  /// In tr, this message translates to:
  /// **'VAZGEÇ'**
  String get cancelBtn;

  /// No description provided for @okBtn.
  ///
  /// In tr, this message translates to:
  /// **'TAMAM'**
  String get okBtn;

  /// No description provided for @closeBtn.
  ///
  /// In tr, this message translates to:
  /// **'KAPAT'**
  String get closeBtn;

  /// No description provided for @backBtn.
  ///
  /// In tr, this message translates to:
  /// **'GERİ GİT'**
  String get backBtn;

  /// No description provided for @saveBtn.
  ///
  /// In tr, this message translates to:
  /// **'KAYDET'**
  String get saveBtn;

  /// No description provided for @deleteBtn.
  ///
  /// In tr, this message translates to:
  /// **'SİL'**
  String get deleteBtn;

  /// No description provided for @restoreBtn.
  ///
  /// In tr, this message translates to:
  /// **'GERİ YÜKLE'**
  String get restoreBtn;

  /// No description provided for @archiveBtn.
  ///
  /// In tr, this message translates to:
  /// **'ARŞİVLE'**
  String get archiveBtn;

  /// No description provided for @copyBtn.
  ///
  /// In tr, this message translates to:
  /// **'KOPYALA'**
  String get copyBtn;

  /// No description provided for @newAnalysisBtn.
  ///
  /// In tr, this message translates to:
  /// **'YENİ ANALİZ'**
  String get newAnalysisBtn;

  /// No description provided for @yesBtn.
  ///
  /// In tr, this message translates to:
  /// **'EVET'**
  String get yesBtn;

  /// No description provided for @noBtn.
  ///
  /// In tr, this message translates to:
  /// **'HAYIR'**
  String get noBtn;

  /// No description provided for @onboardingWelcomeHeadline1.
  ///
  /// In tr, this message translates to:
  /// **'Nosto’ya hoş geldin.'**
  String get onboardingWelcomeHeadline1;

  /// No description provided for @onboardingWelcomeHeadline2.
  ///
  /// In tr, this message translates to:
  /// **''**
  String get onboardingWelcomeHeadline2;

  /// No description provided for @onboardingWelcomeSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Burası unutmaya zorlandığın yer değil.\nKendine geri dönmeye başladığın sessiz alan.'**
  String get onboardingWelcomeSubtitle;

  /// No description provided for @onboardingStartBtn.
  ///
  /// In tr, this message translates to:
  /// **'Bırak. Kendine dön.'**
  String get onboardingStartBtn;

  /// No description provided for @onboardingNameTitle.
  ///
  /// In tr, this message translates to:
  /// **'Sana nasıl hitap edelim?'**
  String get onboardingNameTitle;

  /// No description provided for @onboardingNameSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Bu ismi sadece sana özel planında kullanacağız.'**
  String get onboardingNameSubtitle;

  /// No description provided for @onboardingNameHint.
  ///
  /// In tr, this message translates to:
  /// **'Adın veya takma adın'**
  String get onboardingNameHint;

  /// No description provided for @onboardingReasonTitle.
  ///
  /// In tr, this message translates to:
  /// **'Seni buraya ne getirdi?'**
  String get onboardingReasonTitle;

  /// No description provided for @onboardingReason1.
  ///
  /// In tr, this message translates to:
  /// **'Ona yazmamam gerektiğini biliyorum'**
  String get onboardingReason1;

  /// No description provided for @onboardingReason2.
  ///
  /// In tr, this message translates to:
  /// **'Onu düşünmeden duramıyorum'**
  String get onboardingReason2;

  /// No description provided for @onboardingReason3.
  ///
  /// In tr, this message translates to:
  /// **'İyileşmek istiyorum ama nereden başlayacağımı bilmiyorum'**
  String get onboardingReason3;

  /// No description provided for @onboardingReason4.
  ///
  /// In tr, this message translates to:
  /// **'No-contact\'ı bozdum ve suçlu hissediyorum'**
  String get onboardingReason4;

  /// No description provided for @onboardingReason5.
  ///
  /// In tr, this message translates to:
  /// **'Duygularımı kontrol etmekte zorlanıyorum'**
  String get onboardingReason5;

  /// No description provided for @onboardingRelDurationTitle.
  ///
  /// In tr, this message translates to:
  /// **'İlişkiniz ne kadar sürdü?'**
  String get onboardingRelDurationTitle;

  /// No description provided for @onboardingRelDuration1.
  ///
  /// In tr, this message translates to:
  /// **'1 aydan kısa'**
  String get onboardingRelDuration1;

  /// No description provided for @onboardingRelDuration2.
  ///
  /// In tr, this message translates to:
  /// **'1-3 ay'**
  String get onboardingRelDuration2;

  /// No description provided for @onboardingRelDuration3.
  ///
  /// In tr, this message translates to:
  /// **'3-6 ay'**
  String get onboardingRelDuration3;

  /// No description provided for @onboardingRelDuration4.
  ///
  /// In tr, this message translates to:
  /// **'6-12 ay'**
  String get onboardingRelDuration4;

  /// No description provided for @onboardingRelDuration5.
  ///
  /// In tr, this message translates to:
  /// **'1 yıldan fazla'**
  String get onboardingRelDuration5;

  /// No description provided for @onboardingRelDuration6.
  ///
  /// In tr, this message translates to:
  /// **'3 yıldan fazla'**
  String get onboardingRelDuration6;

  /// No description provided for @onboardingBreakupTimeTitle.
  ///
  /// In tr, this message translates to:
  /// **'Ayrılığın üzerinden ne kadar geçti?'**
  String get onboardingBreakupTimeTitle;

  /// No description provided for @onboardingBreakupTime1.
  ///
  /// In tr, this message translates to:
  /// **'1 haftadan az'**
  String get onboardingBreakupTime1;

  /// No description provided for @onboardingBreakupTime2.
  ///
  /// In tr, this message translates to:
  /// **'1-4 hafta'**
  String get onboardingBreakupTime2;

  /// No description provided for @onboardingBreakupTime3.
  ///
  /// In tr, this message translates to:
  /// **'1-3 ay'**
  String get onboardingBreakupTime3;

  /// No description provided for @onboardingBreakupTime4.
  ///
  /// In tr, this message translates to:
  /// **'3 aydan fazla'**
  String get onboardingBreakupTime4;

  /// No description provided for @onboardingWhoEndedTitle.
  ///
  /// In tr, this message translates to:
  /// **'İlişkiyi kim bitirdi?'**
  String get onboardingWhoEndedTitle;

  /// No description provided for @onboardingWhoEndedMe.
  ///
  /// In tr, this message translates to:
  /// **'Ben'**
  String get onboardingWhoEndedMe;

  /// No description provided for @onboardingWhoEndedThem.
  ///
  /// In tr, this message translates to:
  /// **'O'**
  String get onboardingWhoEndedThem;

  /// No description provided for @onboardingWhoEndedMutual.
  ///
  /// In tr, this message translates to:
  /// **'Ortak karar'**
  String get onboardingWhoEndedMutual;

  /// No description provided for @onboardingNoContactDateTitle.
  ///
  /// In tr, this message translates to:
  /// **'İletişimi ne zaman kestin?'**
  String get onboardingNoContactDateTitle;

  /// No description provided for @onboardingNoContactDateSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Hatırlamıyorsan veya bugün başladıysan geçebilirsin.'**
  String get onboardingNoContactDateSubtitle;

  /// No description provided for @onboardingChangeDateBtn.
  ///
  /// In tr, this message translates to:
  /// **'TARİH DEĞİŞTİR'**
  String get onboardingChangeDateBtn;

  /// No description provided for @onboardingSkipDateBtn.
  ///
  /// In tr, this message translates to:
  /// **'Hatırlamıyorum / Bugün Başladım'**
  String get onboardingSkipDateBtn;

  /// No description provided for @onboardingEmotionTitle.
  ///
  /// In tr, this message translates to:
  /// **'Bugün en çok ne hissediyorsun?'**
  String get onboardingEmotionTitle;

  /// No description provided for @emotionSad.
  ///
  /// In tr, this message translates to:
  /// **'Üzgün'**
  String get emotionSad;

  /// No description provided for @emotionAngry.
  ///
  /// In tr, this message translates to:
  /// **'Öfkeli'**
  String get emotionAngry;

  /// No description provided for @emotionAnxious.
  ///
  /// In tr, this message translates to:
  /// **'Kaygılı'**
  String get emotionAnxious;

  /// No description provided for @emotionCalm.
  ///
  /// In tr, this message translates to:
  /// **'Sakin'**
  String get emotionCalm;

  /// No description provided for @emotionConfused.
  ///
  /// In tr, this message translates to:
  /// **'Kafam karışık'**
  String get emotionConfused;

  /// No description provided for @emotionMissing.
  ///
  /// In tr, this message translates to:
  /// **'Özlüyorum'**
  String get emotionMissing;

  /// No description provided for @onboardingTriggersTitle.
  ///
  /// In tr, this message translates to:
  /// **'En çok ne zaman yazmak istiyorsun?'**
  String get onboardingTriggersTitle;

  /// No description provided for @onboardingTriggersSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Birden fazla seçenek seçebilirsin.'**
  String get onboardingTriggersSubtitle;

  /// No description provided for @onboardingTrigger1.
  ///
  /// In tr, this message translates to:
  /// **'Yalnız hissettiğimde'**
  String get onboardingTrigger1;

  /// No description provided for @onboardingTrigger2.
  ///
  /// In tr, this message translates to:
  /// **'Gece geç saatlerde'**
  String get onboardingTrigger2;

  /// No description provided for @onboardingTrigger3.
  ///
  /// In tr, this message translates to:
  /// **'Eski anılar aklıma geldiğinde'**
  String get onboardingTrigger3;

  /// No description provided for @onboardingTrigger4.
  ///
  /// In tr, this message translates to:
  /// **'Sosyal medyada bir şey gördüğümde'**
  String get onboardingTrigger4;

  /// No description provided for @onboardingTrigger5.
  ///
  /// In tr, this message translates to:
  /// **'Stresli veya kaygılı olduğumda'**
  String get onboardingTrigger5;

  /// No description provided for @onboardingContractTitle.
  ///
  /// In tr, this message translates to:
  /// **'İçsel Akit'**
  String get onboardingContractTitle;

  /// No description provided for @onboardingContractSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Kendine bir söz ver.'**
  String get onboardingContractSubtitle;

  /// No description provided for @onboardingContractBody.
  ///
  /// In tr, this message translates to:
  /// **'İyileşme doğrusal bir yol değil, bir dizi bilinçli seçimdir. Bugün, dürtülerin yerine huzurunu seçiyorsun.'**
  String get onboardingContractBody;

  /// No description provided for @onboardingContract1Title.
  ///
  /// In tr, this message translates to:
  /// **'İletişim kurmadan önce SOS\'u açacağım.'**
  String get onboardingContract1Title;

  /// No description provided for @onboardingContract1Subtitle.
  ///
  /// In tr, this message translates to:
  /// **'Dürtüyle hareket etmeden önce kendime 10 dakika nefes alanı tanıyacağım.'**
  String get onboardingContract1Subtitle;

  /// No description provided for @onboardingContract2Title.
  ///
  /// In tr, this message translates to:
  /// **'İletişimsizliği manipülasyon olarak kullanmayacağım.'**
  String get onboardingContract2Title;

  /// No description provided for @onboardingContract2Subtitle.
  ///
  /// In tr, this message translates to:
  /// **'Sessizliğim karşı taraftan tepki almak için değil, kendi iyileşmem için bir araçtır.'**
  String get onboardingContract2Subtitle;

  /// No description provided for @onboardingContract3Title.
  ///
  /// In tr, this message translates to:
  /// **'Sosyal medya kontrolünün bir tetikleyici olduğunu fark edeceğim.'**
  String get onboardingContract3Title;

  /// No description provided for @onboardingContract3Subtitle.
  ///
  /// In tr, this message translates to:
  /// **'Haber aramanın sadece kaygımı artırdığını kabul ediyorum.'**
  String get onboardingContract3Subtitle;

  /// No description provided for @onboardingContractSealHint.
  ///
  /// In tr, this message translates to:
  /// **'Sözünü mühürlemek için butona basılı tut.'**
  String get onboardingContractSealHint;

  /// No description provided for @onboardingContractSealBtn.
  ///
  /// In tr, this message translates to:
  /// **'SÖZ VER'**
  String get onboardingContractSealBtn;

  /// No description provided for @onboardingFiraqTitle.
  ///
  /// In tr, this message translates to:
  /// **'Önce Firaq vardı.'**
  String get onboardingFiraqTitle;

  /// No description provided for @onboardingFiraqSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Firaq; bir kişiden, bir dönemden ya da eski bir senden uzak düşme hâlidir.'**
  String get onboardingFiraqSubtitle;

  /// No description provided for @onboardingFiraqBody.
  ///
  /// In tr, this message translates to:
  /// **'Bazen gitmek gerekir. Bazen de temas etmemek.'**
  String get onboardingFiraqBody;

  /// No description provided for @onboardingFiraqBtn.
  ///
  /// In tr, this message translates to:
  /// **'Mesafemi Koru'**
  String get onboardingFiraqBtn;

  /// No description provided for @onboardingNoContactTitle.
  ///
  /// In tr, this message translates to:
  /// **'NoContact bir ceza değildir.'**
  String get onboardingNoContactTitle;

  /// No description provided for @onboardingNoContactBody.
  ///
  /// In tr, this message translates to:
  /// **'Bu, karşı tarafı cezalandırmak için değil;\nkendini korumak, sakinleşmek ve yeniden duymak için açılmış bir mesafedir.'**
  String get onboardingNoContactBody;

  /// No description provided for @onboardingNoContactBtn.
  ///
  /// In tr, this message translates to:
  /// **'Mesafemi Koru'**
  String get onboardingNoContactBtn;

  /// No description provided for @onboardingAppPurposeTitle.
  ///
  /// In tr, this message translates to:
  /// **'Nosto yanında durur.'**
  String get onboardingAppPurposeTitle;

  /// No description provided for @onboardingAppPurposeBody.
  ///
  /// In tr, this message translates to:
  /// **'Temas isteği geldiğinde seni durdurur.\nDuygularını yazmana alan açar.\nGeçen günleri, zor anları ve küçük dönüşleri takip eder.'**
  String get onboardingAppPurposeBody;

  /// No description provided for @onboardingAppPurposeBtn.
  ///
  /// In tr, this message translates to:
  /// **'Kendime Dönüyorum'**
  String get onboardingAppPurposeBtn;

  /// No description provided for @onboardingPlanTitle.
  ///
  /// In tr, this message translates to:
  /// **'Bugün bir mesafe başlıyor.'**
  String get onboardingPlanTitle;

  /// No description provided for @onboardingPlanSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Birini silmek zorunda değilsin. Sadece bugün, kendini seçiyorsun.'**
  String get onboardingPlanSubtitle;

  /// No description provided for @onboardingPlanDurationLabel.
  ///
  /// In tr, this message translates to:
  /// **'Mevcut Süre'**
  String get onboardingPlanDurationLabel;

  /// No description provided for @onboardingPlanDurationValue.
  ///
  /// In tr, this message translates to:
  /// **'{days} Gün'**
  String onboardingPlanDurationValue(int days);

  /// No description provided for @onboardingPlanMoodLabel.
  ///
  /// In tr, this message translates to:
  /// **'Ruh Halin'**
  String get onboardingPlanMoodLabel;

  /// No description provided for @onboardingPlanTriggerLabel.
  ///
  /// In tr, this message translates to:
  /// **'En Büyük Tetikleyici'**
  String get onboardingPlanTriggerLabel;

  /// No description provided for @onboardingPlanTriggerUnknown.
  ///
  /// In tr, this message translates to:
  /// **'Bilinmiyor'**
  String get onboardingPlanTriggerUnknown;

  /// No description provided for @onboardingPlanFirst24Title.
  ///
  /// In tr, this message translates to:
  /// **'İLK 24 SAAT HEDEFİ'**
  String get onboardingPlanFirst24Title;

  /// No description provided for @onboardingPlanFirst24Body.
  ///
  /// In tr, this message translates to:
  /// **'Bugün hedefin basit: temas etmeden 24 saati korumak. Zorlandığında önce SOS planını açacağız.'**
  String get onboardingPlanFirst24Body;

  /// No description provided for @appDisclaimer.
  ///
  /// In tr, this message translates to:
  /// **'Bu uygulama terapi veya acil destek yerine geçmez.'**
  String get appDisclaimer;

  /// No description provided for @onboardingStartJourneyBtn.
  ///
  /// In tr, this message translates to:
  /// **'Nosto’yu Başlat'**
  String get onboardingStartJourneyBtn;

  /// No description provided for @homeGreetingMorning.
  ///
  /// In tr, this message translates to:
  /// **'Günaydın, {name}.'**
  String homeGreetingMorning(String name);

  /// No description provided for @homeGreetingAfternoon.
  ///
  /// In tr, this message translates to:
  /// **'İyi günler, {name}.'**
  String homeGreetingAfternoon(String name);

  /// No description provided for @homeGreetingEvening.
  ///
  /// In tr, this message translates to:
  /// **'İyi akşamlar, {name}.'**
  String homeGreetingEvening(String name);

  /// No description provided for @homeGreetingNight.
  ///
  /// In tr, this message translates to:
  /// **'İyi geceler, {name}.'**
  String homeGreetingNight(String name);

  /// No description provided for @homeNcDays.
  ///
  /// In tr, this message translates to:
  /// **'{days} gün'**
  String homeNcDays(int days);

  /// No description provided for @homeNcLabel.
  ///
  /// In tr, this message translates to:
  /// **'TEMASSIZ GÜNLER'**
  String get homeNcLabel;

  /// No description provided for @homeSosSuccess.
  ///
  /// In tr, this message translates to:
  /// **'Bu küçük anı atlattın.\nBugün kendine biraz daha yaklaştın.'**
  String get homeSosSuccess;

  /// No description provided for @homeSupportTitle.
  ///
  /// In tr, this message translates to:
  /// **'BUGÜNÜN DESTEĞİ'**
  String get homeSupportTitle;

  /// No description provided for @homeSupportSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Şu an ihtiyacın olan küçük adımı seç.'**
  String get homeSupportSubtitle;

  /// No description provided for @homePauseActive.
  ///
  /// In tr, this message translates to:
  /// **'24 SAATLİK DURAKLAMA AKTİF'**
  String get homePauseActive;

  /// No description provided for @homePauseActiveSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'{hours}s {minutes}dk kaldı\nKararını şu an koruyorsun.'**
  String homePauseActiveSubtitle(int hours, int minutes);

  /// No description provided for @homePauseExpired.
  ///
  /// In tr, this message translates to:
  /// **'DURAKLAMA TAMAMLANDI'**
  String get homePauseExpired;

  /// No description provided for @homePauseExpiredSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Şimdi daha sakin bir yerden karar verebilirsin.'**
  String get homePauseExpiredSubtitle;

  /// No description provided for @homeLibraryTitle.
  ///
  /// In tr, this message translates to:
  /// **'Sessiz Kütüphane'**
  String get homeLibraryTitle;

  /// No description provided for @homeLibrarySubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Sakin içerikler'**
  String get homeLibrarySubtitle;

  /// No description provided for @homeSilentReplyTitle.
  ///
  /// In tr, this message translates to:
  /// **'Sessiz Cevap'**
  String get homeSilentReplyTitle;

  /// No description provided for @homeSilentReplySubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Göndermeden yaz.'**
  String get homeSilentReplySubtitle;

  /// No description provided for @homeLetterTitle.
  ///
  /// In tr, this message translates to:
  /// **'Göndermeyeceğin Mektup'**
  String get homeLetterTitle;

  /// No description provided for @homeLetterSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'İçini dök.'**
  String get homeLetterSubtitle;

  /// No description provided for @homeTodayStepLabel.
  ///
  /// In tr, this message translates to:
  /// **'GÜN {day}'**
  String homeTodayStepLabel(int day);

  /// No description provided for @homeTodayStepTitle.
  ///
  /// In tr, this message translates to:
  /// **'Bugünün Adımı'**
  String get homeTodayStepTitle;

  /// No description provided for @sosTitle.
  ///
  /// In tr, this message translates to:
  /// **'Şu an yazmak istiyorsun.'**
  String get sosTitle;

  /// No description provided for @sosBreathIn.
  ///
  /// In tr, this message translates to:
  /// **'Nefes Al'**
  String get sosBreathIn;

  /// No description provided for @sosBreathOut.
  ///
  /// In tr, this message translates to:
  /// **'Nefes Ver'**
  String get sosBreathOut;

  /// No description provided for @sosSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Bu istek geçici.\nŞu an karar vermek zorunda değilsin.\nÖnce 90 saniye dur. Sonra ne hissettiğini yaz.'**
  String get sosSubtitle;

  /// No description provided for @sosStep1Title.
  ///
  /// In tr, this message translates to:
  /// **'90 Saniye Dur'**
  String get sosStep1Title;

  /// No description provided for @sosStep2Title.
  ///
  /// In tr, this message translates to:
  /// **'Göndermeden Yaz'**
  String get sosStep2Title;

  /// No description provided for @sosStep3Title.
  ///
  /// In tr, this message translates to:
  /// **'Kendini Seç'**
  String get sosStep3Title;

  /// No description provided for @sosWriteTitle.
  ///
  /// In tr, this message translates to:
  /// **'Göndermeden Yaz'**
  String get sosWriteTitle;

  /// No description provided for @sosWriteSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Düşüncelerini bu sayfaya dök. Kelimelerin ağırlığı zihninden çıksın ve burada kalsın.'**
  String get sosWriteSubtitle;

  /// No description provided for @sosWriteHint.
  ///
  /// In tr, this message translates to:
  /// **'Ona ne söylemek istiyorsan buraya yaz, asla duyulmayacak olsa bile...'**
  String get sosWriteHint;

  /// No description provided for @sosWritePrivacyNote.
  ///
  /// In tr, this message translates to:
  /// **'Bu mesaj asla gönderilmeyecek.'**
  String get sosWritePrivacyNote;

  /// No description provided for @sosWriteReleaseBtn.
  ///
  /// In tr, this message translates to:
  /// **'Mesajı Serbest Bırak'**
  String get sosWriteReleaseBtn;

  /// No description provided for @sosChooseTitle.
  ///
  /// In tr, this message translates to:
  /// **'Son Bir Adım'**
  String get sosChooseTitle;

  /// No description provided for @sosChooseSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Şu an temas etmeme kararını koruyor musun?'**
  String get sosChooseSubtitle;

  /// No description provided for @sosChooseYes.
  ///
  /// In tr, this message translates to:
  /// **'BUGÜN TEMAS ETMEYECEĞİM'**
  String get sosChooseYes;

  /// No description provided for @sosChooseStillStruggling.
  ///
  /// In tr, this message translates to:
  /// **'HÂLÂ ÇOK ZORLANIYORUM'**
  String get sosChooseStillStruggling;

  /// No description provided for @sosCompletionTitle.
  ///
  /// In tr, this message translates to:
  /// **'Geçti. Sen hâlâ buradasın.'**
  String get sosCompletionTitle;

  /// No description provided for @sosCompletionSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Bu küçük anı atlattın.\nBugün kendine biraz daha yaklaştın.'**
  String get sosCompletionSubtitle;

  /// No description provided for @sosReturnBtn.
  ///
  /// In tr, this message translates to:
  /// **'HUZURLA DÖN'**
  String get sosReturnBtn;

  /// No description provided for @sosGroundingTitle.
  ///
  /// In tr, this message translates to:
  /// **'Yanındayız.'**
  String get sosGroundingTitle;

  /// No description provided for @sosGroundingSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Zorlanman çok normal. Şu an bunlardan birini dene:'**
  String get sosGroundingSubtitle;

  /// No description provided for @sosGroundingAction1.
  ///
  /// In tr, this message translates to:
  /// **'Bir bardak su iç'**
  String get sosGroundingAction1;

  /// No description provided for @sosGroundingAction2.
  ///
  /// In tr, this message translates to:
  /// **'Telefonu 10 dk başka odaya bırak'**
  String get sosGroundingAction2;

  /// No description provided for @sosGroundingAction3.
  ///
  /// In tr, this message translates to:
  /// **'Temiz hava al'**
  String get sosGroundingAction3;

  /// No description provided for @sosCrisisWarning.
  ///
  /// In tr, this message translates to:
  /// **'Kendine zarar verme düşüncen varsa hemen yerel acil destek hattına ulaş.'**
  String get sosCrisisWarning;

  /// No description provided for @sosBetterBtn.
  ///
  /// In tr, this message translates to:
  /// **'BİRAZ DAHA İYİYİM'**
  String get sosBetterBtn;

  /// No description provided for @supportTitle.
  ///
  /// In tr, this message translates to:
  /// **'Bugünün Desteği'**
  String get supportTitle;

  /// No description provided for @support24hTitle.
  ///
  /// In tr, this message translates to:
  /// **'24 Saatlik Alan'**
  String get support24hTitle;

  /// No description provided for @support24hBody.
  ///
  /// In tr, this message translates to:
  /// **'Bu mesajı bugün göndermeyeceğim. 24 saat sonra daha sakin karar vereceğim.'**
  String get support24hBody;

  /// No description provided for @support24hStartBtn.
  ///
  /// In tr, this message translates to:
  /// **'24 SAAT BEKLEMEYE AL'**
  String get support24hStartBtn;

  /// No description provided for @supportPauseActiveTitle.
  ///
  /// In tr, this message translates to:
  /// **'24 Saatlik Duraklama Aktif'**
  String get supportPauseActiveTitle;

  /// No description provided for @supportPauseActiveBody.
  ///
  /// In tr, this message translates to:
  /// **'Kalan süre: {hours}s {minutes}dk.\nKararını şu an koruyorsun.'**
  String supportPauseActiveBody(int hours, int minutes);

  /// No description provided for @supportPauseExpiredTitle.
  ///
  /// In tr, this message translates to:
  /// **'Duraklama Tamamlandı'**
  String get supportPauseExpiredTitle;

  /// No description provided for @supportPauseExpiredBody.
  ///
  /// In tr, this message translates to:
  /// **'Şimdi daha sakin bir yerden karar verebilirsin.'**
  String get supportPauseExpiredBody;

  /// No description provided for @supportPauseDismissBtn.
  ///
  /// In tr, this message translates to:
  /// **'KAPAT'**
  String get supportPauseDismissBtn;

  /// No description provided for @supportWhyStartedBtn.
  ///
  /// In tr, this message translates to:
  /// **'NEDEN BAŞLADIĞIMI HATIRLA'**
  String get supportWhyStartedBtn;

  /// No description provided for @supportLeaveNoteBtn.
  ///
  /// In tr, this message translates to:
  /// **'KENDİME NOT BIRAK'**
  String get supportLeaveNoteBtn;

  /// No description provided for @supportSilentReplyBtn.
  ///
  /// In tr, this message translates to:
  /// **'SESSİZ CEVAP YAZ'**
  String get supportSilentReplyBtn;

  /// No description provided for @supportNoteSnackbar.
  ///
  /// In tr, this message translates to:
  /// **'Bunu kendin için bıraktın.'**
  String get supportNoteSnackbar;

  /// No description provided for @supportReasonTitle.
  ///
  /// In tr, this message translates to:
  /// **'Neden Başladığını Hatırla'**
  String get supportReasonTitle;

  /// No description provided for @supportNoteDialogTitle.
  ///
  /// In tr, this message translates to:
  /// **'Kendine Not'**
  String get supportNoteDialogTitle;

  /// No description provided for @supportNoteHint.
  ///
  /// In tr, this message translates to:
  /// **'Kendine bırakmak istediğin bir şey...'**
  String get supportNoteHint;

  /// No description provided for @supportNoteSaveBtn.
  ///
  /// In tr, this message translates to:
  /// **'KAYDET'**
  String get supportNoteSaveBtn;

  /// No description provided for @moodJournalTitle.
  ///
  /// In tr, this message translates to:
  /// **'Duygu Günlüğü'**
  String get moodJournalTitle;

  /// No description provided for @moodJournalTodayTitle.
  ///
  /// In tr, this message translates to:
  /// **'Bugünün Yansıması'**
  String get moodJournalTodayTitle;

  /// No description provided for @moodJournalTodaySubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Şu an nasıl hissediyorsun?'**
  String get moodJournalTodaySubtitle;

  /// No description provided for @moodJournalHowFeel.
  ///
  /// In tr, this message translates to:
  /// **'Bugün nasıl hissettim:'**
  String get moodJournalHowFeel;

  /// No description provided for @moodJournalIntensity.
  ///
  /// In tr, this message translates to:
  /// **'Yoğunluk'**
  String get moodJournalIntensity;

  /// No description provided for @moodJournalTriggers.
  ///
  /// In tr, this message translates to:
  /// **'Bugünkü Tetikleyiciler (opsiyonel)'**
  String get moodJournalTriggers;

  /// No description provided for @moodJournalNote.
  ///
  /// In tr, this message translates to:
  /// **'Özel Not (Opsiyonel)'**
  String get moodJournalNote;

  /// No description provided for @moodJournalNoteHint.
  ///
  /// In tr, this message translates to:
  /// **'Zihninden geçenleri buraya dök...'**
  String get moodJournalNoteHint;

  /// No description provided for @moodJournalSaveBtn.
  ///
  /// In tr, this message translates to:
  /// **'YANSIMAYI KAYDET'**
  String get moodJournalSaveBtn;

  /// No description provided for @moodJournalUpdateBtn.
  ///
  /// In tr, this message translates to:
  /// **'YANSIMAYI GÜNCELLE'**
  String get moodJournalUpdateBtn;

  /// No description provided for @moodJournalSavedSnackbar.
  ///
  /// In tr, this message translates to:
  /// **'Yansıman güvenle saklandı.'**
  String get moodJournalSavedSnackbar;

  /// No description provided for @moodJournalUpdatedSnackbar.
  ///
  /// In tr, this message translates to:
  /// **'Bugünkü yansıman güncellendi.'**
  String get moodJournalUpdatedSnackbar;

  /// No description provided for @moodJournalWeeklyTitle.
  ///
  /// In tr, this message translates to:
  /// **'HAFTALIK ÖZET'**
  String get moodJournalWeeklyTitle;

  /// No description provided for @moodJournalWeeklySubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Dengeyi Bulmak'**
  String get moodJournalWeeklySubtitle;

  /// No description provided for @moodJournalWeeklyStreak.
  ///
  /// In tr, this message translates to:
  /// **'Bu hafta {streak} günlük bir seri yakaladın. En sık tetikleyicin: {trigger}.'**
  String moodJournalWeeklyStreak(int streak, String trigger);

  /// No description provided for @moodJournalHistory.
  ///
  /// In tr, this message translates to:
  /// **'Geçmiş Kayıtlar'**
  String get moodJournalHistory;

  /// No description provided for @lettersVaultTitle.
  ///
  /// In tr, this message translates to:
  /// **'Gönderilmeyen Mektuplar'**
  String get lettersVaultTitle;

  /// No description provided for @lettersVaultEmpty.
  ///
  /// In tr, this message translates to:
  /// **'Henüz mektup yok.\nSöylemek istediklerini yaz. Ama göndermek zorunda değilsin.'**
  String get lettersVaultEmpty;

  /// No description provided for @lettersVaultNewBtn.
  ///
  /// In tr, this message translates to:
  /// **'YENİ MEKTUP'**
  String get lettersVaultNewBtn;

  /// No description provided for @lettersVaultActiveTab.
  ///
  /// In tr, this message translates to:
  /// **'Aktif'**
  String get lettersVaultActiveTab;

  /// No description provided for @lettersVaultArchiveTab.
  ///
  /// In tr, this message translates to:
  /// **'Arşiv'**
  String get lettersVaultArchiveTab;

  /// No description provided for @letterEditorTitleHint.
  ///
  /// In tr, this message translates to:
  /// **'Başlık (isteğe bağlı)...'**
  String get letterEditorTitleHint;

  /// No description provided for @letterEditorBodyHint.
  ///
  /// In tr, this message translates to:
  /// **'Şu an sana söylemek istediğim şey…'**
  String get letterEditorBodyHint;

  /// No description provided for @letterEditorEmotionSection.
  ///
  /// In tr, this message translates to:
  /// **'Duygu Durumu'**
  String get letterEditorEmotionSection;

  /// No description provided for @letterEditorLetterSection.
  ///
  /// In tr, this message translates to:
  /// **'Mektup'**
  String get letterEditorLetterSection;

  /// No description provided for @letterEditorPrivacyNote.
  ///
  /// In tr, this message translates to:
  /// **'Bu mektup asla gönderilmez. Sadece içinden çıkarman için.'**
  String get letterEditorPrivacyNote;

  /// No description provided for @letterEditorReleaseBtn.
  ///
  /// In tr, this message translates to:
  /// **'MEKTUBU SERBEST BIRAK'**
  String get letterEditorReleaseBtn;

  /// No description provided for @letterEditorEmptyError.
  ///
  /// In tr, this message translates to:
  /// **'Boş mektup kaydedilemez.'**
  String get letterEditorEmptyError;

  /// No description provided for @letterEditorSavedSnackbar.
  ///
  /// In tr, this message translates to:
  /// **'Yazdın. Göndermedin. Bu da bir güç.'**
  String get letterEditorSavedSnackbar;

  /// No description provided for @letterEditorArchiveTitle.
  ///
  /// In tr, this message translates to:
  /// **'Gözümün önünden kaldır'**
  String get letterEditorArchiveTitle;

  /// No description provided for @letterEditorArchiveBody.
  ///
  /// In tr, this message translates to:
  /// **'Bu mektup silinmez. Sadece Arşivlenenler bölümüne taşınır.'**
  String get letterEditorArchiveBody;

  /// No description provided for @letterEditorArchiveBtn.
  ///
  /// In tr, this message translates to:
  /// **'KALDIR'**
  String get letterEditorArchiveBtn;

  /// No description provided for @letterEditorArchivedSnackbar.
  ///
  /// In tr, this message translates to:
  /// **'Mektup arşive kaldırıldı.'**
  String get letterEditorArchivedSnackbar;

  /// No description provided for @letterEditorRestoreTitle.
  ///
  /// In tr, this message translates to:
  /// **'Tekrar kasaya taşı'**
  String get letterEditorRestoreTitle;

  /// No description provided for @letterEditorRestoreBody.
  ///
  /// In tr, this message translates to:
  /// **'Bu mektup tekrar Aktif Mektuplar listesinde görünür.'**
  String get letterEditorRestoreBody;

  /// No description provided for @letterEditorRestoreBtn.
  ///
  /// In tr, this message translates to:
  /// **'TAŞI'**
  String get letterEditorRestoreBtn;

  /// No description provided for @letterEditorRestoredSnackbar.
  ///
  /// In tr, this message translates to:
  /// **'Mektup aktif listeye geri taşındı.'**
  String get letterEditorRestoredSnackbar;

  /// No description provided for @letterEditorDeleteTitle.
  ///
  /// In tr, this message translates to:
  /// **'Bu mektubu kalıcı olarak silmek istiyor musun?'**
  String get letterEditorDeleteTitle;

  /// No description provided for @letterEditorDeleteBody.
  ///
  /// In tr, this message translates to:
  /// **'Bu işlem geri alınamaz.'**
  String get letterEditorDeleteBody;

  /// No description provided for @letterEditorDeleteConfirmBtn.
  ///
  /// In tr, this message translates to:
  /// **'Kalıcı Olarak Sil'**
  String get letterEditorDeleteConfirmBtn;

  /// No description provided for @letterEditorCancelBtn.
  ///
  /// In tr, this message translates to:
  /// **'Vazgeç'**
  String get letterEditorCancelBtn;

  /// No description provided for @silentReplyTitle.
  ///
  /// In tr, this message translates to:
  /// **'Sessiz Cevap'**
  String get silentReplyTitle;

  /// No description provided for @silentReplySubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Bir mesaj aldın ve cevap yazmak istiyorsun. Ama göndermeden önce bir adım geri çekil.'**
  String get silentReplySubtitle;

  /// No description provided for @silentReplyHint.
  ///
  /// In tr, this message translates to:
  /// **'Ne yazmak istiyordun?'**
  String get silentReplyHint;

  /// No description provided for @silentReplyPrivacyNote.
  ///
  /// In tr, this message translates to:
  /// **'Bu hiçbir zaman gönderilmez.'**
  String get silentReplyPrivacyNote;

  /// No description provided for @silentReplySaveToVault.
  ///
  /// In tr, this message translates to:
  /// **'KASAYA KAYDET'**
  String get silentReplySaveToVault;

  /// No description provided for @silentReplyShowOptions.
  ///
  /// In tr, this message translates to:
  /// **'SEÇENEKLERİ GÖSTER'**
  String get silentReplyShowOptions;

  /// No description provided for @silentReplyStep3Title.
  ///
  /// In tr, this message translates to:
  /// **'Şimdi daha güvenli bir çıkış seç.'**
  String get silentReplyStep3Title;

  /// No description provided for @silentReplyStep3Subtitle.
  ///
  /// In tr, this message translates to:
  /// **'Kelimelerini korudun. Şimdi onlarla ne yapacağını seç.'**
  String get silentReplyStep3Subtitle;

  /// No description provided for @silentReplyRelease.
  ///
  /// In tr, this message translates to:
  /// **'SERBEST BIRAK'**
  String get silentReplyRelease;

  /// No description provided for @silentReplySavedSnackbar.
  ///
  /// In tr, this message translates to:
  /// **'Sessiz cevabın kasaya eklendi.'**
  String get silentReplySavedSnackbar;

  /// No description provided for @recoveryPathTitle.
  ///
  /// In tr, this message translates to:
  /// **'30 Günlük Yol'**
  String get recoveryPathTitle;

  /// No description provided for @recoveryPathMilestone.
  ///
  /// In tr, this message translates to:
  /// **'MEVCUT KİLOMETRE TAŞI'**
  String get recoveryPathMilestone;

  /// No description provided for @recoveryPathDayCount.
  ///
  /// In tr, this message translates to:
  /// **'/ 30 Gün'**
  String get recoveryPathDayCount;

  /// No description provided for @recoveryPathOpenStep.
  ///
  /// In tr, this message translates to:
  /// **'BU ADIMI AÇ'**
  String get recoveryPathOpenStep;

  /// No description provided for @insightsTitle.
  ///
  /// In tr, this message translates to:
  /// **'İçgörüler'**
  String get insightsTitle;

  /// No description provided for @insightsMoodBalance.
  ///
  /// In tr, this message translates to:
  /// **'Duygu Dengesi'**
  String get insightsMoodBalance;

  /// No description provided for @insightsMoodBalanceSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Son 14 gündeki baskın hislerin.'**
  String get insightsMoodBalanceSubtitle;

  /// No description provided for @insightsMilestones.
  ///
  /// In tr, this message translates to:
  /// **'Yol İzleri'**
  String get insightsMilestones;

  /// No description provided for @insightsMilestonesSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Geride bıraktığın anlamlı anlar.'**
  String get insightsMilestonesSubtitle;

  /// No description provided for @insightsSosStrength.
  ///
  /// In tr, this message translates to:
  /// **'GÜÇLÜ DURUŞ'**
  String get insightsSosStrength;

  /// No description provided for @insightsSosManagedUrges.
  ///
  /// In tr, this message translates to:
  /// **'Yönettiğin {count} dürtü.'**
  String insightsSosManagedUrges(int count);

  /// No description provided for @insightsSosReflection.
  ///
  /// In tr, this message translates to:
  /// **'Her duraklama, kendini seçtiğin bir andır.'**
  String get insightsSosReflection;

  /// No description provided for @settingsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Ayarlar'**
  String get settingsTitle;

  /// No description provided for @settingsProfileSection.
  ///
  /// In tr, this message translates to:
  /// **'Profilim'**
  String get settingsProfileSection;

  /// No description provided for @settingsDaysLabel.
  ///
  /// In tr, this message translates to:
  /// **'gün no-contact'**
  String get settingsDaysLabel;

  /// No description provided for @settingsNotificationsSection.
  ///
  /// In tr, this message translates to:
  /// **'Bildirimler'**
  String get settingsNotificationsSection;

  /// No description provided for @settingsRhythmToggle.
  ///
  /// In tr, this message translates to:
  /// **'Günlük Ritim'**
  String get settingsRhythmToggle;

  /// No description provided for @settingsRhythmSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Sabah, öğle ve akşam için nazik hatırlatmalar.'**
  String get settingsRhythmSubtitle;

  /// No description provided for @settingsMorningLabel.
  ///
  /// In tr, this message translates to:
  /// **'Sabah'**
  String get settingsMorningLabel;

  /// No description provided for @settingsMiddayLabel.
  ///
  /// In tr, this message translates to:
  /// **'Öğle'**
  String get settingsMiddayLabel;

  /// No description provided for @settingsEveningLabel.
  ///
  /// In tr, this message translates to:
  /// **'Akşam'**
  String get settingsEveningLabel;

  /// No description provided for @settingsContextualLabel.
  ///
  /// In tr, this message translates to:
  /// **'Bağlama Göre Hatırlatmalar'**
  String get settingsContextualLabel;

  /// No description provided for @settingsContextualSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'SOS, 24 saat bekleme veya güvenli çıkış sonrasında nazik takip.'**
  String get settingsContextualSubtitle;

  /// No description provided for @settingsTestNotifBtn.
  ///
  /// In tr, this message translates to:
  /// **'1 dk sonra test bildirimi gönder'**
  String get settingsTestNotifBtn;

  /// No description provided for @settingsTestNotifSnackbar.
  ///
  /// In tr, this message translates to:
  /// **'Test bildirimi 1 dakika sonra gelecek.'**
  String get settingsTestNotifSnackbar;

  /// No description provided for @settingsPrivacyNotice.
  ///
  /// In tr, this message translates to:
  /// **'Tüm bildirimler cihazında planlanır. Mektup, günlük veya SOS içeriğin bildirimlerde hiçbir zaman görünmez.'**
  String get settingsPrivacyNotice;

  /// No description provided for @settingsDataSection.
  ///
  /// In tr, this message translates to:
  /// **'Veri ve Gizlilik'**
  String get settingsDataSection;

  /// No description provided for @settingsBiometricLabel.
  ///
  /// In tr, this message translates to:
  /// **'Biyometrik Kilit'**
  String get settingsBiometricLabel;

  /// No description provided for @settingsBiometricSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Günlük ve mektuplarını açmadan önce cihaz doğrulaması ister.'**
  String get settingsBiometricSubtitle;

  /// No description provided for @settingsClearDataLabel.
  ///
  /// In tr, this message translates to:
  /// **'Yerel Verileri Temizle'**
  String get settingsClearDataLabel;

  /// No description provided for @settingsClearDataSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Uygulamayı sıfırlar ve başlangıca döner.'**
  String get settingsClearDataSubtitle;

  /// No description provided for @settingsDeleteDataLabel.
  ///
  /// In tr, this message translates to:
  /// **'Verileri Kalıcı Olarak Sil'**
  String get settingsDeleteDataLabel;

  /// No description provided for @settingsClearConfirmTitle.
  ///
  /// In tr, this message translates to:
  /// **'Emin misiniz?'**
  String get settingsClearConfirmTitle;

  /// No description provided for @settingsClearConfirmBody.
  ///
  /// In tr, this message translates to:
  /// **'Tüm yerel verileriniz (günlükler, mektuplar) silinecek.'**
  String get settingsClearConfirmBody;

  /// No description provided for @settingsClearBtn.
  ///
  /// In tr, this message translates to:
  /// **'TEMİZLE'**
  String get settingsClearBtn;

  /// No description provided for @settingsClearCancelBtn.
  ///
  /// In tr, this message translates to:
  /// **'VAZGEÇ'**
  String get settingsClearCancelBtn;

  /// No description provided for @notifMorningTitle.
  ///
  /// In tr, this message translates to:
  /// **'Günaydın 🌿'**
  String get notifMorningTitle;

  /// No description provided for @notifMorningBody.
  ///
  /// In tr, this message translates to:
  /// **'Bugün kendine verdiğin sözü hatırla.'**
  String get notifMorningBody;

  /// No description provided for @notifMiddayTitle.
  ///
  /// In tr, this message translates to:
  /// **'Bir an dur ✨'**
  String get notifMiddayTitle;

  /// No description provided for @notifMiddayBody.
  ///
  /// In tr, this message translates to:
  /// **'Bugün sadece mesafeni koru. Bu yeter.'**
  String get notifMiddayBody;

  /// No description provided for @notifEveningTitle.
  ///
  /// In tr, this message translates to:
  /// **'Bu akşam 🌙'**
  String get notifEveningTitle;

  /// No description provided for @notifEveningBody.
  ///
  /// In tr, this message translates to:
  /// **'Kendine dönmek bazen yazmamaktır.'**
  String get notifEveningBody;

  /// No description provided for @notifSosFollowupTitle.
  ///
  /// In tr, this message translates to:
  /// **'Nasılsın?'**
  String get notifSosFollowupTitle;

  /// No description provided for @notifSosFollowupBody.
  ///
  /// In tr, this message translates to:
  /// **'Temas isteği geçer. Kendine dönüş kalır.'**
  String get notifSosFollowupBody;

  /// No description provided for @notifPauseExpiredTitle.
  ///
  /// In tr, this message translates to:
  /// **'24 saat tamamlandı.'**
  String get notifPauseExpiredTitle;

  /// No description provided for @notifPauseExpiredBody.
  ///
  /// In tr, this message translates to:
  /// **'Onu değil, kendini dinle. Sadece bugün.'**
  String get notifPauseExpiredBody;

  /// No description provided for @notifSilentReplySavedTitle.
  ///
  /// In tr, this message translates to:
  /// **'Yazdın, göndermedin.'**
  String get notifSilentReplySavedTitle;

  /// No description provided for @notifSilentReplySavedBody.
  ///
  /// In tr, this message translates to:
  /// **'Nosto burada. Önce buraya yaz.'**
  String get notifSilentReplySavedBody;

  /// No description provided for @subscriptionTitle.
  ///
  /// In tr, this message translates to:
  /// **'Nosto Premium'**
  String get subscriptionTitle;

  /// No description provided for @subscriptionTagline.
  ///
  /// In tr, this message translates to:
  /// **'Kendine Dönüş Yolculuğunu Destekle'**
  String get subscriptionTagline;

  /// No description provided for @subscriptionSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Premium özellikler, daha derin bir iyileşme deneyimi için tasarlandı.'**
  String get subscriptionSubtitle;

  /// No description provided for @subscriptionCurrentPlan.
  ///
  /// In tr, this message translates to:
  /// **'Mevcut Plan'**
  String get subscriptionCurrentPlan;

  /// No description provided for @subscriptionFreePlan.
  ///
  /// In tr, this message translates to:
  /// **'Ücretsiz Plan'**
  String get subscriptionFreePlan;

  /// No description provided for @subscriptionPremiumPlan.
  ///
  /// In tr, this message translates to:
  /// **'Premium Plan (Yakında)'**
  String get subscriptionPremiumPlan;

  /// No description provided for @subscriptionContinueBtn.
  ///
  /// In tr, this message translates to:
  /// **'DEVAM ET'**
  String get subscriptionContinueBtn;

  /// No description provided for @subscriptionDevToggleToPremium.
  ///
  /// In tr, this message translates to:
  /// **'Premium Moduna Geç (DEV)'**
  String get subscriptionDevToggleToPremium;

  /// No description provided for @subscriptionDevToggleToFree.
  ///
  /// In tr, this message translates to:
  /// **'Ücretsiz Moduna Dön (DEV)'**
  String get subscriptionDevToggleToFree;

  /// No description provided for @subscriptionPaymentNote.
  ///
  /// In tr, this message translates to:
  /// **'Ödeme entegrasyonu henüz aktif değil. Şu an tüm özellikleri ücretsiz deneyebilirsin.'**
  String get subscriptionPaymentNote;

  /// No description provided for @subscriptionGateRecoveryPath.
  ///
  /// In tr, this message translates to:
  /// **'30 Günlük İyileşme Yolu premium ile açılır.'**
  String get subscriptionGateRecoveryPath;

  /// No description provided for @subscriptionGateSilentReply.
  ///
  /// In tr, this message translates to:
  /// **'Sessiz Cevap rehberi premium ile açılır.'**
  String get subscriptionGateSilentReply;

  /// No description provided for @subscriptionGateInsights.
  ///
  /// In tr, this message translates to:
  /// **'Gelişmiş içgörüler premium ile açılır.'**
  String get subscriptionGateInsights;

  /// No description provided for @subscriptionGateMoodJournal.
  ///
  /// In tr, this message translates to:
  /// **'Duygu Günlüğü premium ile açılır.'**
  String get subscriptionGateMoodJournal;

  /// No description provided for @subscriptionGateLettersVault.
  ///
  /// In tr, this message translates to:
  /// **'Gönderilmeyen Mektuplar premium ile açılır.'**
  String get subscriptionGateLettersVault;

  /// No description provided for @subscriptionGateSupportCenter.
  ///
  /// In tr, this message translates to:
  /// **'Bugünün Desteği premium ile açılır.'**
  String get subscriptionGateSupportCenter;

  /// No description provided for @subscriptionGateLibrary.
  ///
  /// In tr, this message translates to:
  /// **'Sessiz Kütüphane premium ile açılır.'**
  String get subscriptionGateLibrary;

  /// No description provided for @subscriptionGateBetaFeedback.
  ///
  /// In tr, this message translates to:
  /// **'Geri bildirim ekranı premium ile açılır.'**
  String get subscriptionGateBetaFeedback;

  /// No description provided for @subscriptionGateDefault.
  ///
  /// In tr, this message translates to:
  /// **'Bu özellik premium üyelere özeldir.'**
  String get subscriptionGateDefault;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

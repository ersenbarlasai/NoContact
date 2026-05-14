/// Locale-aware notification string resolver.
/// 
/// Since [NotificationService] runs without a BuildContext, this class
/// reads the saved locale from [LocalStorageService] and returns the
/// correct language strings directly — without depending on AppLocalizations.
class NotificationStrings {
  final String _lang;

  NotificationStrings._(this._lang);

  /// Build from a BCP-47 language tag (e.g. 'tr', 'en').
  /// Falls back to English for any unsupported locale.
  factory NotificationStrings.fromLanguageCode(String? languageCode) {
    return NotificationStrings._(languageCode == 'tr' ? 'tr' : 'en');
  }

  // ─── Morning ────────────────────────────────────────────────────────────────
  String get morningTitle => _lang == 'tr' ? 'Günaydın 🌿' : 'Good morning 🌿';
  String get morningBody  => _lang == 'tr'
      ? 'Bugün de kendinle birliktesin. Bu yeterlice güçlü bir başlangıç.'
      : 'Today, you\'re still here with yourself. That\'s a strong enough start.';

  // ─── Midday ─────────────────────────────────────────────────────────────────
  String get middayTitle => _lang == 'tr' ? 'Bir an dur ✨' : 'A quiet pause ✨';
  String get middayBody  => _lang == 'tr'
      ? 'Öğlen sana ufak bir hatırlatma: şu an burada olman başlı başına bir seçim.'
      : 'A midday reminder: simply being here right now is already a choice.';

  // ─── Evening ────────────────────────────────────────────────────────────────
  String get eveningTitle => _lang == 'tr' ? 'Bu akşam 🌙' : 'This evening 🌙';
  String get eveningBody  => _lang == 'tr'
      ? 'Kendine dönmek bazen yazmamaktır.'
      : 'Sometimes returning to yourself means not writing.';

  // ─── SOS Follow-up ──────────────────────────────────────────────────────────
  String get postSosTitle => _lang == 'tr' ? 'Nasılsın?' : 'How are you doing?';
  String get postSosBody  => _lang == 'tr'
      ? 'Dünkü o anı atlattın. Bugün nasıl hissediyorsun?'
      : 'You got through that moment yesterday. How are you feeling today?';

  // ─── 24h Pause follow-up ────────────────────────────────────────────────────
  String get pauseFollowUpTitle => _lang == 'tr' ? '24 saat tamamlandı.' : '24 hours complete.';
  String get pauseFollowUpBody  => _lang == 'tr'
      ? 'Kararını korudun. Şimdi daha net bir yerden düşünebilirsin.'
      : 'You held your boundary. You can think more clearly from here.';

  // ─── Silent Reply ────────────────────────────────────────────────────────────
  String get silentReplyTitle => _lang == 'tr' ? 'Yazdın, göndermedin.' : 'You wrote. You didn\'t send.';
  String get silentReplyBody  => _lang == 'tr'
      ? 'Bu da bir güç. Sessiz cevabın kasada seni bekliyor.'
      : 'That takes strength. Your quiet reply is waiting in the vault.';

  // ─── Daily general ──────────────────────────────────────────────────────────
  String get dailyTitle => _lang == 'tr' ? 'Sessiz Bir An' : 'A Quiet Moment';
  String get dailyBody  => _lang == 'tr'
      ? 'Bugün kendini bir cümleyle yoklamak ister misin?'
      : 'Would you like to check in with yourself today?';
}

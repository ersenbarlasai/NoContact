import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'timezone_helper.dart';

// ─── Kanal sabitleri ─────────────────────────────────────────────────────────
const _kChannelId   = 'daily_rhythm_soft';
const _kAndroidSound = 'still_soft_chime';
const _kChannelName = 'Günlük Ritim';
const _kChannelDesc = 'Günlük iyileşme hatırlatmaları';

// ─── Bildirim ID sabit haritası ───────────────────────────────────────────────
// ID çakışmasını önlemek için tüm bildirimler buradan yönetilir.
class NotificationIds {
  static const int daily          = 1;   // Ana günlük hatırlatma
  static const int morning        = 2;   // Sabah nazik başlangıç
  static const int midday         = 3;   // Öğlen kısa duraklama
  static const int evening        = 4;   // Akşam yansıması
  static const int pauseFollowUp  = 10;  // 24 saat bekleme takibi
  static const int postSos        = 11;  // SOS sonrası nazik takip
  static const int silentReply    = 12;  // Sessiz cevap → kasaya bırak takibi
  static const int _testDebug     = 9999;

  /// Bağlamsal bildirimlerin tam listesi (toplu iptal için).
  static const List<int> contextual = [pauseFollowUp, postSos, silentReply];

  /// Günlük ritim bildirimlerinin tam listesi.
  static const List<int> rhythm = [daily, morning, midday, evening];
}

// ─── Bildirim metinleri (Privacy-safe: hassas içerik YOK) ────────────────────
class _Copy {
  // Günlük ritim
  static const dailyTitle  = 'Sessiz Bir An';
  static const dailyBody   = 'Bugün kendini bir cümleyle yoklamak ister misin?';

  // Sabah
  static const morningTitle = 'Güne Nazikçe Başla';
  static const morningBody  = 'Bugün kendine sert davranmadan ilerleyebilirsin.';

  // Öğlen
  static const middayTitle = 'Bir Anlık Duraklama';
  static const middayBody  = 'Bir an durup bedenini fark etmek ister misin?';

  // Akşam
  static const eveningTitle = 'Bugün Nasıldı?';
  static const eveningBody  = 'Bugün içinden geçenleri güvenli bir yere bırakabilirsin.';

  // 24 saat bekleme takibi
  static const pauseFollowUpTitle = 'Kararına yeniden bakmak ister misin?';
  static const pauseFollowUpBody  = 'Dün kendine bir alan açmıştın. Şimdi daha sakin bir yerden bakabilirsin.';

  // SOS sonrası
  static const postSosTitle = 'Dün zor bir anı atlattın.';
  static const postSosBody  = 'Bugün biraz daha yavaş ilerleyebilirsin.';

  // Sessiz cevap kasaya bırakıldı
  static const silentReplyTitle = 'Göndermeden bıraktığın şey hâlâ güvende.';
  static const silentReplyBody  = 'İstersen bugün sadece bir cümleyle kendine dönebilirsin.';
}

// ─────────────────────────────────────────────────────────────────────────────

class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  // ─── Başlatma ───────────────────────────────────────────────────────────────

  static Future<void> init() async {
    if (kIsWeb) return;

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      _kChannelId,
      _kChannelName,
      description: _kChannelDesc,
      importance: Importance.defaultImportance,
      playSound: true,
      enableVibration: true,
      // Özel ses: android/app/src/main/res/raw/still_soft_chime.wav
      sound: RawResourceAndroidNotificationSound(_kAndroidSound),
    );

    final androidImpl = _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    await androidImpl?.createNotificationChannel(channel);

    const InitializationSettings initSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
      ),
    );

    await _plugin.initialize(
      settings: initSettings,
      onDidReceiveNotificationResponse: (_) {},
    );
  }

  // ─── İzin ───────────────────────────────────────────────────────────────────

  static Future<bool> requestPermission() async {
    if (kIsWeb) return false;
    bool granted = false;

    final androidImpl = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    if (androidImpl != null) {
      final result = await androidImpl.requestNotificationsPermission();
      granted = result ?? false;
    }

    final iosImpl = _plugin.resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>();
    if (iosImpl != null) {
      final result = await iosImpl.requestPermissions(
        alert: true, badge: true, sound: true,
      );
      granted = granted || (result ?? false);
    }

    return granted;
  }

  // ─── Günlük Ritim Bildirimleri ───────────────────────────────────────────────

  /// Ana günlük hatırlatma (ID: 1).
  static Future<void> scheduleDailyReminder({
    required int id,
    required String title,
    required String body,
    required int hour,
    required int minute,
  }) async {
    if (kIsWeb) return;
    await _scheduleRepeating(
      id: id, title: title, body: body, hour: hour, minute: minute,
    );
  }

  /// Sabah nazik başlangıç (ID: 2, ~08:00).
  static Future<void> scheduleMorningReminder() async {
    if (kIsWeb) return;
    await _scheduleRepeating(
      id: NotificationIds.morning,
      title: _Copy.morningTitle,
      body: _Copy.morningBody,
      hour: 8, minute: 0,
    );
  }

  /// Öğlen kısa duraklama (ID: 3, ~12:30).
  static Future<void> scheduleMiddayReminder() async {
    if (kIsWeb) return;
    await _scheduleRepeating(
      id: NotificationIds.midday,
      title: _Copy.middayTitle,
      body: _Copy.middayBody,
      hour: 12, minute: 30,
    );
  }

  /// Akşam yansıması (ID: 4, ~21:00).
  static Future<void> scheduleEveningReflectionReminder() async {
    if (kIsWeb) return;
    await _scheduleRepeating(
      id: NotificationIds.evening,
      title: _Copy.eveningTitle,
      body: _Copy.eveningBody,
      hour: 21, minute: 0,
    );
  }

  // ─── Bağlamsal (Contextual) Bildirimler ─────────────────────────────────────

  /// 24 saat bekleme başlatıldığında: 24 saat sonra bir kez planlar (ID: 10).
  static Future<void> schedule24hPauseFollowUp() async {
    if (kIsWeb) return;
    await _plugin.cancel(id: NotificationIds.pauseFollowUp);
    final scheduledDate = tz.TZDateTime.now(tz.local)
        .add(const Duration(hours: 24));
    await _plugin.zonedSchedule(
      id: NotificationIds.pauseFollowUp,
      title: _Copy.pauseFollowUpTitle,
      body: _Copy.pauseFollowUpBody,
      scheduledDate: scheduledDate,
      notificationDetails: _defaultDetails(),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    );
  }

  /// SOS tamamlandıktan sonra: ertesi gün 10:00'da bir kez planlar (ID: 11).
  static Future<void> schedulePostSosFollowUp() async {
    if (kIsWeb) return;
    await _plugin.cancel(id: NotificationIds.postSos);
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(
      tz.local, now.year, now.month, now.day + 1, 10, 0,
    );
    await _plugin.zonedSchedule(
      id: NotificationIds.postSos,
      title: _Copy.postSosTitle,
      body: _Copy.postSosBody,
      scheduledDate: scheduledDate,
      notificationDetails: _defaultDetails(),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    );
  }

  /// Sessiz cevap kasaya bırakıldığında: aynı gün 22:00 veya ertesi gün 09:00 (ID: 12).
  static Future<void> scheduleContextualReminder({
    required String title,
    required String body,
    required int id,
    required Duration delay,
  }) async {
    if (kIsWeb) return;
    await _plugin.cancel(id: id);
    final scheduledDate = tz.TZDateTime.now(tz.local).add(delay);
    await _plugin.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: scheduledDate,
      notificationDetails: _defaultDetails(),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    );
  }

  /// Sessiz Cevap → Kasaya Bırak sonrası bildirim (ID: 12, ~22:00 veya ertesi 09:00).
  static Future<void> scheduleSilentReplyFollowUp() async {
    if (kIsWeb) return;
    final now = tz.TZDateTime.now(tz.local);
    // Aynı gün 22:00'dan önce ise 22:00'da, sonrasındaysa ertesi gün 09:00'da planla.
    final todayEvening = tz.TZDateTime(tz.local, now.year, now.month, now.day, 22, 0);
    final delay = now.isBefore(todayEvening)
        ? todayEvening.difference(now)
        : Duration(hours: 9 + (24 - now.hour)); // ertesi gün 09:00 yaklaşımı

    await scheduleContextualReminder(
      title: _Copy.silentReplyTitle,
      body: _Copy.silentReplyBody,
      id: NotificationIds.silentReply,
      delay: delay,
    );
  }

  // ─── İptal Metodları ────────────────────────────────────────────────────────

  /// Sadece günlük ritim bildirimlerini iptal eder.
  static Future<void> cancelDailyRhythm() async {
    if (kIsWeb) return;
    for (final id in NotificationIds.rhythm) {
      await _plugin.cancel(id: id);
    }
  }

  /// Sadece bağlamsal bildirimleri iptal eder.
  static Future<void> cancelContextualReminders() async {
    if (kIsWeb) return;
    for (final id in NotificationIds.contextual) {
      await _plugin.cancel(id: id);
    }
  }

  /// Tek bir bildirim ID'sini iptal eder.
  static Future<void> cancelById(int id) async {
    if (kIsWeb) return;
    await _plugin.cancel(id: id);
  }

  /// Tüm planlanmış bildirimleri iptal eder.
  static Future<void> cancelAll() async {
    if (kIsWeb) return;
    await _plugin.cancelAll();
  }

  // ─── Yardımcı ───────────────────────────────────────────────────────────────

  /// Her gün aynı saatte tekrarlayan bildirim planlar (idempotent).
  static Future<void> _scheduleRepeating({
    required int id,
    required String title,
    required String body,
    required int hour,
    required int minute,
  }) async {
    await _plugin.cancel(id: id);
    await _plugin.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: TimezoneHelper.nextInstanceOfTime(hour, minute),
      notificationDetails: _defaultDetails(),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  /// Varsayılan bildirim detayları.
  static NotificationDetails _defaultDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        _kChannelId,
        _kChannelName,
        channelDescription: _kChannelDesc,
        importance: Importance.defaultImportance,
        priority: Priority.defaultPriority,
        icon: '@mipmap/ic_launcher',
        playSound: true,
        enableVibration: true,
        // Özel ses için:
        sound: RawResourceAndroidNotificationSound(_kAndroidSound),
      ),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: false,
        presentSound: true,
        // Özel ses için: sound: 'still_soft_chime.aiff',
      ),
    );
  }

  /// [SADECE DEBUG] 1 dakika sonra test bildirimi planlar.
  static Future<void> sendTestNotificationIn1Minute() async {
    if (!kDebugMode || kIsWeb) return;
    await _plugin.zonedSchedule(
      id: NotificationIds._testDebug,
      title: 'Test Bildirimi 🔔',
      body: 'Bu bildirimi görüyorsan sistem çalışıyor.',
      scheduledDate: tz.TZDateTime.now(tz.local).add(const Duration(minutes: 1)),
      notificationDetails: _defaultDetails(),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    );
  }
}

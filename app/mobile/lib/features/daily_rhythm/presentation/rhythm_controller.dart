import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/rhythm_settings.dart';
import '../data/rhythm_repository.dart';
import '../../../core/notifications/notification_service.dart';

class RhythmController extends StateNotifier<RhythmSettings> {
  final RhythmRepository _repository;

  RhythmController(this._repository) : super(const RhythmSettings()) {
    _init();
  }

  Future<void> _init() async {
    state = _repository.fetchSettings();
    if (state.isEnabled) {
      await _scheduleAll();
    }
  }

  // ─── Ana Toggle ─────────────────────────────────────────────────────────────

  /// Günlük Ritim sistemini tümüyle açar veya kapatır.
  /// Kapatılınca ritim + bağlamsal tüm bildirimler iptal edilir.
  Future<void> toggleEnabled(bool enabled) async {
    if (enabled) {
      final granted = await NotificationService.requestPermission();
      if (!granted) {
        // İzin reddedildi → toggle kapalı kalır, persist et.
        state = state.copyWith(isEnabled: false, hasRequestedPermission: true);
        await _repository.saveSettings(state);
        return;
      }
      state = state.copyWith(isEnabled: true, hasRequestedPermission: true);
      // Önce persist, sonra planla. Crash durumunda ayar kaybolmaz.
      await _repository.saveSettings(state);
      await _scheduleAll();
    } else {
      state = state.copyWith(isEnabled: false);
      // Önce persist, sonra iptal. Uygulama yeniden açılınca ritim planlanmaz.
      await _repository.saveSettings(state);
      await NotificationService.cancelAll();
    }
  }

  // ─── Ana Saat ───────────────────────────────────────────────────────────────

  Future<void> updateTime(int hour, int minute) async {
    state = state.copyWith(hour: hour, minute: minute);
    await _repository.saveSettings(state);
    if (state.isEnabled) await _scheduleAll();
  }

  // ─── Ek Ritim Pencereleri (opt-in) ─────────────────────────────────────────

  Future<void> toggleMorning(bool enabled) async {
    state = state.copyWith(morningEnabled: enabled);
    await _repository.saveSettings(state);
    if (enabled) {
      await NotificationService.scheduleMorningReminder();
    } else {
      await NotificationService.cancelById(NotificationIds.morning);
    }
  }

  Future<void> toggleMidday(bool enabled) async {
    state = state.copyWith(middayEnabled: enabled);
    await _repository.saveSettings(state);
    if (enabled) {
      await NotificationService.scheduleMiddayReminder();
    } else {
      await NotificationService.cancelById(NotificationIds.midday);
    }
  }

  Future<void> toggleEvening(bool enabled) async {
    state = state.copyWith(eveningEnabled: enabled);
    await _repository.saveSettings(state);
    if (enabled) {
      await NotificationService.scheduleEveningReflectionReminder();
    } else {
      await NotificationService.cancelById(NotificationIds.evening);
    }
  }

  // ─── Bağlamsal Bildirimler Toggle ───────────────────────────────────────────

  Future<void> toggleContextual(bool enabled) async {
    state = state.copyWith(contextualEnabled: enabled);
    await _repository.saveSettings(state);
    if (!enabled) {
      await NotificationService.cancelContextualReminders();
    }
  }

  // ─── Planlama ────────────────────────────────────────────────────────────────

  /// Ana + aktif alt ritimleri planlar (önce hepsini iptal eder).
  Future<void> _scheduleAll() async {
    await NotificationService.scheduleDailyReminder(
      id: NotificationIds.daily,
      title: 'Sessiz Bir An',
      body: 'Bugün kendini bir cümleyle yoklamak ister misin?',
      hour: state.hour,
      minute: state.minute,
    );

    if (state.morningEnabled) {
      await NotificationService.scheduleMorningReminder();
    }
    if (state.middayEnabled) {
      await NotificationService.scheduleMiddayReminder();
    }
    if (state.eveningEnabled) {
      await NotificationService.scheduleEveningReflectionReminder();
    }
  }

  // ─── Debug ──────────────────────────────────────────────────────────────────

  Future<void> sendTestNotification() async {
    if (!kDebugMode) return;
    await NotificationService.sendTestNotificationIn1Minute();
  }
}

final rhythmRepositoryProvider = Provider((ref) => RhythmRepository());

final rhythmControllerProvider =
    StateNotifierProvider<RhythmController, RhythmSettings>((ref) {
  final repo = ref.watch(rhythmRepositoryProvider);
  return RhythmController(repo);
});

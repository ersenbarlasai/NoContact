import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/rhythm_settings.dart';
import '../data/rhythm_repository.dart';
import '../../../core/notifications/notification_service.dart';

class RhythmController extends StateNotifier<RhythmSettings> {
  final RhythmRepository _repository;

  RhythmController(this._repository) : super(const RhythmSettings()) {
    _init();
  }

  void _init() {
    state = _repository.fetchSettings();
    if (state.isEnabled) {
      _schedule();
    }
  }

  Future<void> toggleEnabled(bool enabled) async {
    if (enabled && !state.hasRequestedPermission) {
      final granted = await NotificationService.requestPermission();
      state = state.copyWith(isEnabled: granted, hasRequestedPermission: true);
    } else if (enabled) {
      state = state.copyWith(isEnabled: true);
    } else {
      state = state.copyWith(isEnabled: false);
      await NotificationService.cancelAll();
    }
    
    await _repository.saveSettings(state);
    if (state.isEnabled) {
      _schedule();
    }
  }

  Future<void> updateTime(int hour, int minute) async {
    state = state.copyWith(hour: hour, minute: minute);
    await _repository.saveSettings(state);
    if (state.isEnabled) {
      _schedule();
    }
  }

  Future<void> _schedule() async {
    await NotificationService.cancelAll();
    await NotificationService.scheduleDailyReminder(
      id: 1,
      title: 'Sessiz Bir An',
      body: 'Bugün kendini bir cümleyle yoklamak ister misin?',
      hour: state.hour,
      minute: state.minute,
    );
  }
}

final rhythmRepositoryProvider = Provider((ref) => RhythmRepository());

final rhythmControllerProvider =
    StateNotifierProvider<RhythmController, RhythmSettings>((ref) {
  final repo = ref.watch(rhythmRepositoryProvider);
  return RhythmController(repo);
});

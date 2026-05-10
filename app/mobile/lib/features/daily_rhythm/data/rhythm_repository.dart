import 'dart:convert';
import '../../../core/storage/local_storage_service.dart';
import '../domain/rhythm_settings.dart';

class RhythmRepository {
  static const String _settingsKey = 'daily_rhythm_settings';

  RhythmSettings fetchSettings() {
    final jsonString = LocalStorageService.getString(_settingsKey);
    if (jsonString == null) return const RhythmSettings();

    try {
      return RhythmSettings.fromJson(json.decode(jsonString));
    } catch (e) {
      return const RhythmSettings();
    }
  }

  Future<void> saveSettings(RhythmSettings settings) async {
    final jsonString = json.encode(settings.toJson());
    await LocalStorageService.setString(_settingsKey, jsonString);
  }
}

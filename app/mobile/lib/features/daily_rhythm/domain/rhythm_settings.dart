import 'package:freezed_annotation/freezed_annotation.dart';

part 'rhythm_settings.freezed.dart';
part 'rhythm_settings.g.dart';

@freezed
class RhythmSettings with _$RhythmSettings {
  const factory RhythmSettings({
    @Default(false) bool isEnabled,
    @Default(20) int hour,
    @Default(30) int minute,
    @Default(false) bool hasRequestedPermission,
  }) = _RhythmSettings;

  factory RhythmSettings.fromJson(Map<String, dynamic> json) => _$RhythmSettingsFromJson(json);
}

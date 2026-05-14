import 'package:freezed_annotation/freezed_annotation.dart';

part 'rhythm_settings.freezed.dart';
part 'rhythm_settings.g.dart';

@freezed
class RhythmSettings with _$RhythmSettings {
  const factory RhythmSettings({
    // --- Ana Hatırlatma ---
    @Default(false) bool isEnabled,
    @Default(20) int hour,
    @Default(30) int minute,
    @Default(false) bool hasRequestedPermission,

    // --- Ek Ritim Pencereleri (opt-in) ---
    @Default(false) bool morningEnabled,   // Sabah nazik başlangıç
    @Default(false) bool middayEnabled,    // Öğlen kısa duraklama
    @Default(false) bool eveningEnabled,   // Akşam yansıması

    // --- Bağlama Göre Akıllı Bildirimler ---
    @Default(true) bool contextualEnabled, // SOS, 24h, Sessiz Cevap sonrası
  }) = _RhythmSettings;

  factory RhythmSettings.fromJson(Map<String, dynamic> json) =>
      _$RhythmSettingsFromJson(json);
}

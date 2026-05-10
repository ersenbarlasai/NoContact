import 'package:freezed_annotation/freezed_annotation.dart';

part 'mood_entry.freezed.dart';
part 'mood_entry.g.dart';

@freezed
class MoodEntry with _$MoodEntry {
  const factory MoodEntry({
    required String id,
    required DateTime date,
    required String mood,
    @Default(3) int intensity,
    @Default([]) List<String> triggers,
    String? note,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? syncedAt,
  }) = _MoodEntry;

  factory MoodEntry.fromJson(Map<String, dynamic> json) => _$MoodEntryFromJson(json);
}

const List<String> moodOptions = [
  'Üzgün',
  'Öfkeli',
  'Kaygılı',
  'Sakin',
  'Özlüyorum',
  'Güçlü',
  'Kafam karışık',
];

const List<String> triggerOptions = [
  'Yalnızlık',
  'Gece saatleri',
  'Sosyal medya',
  'Anılar',
  'Stres',
  'Rüya gördüm',
  'Ortak arkadaşlar',
  'Müzik / fotoğraf',
  'Alkol',
  'Özel gün',
];

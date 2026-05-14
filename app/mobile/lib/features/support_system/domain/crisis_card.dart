import 'package:freezed_annotation/freezed_annotation.dart';

part 'crisis_card.freezed.dart';
part 'crisis_card.g.dart';

enum CrisisCardType {
  reasonStarted,
  commitment,
  futureSelf,
  consequence,
  trustedSentence,
  supportNote, // For the "Tek cümle not"
  custom,
}

@freezed
class CrisisCard with _$CrisisCard {
  const factory CrisisCard({
    required String id,
    required CrisisCardType type,
    required String title,
    required String body,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default(false) bool isPinned,
  }) = _CrisisCard;

  factory CrisisCard.fromJson(Map<String, dynamic> json) => _$CrisisCardFromJson(json);
}

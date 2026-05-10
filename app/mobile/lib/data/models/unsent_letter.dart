import 'package:freezed_annotation/freezed_annotation.dart';

part 'unsent_letter.freezed.dart';
part 'unsent_letter.g.dart';

@freezed
class UnsentLetter with _$UnsentLetter {
  const factory UnsentLetter({
    required String id,
    String? title,
    required String body,
    String? emotion,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? archivedAt,
    DateTime? deletedAt,
  }) = _UnsentLetter;

  factory UnsentLetter.fromJson(Map<String, dynamic> json) => _$UnsentLetterFromJson(json);
}

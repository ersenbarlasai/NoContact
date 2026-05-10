// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sos_session.freezed.dart';
part 'sos_session.g.dart';

@freezed
class SosSession with _$SosSession {
  const factory SosSession({
    @JsonKey(name: 'started_at') DateTime? startedAt,
    @JsonKey(name: 'completed_at') DateTime? completedAt,
    @JsonKey(includeToJson: false, includeFromJson: false) @Default('') String urgeText,
    @JsonKey(name: 'selected_outcome') @Default('') String selectedOutcome,
    @JsonKey(name: 'needed_extra_support') @Default(false) bool neededExtraSupport,
    @JsonKey(name: 'dominant_emotion') String? dominantEmotion,
    @JsonKey(name: 'strongest_trigger') String? strongestTrigger,
    @JsonKey(name: 'urge_text_saved') @Default(false) bool urgeTextSaved,
    @JsonKey(name: 'urge_text_preview') String? urgeTextPreview,
  }) = _SosSession;

  factory SosSession.fromJson(Map<String, dynamic> json) => _$SosSessionFromJson(json);
}

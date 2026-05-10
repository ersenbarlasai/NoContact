// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recovery_profile.freezed.dart';
part 'recovery_profile.g.dart';

@freezed
class RecoveryProfile with _$RecoveryProfile {
  const factory RecoveryProfile({
    @JsonKey(name: 'preferred_name') @Default('') String name,
    @JsonKey(name: 'reason_for_joining') @Default('') String reason,
    @JsonKey(name: 'relationship_duration') @Default('') String relationshipDuration,
    @JsonKey(name: 'time_since_breakup') @Default('') String timeSinceBreakup,
    @JsonKey(name: 'ended_by') @Default('') String whoEnded,
    @JsonKey(name: 'no_contact_start_date') DateTime? noContactStartDate,
    @JsonKey(name: 'dominant_emotion') @Default('') String dominantEmotion,
    @JsonKey(name: 'contact_triggers') @Default([]) List<String> contactTriggers,
    @JsonKey(name: 'commitment_accepted_at') DateTime? commitmentAcceptedAt,
    @JsonKey(name: 'onboarding_completed') @Default(false) bool isOnboardingCompleted,
    @JsonKey(name: 'app_disclaimer_seen') @Default(false) bool appDisclaimerSeen,
  }) = _RecoveryProfile;

  factory RecoveryProfile.fromJson(Map<String, dynamic> json) =>
      _$RecoveryProfileFromJson(json);
}

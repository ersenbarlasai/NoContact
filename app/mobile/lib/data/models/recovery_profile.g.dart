// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recovery_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RecoveryProfileImpl _$$RecoveryProfileImplFromJson(
  Map<String, dynamic> json,
) => _$RecoveryProfileImpl(
  name: json['preferred_name'] as String? ?? '',
  reason: json['reason_for_joining'] as String? ?? '',
  relationshipDuration: json['relationship_duration'] as String? ?? '',
  timeSinceBreakup: json['time_since_breakup'] as String? ?? '',
  whoEnded: json['ended_by'] as String? ?? '',
  noContactStartDate: json['no_contact_start_date'] == null
      ? null
      : DateTime.parse(json['no_contact_start_date'] as String),
  dominantEmotion: json['dominant_emotion'] as String? ?? '',
  contactTriggers:
      (json['contact_triggers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  commitmentAcceptedAt: json['commitment_accepted_at'] == null
      ? null
      : DateTime.parse(json['commitment_accepted_at'] as String),
  isOnboardingCompleted: json['onboarding_completed'] as bool? ?? false,
  appDisclaimerSeen: json['app_disclaimer_seen'] as bool? ?? false,
);

Map<String, dynamic> _$$RecoveryProfileImplToJson(
  _$RecoveryProfileImpl instance,
) => <String, dynamic>{
  'preferred_name': instance.name,
  'reason_for_joining': instance.reason,
  'relationship_duration': instance.relationshipDuration,
  'time_since_breakup': instance.timeSinceBreakup,
  'ended_by': instance.whoEnded,
  'no_contact_start_date': instance.noContactStartDate?.toIso8601String(),
  'dominant_emotion': instance.dominantEmotion,
  'contact_triggers': instance.contactTriggers,
  'commitment_accepted_at': instance.commitmentAcceptedAt?.toIso8601String(),
  'onboarding_completed': instance.isOnboardingCompleted,
  'app_disclaimer_seen': instance.appDisclaimerSeen,
};

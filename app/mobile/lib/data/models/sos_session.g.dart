// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sos_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SosSessionImpl _$$SosSessionImplFromJson(Map<String, dynamic> json) =>
    _$SosSessionImpl(
      startedAt: json['started_at'] == null
          ? null
          : DateTime.parse(json['started_at'] as String),
      completedAt: json['completed_at'] == null
          ? null
          : DateTime.parse(json['completed_at'] as String),
      selectedOutcome: json['selected_outcome'] as String? ?? '',
      neededExtraSupport: json['needed_extra_support'] as bool? ?? false,
      dominantEmotion: json['dominant_emotion'] as String?,
      strongestTrigger: json['strongest_trigger'] as String?,
      urgeTextSaved: json['urge_text_saved'] as bool? ?? false,
      urgeTextPreview: json['urge_text_preview'] as String?,
    );

Map<String, dynamic> _$$SosSessionImplToJson(_$SosSessionImpl instance) =>
    <String, dynamic>{
      'started_at': instance.startedAt?.toIso8601String(),
      'completed_at': instance.completedAt?.toIso8601String(),
      'selected_outcome': instance.selectedOutcome,
      'needed_extra_support': instance.neededExtraSupport,
      'dominant_emotion': instance.dominantEmotion,
      'strongest_trigger': instance.strongestTrigger,
      'urge_text_saved': instance.urgeTextSaved,
      'urge_text_preview': instance.urgeTextPreview,
    };

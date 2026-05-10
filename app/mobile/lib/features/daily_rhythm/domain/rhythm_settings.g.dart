// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rhythm_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RhythmSettingsImpl _$$RhythmSettingsImplFromJson(Map<String, dynamic> json) =>
    _$RhythmSettingsImpl(
      isEnabled: json['isEnabled'] as bool? ?? false,
      hour: (json['hour'] as num?)?.toInt() ?? 20,
      minute: (json['minute'] as num?)?.toInt() ?? 30,
      hasRequestedPermission: json['hasRequestedPermission'] as bool? ?? false,
    );

Map<String, dynamic> _$$RhythmSettingsImplToJson(
  _$RhythmSettingsImpl instance,
) => <String, dynamic>{
  'isEnabled': instance.isEnabled,
  'hour': instance.hour,
  'minute': instance.minute,
  'hasRequestedPermission': instance.hasRequestedPermission,
};

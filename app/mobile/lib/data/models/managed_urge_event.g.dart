// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'managed_urge_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ManagedUrgeEventImpl _$$ManagedUrgeEventImplFromJson(
  Map<String, dynamic> json,
) => _$ManagedUrgeEventImpl(
  id: json['id'] as String,
  source: json['source'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$$ManagedUrgeEventImplToJson(
  _$ManagedUrgeEventImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'source': instance.source,
  'createdAt': instance.createdAt.toIso8601String(),
};

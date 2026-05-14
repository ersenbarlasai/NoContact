// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crisis_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CrisisCardImpl _$$CrisisCardImplFromJson(Map<String, dynamic> json) =>
    _$CrisisCardImpl(
      id: json['id'] as String,
      type: $enumDecode(_$CrisisCardTypeEnumMap, json['type']),
      title: json['title'] as String,
      body: json['body'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      isPinned: json['isPinned'] as bool? ?? false,
    );

Map<String, dynamic> _$$CrisisCardImplToJson(_$CrisisCardImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$CrisisCardTypeEnumMap[instance.type]!,
      'title': instance.title,
      'body': instance.body,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'isPinned': instance.isPinned,
    };

const _$CrisisCardTypeEnumMap = {
  CrisisCardType.reasonStarted: 'reasonStarted',
  CrisisCardType.commitment: 'commitment',
  CrisisCardType.futureSelf: 'futureSelf',
  CrisisCardType.consequence: 'consequence',
  CrisisCardType.trustedSentence: 'trustedSentence',
  CrisisCardType.supportNote: 'supportNote',
  CrisisCardType.custom: 'custom',
};

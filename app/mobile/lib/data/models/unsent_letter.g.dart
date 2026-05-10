// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unsent_letter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UnsentLetterImpl _$$UnsentLetterImplFromJson(Map<String, dynamic> json) =>
    _$UnsentLetterImpl(
      id: json['id'] as String,
      title: json['title'] as String?,
      body: json['body'] as String,
      emotion: json['emotion'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      archivedAt: json['archivedAt'] == null
          ? null
          : DateTime.parse(json['archivedAt'] as String),
      deletedAt: json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
    );

Map<String, dynamic> _$$UnsentLetterImplToJson(_$UnsentLetterImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
      'emotion': instance.emotion,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'archivedAt': instance.archivedAt?.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
    };

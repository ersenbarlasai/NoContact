// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'crisis_card.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CrisisCard _$CrisisCardFromJson(Map<String, dynamic> json) {
  return _CrisisCard.fromJson(json);
}

/// @nodoc
mixin _$CrisisCard {
  String get id => throw _privateConstructorUsedError;
  CrisisCardType get type => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get body => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  bool get isPinned => throw _privateConstructorUsedError;

  /// Serializes this CrisisCard to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CrisisCard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CrisisCardCopyWith<CrisisCard> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CrisisCardCopyWith<$Res> {
  factory $CrisisCardCopyWith(
    CrisisCard value,
    $Res Function(CrisisCard) then,
  ) = _$CrisisCardCopyWithImpl<$Res, CrisisCard>;
  @useResult
  $Res call({
    String id,
    CrisisCardType type,
    String title,
    String body,
    DateTime createdAt,
    DateTime updatedAt,
    bool isPinned,
  });
}

/// @nodoc
class _$CrisisCardCopyWithImpl<$Res, $Val extends CrisisCard>
    implements $CrisisCardCopyWith<$Res> {
  _$CrisisCardCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CrisisCard
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? title = null,
    Object? body = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? isPinned = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as CrisisCardType,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            body: null == body
                ? _value.body
                : body // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            isPinned: null == isPinned
                ? _value.isPinned
                : isPinned // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CrisisCardImplCopyWith<$Res>
    implements $CrisisCardCopyWith<$Res> {
  factory _$$CrisisCardImplCopyWith(
    _$CrisisCardImpl value,
    $Res Function(_$CrisisCardImpl) then,
  ) = __$$CrisisCardImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    CrisisCardType type,
    String title,
    String body,
    DateTime createdAt,
    DateTime updatedAt,
    bool isPinned,
  });
}

/// @nodoc
class __$$CrisisCardImplCopyWithImpl<$Res>
    extends _$CrisisCardCopyWithImpl<$Res, _$CrisisCardImpl>
    implements _$$CrisisCardImplCopyWith<$Res> {
  __$$CrisisCardImplCopyWithImpl(
    _$CrisisCardImpl _value,
    $Res Function(_$CrisisCardImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CrisisCard
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? title = null,
    Object? body = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? isPinned = null,
  }) {
    return _then(
      _$CrisisCardImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as CrisisCardType,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        body: null == body
            ? _value.body
            : body // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        isPinned: null == isPinned
            ? _value.isPinned
            : isPinned // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CrisisCardImpl implements _CrisisCard {
  const _$CrisisCardImpl({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    required this.createdAt,
    required this.updatedAt,
    this.isPinned = false,
  });

  factory _$CrisisCardImpl.fromJson(Map<String, dynamic> json) =>
      _$$CrisisCardImplFromJson(json);

  @override
  final String id;
  @override
  final CrisisCardType type;
  @override
  final String title;
  @override
  final String body;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  @JsonKey()
  final bool isPinned;

  @override
  String toString() {
    return 'CrisisCard(id: $id, type: $type, title: $title, body: $body, createdAt: $createdAt, updatedAt: $updatedAt, isPinned: $isPinned)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CrisisCardImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.isPinned, isPinned) ||
                other.isPinned == isPinned));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    type,
    title,
    body,
    createdAt,
    updatedAt,
    isPinned,
  );

  /// Create a copy of CrisisCard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CrisisCardImplCopyWith<_$CrisisCardImpl> get copyWith =>
      __$$CrisisCardImplCopyWithImpl<_$CrisisCardImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CrisisCardImplToJson(this);
  }
}

abstract class _CrisisCard implements CrisisCard {
  const factory _CrisisCard({
    required final String id,
    required final CrisisCardType type,
    required final String title,
    required final String body,
    required final DateTime createdAt,
    required final DateTime updatedAt,
    final bool isPinned,
  }) = _$CrisisCardImpl;

  factory _CrisisCard.fromJson(Map<String, dynamic> json) =
      _$CrisisCardImpl.fromJson;

  @override
  String get id;
  @override
  CrisisCardType get type;
  @override
  String get title;
  @override
  String get body;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  bool get isPinned;

  /// Create a copy of CrisisCard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CrisisCardImplCopyWith<_$CrisisCardImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

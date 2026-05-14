// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'managed_urge_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ManagedUrgeEvent _$ManagedUrgeEventFromJson(Map<String, dynamic> json) {
  return _ManagedUrgeEvent.fromJson(json);
}

/// @nodoc
mixin _$ManagedUrgeEvent {
  String get id => throw _privateConstructorUsedError;
  String get source =>
      throw _privateConstructorUsedError; // 'sos', 'silent_reply_vault', 'silent_reply_wait', 'support_wait'
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this ManagedUrgeEvent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ManagedUrgeEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ManagedUrgeEventCopyWith<ManagedUrgeEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ManagedUrgeEventCopyWith<$Res> {
  factory $ManagedUrgeEventCopyWith(
    ManagedUrgeEvent value,
    $Res Function(ManagedUrgeEvent) then,
  ) = _$ManagedUrgeEventCopyWithImpl<$Res, ManagedUrgeEvent>;
  @useResult
  $Res call({String id, String source, DateTime createdAt});
}

/// @nodoc
class _$ManagedUrgeEventCopyWithImpl<$Res, $Val extends ManagedUrgeEvent>
    implements $ManagedUrgeEventCopyWith<$Res> {
  _$ManagedUrgeEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ManagedUrgeEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? source = null,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            source: null == source
                ? _value.source
                : source // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ManagedUrgeEventImplCopyWith<$Res>
    implements $ManagedUrgeEventCopyWith<$Res> {
  factory _$$ManagedUrgeEventImplCopyWith(
    _$ManagedUrgeEventImpl value,
    $Res Function(_$ManagedUrgeEventImpl) then,
  ) = __$$ManagedUrgeEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String source, DateTime createdAt});
}

/// @nodoc
class __$$ManagedUrgeEventImplCopyWithImpl<$Res>
    extends _$ManagedUrgeEventCopyWithImpl<$Res, _$ManagedUrgeEventImpl>
    implements _$$ManagedUrgeEventImplCopyWith<$Res> {
  __$$ManagedUrgeEventImplCopyWithImpl(
    _$ManagedUrgeEventImpl _value,
    $Res Function(_$ManagedUrgeEventImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ManagedUrgeEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? source = null,
    Object? createdAt = null,
  }) {
    return _then(
      _$ManagedUrgeEventImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        source: null == source
            ? _value.source
            : source // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ManagedUrgeEventImpl implements _ManagedUrgeEvent {
  const _$ManagedUrgeEventImpl({
    required this.id,
    required this.source,
    required this.createdAt,
  });

  factory _$ManagedUrgeEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$ManagedUrgeEventImplFromJson(json);

  @override
  final String id;
  @override
  final String source;
  // 'sos', 'silent_reply_vault', 'silent_reply_wait', 'support_wait'
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'ManagedUrgeEvent(id: $id, source: $source, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ManagedUrgeEventImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, source, createdAt);

  /// Create a copy of ManagedUrgeEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ManagedUrgeEventImplCopyWith<_$ManagedUrgeEventImpl> get copyWith =>
      __$$ManagedUrgeEventImplCopyWithImpl<_$ManagedUrgeEventImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ManagedUrgeEventImplToJson(this);
  }
}

abstract class _ManagedUrgeEvent implements ManagedUrgeEvent {
  const factory _ManagedUrgeEvent({
    required final String id,
    required final String source,
    required final DateTime createdAt,
  }) = _$ManagedUrgeEventImpl;

  factory _ManagedUrgeEvent.fromJson(Map<String, dynamic> json) =
      _$ManagedUrgeEventImpl.fromJson;

  @override
  String get id;
  @override
  String get source; // 'sos', 'silent_reply_vault', 'silent_reply_wait', 'support_wait'
  @override
  DateTime get createdAt;

  /// Create a copy of ManagedUrgeEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ManagedUrgeEventImplCopyWith<_$ManagedUrgeEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

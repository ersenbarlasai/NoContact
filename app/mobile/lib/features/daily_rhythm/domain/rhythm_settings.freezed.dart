// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rhythm_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

RhythmSettings _$RhythmSettingsFromJson(Map<String, dynamic> json) {
  return _RhythmSettings.fromJson(json);
}

/// @nodoc
mixin _$RhythmSettings {
  bool get isEnabled => throw _privateConstructorUsedError;
  int get hour => throw _privateConstructorUsedError;
  int get minute => throw _privateConstructorUsedError;
  bool get hasRequestedPermission => throw _privateConstructorUsedError;

  /// Serializes this RhythmSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RhythmSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RhythmSettingsCopyWith<RhythmSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RhythmSettingsCopyWith<$Res> {
  factory $RhythmSettingsCopyWith(
    RhythmSettings value,
    $Res Function(RhythmSettings) then,
  ) = _$RhythmSettingsCopyWithImpl<$Res, RhythmSettings>;
  @useResult
  $Res call({
    bool isEnabled,
    int hour,
    int minute,
    bool hasRequestedPermission,
  });
}

/// @nodoc
class _$RhythmSettingsCopyWithImpl<$Res, $Val extends RhythmSettings>
    implements $RhythmSettingsCopyWith<$Res> {
  _$RhythmSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RhythmSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isEnabled = null,
    Object? hour = null,
    Object? minute = null,
    Object? hasRequestedPermission = null,
  }) {
    return _then(
      _value.copyWith(
            isEnabled: null == isEnabled
                ? _value.isEnabled
                : isEnabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            hour: null == hour
                ? _value.hour
                : hour // ignore: cast_nullable_to_non_nullable
                      as int,
            minute: null == minute
                ? _value.minute
                : minute // ignore: cast_nullable_to_non_nullable
                      as int,
            hasRequestedPermission: null == hasRequestedPermission
                ? _value.hasRequestedPermission
                : hasRequestedPermission // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RhythmSettingsImplCopyWith<$Res>
    implements $RhythmSettingsCopyWith<$Res> {
  factory _$$RhythmSettingsImplCopyWith(
    _$RhythmSettingsImpl value,
    $Res Function(_$RhythmSettingsImpl) then,
  ) = __$$RhythmSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool isEnabled,
    int hour,
    int minute,
    bool hasRequestedPermission,
  });
}

/// @nodoc
class __$$RhythmSettingsImplCopyWithImpl<$Res>
    extends _$RhythmSettingsCopyWithImpl<$Res, _$RhythmSettingsImpl>
    implements _$$RhythmSettingsImplCopyWith<$Res> {
  __$$RhythmSettingsImplCopyWithImpl(
    _$RhythmSettingsImpl _value,
    $Res Function(_$RhythmSettingsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RhythmSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isEnabled = null,
    Object? hour = null,
    Object? minute = null,
    Object? hasRequestedPermission = null,
  }) {
    return _then(
      _$RhythmSettingsImpl(
        isEnabled: null == isEnabled
            ? _value.isEnabled
            : isEnabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        hour: null == hour
            ? _value.hour
            : hour // ignore: cast_nullable_to_non_nullable
                  as int,
        minute: null == minute
            ? _value.minute
            : minute // ignore: cast_nullable_to_non_nullable
                  as int,
        hasRequestedPermission: null == hasRequestedPermission
            ? _value.hasRequestedPermission
            : hasRequestedPermission // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RhythmSettingsImpl implements _RhythmSettings {
  const _$RhythmSettingsImpl({
    this.isEnabled = false,
    this.hour = 20,
    this.minute = 30,
    this.hasRequestedPermission = false,
  });

  factory _$RhythmSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$RhythmSettingsImplFromJson(json);

  @override
  @JsonKey()
  final bool isEnabled;
  @override
  @JsonKey()
  final int hour;
  @override
  @JsonKey()
  final int minute;
  @override
  @JsonKey()
  final bool hasRequestedPermission;

  @override
  String toString() {
    return 'RhythmSettings(isEnabled: $isEnabled, hour: $hour, minute: $minute, hasRequestedPermission: $hasRequestedPermission)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RhythmSettingsImpl &&
            (identical(other.isEnabled, isEnabled) ||
                other.isEnabled == isEnabled) &&
            (identical(other.hour, hour) || other.hour == hour) &&
            (identical(other.minute, minute) || other.minute == minute) &&
            (identical(other.hasRequestedPermission, hasRequestedPermission) ||
                other.hasRequestedPermission == hasRequestedPermission));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, isEnabled, hour, minute, hasRequestedPermission);

  /// Create a copy of RhythmSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RhythmSettingsImplCopyWith<_$RhythmSettingsImpl> get copyWith =>
      __$$RhythmSettingsImplCopyWithImpl<_$RhythmSettingsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RhythmSettingsImplToJson(this);
  }
}

abstract class _RhythmSettings implements RhythmSettings {
  const factory _RhythmSettings({
    final bool isEnabled,
    final int hour,
    final int minute,
    final bool hasRequestedPermission,
  }) = _$RhythmSettingsImpl;

  factory _RhythmSettings.fromJson(Map<String, dynamic> json) =
      _$RhythmSettingsImpl.fromJson;

  @override
  bool get isEnabled;
  @override
  int get hour;
  @override
  int get minute;
  @override
  bool get hasRequestedPermission;

  /// Create a copy of RhythmSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RhythmSettingsImplCopyWith<_$RhythmSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

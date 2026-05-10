// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recovery_path_step.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$RecoveryPathStep {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  RecoveryPhase get phase => throw _privateConstructorUsedError;
  int? get dayTarget => throw _privateConstructorUsedError;
  StepStatus get status => throw _privateConstructorUsedError;
  String? get suggestedActionRoute => throw _privateConstructorUsedError;
  IconData? get icon => throw _privateConstructorUsedError;

  /// Create a copy of RecoveryPathStep
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecoveryPathStepCopyWith<RecoveryPathStep> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecoveryPathStepCopyWith<$Res> {
  factory $RecoveryPathStepCopyWith(
    RecoveryPathStep value,
    $Res Function(RecoveryPathStep) then,
  ) = _$RecoveryPathStepCopyWithImpl<$Res, RecoveryPathStep>;
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    RecoveryPhase phase,
    int? dayTarget,
    StepStatus status,
    String? suggestedActionRoute,
    IconData? icon,
  });
}

/// @nodoc
class _$RecoveryPathStepCopyWithImpl<$Res, $Val extends RecoveryPathStep>
    implements $RecoveryPathStepCopyWith<$Res> {
  _$RecoveryPathStepCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecoveryPathStep
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? phase = null,
    Object? dayTarget = freezed,
    Object? status = null,
    Object? suggestedActionRoute = freezed,
    Object? icon = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            phase: null == phase
                ? _value.phase
                : phase // ignore: cast_nullable_to_non_nullable
                      as RecoveryPhase,
            dayTarget: freezed == dayTarget
                ? _value.dayTarget
                : dayTarget // ignore: cast_nullable_to_non_nullable
                      as int?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as StepStatus,
            suggestedActionRoute: freezed == suggestedActionRoute
                ? _value.suggestedActionRoute
                : suggestedActionRoute // ignore: cast_nullable_to_non_nullable
                      as String?,
            icon: freezed == icon
                ? _value.icon
                : icon // ignore: cast_nullable_to_non_nullable
                      as IconData?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RecoveryPathStepImplCopyWith<$Res>
    implements $RecoveryPathStepCopyWith<$Res> {
  factory _$$RecoveryPathStepImplCopyWith(
    _$RecoveryPathStepImpl value,
    $Res Function(_$RecoveryPathStepImpl) then,
  ) = __$$RecoveryPathStepImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String description,
    RecoveryPhase phase,
    int? dayTarget,
    StepStatus status,
    String? suggestedActionRoute,
    IconData? icon,
  });
}

/// @nodoc
class __$$RecoveryPathStepImplCopyWithImpl<$Res>
    extends _$RecoveryPathStepCopyWithImpl<$Res, _$RecoveryPathStepImpl>
    implements _$$RecoveryPathStepImplCopyWith<$Res> {
  __$$RecoveryPathStepImplCopyWithImpl(
    _$RecoveryPathStepImpl _value,
    $Res Function(_$RecoveryPathStepImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RecoveryPathStep
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? phase = null,
    Object? dayTarget = freezed,
    Object? status = null,
    Object? suggestedActionRoute = freezed,
    Object? icon = freezed,
  }) {
    return _then(
      _$RecoveryPathStepImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        phase: null == phase
            ? _value.phase
            : phase // ignore: cast_nullable_to_non_nullable
                  as RecoveryPhase,
        dayTarget: freezed == dayTarget
            ? _value.dayTarget
            : dayTarget // ignore: cast_nullable_to_non_nullable
                  as int?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as StepStatus,
        suggestedActionRoute: freezed == suggestedActionRoute
            ? _value.suggestedActionRoute
            : suggestedActionRoute // ignore: cast_nullable_to_non_nullable
                  as String?,
        icon: freezed == icon
            ? _value.icon
            : icon // ignore: cast_nullable_to_non_nullable
                  as IconData?,
      ),
    );
  }
}

/// @nodoc

class _$RecoveryPathStepImpl implements _RecoveryPathStep {
  const _$RecoveryPathStepImpl({
    required this.id,
    required this.title,
    required this.description,
    required this.phase,
    this.dayTarget,
    this.status = StepStatus.locked,
    this.suggestedActionRoute,
    this.icon,
  });

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final RecoveryPhase phase;
  @override
  final int? dayTarget;
  @override
  @JsonKey()
  final StepStatus status;
  @override
  final String? suggestedActionRoute;
  @override
  final IconData? icon;

  @override
  String toString() {
    return 'RecoveryPathStep(id: $id, title: $title, description: $description, phase: $phase, dayTarget: $dayTarget, status: $status, suggestedActionRoute: $suggestedActionRoute, icon: $icon)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecoveryPathStepImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.phase, phase) || other.phase == phase) &&
            (identical(other.dayTarget, dayTarget) ||
                other.dayTarget == dayTarget) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.suggestedActionRoute, suggestedActionRoute) ||
                other.suggestedActionRoute == suggestedActionRoute) &&
            (identical(other.icon, icon) || other.icon == icon));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    description,
    phase,
    dayTarget,
    status,
    suggestedActionRoute,
    icon,
  );

  /// Create a copy of RecoveryPathStep
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecoveryPathStepImplCopyWith<_$RecoveryPathStepImpl> get copyWith =>
      __$$RecoveryPathStepImplCopyWithImpl<_$RecoveryPathStepImpl>(
        this,
        _$identity,
      );
}

abstract class _RecoveryPathStep implements RecoveryPathStep {
  const factory _RecoveryPathStep({
    required final String id,
    required final String title,
    required final String description,
    required final RecoveryPhase phase,
    final int? dayTarget,
    final StepStatus status,
    final String? suggestedActionRoute,
    final IconData? icon,
  }) = _$RecoveryPathStepImpl;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  RecoveryPhase get phase;
  @override
  int? get dayTarget;
  @override
  StepStatus get status;
  @override
  String? get suggestedActionRoute;
  @override
  IconData? get icon;

  /// Create a copy of RecoveryPathStep
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecoveryPathStepImplCopyWith<_$RecoveryPathStepImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

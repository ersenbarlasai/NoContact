// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recovery_path_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$RecoveryPathState {
  List<RecoveryPathStep> get steps => throw _privateConstructorUsedError;
  int get ncDays => throw _privateConstructorUsedError;
  int get moodCount => throw _privateConstructorUsedError;
  int get letterCount => throw _privateConstructorUsedError;
  int get managedUrgeCount => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  /// Create a copy of RecoveryPathState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecoveryPathStateCopyWith<RecoveryPathState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecoveryPathStateCopyWith<$Res> {
  factory $RecoveryPathStateCopyWith(
    RecoveryPathState value,
    $Res Function(RecoveryPathState) then,
  ) = _$RecoveryPathStateCopyWithImpl<$Res, RecoveryPathState>;
  @useResult
  $Res call({
    List<RecoveryPathStep> steps,
    int ncDays,
    int moodCount,
    int letterCount,
    int managedUrgeCount,
    bool isLoading,
  });
}

/// @nodoc
class _$RecoveryPathStateCopyWithImpl<$Res, $Val extends RecoveryPathState>
    implements $RecoveryPathStateCopyWith<$Res> {
  _$RecoveryPathStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecoveryPathState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? steps = null,
    Object? ncDays = null,
    Object? moodCount = null,
    Object? letterCount = null,
    Object? managedUrgeCount = null,
    Object? isLoading = null,
  }) {
    return _then(
      _value.copyWith(
            steps: null == steps
                ? _value.steps
                : steps // ignore: cast_nullable_to_non_nullable
                      as List<RecoveryPathStep>,
            ncDays: null == ncDays
                ? _value.ncDays
                : ncDays // ignore: cast_nullable_to_non_nullable
                      as int,
            moodCount: null == moodCount
                ? _value.moodCount
                : moodCount // ignore: cast_nullable_to_non_nullable
                      as int,
            letterCount: null == letterCount
                ? _value.letterCount
                : letterCount // ignore: cast_nullable_to_non_nullable
                      as int,
            managedUrgeCount: null == managedUrgeCount
                ? _value.managedUrgeCount
                : managedUrgeCount // ignore: cast_nullable_to_non_nullable
                      as int,
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RecoveryPathStateImplCopyWith<$Res>
    implements $RecoveryPathStateCopyWith<$Res> {
  factory _$$RecoveryPathStateImplCopyWith(
    _$RecoveryPathStateImpl value,
    $Res Function(_$RecoveryPathStateImpl) then,
  ) = __$$RecoveryPathStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<RecoveryPathStep> steps,
    int ncDays,
    int moodCount,
    int letterCount,
    int managedUrgeCount,
    bool isLoading,
  });
}

/// @nodoc
class __$$RecoveryPathStateImplCopyWithImpl<$Res>
    extends _$RecoveryPathStateCopyWithImpl<$Res, _$RecoveryPathStateImpl>
    implements _$$RecoveryPathStateImplCopyWith<$Res> {
  __$$RecoveryPathStateImplCopyWithImpl(
    _$RecoveryPathStateImpl _value,
    $Res Function(_$RecoveryPathStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RecoveryPathState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? steps = null,
    Object? ncDays = null,
    Object? moodCount = null,
    Object? letterCount = null,
    Object? managedUrgeCount = null,
    Object? isLoading = null,
  }) {
    return _then(
      _$RecoveryPathStateImpl(
        steps: null == steps
            ? _value._steps
            : steps // ignore: cast_nullable_to_non_nullable
                  as List<RecoveryPathStep>,
        ncDays: null == ncDays
            ? _value.ncDays
            : ncDays // ignore: cast_nullable_to_non_nullable
                  as int,
        moodCount: null == moodCount
            ? _value.moodCount
            : moodCount // ignore: cast_nullable_to_non_nullable
                  as int,
        letterCount: null == letterCount
            ? _value.letterCount
            : letterCount // ignore: cast_nullable_to_non_nullable
                  as int,
        managedUrgeCount: null == managedUrgeCount
            ? _value.managedUrgeCount
            : managedUrgeCount // ignore: cast_nullable_to_non_nullable
                  as int,
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$RecoveryPathStateImpl extends _RecoveryPathState {
  const _$RecoveryPathStateImpl({
    final List<RecoveryPathStep> steps = const [],
    this.ncDays = 0,
    this.moodCount = 0,
    this.letterCount = 0,
    this.managedUrgeCount = 0,
    this.isLoading = false,
  }) : _steps = steps,
       super._();

  final List<RecoveryPathStep> _steps;
  @override
  @JsonKey()
  List<RecoveryPathStep> get steps {
    if (_steps is EqualUnmodifiableListView) return _steps;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_steps);
  }

  @override
  @JsonKey()
  final int ncDays;
  @override
  @JsonKey()
  final int moodCount;
  @override
  @JsonKey()
  final int letterCount;
  @override
  @JsonKey()
  final int managedUrgeCount;
  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString() {
    return 'RecoveryPathState(steps: $steps, ncDays: $ncDays, moodCount: $moodCount, letterCount: $letterCount, managedUrgeCount: $managedUrgeCount, isLoading: $isLoading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecoveryPathStateImpl &&
            const DeepCollectionEquality().equals(other._steps, _steps) &&
            (identical(other.ncDays, ncDays) || other.ncDays == ncDays) &&
            (identical(other.moodCount, moodCount) ||
                other.moodCount == moodCount) &&
            (identical(other.letterCount, letterCount) ||
                other.letterCount == letterCount) &&
            (identical(other.managedUrgeCount, managedUrgeCount) ||
                other.managedUrgeCount == managedUrgeCount) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_steps),
    ncDays,
    moodCount,
    letterCount,
    managedUrgeCount,
    isLoading,
  );

  /// Create a copy of RecoveryPathState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecoveryPathStateImplCopyWith<_$RecoveryPathStateImpl> get copyWith =>
      __$$RecoveryPathStateImplCopyWithImpl<_$RecoveryPathStateImpl>(
        this,
        _$identity,
      );
}

abstract class _RecoveryPathState extends RecoveryPathState {
  const factory _RecoveryPathState({
    final List<RecoveryPathStep> steps,
    final int ncDays,
    final int moodCount,
    final int letterCount,
    final int managedUrgeCount,
    final bool isLoading,
  }) = _$RecoveryPathStateImpl;
  const _RecoveryPathState._() : super._();

  @override
  List<RecoveryPathStep> get steps;
  @override
  int get ncDays;
  @override
  int get moodCount;
  @override
  int get letterCount;
  @override
  int get managedUrgeCount;
  @override
  bool get isLoading;

  /// Create a copy of RecoveryPathState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecoveryPathStateImplCopyWith<_$RecoveryPathStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

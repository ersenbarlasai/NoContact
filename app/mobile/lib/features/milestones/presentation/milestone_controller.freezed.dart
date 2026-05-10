// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'milestone_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$MilestoneState {
  List<Milestone> get allMilestones => throw _privateConstructorUsedError;
  Milestone? get pendingMilestone => throw _privateConstructorUsedError;

  /// Create a copy of MilestoneState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MilestoneStateCopyWith<MilestoneState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MilestoneStateCopyWith<$Res> {
  factory $MilestoneStateCopyWith(
    MilestoneState value,
    $Res Function(MilestoneState) then,
  ) = _$MilestoneStateCopyWithImpl<$Res, MilestoneState>;
  @useResult
  $Res call({List<Milestone> allMilestones, Milestone? pendingMilestone});

  $MilestoneCopyWith<$Res>? get pendingMilestone;
}

/// @nodoc
class _$MilestoneStateCopyWithImpl<$Res, $Val extends MilestoneState>
    implements $MilestoneStateCopyWith<$Res> {
  _$MilestoneStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MilestoneState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? allMilestones = null,
    Object? pendingMilestone = freezed,
  }) {
    return _then(
      _value.copyWith(
            allMilestones: null == allMilestones
                ? _value.allMilestones
                : allMilestones // ignore: cast_nullable_to_non_nullable
                      as List<Milestone>,
            pendingMilestone: freezed == pendingMilestone
                ? _value.pendingMilestone
                : pendingMilestone // ignore: cast_nullable_to_non_nullable
                      as Milestone?,
          )
          as $Val,
    );
  }

  /// Create a copy of MilestoneState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MilestoneCopyWith<$Res>? get pendingMilestone {
    if (_value.pendingMilestone == null) {
      return null;
    }

    return $MilestoneCopyWith<$Res>(_value.pendingMilestone!, (value) {
      return _then(_value.copyWith(pendingMilestone: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MilestoneStateImplCopyWith<$Res>
    implements $MilestoneStateCopyWith<$Res> {
  factory _$$MilestoneStateImplCopyWith(
    _$MilestoneStateImpl value,
    $Res Function(_$MilestoneStateImpl) then,
  ) = __$$MilestoneStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Milestone> allMilestones, Milestone? pendingMilestone});

  @override
  $MilestoneCopyWith<$Res>? get pendingMilestone;
}

/// @nodoc
class __$$MilestoneStateImplCopyWithImpl<$Res>
    extends _$MilestoneStateCopyWithImpl<$Res, _$MilestoneStateImpl>
    implements _$$MilestoneStateImplCopyWith<$Res> {
  __$$MilestoneStateImplCopyWithImpl(
    _$MilestoneStateImpl _value,
    $Res Function(_$MilestoneStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MilestoneState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? allMilestones = null,
    Object? pendingMilestone = freezed,
  }) {
    return _then(
      _$MilestoneStateImpl(
        allMilestones: null == allMilestones
            ? _value._allMilestones
            : allMilestones // ignore: cast_nullable_to_non_nullable
                  as List<Milestone>,
        pendingMilestone: freezed == pendingMilestone
            ? _value.pendingMilestone
            : pendingMilestone // ignore: cast_nullable_to_non_nullable
                  as Milestone?,
      ),
    );
  }
}

/// @nodoc

class _$MilestoneStateImpl implements _MilestoneState {
  const _$MilestoneStateImpl({
    final List<Milestone> allMilestones = const [],
    this.pendingMilestone,
  }) : _allMilestones = allMilestones;

  final List<Milestone> _allMilestones;
  @override
  @JsonKey()
  List<Milestone> get allMilestones {
    if (_allMilestones is EqualUnmodifiableListView) return _allMilestones;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allMilestones);
  }

  @override
  final Milestone? pendingMilestone;

  @override
  String toString() {
    return 'MilestoneState(allMilestones: $allMilestones, pendingMilestone: $pendingMilestone)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MilestoneStateImpl &&
            const DeepCollectionEquality().equals(
              other._allMilestones,
              _allMilestones,
            ) &&
            (identical(other.pendingMilestone, pendingMilestone) ||
                other.pendingMilestone == pendingMilestone));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_allMilestones),
    pendingMilestone,
  );

  /// Create a copy of MilestoneState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MilestoneStateImplCopyWith<_$MilestoneStateImpl> get copyWith =>
      __$$MilestoneStateImplCopyWithImpl<_$MilestoneStateImpl>(
        this,
        _$identity,
      );
}

abstract class _MilestoneState implements MilestoneState {
  const factory _MilestoneState({
    final List<Milestone> allMilestones,
    final Milestone? pendingMilestone,
  }) = _$MilestoneStateImpl;

  @override
  List<Milestone> get allMilestones;
  @override
  Milestone? get pendingMilestone;

  /// Create a copy of MilestoneState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MilestoneStateImplCopyWith<_$MilestoneStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

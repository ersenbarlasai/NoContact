// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recovery_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

RecoveryProfile _$RecoveryProfileFromJson(Map<String, dynamic> json) {
  return _RecoveryProfile.fromJson(json);
}

/// @nodoc
mixin _$RecoveryProfile {
  @JsonKey(name: 'preferred_name')
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'reason_for_joining')
  String get reason => throw _privateConstructorUsedError;
  @JsonKey(name: 'relationship_duration')
  String get relationshipDuration => throw _privateConstructorUsedError;
  @JsonKey(name: 'time_since_breakup')
  String get timeSinceBreakup => throw _privateConstructorUsedError;
  @JsonKey(name: 'ended_by')
  String get whoEnded => throw _privateConstructorUsedError;
  @JsonKey(name: 'no_contact_start_date')
  DateTime? get noContactStartDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'dominant_emotion')
  String get dominantEmotion => throw _privateConstructorUsedError;
  @JsonKey(name: 'contact_triggers')
  List<String> get contactTriggers => throw _privateConstructorUsedError;
  @JsonKey(name: 'commitment_accepted_at')
  DateTime? get commitmentAcceptedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'onboarding_completed')
  bool get isOnboardingCompleted => throw _privateConstructorUsedError;
  @JsonKey(name: 'app_disclaimer_seen')
  bool get appDisclaimerSeen => throw _privateConstructorUsedError;

  /// Serializes this RecoveryProfile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RecoveryProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecoveryProfileCopyWith<RecoveryProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecoveryProfileCopyWith<$Res> {
  factory $RecoveryProfileCopyWith(
    RecoveryProfile value,
    $Res Function(RecoveryProfile) then,
  ) = _$RecoveryProfileCopyWithImpl<$Res, RecoveryProfile>;
  @useResult
  $Res call({
    @JsonKey(name: 'preferred_name') String name,
    @JsonKey(name: 'reason_for_joining') String reason,
    @JsonKey(name: 'relationship_duration') String relationshipDuration,
    @JsonKey(name: 'time_since_breakup') String timeSinceBreakup,
    @JsonKey(name: 'ended_by') String whoEnded,
    @JsonKey(name: 'no_contact_start_date') DateTime? noContactStartDate,
    @JsonKey(name: 'dominant_emotion') String dominantEmotion,
    @JsonKey(name: 'contact_triggers') List<String> contactTriggers,
    @JsonKey(name: 'commitment_accepted_at') DateTime? commitmentAcceptedAt,
    @JsonKey(name: 'onboarding_completed') bool isOnboardingCompleted,
    @JsonKey(name: 'app_disclaimer_seen') bool appDisclaimerSeen,
  });
}

/// @nodoc
class _$RecoveryProfileCopyWithImpl<$Res, $Val extends RecoveryProfile>
    implements $RecoveryProfileCopyWith<$Res> {
  _$RecoveryProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecoveryProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? reason = null,
    Object? relationshipDuration = null,
    Object? timeSinceBreakup = null,
    Object? whoEnded = null,
    Object? noContactStartDate = freezed,
    Object? dominantEmotion = null,
    Object? contactTriggers = null,
    Object? commitmentAcceptedAt = freezed,
    Object? isOnboardingCompleted = null,
    Object? appDisclaimerSeen = null,
  }) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            reason: null == reason
                ? _value.reason
                : reason // ignore: cast_nullable_to_non_nullable
                      as String,
            relationshipDuration: null == relationshipDuration
                ? _value.relationshipDuration
                : relationshipDuration // ignore: cast_nullable_to_non_nullable
                      as String,
            timeSinceBreakup: null == timeSinceBreakup
                ? _value.timeSinceBreakup
                : timeSinceBreakup // ignore: cast_nullable_to_non_nullable
                      as String,
            whoEnded: null == whoEnded
                ? _value.whoEnded
                : whoEnded // ignore: cast_nullable_to_non_nullable
                      as String,
            noContactStartDate: freezed == noContactStartDate
                ? _value.noContactStartDate
                : noContactStartDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            dominantEmotion: null == dominantEmotion
                ? _value.dominantEmotion
                : dominantEmotion // ignore: cast_nullable_to_non_nullable
                      as String,
            contactTriggers: null == contactTriggers
                ? _value.contactTriggers
                : contactTriggers // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            commitmentAcceptedAt: freezed == commitmentAcceptedAt
                ? _value.commitmentAcceptedAt
                : commitmentAcceptedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            isOnboardingCompleted: null == isOnboardingCompleted
                ? _value.isOnboardingCompleted
                : isOnboardingCompleted // ignore: cast_nullable_to_non_nullable
                      as bool,
            appDisclaimerSeen: null == appDisclaimerSeen
                ? _value.appDisclaimerSeen
                : appDisclaimerSeen // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RecoveryProfileImplCopyWith<$Res>
    implements $RecoveryProfileCopyWith<$Res> {
  factory _$$RecoveryProfileImplCopyWith(
    _$RecoveryProfileImpl value,
    $Res Function(_$RecoveryProfileImpl) then,
  ) = __$$RecoveryProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'preferred_name') String name,
    @JsonKey(name: 'reason_for_joining') String reason,
    @JsonKey(name: 'relationship_duration') String relationshipDuration,
    @JsonKey(name: 'time_since_breakup') String timeSinceBreakup,
    @JsonKey(name: 'ended_by') String whoEnded,
    @JsonKey(name: 'no_contact_start_date') DateTime? noContactStartDate,
    @JsonKey(name: 'dominant_emotion') String dominantEmotion,
    @JsonKey(name: 'contact_triggers') List<String> contactTriggers,
    @JsonKey(name: 'commitment_accepted_at') DateTime? commitmentAcceptedAt,
    @JsonKey(name: 'onboarding_completed') bool isOnboardingCompleted,
    @JsonKey(name: 'app_disclaimer_seen') bool appDisclaimerSeen,
  });
}

/// @nodoc
class __$$RecoveryProfileImplCopyWithImpl<$Res>
    extends _$RecoveryProfileCopyWithImpl<$Res, _$RecoveryProfileImpl>
    implements _$$RecoveryProfileImplCopyWith<$Res> {
  __$$RecoveryProfileImplCopyWithImpl(
    _$RecoveryProfileImpl _value,
    $Res Function(_$RecoveryProfileImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RecoveryProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? reason = null,
    Object? relationshipDuration = null,
    Object? timeSinceBreakup = null,
    Object? whoEnded = null,
    Object? noContactStartDate = freezed,
    Object? dominantEmotion = null,
    Object? contactTriggers = null,
    Object? commitmentAcceptedAt = freezed,
    Object? isOnboardingCompleted = null,
    Object? appDisclaimerSeen = null,
  }) {
    return _then(
      _$RecoveryProfileImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        reason: null == reason
            ? _value.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as String,
        relationshipDuration: null == relationshipDuration
            ? _value.relationshipDuration
            : relationshipDuration // ignore: cast_nullable_to_non_nullable
                  as String,
        timeSinceBreakup: null == timeSinceBreakup
            ? _value.timeSinceBreakup
            : timeSinceBreakup // ignore: cast_nullable_to_non_nullable
                  as String,
        whoEnded: null == whoEnded
            ? _value.whoEnded
            : whoEnded // ignore: cast_nullable_to_non_nullable
                  as String,
        noContactStartDate: freezed == noContactStartDate
            ? _value.noContactStartDate
            : noContactStartDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        dominantEmotion: null == dominantEmotion
            ? _value.dominantEmotion
            : dominantEmotion // ignore: cast_nullable_to_non_nullable
                  as String,
        contactTriggers: null == contactTriggers
            ? _value._contactTriggers
            : contactTriggers // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        commitmentAcceptedAt: freezed == commitmentAcceptedAt
            ? _value.commitmentAcceptedAt
            : commitmentAcceptedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        isOnboardingCompleted: null == isOnboardingCompleted
            ? _value.isOnboardingCompleted
            : isOnboardingCompleted // ignore: cast_nullable_to_non_nullable
                  as bool,
        appDisclaimerSeen: null == appDisclaimerSeen
            ? _value.appDisclaimerSeen
            : appDisclaimerSeen // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RecoveryProfileImpl implements _RecoveryProfile {
  const _$RecoveryProfileImpl({
    @JsonKey(name: 'preferred_name') this.name = '',
    @JsonKey(name: 'reason_for_joining') this.reason = '',
    @JsonKey(name: 'relationship_duration') this.relationshipDuration = '',
    @JsonKey(name: 'time_since_breakup') this.timeSinceBreakup = '',
    @JsonKey(name: 'ended_by') this.whoEnded = '',
    @JsonKey(name: 'no_contact_start_date') this.noContactStartDate,
    @JsonKey(name: 'dominant_emotion') this.dominantEmotion = '',
    @JsonKey(name: 'contact_triggers')
    final List<String> contactTriggers = const [],
    @JsonKey(name: 'commitment_accepted_at') this.commitmentAcceptedAt,
    @JsonKey(name: 'onboarding_completed') this.isOnboardingCompleted = false,
    @JsonKey(name: 'app_disclaimer_seen') this.appDisclaimerSeen = false,
  }) : _contactTriggers = contactTriggers;

  factory _$RecoveryProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecoveryProfileImplFromJson(json);

  @override
  @JsonKey(name: 'preferred_name')
  final String name;
  @override
  @JsonKey(name: 'reason_for_joining')
  final String reason;
  @override
  @JsonKey(name: 'relationship_duration')
  final String relationshipDuration;
  @override
  @JsonKey(name: 'time_since_breakup')
  final String timeSinceBreakup;
  @override
  @JsonKey(name: 'ended_by')
  final String whoEnded;
  @override
  @JsonKey(name: 'no_contact_start_date')
  final DateTime? noContactStartDate;
  @override
  @JsonKey(name: 'dominant_emotion')
  final String dominantEmotion;
  final List<String> _contactTriggers;
  @override
  @JsonKey(name: 'contact_triggers')
  List<String> get contactTriggers {
    if (_contactTriggers is EqualUnmodifiableListView) return _contactTriggers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_contactTriggers);
  }

  @override
  @JsonKey(name: 'commitment_accepted_at')
  final DateTime? commitmentAcceptedAt;
  @override
  @JsonKey(name: 'onboarding_completed')
  final bool isOnboardingCompleted;
  @override
  @JsonKey(name: 'app_disclaimer_seen')
  final bool appDisclaimerSeen;

  @override
  String toString() {
    return 'RecoveryProfile(name: $name, reason: $reason, relationshipDuration: $relationshipDuration, timeSinceBreakup: $timeSinceBreakup, whoEnded: $whoEnded, noContactStartDate: $noContactStartDate, dominantEmotion: $dominantEmotion, contactTriggers: $contactTriggers, commitmentAcceptedAt: $commitmentAcceptedAt, isOnboardingCompleted: $isOnboardingCompleted, appDisclaimerSeen: $appDisclaimerSeen)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecoveryProfileImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.relationshipDuration, relationshipDuration) ||
                other.relationshipDuration == relationshipDuration) &&
            (identical(other.timeSinceBreakup, timeSinceBreakup) ||
                other.timeSinceBreakup == timeSinceBreakup) &&
            (identical(other.whoEnded, whoEnded) ||
                other.whoEnded == whoEnded) &&
            (identical(other.noContactStartDate, noContactStartDate) ||
                other.noContactStartDate == noContactStartDate) &&
            (identical(other.dominantEmotion, dominantEmotion) ||
                other.dominantEmotion == dominantEmotion) &&
            const DeepCollectionEquality().equals(
              other._contactTriggers,
              _contactTriggers,
            ) &&
            (identical(other.commitmentAcceptedAt, commitmentAcceptedAt) ||
                other.commitmentAcceptedAt == commitmentAcceptedAt) &&
            (identical(other.isOnboardingCompleted, isOnboardingCompleted) ||
                other.isOnboardingCompleted == isOnboardingCompleted) &&
            (identical(other.appDisclaimerSeen, appDisclaimerSeen) ||
                other.appDisclaimerSeen == appDisclaimerSeen));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    name,
    reason,
    relationshipDuration,
    timeSinceBreakup,
    whoEnded,
    noContactStartDate,
    dominantEmotion,
    const DeepCollectionEquality().hash(_contactTriggers),
    commitmentAcceptedAt,
    isOnboardingCompleted,
    appDisclaimerSeen,
  );

  /// Create a copy of RecoveryProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecoveryProfileImplCopyWith<_$RecoveryProfileImpl> get copyWith =>
      __$$RecoveryProfileImplCopyWithImpl<_$RecoveryProfileImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RecoveryProfileImplToJson(this);
  }
}

abstract class _RecoveryProfile implements RecoveryProfile {
  const factory _RecoveryProfile({
    @JsonKey(name: 'preferred_name') final String name,
    @JsonKey(name: 'reason_for_joining') final String reason,
    @JsonKey(name: 'relationship_duration') final String relationshipDuration,
    @JsonKey(name: 'time_since_breakup') final String timeSinceBreakup,
    @JsonKey(name: 'ended_by') final String whoEnded,
    @JsonKey(name: 'no_contact_start_date') final DateTime? noContactStartDate,
    @JsonKey(name: 'dominant_emotion') final String dominantEmotion,
    @JsonKey(name: 'contact_triggers') final List<String> contactTriggers,
    @JsonKey(name: 'commitment_accepted_at')
    final DateTime? commitmentAcceptedAt,
    @JsonKey(name: 'onboarding_completed') final bool isOnboardingCompleted,
    @JsonKey(name: 'app_disclaimer_seen') final bool appDisclaimerSeen,
  }) = _$RecoveryProfileImpl;

  factory _RecoveryProfile.fromJson(Map<String, dynamic> json) =
      _$RecoveryProfileImpl.fromJson;

  @override
  @JsonKey(name: 'preferred_name')
  String get name;
  @override
  @JsonKey(name: 'reason_for_joining')
  String get reason;
  @override
  @JsonKey(name: 'relationship_duration')
  String get relationshipDuration;
  @override
  @JsonKey(name: 'time_since_breakup')
  String get timeSinceBreakup;
  @override
  @JsonKey(name: 'ended_by')
  String get whoEnded;
  @override
  @JsonKey(name: 'no_contact_start_date')
  DateTime? get noContactStartDate;
  @override
  @JsonKey(name: 'dominant_emotion')
  String get dominantEmotion;
  @override
  @JsonKey(name: 'contact_triggers')
  List<String> get contactTriggers;
  @override
  @JsonKey(name: 'commitment_accepted_at')
  DateTime? get commitmentAcceptedAt;
  @override
  @JsonKey(name: 'onboarding_completed')
  bool get isOnboardingCompleted;
  @override
  @JsonKey(name: 'app_disclaimer_seen')
  bool get appDisclaimerSeen;

  /// Create a copy of RecoveryProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecoveryProfileImplCopyWith<_$RecoveryProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sos_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SosSession _$SosSessionFromJson(Map<String, dynamic> json) {
  return _SosSession.fromJson(json);
}

/// @nodoc
mixin _$SosSession {
  @JsonKey(name: 'started_at')
  DateTime? get startedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'completed_at')
  DateTime? get completedAt => throw _privateConstructorUsedError;
  @JsonKey(includeToJson: false, includeFromJson: false)
  String get urgeText => throw _privateConstructorUsedError;
  @JsonKey(name: 'selected_outcome')
  String get selectedOutcome => throw _privateConstructorUsedError;
  @JsonKey(name: 'needed_extra_support')
  bool get neededExtraSupport => throw _privateConstructorUsedError;
  @JsonKey(name: 'dominant_emotion')
  String? get dominantEmotion => throw _privateConstructorUsedError;
  @JsonKey(name: 'strongest_trigger')
  String? get strongestTrigger => throw _privateConstructorUsedError;
  @JsonKey(name: 'urge_text_saved')
  bool get urgeTextSaved => throw _privateConstructorUsedError;
  @JsonKey(name: 'urge_text_preview')
  String? get urgeTextPreview => throw _privateConstructorUsedError;

  /// Serializes this SosSession to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SosSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SosSessionCopyWith<SosSession> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SosSessionCopyWith<$Res> {
  factory $SosSessionCopyWith(
    SosSession value,
    $Res Function(SosSession) then,
  ) = _$SosSessionCopyWithImpl<$Res, SosSession>;
  @useResult
  $Res call({
    @JsonKey(name: 'started_at') DateTime? startedAt,
    @JsonKey(name: 'completed_at') DateTime? completedAt,
    @JsonKey(includeToJson: false, includeFromJson: false) String urgeText,
    @JsonKey(name: 'selected_outcome') String selectedOutcome,
    @JsonKey(name: 'needed_extra_support') bool neededExtraSupport,
    @JsonKey(name: 'dominant_emotion') String? dominantEmotion,
    @JsonKey(name: 'strongest_trigger') String? strongestTrigger,
    @JsonKey(name: 'urge_text_saved') bool urgeTextSaved,
    @JsonKey(name: 'urge_text_preview') String? urgeTextPreview,
  });
}

/// @nodoc
class _$SosSessionCopyWithImpl<$Res, $Val extends SosSession>
    implements $SosSessionCopyWith<$Res> {
  _$SosSessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SosSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startedAt = freezed,
    Object? completedAt = freezed,
    Object? urgeText = null,
    Object? selectedOutcome = null,
    Object? neededExtraSupport = null,
    Object? dominantEmotion = freezed,
    Object? strongestTrigger = freezed,
    Object? urgeTextSaved = null,
    Object? urgeTextPreview = freezed,
  }) {
    return _then(
      _value.copyWith(
            startedAt: freezed == startedAt
                ? _value.startedAt
                : startedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            completedAt: freezed == completedAt
                ? _value.completedAt
                : completedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            urgeText: null == urgeText
                ? _value.urgeText
                : urgeText // ignore: cast_nullable_to_non_nullable
                      as String,
            selectedOutcome: null == selectedOutcome
                ? _value.selectedOutcome
                : selectedOutcome // ignore: cast_nullable_to_non_nullable
                      as String,
            neededExtraSupport: null == neededExtraSupport
                ? _value.neededExtraSupport
                : neededExtraSupport // ignore: cast_nullable_to_non_nullable
                      as bool,
            dominantEmotion: freezed == dominantEmotion
                ? _value.dominantEmotion
                : dominantEmotion // ignore: cast_nullable_to_non_nullable
                      as String?,
            strongestTrigger: freezed == strongestTrigger
                ? _value.strongestTrigger
                : strongestTrigger // ignore: cast_nullable_to_non_nullable
                      as String?,
            urgeTextSaved: null == urgeTextSaved
                ? _value.urgeTextSaved
                : urgeTextSaved // ignore: cast_nullable_to_non_nullable
                      as bool,
            urgeTextPreview: freezed == urgeTextPreview
                ? _value.urgeTextPreview
                : urgeTextPreview // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SosSessionImplCopyWith<$Res>
    implements $SosSessionCopyWith<$Res> {
  factory _$$SosSessionImplCopyWith(
    _$SosSessionImpl value,
    $Res Function(_$SosSessionImpl) then,
  ) = __$$SosSessionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'started_at') DateTime? startedAt,
    @JsonKey(name: 'completed_at') DateTime? completedAt,
    @JsonKey(includeToJson: false, includeFromJson: false) String urgeText,
    @JsonKey(name: 'selected_outcome') String selectedOutcome,
    @JsonKey(name: 'needed_extra_support') bool neededExtraSupport,
    @JsonKey(name: 'dominant_emotion') String? dominantEmotion,
    @JsonKey(name: 'strongest_trigger') String? strongestTrigger,
    @JsonKey(name: 'urge_text_saved') bool urgeTextSaved,
    @JsonKey(name: 'urge_text_preview') String? urgeTextPreview,
  });
}

/// @nodoc
class __$$SosSessionImplCopyWithImpl<$Res>
    extends _$SosSessionCopyWithImpl<$Res, _$SosSessionImpl>
    implements _$$SosSessionImplCopyWith<$Res> {
  __$$SosSessionImplCopyWithImpl(
    _$SosSessionImpl _value,
    $Res Function(_$SosSessionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SosSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startedAt = freezed,
    Object? completedAt = freezed,
    Object? urgeText = null,
    Object? selectedOutcome = null,
    Object? neededExtraSupport = null,
    Object? dominantEmotion = freezed,
    Object? strongestTrigger = freezed,
    Object? urgeTextSaved = null,
    Object? urgeTextPreview = freezed,
  }) {
    return _then(
      _$SosSessionImpl(
        startedAt: freezed == startedAt
            ? _value.startedAt
            : startedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        completedAt: freezed == completedAt
            ? _value.completedAt
            : completedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        urgeText: null == urgeText
            ? _value.urgeText
            : urgeText // ignore: cast_nullable_to_non_nullable
                  as String,
        selectedOutcome: null == selectedOutcome
            ? _value.selectedOutcome
            : selectedOutcome // ignore: cast_nullable_to_non_nullable
                  as String,
        neededExtraSupport: null == neededExtraSupport
            ? _value.neededExtraSupport
            : neededExtraSupport // ignore: cast_nullable_to_non_nullable
                  as bool,
        dominantEmotion: freezed == dominantEmotion
            ? _value.dominantEmotion
            : dominantEmotion // ignore: cast_nullable_to_non_nullable
                  as String?,
        strongestTrigger: freezed == strongestTrigger
            ? _value.strongestTrigger
            : strongestTrigger // ignore: cast_nullable_to_non_nullable
                  as String?,
        urgeTextSaved: null == urgeTextSaved
            ? _value.urgeTextSaved
            : urgeTextSaved // ignore: cast_nullable_to_non_nullable
                  as bool,
        urgeTextPreview: freezed == urgeTextPreview
            ? _value.urgeTextPreview
            : urgeTextPreview // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SosSessionImpl implements _SosSession {
  const _$SosSessionImpl({
    @JsonKey(name: 'started_at') this.startedAt,
    @JsonKey(name: 'completed_at') this.completedAt,
    @JsonKey(includeToJson: false, includeFromJson: false) this.urgeText = '',
    @JsonKey(name: 'selected_outcome') this.selectedOutcome = '',
    @JsonKey(name: 'needed_extra_support') this.neededExtraSupport = false,
    @JsonKey(name: 'dominant_emotion') this.dominantEmotion,
    @JsonKey(name: 'strongest_trigger') this.strongestTrigger,
    @JsonKey(name: 'urge_text_saved') this.urgeTextSaved = false,
    @JsonKey(name: 'urge_text_preview') this.urgeTextPreview,
  });

  factory _$SosSessionImpl.fromJson(Map<String, dynamic> json) =>
      _$$SosSessionImplFromJson(json);

  @override
  @JsonKey(name: 'started_at')
  final DateTime? startedAt;
  @override
  @JsonKey(name: 'completed_at')
  final DateTime? completedAt;
  @override
  @JsonKey(includeToJson: false, includeFromJson: false)
  final String urgeText;
  @override
  @JsonKey(name: 'selected_outcome')
  final String selectedOutcome;
  @override
  @JsonKey(name: 'needed_extra_support')
  final bool neededExtraSupport;
  @override
  @JsonKey(name: 'dominant_emotion')
  final String? dominantEmotion;
  @override
  @JsonKey(name: 'strongest_trigger')
  final String? strongestTrigger;
  @override
  @JsonKey(name: 'urge_text_saved')
  final bool urgeTextSaved;
  @override
  @JsonKey(name: 'urge_text_preview')
  final String? urgeTextPreview;

  @override
  String toString() {
    return 'SosSession(startedAt: $startedAt, completedAt: $completedAt, urgeText: $urgeText, selectedOutcome: $selectedOutcome, neededExtraSupport: $neededExtraSupport, dominantEmotion: $dominantEmotion, strongestTrigger: $strongestTrigger, urgeTextSaved: $urgeTextSaved, urgeTextPreview: $urgeTextPreview)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SosSessionImpl &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.urgeText, urgeText) ||
                other.urgeText == urgeText) &&
            (identical(other.selectedOutcome, selectedOutcome) ||
                other.selectedOutcome == selectedOutcome) &&
            (identical(other.neededExtraSupport, neededExtraSupport) ||
                other.neededExtraSupport == neededExtraSupport) &&
            (identical(other.dominantEmotion, dominantEmotion) ||
                other.dominantEmotion == dominantEmotion) &&
            (identical(other.strongestTrigger, strongestTrigger) ||
                other.strongestTrigger == strongestTrigger) &&
            (identical(other.urgeTextSaved, urgeTextSaved) ||
                other.urgeTextSaved == urgeTextSaved) &&
            (identical(other.urgeTextPreview, urgeTextPreview) ||
                other.urgeTextPreview == urgeTextPreview));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    startedAt,
    completedAt,
    urgeText,
    selectedOutcome,
    neededExtraSupport,
    dominantEmotion,
    strongestTrigger,
    urgeTextSaved,
    urgeTextPreview,
  );

  /// Create a copy of SosSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SosSessionImplCopyWith<_$SosSessionImpl> get copyWith =>
      __$$SosSessionImplCopyWithImpl<_$SosSessionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SosSessionImplToJson(this);
  }
}

abstract class _SosSession implements SosSession {
  const factory _SosSession({
    @JsonKey(name: 'started_at') final DateTime? startedAt,
    @JsonKey(name: 'completed_at') final DateTime? completedAt,
    @JsonKey(includeToJson: false, includeFromJson: false)
    final String urgeText,
    @JsonKey(name: 'selected_outcome') final String selectedOutcome,
    @JsonKey(name: 'needed_extra_support') final bool neededExtraSupport,
    @JsonKey(name: 'dominant_emotion') final String? dominantEmotion,
    @JsonKey(name: 'strongest_trigger') final String? strongestTrigger,
    @JsonKey(name: 'urge_text_saved') final bool urgeTextSaved,
    @JsonKey(name: 'urge_text_preview') final String? urgeTextPreview,
  }) = _$SosSessionImpl;

  factory _SosSession.fromJson(Map<String, dynamic> json) =
      _$SosSessionImpl.fromJson;

  @override
  @JsonKey(name: 'started_at')
  DateTime? get startedAt;
  @override
  @JsonKey(name: 'completed_at')
  DateTime? get completedAt;
  @override
  @JsonKey(includeToJson: false, includeFromJson: false)
  String get urgeText;
  @override
  @JsonKey(name: 'selected_outcome')
  String get selectedOutcome;
  @override
  @JsonKey(name: 'needed_extra_support')
  bool get neededExtraSupport;
  @override
  @JsonKey(name: 'dominant_emotion')
  String? get dominantEmotion;
  @override
  @JsonKey(name: 'strongest_trigger')
  String? get strongestTrigger;
  @override
  @JsonKey(name: 'urge_text_saved')
  bool get urgeTextSaved;
  @override
  @JsonKey(name: 'urge_text_preview')
  String? get urgeTextPreview;

  /// Create a copy of SosSession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SosSessionImplCopyWith<_$SosSessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

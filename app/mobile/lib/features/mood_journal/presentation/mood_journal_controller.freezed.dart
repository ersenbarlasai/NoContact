// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mood_journal_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$MoodJournalState {
  List<MoodEntry> get entries => throw _privateConstructorUsedError;
  MoodEntry? get todayEntry => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  /// Create a copy of MoodJournalState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MoodJournalStateCopyWith<MoodJournalState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MoodJournalStateCopyWith<$Res> {
  factory $MoodJournalStateCopyWith(
    MoodJournalState value,
    $Res Function(MoodJournalState) then,
  ) = _$MoodJournalStateCopyWithImpl<$Res, MoodJournalState>;
  @useResult
  $Res call({List<MoodEntry> entries, MoodEntry? todayEntry, bool isLoading});

  $MoodEntryCopyWith<$Res>? get todayEntry;
}

/// @nodoc
class _$MoodJournalStateCopyWithImpl<$Res, $Val extends MoodJournalState>
    implements $MoodJournalStateCopyWith<$Res> {
  _$MoodJournalStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MoodJournalState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? entries = null,
    Object? todayEntry = freezed,
    Object? isLoading = null,
  }) {
    return _then(
      _value.copyWith(
            entries: null == entries
                ? _value.entries
                : entries // ignore: cast_nullable_to_non_nullable
                      as List<MoodEntry>,
            todayEntry: freezed == todayEntry
                ? _value.todayEntry
                : todayEntry // ignore: cast_nullable_to_non_nullable
                      as MoodEntry?,
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }

  /// Create a copy of MoodJournalState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MoodEntryCopyWith<$Res>? get todayEntry {
    if (_value.todayEntry == null) {
      return null;
    }

    return $MoodEntryCopyWith<$Res>(_value.todayEntry!, (value) {
      return _then(_value.copyWith(todayEntry: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MoodJournalStateImplCopyWith<$Res>
    implements $MoodJournalStateCopyWith<$Res> {
  factory _$$MoodJournalStateImplCopyWith(
    _$MoodJournalStateImpl value,
    $Res Function(_$MoodJournalStateImpl) then,
  ) = __$$MoodJournalStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<MoodEntry> entries, MoodEntry? todayEntry, bool isLoading});

  @override
  $MoodEntryCopyWith<$Res>? get todayEntry;
}

/// @nodoc
class __$$MoodJournalStateImplCopyWithImpl<$Res>
    extends _$MoodJournalStateCopyWithImpl<$Res, _$MoodJournalStateImpl>
    implements _$$MoodJournalStateImplCopyWith<$Res> {
  __$$MoodJournalStateImplCopyWithImpl(
    _$MoodJournalStateImpl _value,
    $Res Function(_$MoodJournalStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MoodJournalState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? entries = null,
    Object? todayEntry = freezed,
    Object? isLoading = null,
  }) {
    return _then(
      _$MoodJournalStateImpl(
        entries: null == entries
            ? _value._entries
            : entries // ignore: cast_nullable_to_non_nullable
                  as List<MoodEntry>,
        todayEntry: freezed == todayEntry
            ? _value.todayEntry
            : todayEntry // ignore: cast_nullable_to_non_nullable
                  as MoodEntry?,
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$MoodJournalStateImpl extends _MoodJournalState {
  const _$MoodJournalStateImpl({
    final List<MoodEntry> entries = const [],
    this.todayEntry,
    this.isLoading = false,
  }) : _entries = entries,
       super._();

  final List<MoodEntry> _entries;
  @override
  @JsonKey()
  List<MoodEntry> get entries {
    if (_entries is EqualUnmodifiableListView) return _entries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_entries);
  }

  @override
  final MoodEntry? todayEntry;
  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString() {
    return 'MoodJournalState(entries: $entries, todayEntry: $todayEntry, isLoading: $isLoading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MoodJournalStateImpl &&
            const DeepCollectionEquality().equals(other._entries, _entries) &&
            (identical(other.todayEntry, todayEntry) ||
                other.todayEntry == todayEntry) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_entries),
    todayEntry,
    isLoading,
  );

  /// Create a copy of MoodJournalState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MoodJournalStateImplCopyWith<_$MoodJournalStateImpl> get copyWith =>
      __$$MoodJournalStateImplCopyWithImpl<_$MoodJournalStateImpl>(
        this,
        _$identity,
      );
}

abstract class _MoodJournalState extends MoodJournalState {
  const factory _MoodJournalState({
    final List<MoodEntry> entries,
    final MoodEntry? todayEntry,
    final bool isLoading,
  }) = _$MoodJournalStateImpl;
  const _MoodJournalState._() : super._();

  @override
  List<MoodEntry> get entries;
  @override
  MoodEntry? get todayEntry;
  @override
  bool get isLoading;

  /// Create a copy of MoodJournalState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MoodJournalStateImplCopyWith<_$MoodJournalStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

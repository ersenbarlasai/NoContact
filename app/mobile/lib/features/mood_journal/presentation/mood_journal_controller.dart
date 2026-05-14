import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../data/models/mood_entry.dart';
import '../../../data/repositories/providers.dart';

part 'mood_journal_controller.freezed.dart';

@freezed
class MoodJournalState with _$MoodJournalState {
  const factory MoodJournalState({
    @Default([]) List<MoodEntry> entries,
    MoodEntry? todayEntry,
    @Default(false) bool isEditing,
    @Default(false) bool isLoading,
  }) = _MoodJournalState;

  const MoodJournalState._();

  // Streak logic: 
  // - If user has entry today, streak counts today backward.
  // - If user has no entry today but had entry yesterday, streak is still alive.
  // - Otherwise, streak is broken.
  int get currentStreak {
    if (entries.isEmpty) return 0;
    
    final sorted = List<MoodEntry>.from(entries)..sort((a, b) => b.date.compareTo(a.date));
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    bool hasEntryToday = false;
    bool hasEntryYesterday = false;

    for (final entry in sorted) {
      final entryDate = DateTime(entry.date.year, entry.date.month, entry.date.day);
      if (entryDate == today) hasEntryToday = true;
      if (entryDate == yesterday) hasEntryYesterday = true;
    }

    // If no entry today AND no entry yesterday, streak is broken
    if (!hasEntryToday && !hasEntryYesterday) return 0;

    int streak = 0;
    DateTime checkDate = hasEntryToday ? today : yesterday;

    // Iterate backwards from the latest relevant date
    for (final entry in sorted) {
      final entryDate = DateTime(entry.date.year, entry.date.month, entry.date.day);
      if (entryDate == checkDate) {
        streak++;
        checkDate = checkDate.subtract(const Duration(days: 1));
      } else if (entryDate.isBefore(checkDate)) {
        break;
      }
    }
    
    return streak;
  }

  String get mostCommonTrigger {
    if (entries.isEmpty) return 'Henüz veri yok';
    final triggerCounts = <String, int>{};
    for (final entry in entries) {
      for (final trigger in entry.triggers) {
        triggerCounts[trigger] = (triggerCounts[trigger] ?? 0) + 1;
      }
    }
    if (triggerCounts.isEmpty) return 'Henüz veri yok';
    return triggerCounts.entries.reduce((a, b) => a.value > b.value ? a : b).key;
  }

  List<MoodEntry> get last7Days {
    final now = DateTime.now();
    final todayMidnight = DateTime(now.year, now.month, now.day);
    final sevenDaysAgoMidnight = todayMidnight.subtract(const Duration(days: 6));
    
    return entries.where((e) {
      final entryDate = DateTime(e.date.year, e.date.month, e.date.day);
      return !entryDate.isBefore(sevenDaysAgoMidnight) && !entryDate.isAfter(todayMidnight);
    }).toList()..sort((a, b) => b.date.compareTo(a.date));
  }
}

class MoodJournalController extends StateNotifier<MoodJournalState> {
  final Ref _ref;

  MoodJournalController(this._ref) : super(const MoodJournalState()) {
    loadEntries();
  }

  Future<void> loadEntries() async {
    state = state.copyWith(isLoading: true);
    final repo = _ref.read(localMoodJournalRepositoryProvider);
    final entries = await repo.fetchMoodEntries();
    final today = await repo.fetchTodayMoodEntry();
    
    state = state.copyWith(
      entries: entries,
      todayEntry: today,
      isEditing: today != null,
      isLoading: false,
    );
  }

  void prepareForEntry() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    
    // If we have an entry in state, verify it is still for "today"
    if (state.todayEntry != null) {
      final entryDate = DateTime(
        state.todayEntry!.date.year,
        state.todayEntry!.date.month,
        state.todayEntry!.date.day,
      );
      
      if (entryDate != today) {
        // Stale entry from previous day/session, clear it
        state = state.copyWith(todayEntry: null, isEditing: false);
      }
    }
    
    // If after verification todayEntry is still null, we might need to load from DB 
    // or wait for the user to start interacting (initTodayEntry)
  }

  void initTodayEntry() {
    if (state.todayEntry != null) return;
    
    final now = DateTime.now();
    state = state.copyWith(
      todayEntry: MoodEntry(
        id: const Uuid().v4(),
        date: now,
        mood: moodOptions.first,
        intensity: 3,
        triggers: [],
        createdAt: now,
        updatedAt: now,
      ),
    );
  }

  void updateMood(String mood) {
    if (state.todayEntry == null) initTodayEntry();
    state = state.copyWith(
      todayEntry: state.todayEntry!.copyWith(
        mood: mood,
        updatedAt: DateTime.now(),
      ),
    );
  }

  void updateIntensity(int intensity) {
    if (state.todayEntry == null) initTodayEntry();
    state = state.copyWith(
      todayEntry: state.todayEntry!.copyWith(
        intensity: intensity,
        updatedAt: DateTime.now(),
      ),
    );
  }

  void toggleTrigger(String trigger) {
    if (state.todayEntry == null) initTodayEntry();
    final current = List<String>.from(state.todayEntry!.triggers);
    if (current.contains(trigger)) {
      current.remove(trigger);
    } else {
      current.add(trigger);
    }
    state = state.copyWith(
      todayEntry: state.todayEntry!.copyWith(
        triggers: current,
        updatedAt: DateTime.now(),
      ),
    );
  }

  void updateNote(String note) {
    if (state.todayEntry == null) initTodayEntry();
    state = state.copyWith(
      todayEntry: state.todayEntry!.copyWith(
        note: note,
        updatedAt: DateTime.now(),
      ),
    );
  }

  Future<void> saveTodayEntry() async {
    if (state.todayEntry == null) return;
    
    final repo = _ref.read(localMoodJournalRepositoryProvider);
    await repo.upsertMoodEntry(state.todayEntry!);
    await loadEntries();
  }
}

final moodJournalControllerProvider =
    StateNotifierProvider<MoodJournalController, MoodJournalState>((ref) {
  return MoodJournalController(ref);
});

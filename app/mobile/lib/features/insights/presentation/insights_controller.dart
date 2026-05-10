import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/insights_data.dart';
import '../../recovery_path/presentation/recovery_path_controller.dart';
import '../../milestones/presentation/milestone_controller.dart';
import '../../mood_journal/presentation/mood_journal_controller.dart';
import '../../../data/models/mood_entry.dart';

class InsightsController extends StateNotifier<InsightsData> {
  InsightsController(this.ref)
      : super(const InsightsData(
          ncDays: 0,
          managedUrgeCount: 0,
          moodStreak: 0,
          moodCount: 0,
          milestoneCount: 0,
          letterCount: 0,
          milestoneHistory: [],
          moodDistribution: {},
          isLoading: true,
        )) {
    _init();
  }

  final Ref ref;

  void _init() {
    _update();
  }

  void _update() {
    final pathState = ref.read(recoveryPathControllerProvider);
    final milestoneState = ref.read(milestoneControllerProvider);
    final moodState = ref.read(moodJournalControllerProvider);

    if (pathState.isLoading) return;

    final distribution = _calculateMoodDistribution(moodState.entries);
    final streak = _calculateMoodStreak(moodState.entries);
    final history = milestoneState.allMilestones
        .where((m) => m.isSeen)
        .toList()
      ..sort((a, b) => (b.seenAt ?? DateTime.now()).compareTo(a.seenAt ?? DateTime.now()));

    state = state.copyWith(
      ncDays: pathState.ncDays,
      managedUrgeCount: pathState.managedUrgeCount,
      moodCount: pathState.moodCount, // Wait, I didn't add this to InsightsData, I'll add it or use streak
      moodStreak: streak,
      milestoneCount: history.length,
      letterCount: pathState.letterCount,
      milestoneHistory: history,
      moodDistribution: distribution,
      isLoading: false,
    );
  }

  Map<String, int> _calculateMoodDistribution(List<MoodEntry> entries) {
    final distribution = <String, int>{};
    // Last 14 days
    final cutoff = DateTime.now().subtract(const Duration(days: 14));
    
    for (final entry in entries) {
      if (entry.createdAt.isAfter(cutoff)) {
        distribution[entry.mood] = (distribution[entry.mood] ?? 0) + 1;
      }
    }
    return distribution;
  }

  int _calculateMoodStreak(List<MoodEntry> entries) {
    if (entries.isEmpty) return 0;
    
    // Sort by date descending
    final sorted = [...entries]..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    
    int streak = 0;
    DateTime? lastDate;
    
    // Check if the latest entry is today or yesterday
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final latestDate = DateTime(sorted[0].createdAt.year, sorted[0].createdAt.month, sorted[0].createdAt.day);
    
    if (latestDate.isBefore(today.subtract(const Duration(days: 1)))) {
      return 0; // Streak broken
    }

    for (final entry in sorted) {
      final entryDate = DateTime(entry.createdAt.year, entry.createdAt.month, entry.createdAt.day);
      if (lastDate == null) {
        streak = 1;
        lastDate = entryDate;
      } else {
        final diff = lastDate.difference(entryDate).inDays;
        if (diff == 1) {
          streak++;
          lastDate = entryDate;
        } else if (diff == 0) {
          continue; // Multiple entries same day, don't increment streak
        } else {
          break; // Streak broken
        }
      }
    }
    return streak;
  }
}

final insightsControllerProvider =
    StateNotifierProvider<InsightsController, InsightsData>((ref) {
  // Watch dependencies to trigger updates
  ref.watch(recoveryPathControllerProvider);
  ref.watch(milestoneControllerProvider);
  ref.watch(moodJournalControllerProvider);
  
  return InsightsController(ref);
});

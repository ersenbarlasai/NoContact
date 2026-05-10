import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nocontact/features/insights/presentation/insights_controller.dart';
import 'package:nocontact/features/insights/domain/insights_data.dart';
import 'package:nocontact/data/models/mood_entry.dart';
import 'package:nocontact/features/mood_journal/presentation/mood_journal_controller.dart';
import 'package:nocontact/features/recovery_path/presentation/recovery_path_controller.dart';
import 'package:nocontact/features/milestones/presentation/milestone_controller.dart';
import 'package:nocontact/features/milestones/domain/milestone.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('InsightsController Tests', () {
    test('calculateMoodStreak returns correct streak', () async {
      final now = DateTime.now();
      final container = ProviderContainer(
        overrides: [
          moodJournalControllerProvider.overrideWith((ref) => _MockMoodJournalController([
            MoodEntry(id: '1', date: now, mood: 'Ağır', intensity: 3, triggers: [], createdAt: now, updatedAt: now),
            MoodEntry(id: '2', date: now.subtract(const Duration(days: 1)), mood: 'Yumuşak', intensity: 2, triggers: [], createdAt: now.subtract(const Duration(days: 1)), updatedAt: now.subtract(const Duration(days: 1))),
            MoodEntry(id: '3', date: now.subtract(const Duration(days: 2)), mood: 'Donuk', intensity: 1, triggers: [], createdAt: now.subtract(const Duration(days: 2)), updatedAt: now.subtract(const Duration(days: 2))),
          ])),
          recoveryPathControllerProvider.overrideWith((ref) => _MockRecoveryPathController()),
          milestoneControllerProvider.overrideWith((ref) => _MockMilestoneController()),
        ],
      );

      // Wait for build
      await Future.delayed(Duration.zero);
      
      final streak = container.read(insightsControllerProvider).moodStreak;
      expect(streak, 3);
    });

    test('calculateMoodStreak returns 1 if yesterday missed but today entered', () async {
      final now = DateTime.now();
      final container = ProviderContainer(
        overrides: [
          moodJournalControllerProvider.overrideWith((ref) => _MockMoodJournalController([
            MoodEntry(id: '1', date: now, mood: 'Ağır', intensity: 3, triggers: [], createdAt: now, updatedAt: now),
            // Missed yesterday
            MoodEntry(id: '3', date: now.subtract(const Duration(days: 2)), mood: 'Donuk', intensity: 1, triggers: [], createdAt: now.subtract(const Duration(days: 2)), updatedAt: now.subtract(const Duration(days: 2))),
          ])),
          recoveryPathControllerProvider.overrideWith((ref) => _MockRecoveryPathController()),
          milestoneControllerProvider.overrideWith((ref) => _MockMilestoneController()),
        ],
      );

      await Future.delayed(Duration.zero);
      final streak = container.read(insightsControllerProvider).moodStreak;
      expect(streak, 1); 
    });
  });
}

class _MockMoodJournalController extends StateNotifier<MoodJournalState> implements MoodJournalController {
  _MockMoodJournalController(List<MoodEntry> entries) : super(MoodJournalState(entries: entries));
  
  @override
  Future<void> _init() async {}
  
  @override
  Future<void> saveTodayEntry() async {}
  
  @override
  void toggleTrigger(String trigger) {}
  
  @override
  void updateIntensity(int intensity) {}
  
  @override
  void updateMood(String mood) {}

  @override
  void updateNote(String note) {}

  @override
  void initTodayEntry() {}

  @override
  Future<void> loadEntries() async {}
}

class _MockRecoveryPathController extends StateNotifier<RecoveryPathState> implements RecoveryPathController {
  _MockRecoveryPathController() : super(const RecoveryPathState(ncDays: 10, managedUrgeCount: 5, letterCount: 2));
  
  @override
  Future<void> refreshPath() async {}
}

class _MockMilestoneController extends StateNotifier<MilestoneState> implements MilestoneController {
  _MockMilestoneController() : super(const MilestoneState(allMilestones: [
    Milestone(id: 'm1', title: 'T', message: 'M', triggerType: 'nc_3', isSeen: true)
  ]));

  @override
  Future<void> dismissMilestone() async {}

  @override
  void _checkNew() {}

  @override
  Future<void> _init() async {}
}

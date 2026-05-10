import 'package:flutter_test/flutter_test.dart';
import 'package:nocontact/data/models/mood_entry.dart';
import 'package:nocontact/data/repositories/local_mood_journal_repository.dart';
import 'package:nocontact/features/mood_journal/presentation/mood_journal_controller.dart';
import 'package:nocontact/core/storage/local_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Mood Journal Logic & Encryption Tests', () {
    late LocalMoodJournalRepository repository;
    final Map<String, String> mockSecureStorage = {};

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await LocalStorageService.init();
      repository = LocalMoodJournalRepository();
      mockSecureStorage.clear();

      // Mock FlutterSecureStorage Platform Channel
      const MethodChannel('plugins.it_nomads.com/flutter_secure_storage')
          .setMockMethodCallHandler((MethodCall methodCall) async {
        switch (methodCall.method) {
          case 'write':
            mockSecureStorage[methodCall.arguments['key'] as String] = methodCall.arguments['value'] as String;
            return null;
          case 'read':
            return mockSecureStorage[methodCall.arguments['key'] as String];
          case 'delete':
            mockSecureStorage.remove(methodCall.arguments['key'] as String);
            return null;
          case 'deleteAll':
            mockSecureStorage.clear();
            return null;
          default:
            return null;
        }
      });
    });

    test('upsertMoodEntry prevents same-day duplicates', () async {
      final now = DateTime.now();
      final entry1 = MoodEntry(
        id: '1',
        date: now,
        mood: 'Mutlu',
        intensity: 4,
        createdAt: now,
        updatedAt: now,
      );

      final entry2 = MoodEntry(
        id: '2',
        date: now, // Same day
        mood: 'Üzgün',
        intensity: 2,
        createdAt: now,
        updatedAt: now,
      );

      await repository.upsertMoodEntry(entry1);
      await repository.upsertMoodEntry(entry2);

      final entries = await repository.fetchMoodEntries();
      expect(entries.length, 1);
      expect(entries.first.mood, 'Üzgün'); // Should be updated
    });

    test('Migration: plain shared_prefs data moves to encrypted storage', () async {
      final now = DateTime.now();
      final plainEntries = [
        MoodEntry(id: 'old_1', date: now, mood: 'Eski', createdAt: now, updatedAt: now).toJson(),
      ];
      
      // 1. Manually put data into plain shared_prefs
      await LocalStorageService.setJsonList('mood_entries', plainEntries);
      
      // 2. Fetch via repository (should trigger migration)
      final entries = await repository.fetchMoodEntries();
      
      // 3. Verify data moved to secure storage
      expect(entries.length, 1);
      expect(entries.first.id, 'old_1');
      expect(mockSecureStorage.containsKey('encrypted_mood_entries'), isTrue);
      
      // 4. Verify old key is removed
      expect(LocalStorageService.getJsonList('mood_entries'), isNull);
    });

    test('Streak calculation: active streak when entry exists today', () {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final yesterday = today.subtract(const Duration(days: 1));
      final dayBefore = today.subtract(const Duration(days: 2));

      final state = MoodJournalState(entries: [
        MoodEntry(id: '1', date: today, mood: 'A', createdAt: now, updatedAt: now),
        MoodEntry(id: '2', date: yesterday, mood: 'B', createdAt: now, updatedAt: now),
        MoodEntry(id: '3', date: dayBefore, mood: 'C', createdAt: now, updatedAt: now),
      ]);

      expect(state.currentStreak, 3);
    });

    test('last7Days includes today and 6 previous days correctly', () {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      
      final entries = List.generate(10, (index) {
        final date = today.subtract(Duration(days: index));
        return MoodEntry(
          id: '$index',
          date: date,
          mood: 'Mood $index',
          createdAt: now,
          updatedAt: now,
        );
      });

      final state = MoodJournalState(entries: entries);
      expect(state.last7Days.length, 7);
      expect(state.last7Days.first.id, '0'); // Today
      expect(state.last7Days.last.id, '6'); // 6 days ago
    });
  });
}

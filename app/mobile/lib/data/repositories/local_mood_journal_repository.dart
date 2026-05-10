import 'dart:convert';
import '../../core/storage/local_storage_service.dart';
import '../../core/storage/encrypted_storage_service.dart';
import '../models/mood_entry.dart';

class LocalMoodJournalRepository {
  static const String _oldMoodEntriesKey = 'mood_entries';
  static const String _encryptedMoodEntriesKey = 'encrypted_mood_entries';

  Future<List<MoodEntry>> fetchMoodEntries() async {
    // 1. Try to migrate if old data exists
    await _migrateIfNeeded();

    // 2. Read from encrypted storage
    final jsonList = await EncryptedStorageService.getJsonList(_encryptedMoodEntriesKey);
    if (jsonList != null) {
      return jsonList.map((e) => MoodEntry.fromJson(e as Map<String, dynamic>)).toList();
    }
    return [];
  }

  Future<void> _migrateIfNeeded() async {
    // Check if plain shared_prefs has data
    final plainJsonList = LocalStorageService.getJsonList(_oldMoodEntriesKey);
    if (plainJsonList != null && plainJsonList.isNotEmpty) {
      // Check if encrypted storage is already populated
      final encryptedJsonList = await EncryptedStorageService.getJsonList(_encryptedMoodEntriesKey);
      
      if (encryptedJsonList == null || encryptedJsonList.isEmpty) {
        // Perform migration
        await EncryptedStorageService.setJsonList(_encryptedMoodEntriesKey, plainJsonList);
      }
      
      // Always remove old plain data after migration attempt (idempotent)
      await LocalStorageService.remove(_oldMoodEntriesKey);
    }
  }

  Future<MoodEntry?> fetchTodayMoodEntry() async {
    final entries = await fetchMoodEntries();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    
    try {
      return entries.firstWhere(
        (e) {
          final entryDate = DateTime(e.date.year, e.date.month, e.date.day);
          return entryDate == today;
        },
      );
    } catch (e) {
      return null;
    }
  }

  Future<void> upsertMoodEntry(MoodEntry entry) async {
    final entries = await fetchMoodEntries();
    final entryDate = DateTime(entry.date.year, entry.date.month, entry.date.day);

    // Prioritize date-based matching to ensure only one entry per calendar day
    int index = entries.indexWhere((e) {
      final eDate = DateTime(e.date.year, e.date.month, e.date.day);
      return eDate == entryDate;
    });

    // If not found by date, fallback to id matching
    if (index == -1) {
      index = entries.indexWhere((e) => e.id == entry.id);
    }

    if (index >= 0) {
      entries[index] = entry;
    } else {
      entries.add(entry);
    }

    await EncryptedStorageService.setJsonList(_encryptedMoodEntriesKey, entries.map((e) => e.toJson()).toList());
  }

  Future<void> deleteMoodEntry(String id) async {
    final entries = await fetchMoodEntries();
    entries.removeWhere((e) => e.id == id);
    await EncryptedStorageService.setJsonList(_encryptedMoodEntriesKey, entries.map((e) => e.toJson()).toList());
  }

  Future<void> clearMoodEntries() async {
    await EncryptedStorageService.delete(_encryptedMoodEntriesKey);
    // Also ensure old key is gone
    await LocalStorageService.remove(_oldMoodEntriesKey);
  }
}

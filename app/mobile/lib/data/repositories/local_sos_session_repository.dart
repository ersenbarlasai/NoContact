import '../../core/storage/local_storage_service.dart';

class LocalSosSessionRepository {
  static const String _managedUrgesKey = 'managed_urges_count';
  static const String _lastSosCompletedAtKey = 'last_sos_completed_at';

  Future<void> incrementManagedUrgeCount() async {
    final current = await fetchManagedUrgeCount();
    await LocalStorageService.setInt(_managedUrgesKey, current + 1);
  }

  Future<int> fetchManagedUrgeCount() async {
    return LocalStorageService.getInt(_managedUrgesKey) ?? 0;
  }

  Future<void> saveLastSosCompletedAt(DateTime timestamp) async {
    await LocalStorageService.setString(_lastSosCompletedAtKey, timestamp.toIso8601String());
  }

  Future<DateTime?> fetchLastSosCompletedAt() async {
    final value = LocalStorageService.getString(_lastSosCompletedAtKey);
    if (value != null) {
      return DateTime.tryParse(value);
    }
    return null;
  }

  Future<void> clearStats() async {
    await LocalStorageService.remove(_managedUrgesKey);
    await LocalStorageService.remove(_lastSosCompletedAtKey);
  }
}

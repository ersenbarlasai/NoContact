import '../../../core/storage/local_storage_service.dart';
import '../domain/entitlement_state.dart';

class EntitlementRepository {
  static const String _usageKey = 'ai_usage_daily';
  static const String _tierKey = 'subscription_tier';

  Future<EntitlementState> fetchEntitlement() async {
    final tierStr = LocalStorageService.getString(_tierKey) ?? 'free';
    final tier = tierStr == 'premium' ? SubscriptionTier.premium : SubscriptionTier.free;
    
    final usageJson = LocalStorageService.getJson(_usageKey);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    int usedToday = 0;
    DateTime lastReset = today;

    if (usageJson != null) {
      final dateStr = usageJson['date'] as String?;
      if (dateStr != null) {
        final storedDate = DateTime.parse(dateStr);
        final storedDay = DateTime(storedDate.year, storedDate.month, storedDate.day);
        
        if (storedDay.isAtSameMomentAs(today)) {
          usedToday = usageJson['messageAnalysisUsedCount'] as int? ?? 0;
          lastReset = storedDay;
        } else {
          // New day, reset count
          await _saveUsage(0, today);
          lastReset = today;
        }
      }
    } else {
      await _saveUsage(0, today);
    }

    return EntitlementState(
      tier: tier,
      messageAnalysisDailyLimit: tier == SubscriptionTier.premium ? 50 : 3,
      messageAnalysisUsedToday: usedToday,
      lastResetDate: lastReset,
    );
  }

  Future<void> setMockTier(SubscriptionTier tier) async {
    await LocalStorageService.setString(_tierKey, tier.name);
  }

  Future<void> incrementMessageAnalysisUsage() async {
    final current = await fetchEntitlement();
    await _saveUsage(current.messageAnalysisUsedToday + 1, current.lastResetDate);
  }

  Future<void> _saveUsage(int count, DateTime date) async {
    await LocalStorageService.setJson(_usageKey, {
      'date': date.toIso8601String(),
      'messageAnalysisUsedCount': count,
    });
  }

  Future<void> clearUsage() async {
    await LocalStorageService.remove(_usageKey);
  }
}

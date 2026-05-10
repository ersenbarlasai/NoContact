import 'package:flutter_test/flutter_test.dart';
import 'package:nocontact/features/subscription/domain/entitlement_state.dart';
import 'package:nocontact/features/subscription/data/entitlement_repository.dart';
import 'package:nocontact/core/storage/local_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Entitlement Logic Tests', () {
    late EntitlementRepository repository;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await LocalStorageService.init();
      repository = EntitlementRepository();
    });

    test('Free tier starts with 3 analyses limit', () async {
      final state = await repository.fetchEntitlement();
      expect(state.tier, SubscriptionTier.free);
      expect(state.messageAnalysisDailyLimit, 3);
      expect(state.messageAnalysisUsedToday, 0);
      expect(state.canUseMessageAnalysis, true);
    });

    test('Usage increments correctly', () async {
      await repository.incrementMessageAnalysisUsage();
      var state = await repository.fetchEntitlement();
      expect(state.messageAnalysisUsedToday, 1);
      expect(state.remainingMessageAnalyses, 2);

      await repository.incrementMessageAnalysisUsage();
      await repository.incrementMessageAnalysisUsage();
      state = await repository.fetchEntitlement();
      expect(state.messageAnalysisUsedToday, 3);
      expect(state.canUseMessageAnalysis, false);
      expect(state.remainingMessageAnalyses, 0);
    });

    test('Premium tier has higher limit (50)', () async {
      await repository.setMockTier(SubscriptionTier.premium);
      final state = await repository.fetchEntitlement();
      expect(state.tier, SubscriptionTier.premium);
      expect(state.messageAnalysisDailyLimit, 50);
    });

    test('Usage resets on next calendar day', () async {
      // Set usage for "yesterday"
      final yesterday = DateTime.now().subtract(const Duration(days: 1));
      await LocalStorageService.setJson('ai_usage_daily', {
        'date': yesterday.toIso8601String(),
        'messageAnalysisUsedCount': 3,
      });

      final state = await repository.fetchEntitlement();
      expect(state.messageAnalysisUsedToday, 0, reason: 'Usage should reset for a new day');
      expect(state.canUseMessageAnalysis, true);
    });
  });
}

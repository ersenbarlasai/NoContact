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

    test('Default tier is free', () async {
      final state = await repository.fetchEntitlement();
      expect(state.tier, SubscriptionTier.free);
      expect(state.isPremium, false);
    });

    test('setMockTier switches to premium', () async {
      await repository.setMockTier(SubscriptionTier.premium);
      final state = await repository.fetchEntitlement();
      expect(state.tier, SubscriptionTier.premium);
      expect(state.isPremium, true);
    });

    test('setMockTier can revert to free', () async {
      await repository.setMockTier(SubscriptionTier.premium);
      await repository.setMockTier(SubscriptionTier.free);
      final state = await repository.fetchEntitlement();
      expect(state.tier, SubscriptionTier.free);
    });
  });
}

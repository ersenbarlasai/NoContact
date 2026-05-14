import '../../../core/storage/local_storage_service.dart';
import '../domain/entitlement_state.dart';

class EntitlementRepository {
  static const String _tierKey = 'subscription_tier';

  Future<EntitlementState> fetchEntitlement() async {
    final tierStr = LocalStorageService.getString(_tierKey) ?? 'free';
    final tier = tierStr == 'premium' ? SubscriptionTier.premium : SubscriptionTier.free;
    return EntitlementState(tier: tier);
  }

  Future<void> setMockTier(SubscriptionTier tier) async {
    await LocalStorageService.setString(_tierKey, tier.name);
  }
}

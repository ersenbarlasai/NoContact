import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/entitlement_state.dart';
import '../data/entitlement_repository.dart';

final entitlementRepositoryProvider = Provider((ref) => EntitlementRepository());

class EntitlementController extends StateNotifier<EntitlementState> {
  final EntitlementRepository _repository;

  EntitlementController(this._repository) : super(EntitlementState.initial()) {
    refresh();
  }

  Future<void> refresh() async {
    state = await _repository.fetchEntitlement();
  }

  /// DEV ONLY — toggles mock premium tier for testing. Not shown in production UI.
  Future<void> toggleMockTier() async {
    final newTier = state.tier == SubscriptionTier.free
        ? SubscriptionTier.premium
        : SubscriptionTier.free;
    await _repository.setMockTier(newTier);
    await refresh();
  }
}

final entitlementControllerProvider =
    StateNotifierProvider<EntitlementController, EntitlementState>((ref) {
  final repository = ref.watch(entitlementRepositoryProvider);
  return EntitlementController(repository);
});

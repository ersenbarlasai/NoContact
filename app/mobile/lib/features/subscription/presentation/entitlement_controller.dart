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

  Future<void> incrementUsage() async {
    await _repository.incrementMessageAnalysisUsage();
    await refresh();
  }

  Future<void> toggleMockTier() async {
    final newTier = state.tier == SubscriptionTier.free 
        ? SubscriptionTier.premium 
        : SubscriptionTier.free;
    await _repository.setMockTier(newTier);
    await refresh();
  }

  String get usageStatusText {
    if (state.tier == SubscriptionTier.premium) {
      return 'Premium Plan: ${state.remainingMessageAnalyses} analiz hakkın kaldı.';
    }
    return 'Ücretsiz Plan: Bugün ${state.remainingMessageAnalyses} analiz hakkın kaldı.';
  }
}

final entitlementControllerProvider = StateNotifierProvider<EntitlementController, EntitlementState>((ref) {
  final repository = ref.watch(entitlementRepositoryProvider);
  return EntitlementController(repository);
});

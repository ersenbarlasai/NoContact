import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/sos_session.dart';
import '../../../data/repositories/providers.dart';
import '../../onboarding/presentation/onboarding_controller.dart';

class SosController extends StateNotifier<SosSession> {
  final Ref _ref;

  SosController(this._ref) : super(const SosSession());

  void startSession() {
    final profile = _ref.read(onboardingControllerProvider);
    state = state.copyWith(
      startedAt: DateTime.now(),
      dominantEmotion: profile.dominantEmotion,
      strongestTrigger: profile.contactTriggers.isNotEmpty ? profile.contactTriggers.first : null,
    );
  }

  void updateUrgeText(String text) {
    state = state.copyWith(urgeText: text);
  }

  void setOutcome(String outcome) {
    state = state.copyWith(
      selectedOutcome: outcome,
      completedAt: outcome == 'maintained_nc' ? DateTime.now() : null,
    );
  }

  void toggleGroundingAction(String action) {
    state = state.copyWith(
      neededExtraSupport: true,
    );
  }

  Future<void> finishSession() async {
    final now = DateTime.now();
    state = state.copyWith(completedAt: now);
    
    // 1. Update Local Stats
    if (state.selectedOutcome == 'maintained_nc') {
      final localSosRepo = _ref.read(localSosSessionRepositoryProvider);
      await localSosRepo.incrementManagedUrgeCount();
      await localSosRepo.saveLastSosCompletedAt(now);
    }

    // 2. Persist to Supabase
    final sosRepo = _ref.read(sosSessionRepositoryProvider);
    try {
      await sosRepo.saveSosSession(state);
    } catch (e) {
      // Offline - local stats are already updated
    }
  }

  void reset() {
    state = const SosSession();
  }
}

final sosControllerProvider = StateNotifierProvider<SosController, SosSession>((ref) {
  return SosController(ref);
});

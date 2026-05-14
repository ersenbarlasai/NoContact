import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/recovery_profile.dart';
import '../../../data/repositories/providers.dart';

class OnboardingController extends StateNotifier<RecoveryProfile> {
  final Ref _ref;

  OnboardingController(this._ref) : super(const RecoveryProfile());

  void updateName(String name) {
    state = state.copyWith(name: name);
  }

  void updateReason(String reason) {
    state = state.copyWith(reason: reason);
  }

  void updateRelationshipDuration(String duration) {
    state = state.copyWith(relationshipDuration: duration);
  }

  void updateTimeSinceBreakup(String time) {
    state = state.copyWith(timeSinceBreakup: time);
  }

  void updateWhoEnded(String who) {
    state = state.copyWith(whoEnded: who);
  }

  void updateNoContactStartDate(DateTime date) {
    state = state.copyWith(noContactStartDate: date);
  }

  void updateDominantEmotion(String emotion) {
    state = state.copyWith(dominantEmotion: emotion);
  }

  void toggleContactTrigger(String trigger) {
    final currentTriggers = List<String>.from(state.contactTriggers);
    if (currentTriggers.contains(trigger)) {
      currentTriggers.remove(trigger);
    } else {
      currentTriggers.add(trigger);
    }
    state = state.copyWith(contactTriggers: currentTriggers);
  }

  void commitToContract() {
    state = state.copyWith(
      commitmentAcceptedAt: DateTime.now(),
    );
  }
  Future<void> completeOnboarding() async {
    state = state.copyWith(
      isOnboardingCompleted: true,
      noContactStartDate: state.noContactStartDate ?? DateTime.now(),
    );

    // 1. Save Locally first (Guaranteed to work if storage initialized)
    final localRepo = _ref.read(localRecoveryProfileRepositoryProvider);
    await localRepo.saveProfile(state);

    // 2. Persist to Supabase if available
    final authRepo = _ref.read(authRepositoryProvider);
    final remoteRepo = _ref.read(recoveryProfileRepositoryProvider);

    try {
      if (!authRepo.isAuthenticated) {
        await authRepo.signInAnonymously();
      }
      
      if (authRepo.isAuthenticated) {
        await remoteRepo.upsertRecoveryProfile(state);
      }
    } catch (e) {
      // Offline or Supabase error - local persistence is already done
    }
  }

  Future<void> acceptAiConsent() async {
    state = state.copyWith(aiConsentAccepted: true);
    
    // Save locally
    final localRepo = _ref.read(localRecoveryProfileRepositoryProvider);
    await localRepo.saveProfile(state);

    // Persist remotely if possible
    final authRepo = _ref.read(authRepositoryProvider);
    if (authRepo.isAuthenticated) {
      try {
        final remoteRepo = _ref.read(recoveryProfileRepositoryProvider);
        await remoteRepo.upsertRecoveryProfile(state);
      } catch (_) {}
    }
  }

  void hydrate(RecoveryProfile profile) {
    state = profile;
  }
}

final onboardingControllerProvider =
    StateNotifierProvider<OnboardingController, RecoveryProfile>((ref) {
  return OnboardingController(ref);
});

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/repositories/providers.dart';
import '../../features/onboarding/presentation/onboarding_controller.dart';
import '../../../core/services/supabase_service.dart';

enum AppStartupStatus {
  loading,
  needsOnboarding,
  ready,
  offlineLocalOnly,
}

class AppStartupState {
  final AppStartupStatus status;
  final String? error;

  AppStartupState({required this.status, this.error});
}

class AppStartupController extends StateNotifier<AppStartupState> {
  final Ref _ref;

  AppStartupController(this._ref) : super(AppStartupState(status: AppStartupStatus.loading)) {
    _init();
  }

  Future<void> _init() async {
    state = AppStartupState(status: AppStartupStatus.loading);

    final authRepo = _ref.read(authRepositoryProvider);
    final remoteProfileRepo = _ref.read(recoveryProfileRepositoryProvider);
    final localProfileRepo = _ref.read(localRecoveryProfileRepositoryProvider);

    // 1. Try Remote First if configured and authenticated
    if (SupabaseService.isInitialized && authRepo.isAuthenticated) {
      try {
        final profile = await remoteProfileRepo.fetchRecoveryProfile();
        if (profile != null && profile.isOnboardingCompleted) {
          _ref.read(onboardingControllerProvider.notifier).hydrate(profile);
          state = AppStartupState(status: AppStartupStatus.ready);
          return;
        }
      } catch (e) {
        // Continue to local fallback
      }
    }

    // 2. Fallback to Local Storage
    try {
      final localProfile = await localProfileRepo.fetchProfile();
      if (localProfile != null && localProfile.isOnboardingCompleted) {
        _ref.read(onboardingControllerProvider.notifier).hydrate(localProfile);
        state = AppStartupState(
          status: SupabaseService.isInitialized 
              ? AppStartupStatus.ready 
              : AppStartupStatus.offlineLocalOnly
        );
      } else {
        state = AppStartupState(status: AppStartupStatus.needsOnboarding);
      }
    } catch (e) {
      state = AppStartupState(status: AppStartupStatus.needsOnboarding);
    }
  }

  void retry() => _init();
}

final appStartupProvider = StateNotifierProvider<AppStartupController, AppStartupState>((ref) {
  return AppStartupController(ref);
});

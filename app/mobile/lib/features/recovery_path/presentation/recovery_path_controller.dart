import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../data/repositories/providers.dart';
import '../../onboarding/presentation/onboarding_controller.dart';
import '../../mood_journal/presentation/mood_journal_controller.dart';
import '../../letters_vault/presentation/letters_vault_controller.dart';
import '../domain/recovery_path_step.dart';
import '../application/recovery_path_builder.dart';

part 'recovery_path_controller.freezed.dart';

@freezed
class RecoveryPathState with _$RecoveryPathState {
  const factory RecoveryPathState({
    @Default([]) List<RecoveryPathStep> steps,
    @Default(0) int ncDays,
    @Default(0) int moodCount,
    @Default(0) int letterCount,
    @Default(0) int managedUrgeCount,
    @Default(false) bool isLoading,
  }) = _RecoveryPathState;

  const RecoveryPathState._();

  RecoveryPathStep? get activeStep {
    // Return the first non-completed step
    for (final step in steps) {
      if (step.status != StepStatus.completed) return step;
    }
    return null;
  }

  int get completedCount => steps.where((s) => s.status == StepStatus.completed).length;
  double get progressPercent => steps.isEmpty ? 0 : (ncDays / 30).clamp(0.0, 1.0);
}

class RecoveryPathController extends StateNotifier<RecoveryPathState> {
  final Ref _ref;

  RecoveryPathController(this._ref) : super(const RecoveryPathState()) {
    refreshPath();
  }

  Future<void> refreshPath() async {
    state = state.copyWith(isLoading: true);

    final profile = _ref.read(onboardingControllerProvider);
    final moodState = _ref.read(moodJournalControllerProvider);
    final lettersState = _ref.read(lettersVaultControllerProvider);
    final sosRepo = _ref.read(localSosSessionRepositoryProvider);

    final managedUrgeCount = await sosRepo.fetchManagedUrgeCount();
    
    final startDate = profile.noContactStartDate ?? DateTime.now();
    final ncDays = DateTime.now().difference(startDate).inDays;

    final steps = RecoveryPathBuilder.buildPath(
      noContactStartDate: startDate,
      moodEntryCount: moodState.entries.length,
      hasMoodEntryToday: moodState.todayEntry != null && moodState.todayEntry!.mood.isNotEmpty,
      letterCount: lettersState.letters.length,
      managedUrgeCount: managedUrgeCount,
    );

    state = state.copyWith(
      steps: steps,
      ncDays: ncDays,
      moodCount: moodState.entries.length,
      letterCount: lettersState.letters.length,
      managedUrgeCount: managedUrgeCount,
      isLoading: false,
    );
  }
}

final recoveryPathControllerProvider =
    StateNotifierProvider<RecoveryPathController, RecoveryPathState>((ref) {
  // Watch relevant providers to trigger refresh
  ref.watch(onboardingControllerProvider);
  ref.watch(moodJournalControllerProvider);
  ref.watch(lettersVaultControllerProvider);
  
  return RecoveryPathController(ref);
});

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../data/models/unsent_letter.dart';
import '../../../data/repositories/providers.dart';
import '../../letters_vault/presentation/letters_vault_controller.dart';
import '../../daily_rhythm/presentation/rhythm_controller.dart';
import '../../../core/notifications/notification_service.dart';
import '../domain/silent_reply_need.dart';

class SilentReplyState {
  final String draftText;
  final SilentReplyNeed? selectedNeed;
  final int currentStep;
  final bool isSaving;
  final String? error;

  SilentReplyState({
    this.draftText = '',
    this.selectedNeed,
    this.currentStep = 0,
    this.isSaving = false,
    this.error,
  });

  SilentReplyState copyWith({
    String? draftText,
    SilentReplyNeed? selectedNeed,
    int? currentStep,
    bool? isSaving,
    String? error,
  }) {
    return SilentReplyState(
      draftText: draftText ?? this.draftText,
      selectedNeed: selectedNeed ?? this.selectedNeed,
      currentStep: currentStep ?? this.currentStep,
      isSaving: isSaving ?? this.isSaving,
      error: error ?? this.error,
    );
  }
}

class SilentReplyController extends Notifier<SilentReplyState> {
  @override
  SilentReplyState build() {
    return SilentReplyState();
  }

  void updateDraftText(String text) {
    state = state.copyWith(draftText: text, error: null);
  }

  void selectNeed(SilentReplyNeed need) {
    state = state.copyWith(selectedNeed: need, error: null);
  }

  void nextStep() {
    if (state.currentStep == 0 && state.draftText.trim().isEmpty) {
      state = state.copyWith(error: 'Lütfen bir şeyler yazın.');
      return;
    }
    if (state.currentStep == 1 && state.selectedNeed == null) {
      state = state.copyWith(error: 'Lütfen bir ihtiyaç seçin.');
      return;
    }
    state = state.copyWith(currentStep: state.currentStep + 1, error: null);
  }

  void previousStep() {
    if (state.currentStep > 0) {
      state = state.copyWith(currentStep: state.currentStep - 1, error: null);
    }
  }

  Future<bool> saveToVault() async {
    state = state.copyWith(isSaving: true, error: null);
    try {
      final letter = UnsentLetter(
        id: const Uuid().v4(),
        title: 'Sessiz Cevap',
        body: state.draftText,
        emotion: state.selectedNeed?.label ?? 'Sessiz Cevap',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await ref.read(lettersVaultControllerProvider.notifier).saveLetter(letter);
      await ref.read(localManagedUrgeRepositoryProvider).saveEvent('silent_reply_vault');
      ref.invalidate(managedUrgeCountProvider);

      // Bağlamsal sessiz cevap takip bildirimini planla.
      final rhythmSettings = ref.read(rhythmControllerProvider);
      if (rhythmSettings.isEnabled && rhythmSettings.contextualEnabled) {
        await NotificationService.scheduleSilentReplyFollowUp();
      }

      state = state.copyWith(isSaving: false);
      return true;
    } catch (e) {
      state = state.copyWith(isSaving: false, error: 'Kaydedilirken bir hata oluştu.');
      return false;
    }
  }

  void reset() {
    state = SilentReplyState();
  }
}

final silentReplyControllerProvider = NotifierProvider<SilentReplyController, SilentReplyState>(() {
  return SilentReplyController();
});

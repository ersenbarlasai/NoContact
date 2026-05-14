import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../subscription/presentation/entitlement_controller.dart';
import '../../onboarding/presentation/onboarding_controller.dart';
import '../../../data/repositories/providers.dart';
import '../domain/message_analysis_result.dart';

class MessageAnalysisState {
  final String inputText;
  final bool isAnalyzing;
  final MessageAnalysisResult? result;
  final String? error;
  final bool needsConsent;

  MessageAnalysisState({
    this.inputText = '',
    this.isAnalyzing = false,
    this.result,
    this.error,
    this.needsConsent = false,
  });

  MessageAnalysisState copyWith({
    String? inputText,
    bool? isAnalyzing,
    MessageAnalysisResult? result,
    String? error,
    bool? needsConsent,
    bool clearResult = false,
  }) {
    return MessageAnalysisState(
      inputText: inputText ?? this.inputText,
      isAnalyzing: isAnalyzing ?? this.isAnalyzing,
      result: clearResult ? null : (result ?? this.result),
      error: error ?? this.error,
      needsConsent: needsConsent ?? this.needsConsent,
    );
  }
}

class MessageAnalysisController extends StateNotifier<MessageAnalysisState> {
  final Ref _ref;
  MessageAnalysisController(this._ref) : super(MessageAnalysisState()) {
    _checkConsent();
  }

  void _checkConsent() {
    final profile = _ref.read(onboardingControllerProvider);
    if (!profile.aiConsentAccepted) {
      state = state.copyWith(needsConsent: true);
    }
  }

  Future<void> acceptConsent() async {
    await _ref.read(onboardingControllerProvider.notifier).acceptAiConsent();
    state = state.copyWith(needsConsent: false);
  }

  void updateInput(String text) {
    state = state.copyWith(inputText: text, error: null);
  }

  Future<void> analyze() async {
    final input = state.inputText.trim();
    if (input.isEmpty) {
      state = state.copyWith(error: 'Lütfen bir mesaj girin.');
      return;
    }

    if (state.needsConsent) {
      state = state.copyWith(error: 'Analiz için önce veri izni vermelisin.');
      return;
    }

    state = state.copyWith(isAnalyzing: true, error: null, clearResult: true);

    try {
      final repo = _ref.read(messageAnalysisRepositoryProvider);
      final result = await repo.analyzeMessage(input);
      
      state = state.copyWith(isAnalyzing: false, result: result);
      
      // Local usage increment (optional, server handles it now but useful for UI state)
      await _ref.read(entitlementControllerProvider.notifier).incrementUsage();
    } catch (e) {
      state = state.copyWith(
        isAnalyzing: false, 
        error: e.toString().replaceFirst('Exception: ', ''),
      );
    }
  }

  void clear() {
    state = MessageAnalysisState(needsConsent: !_ref.read(onboardingControllerProvider).aiConsentAccepted);
  }

  void resetResult() {
    state = state.copyWith(clearResult: true);
  }
}

final messageAnalysisControllerProvider =
    StateNotifierProvider<MessageAnalysisController, MessageAnalysisState>((ref) {
  return MessageAnalysisController(ref);
});

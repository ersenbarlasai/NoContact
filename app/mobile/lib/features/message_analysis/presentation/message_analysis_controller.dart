import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../subscription/presentation/entitlement_controller.dart';
import '../domain/message_analysis_result.dart';
import '../application/mock_message_analyzer.dart';

class MessageAnalysisState {
  final String inputText;
  final bool isAnalyzing;
  final MessageAnalysisResult? result;
  final String? error;

  MessageAnalysisState({
    this.inputText = '',
    this.isAnalyzing = false,
    this.result,
    this.error,
  });

  MessageAnalysisState copyWith({
    String? inputText,
    bool? isAnalyzing,
    MessageAnalysisResult? result,
    String? error,
    bool clearResult = false,
  }) {
    return MessageAnalysisState(
      inputText: inputText ?? this.inputText,
      isAnalyzing: isAnalyzing ?? this.isAnalyzing,
      result: clearResult ? null : (result ?? this.result),
      error: error ?? this.error,
    );
  }
}


class MessageAnalysisController extends StateNotifier<MessageAnalysisState> {
  final Ref _ref;
  MessageAnalysisController(this._ref) : super(MessageAnalysisState());

  void updateInput(String text) {
    state = state.copyWith(inputText: text, error: null);
  }

  Future<void> analyze() async {
    final input = state.inputText.trim();
    if (input.isEmpty) {
      state = state.copyWith(error: 'Lütfen bir mesaj girin.');
      return;
    }

    final entitlement = _ref.read(entitlementControllerProvider);
    if (!entitlement.canUseMessageAnalysis) {
      state = state.copyWith(
        error: 'Günlük limitine ulaştın. Gerçek AI analizi yayınlandığında daha yüksek limitler Premium’da olacak.',
      );
      return;
    }

    state = state.copyWith(isAnalyzing: true, error: null, clearResult: true);

    try {
      final result = await MockMessageAnalyzer.analyze(input);
      state = state.copyWith(isAnalyzing: false, result: result);
      // Increment usage after successful analysis
      await _ref.read(entitlementControllerProvider.notifier).incrementUsage();
    } catch (e) {
      state = state.copyWith(isAnalyzing: false, error: 'Analiz sırasında bir hata oluştu.');
    }
  }

  void clear() {
    state = MessageAnalysisState();
  }

  void resetResult() {
    state = state.copyWith(clearResult: true);
  }
}

final messageAnalysisControllerProvider =
    StateNotifierProvider<MessageAnalysisController, MessageAnalysisState>((ref) {
  return MessageAnalysisController(ref);
});

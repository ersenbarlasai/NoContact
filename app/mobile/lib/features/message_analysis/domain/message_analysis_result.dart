import 'message_analysis_types.dart';

class MessageAnalysisResult {
  final String toneLabel;
  final RiskLevel riskLevel;
  final List<String> manipulationSignals;
  final RecommendedAction recommendedAction;
  final String summary;
  final String? suggestedReply;
  final String groundingReminder;
  final DateTime createdAt;

  MessageAnalysisResult({
    required this.toneLabel,
    required this.riskLevel,
    required this.manipulationSignals,
    required this.recommendedAction,
    required this.summary,
    this.suggestedReply,
    required this.groundingReminder,
    required this.createdAt,
  });

  factory MessageAnalysisResult.mock({
    required String toneLabel,
    required RiskLevel riskLevel,
    required List<String> manipulationSignals,
    required RecommendedAction recommendedAction,
    required String summary,
    String? suggestedReply,
    required String groundingReminder,
  }) {
    return MessageAnalysisResult(
      toneLabel: toneLabel,
      riskLevel: riskLevel,
      manipulationSignals: manipulationSignals,
      recommendedAction: recommendedAction,
      summary: summary,
      suggestedReply: suggestedReply,
      groundingReminder: groundingReminder,
      createdAt: DateTime.now(),
    );
  }
}

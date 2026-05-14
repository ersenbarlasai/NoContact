import 'message_analysis_types.dart';

class MessageAnalysisResult {
  final RiskLevel riskLevel;
  final List<String> detectedPatterns;
  final String emotionalTone;
  final List<String> manipulationSignals;
  final String boundaryRecommendation;
  final RecommendedAction recommendedAction;
  final String shortSummary;
  final String userFacingExplanation;
  final String? safeReplyExample;
  final AnalysisConfidence confidence;
  final String disclaimer;
  final DateTime createdAt;

  MessageAnalysisResult({
    required this.riskLevel,
    required this.detectedPatterns,
    required this.emotionalTone,
    required this.manipulationSignals,
    required this.boundaryRecommendation,
    required this.recommendedAction,
    required this.shortSummary,
    required this.userFacingExplanation,
    this.safeReplyExample,
    required this.confidence,
    required this.disclaimer,
    required this.createdAt,
  });

  factory MessageAnalysisResult.fromJson(Map<String, dynamic> json) {
    return MessageAnalysisResult(
      riskLevel: RiskLevel.values.byName(json['risk_level'] as String),
      detectedPatterns: List<String>.from(json['detected_patterns'] as Iterable),
      emotionalTone: json['emotional_tone'] as String,
      manipulationSignals: List<String>.from(json['manipulation_or_pressure_signals'] as Iterable),
      boundaryRecommendation: json['boundary_recommendation'] as String,
      recommendedAction: _parseAction(json['suggested_next_step'] as String),
      shortSummary: json['short_summary'] as String,
      userFacingExplanation: json['user_facing_explanation'] as String,
      safeReplyExample: json['safe_reply_example'] as String?,
      confidence: AnalysisConfidence.values.byName(json['confidence'] as String),
      disclaimer: json['disclaimer'] as String,
      createdAt: DateTime.now(),
    );
  }

  static RecommendedAction _parseAction(String action) {
    switch (action) {
      case 'wait': return RecommendedAction.wait;
      case 'do_not_reply': return RecommendedAction.doNotReply;
      case 'reply_with_boundary': return RecommendedAction.replyWithBoundary;
      case 'use_sos': return RecommendedAction.useSos;
      case 'write_unsent_letter': return RecommendedAction.writeUnsentLetter;
      default: return RecommendedAction.wait;
    }
  }
}

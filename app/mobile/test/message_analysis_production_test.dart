import 'package:flutter_test/flutter_test.dart';
import 'package:nocontact/features/message_analysis/domain/message_analysis_result.dart';
import 'package:nocontact/features/message_analysis/domain/message_analysis_types.dart';

void main() {
  group('MessageAnalysisResult Parsing', () {
    test('should parse valid production JSON correctly', () {
      final json = {
        "risk_level": "medium",
        "detected_patterns": ["Breadcrumbing", "Nostalgia Hook"],
        "emotional_tone": "Sentimental",
        "manipulation_or_pressure_signals": ["Past focus", "Casual check-in"],
        "boundary_recommendation": "Do not rush to reply. This message is designed to test your boundary.",
        "suggested_next_step": "wait",
        "short_summary": "He is checking if you are still available by using a shared memory.",
        "user_facing_explanation": "This message uses nostalgia to pull you back into conversation without making any real commitment.",
        "safe_reply_example": null,
        "confidence": "high",
        "disclaimer": "AI disclaimer"
      };

      final result = MessageAnalysisResult.fromJson(json);

      expect(result.riskLevel, RiskLevel.medium);
      expect(result.detectedPatterns, contains("Breadcrumbing"));
      expect(result.recommendedAction, RecommendedAction.wait);
      expect(result.confidence, AnalysisConfidence.high);
      expect(result.safeReplyExample, isNull);
    });

    test('should handle high risk and SOS suggestion', () {
      final json = {
        "risk_level": "high",
        "detected_patterns": ["Pressure", "Threat"],
        "emotional_tone": "Aggressive",
        "manipulation_or_pressure_signals": ["Urgency", "Blame"],
        "boundary_recommendation": "Protect your peace. Use SOS if you feel unsafe.",
        "suggested_next_step": "use_sos",
        "short_summary": "High pressure message.",
        "user_facing_explanation": "Detailed explanation.",
        "safe_reply_example": null,
        "confidence": "medium",
        "disclaimer": "AI disclaimer"
      };

      final result = MessageAnalysisResult.fromJson(json);

      expect(result.riskLevel, RiskLevel.high);
      expect(result.recommendedAction, RecommendedAction.useSos);
    });
  });
}

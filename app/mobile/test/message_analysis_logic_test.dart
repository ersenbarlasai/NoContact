import 'package:flutter_test/flutter_test.dart';
import 'package:nocontact/features/message_analysis/application/mock_message_analyzer.dart';
import 'package:nocontact/features/message_analysis/domain/message_analysis_types.dart';

void main() {
  group('MockMessageAnalyzer Heuristics', () {
    test('High Risk: Guilt + Emotional Pull', () async {
      const text = 'Senin yüzünden beni mahvettin, seni düşünüyorum.';
      final result = await MockMessageAnalyzer.analyze(text);
      
      expect(result.riskLevel, RiskLevel.high);
      expect(result.recommendedAction, RecommendedAction.doNotReply);
      expect(result.manipulationSignals, contains('Suçlama/Sorumluluk yükleme'));
    });

    test('Medium Risk: Breadcrumbing', () async {
      const text = 'Nasılsın? Sadece merak ettim.';
      final result = await MockMessageAnalyzer.analyze(text);
      
      expect(result.riskLevel, RiskLevel.medium);
      expect(result.recommendedAction, RecommendedAction.wait24Hours);
      expect(result.toneLabel, 'Kırıntı Atma');
    });

    test('Low Risk: Logistical', () async {
      const text = 'Eşyalar için fatura randevusu almalıyız.';
      final result = await MockMessageAnalyzer.analyze(text);
      
      expect(result.riskLevel, RiskLevel.low);
      expect(result.recommendedAction, RecommendedAction.replyWithBoundary);
      expect(result.suggestedReply, isNotNull);
    });

    test('Uncertain content defaults to wait24Hours', () async {
      const text = 'Sıradan bir gün.';
      final result = await MockMessageAnalyzer.analyze(text);
      
      expect(result.recommendedAction, RecommendedAction.wait24Hours);
    });
  });
}

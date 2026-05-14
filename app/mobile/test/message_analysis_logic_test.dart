import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Status: Deferred Message Analysis Tests', () {
    // These tests were disabled following the implementation of Phase 1: Trustworthy Support System.
    // The product focus has shifted from speculative AI message analysis to reliable self-regulation tools (Bugünün Desteği).
    // Message Analysis code is preserved for future production-grade AI integration but is not currently a primary release path.
  });
}
/*
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
      expect(result.recommendedAction, RecommendedAction.wait);
      expect(result.toneLabel, 'Kırıntı Atma');
    });

    test('Low Risk: Logistical', () async {
      const text = 'Eşyalar için fatura randevusu almalıyız.';
      final result = await MockMessageAnalyzer.analyze(text);
      
      expect(result.riskLevel, RiskLevel.low);
      expect(result.recommendedAction, RecommendedAction.replyWithBoundary);
      expect(result.suggestedReply, isNotNull);
    });

    test('Uncertain content defaults to wait', () async {
      const text = 'Sıradan bir gün.';
      final result = await MockMessageAnalyzer.analyze(text);
      
      expect(result.recommendedAction, RecommendedAction.wait);
    });
  });
}
*/

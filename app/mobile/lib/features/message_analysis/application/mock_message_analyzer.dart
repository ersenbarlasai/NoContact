import '../domain/message_analysis_result.dart';
import '../domain/message_analysis_types.dart';

class MockMessageAnalyzer {
  static Future<MessageAnalysisResult> analyze(String text) async {
    // Artificial delay to simulate processing
    await Future.delayed(const Duration(milliseconds: 800));

    final lowerText = text.toLowerCase();

    // 1. Detect Signals
    final emotionalPull = _containsAny(lowerText, ['özledim', 'miss you', 'seni düşünüyorum']);
    final urgencyPressure = _containsAny(lowerText, ['hemen', 'şimdi', 'neden cevap vermiyorsun', 'cevap ver']);
    final guiltBlame = _containsAny(lowerText, ['senin yüzünden', 'beni mahvettin', 'bunu bana nasıl yaparsın']);
    final breadcrumbing = _containsAny(lowerText, ['nasılsın', 'aklıma geldin', 'sadece merak ettim']);
    final logistical = _containsAny(lowerText, ['eşyalar', 'anahtar', 'fatura', 'randevu']);

    // 2. Determine Risk Level
    RiskLevel riskLevel = RiskLevel.low;
    if (guiltBlame || (emotionalPull && urgencyPressure)) {
      riskLevel = RiskLevel.high;
    } else if (breadcrumbing || emotionalPull) {
      riskLevel = RiskLevel.medium;
    } else if (logistical) {
      riskLevel = RiskLevel.low;
    }

    // 3. Recommended Action
    RecommendedAction action = RecommendedAction.wait24Hours;
    if (riskLevel == RiskLevel.high) {
      action = RecommendedAction.doNotReply;
    } else if (riskLevel == RiskLevel.medium) {
      action = RecommendedAction.wait24Hours;
    } else if (logistical) {
      action = RecommendedAction.replyWithBoundary;
    }

    // 4. Tone and Summary
    String toneLabel = 'Belirsiz';
    String summary = 'Mesajın içeriği net bir niyet göstermiyor. Acele etmemek en iyisi.';
    List<String> signals = [];

    if (guiltBlame) {
      toneLabel = 'Suçlayıcı / Manipülatif';
      summary = 'Bu mesaj suçluluk hissettirerek kontrolü geri kazanmaya çalışıyor.';
      signals.add('Suçlama/Sorumluluk yükleme');
    }
    if (emotionalPull) {
      toneLabel = toneLabel == 'Belirsiz' ? 'Duygusal Çekim' : toneLabel;
      signals.add('Duygusal kanca');
    }
    if (urgencyPressure) {
      signals.add('Yapay aciliyet/Baskı');
    }
    if (breadcrumbing) {
      toneLabel = 'Kırıntı Atma';
      summary = 'İletişimi koparmamak için atılan, yatırım içermeyen bir mesaj.';
      signals.add('Belirsiz yoklama');
    }
    if (logistical) {
      toneLabel = 'Lojistik / Pratik';
      summary = 'Duygusal olmayan, teknik veya pratik bir konu hakkında.';
      signals.add('Pratik ihtiyaç');
    }

    // 5. Suggested Reply
    String? suggestedReply;
    if (action == RecommendedAction.replyWithBoundary) {
      if (lowerText.contains('eşya') || lowerText.contains('anahtar')) {
        suggestedReply = 'Bunu kısa ve net tutalım. Eşyalar/Anahtarlar için şu zaman uygunum.';
      } else {
        suggestedReply = 'Şu an kişisel konuşmaya girmek istemiyorum. Gerekli konu buysa kısa şekilde yazabilirsin.';
      }
    }

    // 6. Grounding Reminder
    String reminder = 'Huzuruna saygı duymayan birine duygusal emek vermek zorunda değilsin.';
    if (riskLevel == RiskLevel.high) {
      reminder = 'Sessizlik senin en güçlü sınırındır. Etkileşime girmeyerek enerjini geri kazanırsın.';
    }

    return MessageAnalysisResult.mock(
      toneLabel: toneLabel,
      riskLevel: riskLevel,
      manipulationSignals: signals,
      recommendedAction: action,
      summary: summary,
      suggestedReply: suggestedReply,
      groundingReminder: reminder,
    );
  }

  static bool _containsAny(String text, List<String> keywords) {
    return keywords.any((k) => text.contains(k));
  }
}

import 'package:flutter/foundation.dart';

@immutable
class BetaFeedback {
  final String? id;
  final String? userId;
  final DateTime? createdAt;
  
  final String? appVersion;
  final String? platform;
  final String? sourceScreen;
  
  final int? overallRating;
  final String? firstImpression;
  final String? onboardingFeedback;
  final String? sosFeedback;
  final String? moodJournalFeedback;
  final String? lettersVaultFeedback;
  final String? messageAnalysisFeedback;
  final String? aiValueFeedback;
  final String? paymentFeedback;
  final String? safetyOrDiscomfort;
  final String? mostValuableFeature;
  final String? missingFeature;
  final String? extraNotes;

  const BetaFeedback({
    this.id,
    this.userId,
    this.createdAt,
    this.appVersion,
    this.platform,
    this.sourceScreen,
    this.overallRating,
    this.firstImpression,
    this.onboardingFeedback,
    this.sosFeedback,
    this.moodJournalFeedback,
    this.lettersVaultFeedback,
    this.messageAnalysisFeedback,
    this.aiValueFeedback,
    this.paymentFeedback,
    this.safetyOrDiscomfort,
    this.mostValuableFeature,
    this.missingFeature,
    this.extraNotes,
  });

  Map<String, dynamic> toJson() {
    return {
      if (userId != null) 'user_id': userId,
      if (appVersion != null) 'app_version': appVersion,
      if (platform != null) 'platform': platform,
      if (sourceScreen != null) 'source_screen': sourceScreen,
      if (overallRating != null) 'overall_rating': overallRating,
      if (firstImpression != null && firstImpression!.isNotEmpty) 'first_impression': firstImpression,
      if (onboardingFeedback != null && onboardingFeedback!.isNotEmpty) 'onboarding_feedback': onboardingFeedback,
      if (sosFeedback != null && sosFeedback!.isNotEmpty) 'sos_feedback': sosFeedback,
      if (moodJournalFeedback != null && moodJournalFeedback!.isNotEmpty) 'mood_journal_feedback': moodJournalFeedback,
      if (lettersVaultFeedback != null && lettersVaultFeedback!.isNotEmpty) 'letters_vault_feedback': lettersVaultFeedback,
      if (messageAnalysisFeedback != null && messageAnalysisFeedback!.isNotEmpty) 'message_analysis_feedback': messageAnalysisFeedback,
      if (aiValueFeedback != null && aiValueFeedback!.isNotEmpty) 'ai_value_feedback': aiValueFeedback,
      if (paymentFeedback != null && paymentFeedback!.isNotEmpty) 'payment_feedback': paymentFeedback,
      if (safetyOrDiscomfort != null && safetyOrDiscomfort!.isNotEmpty) 'safety_or_discomfort': safetyOrDiscomfort,
      if (mostValuableFeature != null && mostValuableFeature!.isNotEmpty) 'most_valuable_feature': mostValuableFeature,
      if (missingFeature != null && missingFeature!.isNotEmpty) 'missing_feature': missingFeature,
      if (extraNotes != null && extraNotes!.isNotEmpty) 'extra_notes': extraNotes,
    };
  }
}

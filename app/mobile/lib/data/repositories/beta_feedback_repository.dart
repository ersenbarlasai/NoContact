import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/services/supabase_service.dart';
import '../models/beta_feedback.dart';

class BetaFeedbackRepository {
  final SupabaseClient? _supabase = SupabaseService.client;

  Future<void> submitFeedback(BetaFeedback feedback) async {
    if (_supabase == null) {
      // If Supabase is missing, just simulate success for testing, or print.
      print('Warning: Supabase not configured. Feedback not sent.');
      return;
    }

    // Ensure we have an anonymous session if possible, though RLS allows user_id IS NULL
    final session = _supabase.auth.currentSession;
    if (session == null) {
      try {
        await _supabase.auth.signInAnonymously();
      } catch (e) {
        print('Warning: Could not sign in anonymously: $e');
      }
    }

    final userId = _supabase.auth.currentUser?.id;
    final payload = BetaFeedback(
      userId: userId,
      appVersion: feedback.appVersion,
      platform: feedback.platform,
      sourceScreen: feedback.sourceScreen,
      overallRating: feedback.overallRating,
      firstImpression: feedback.firstImpression,
      onboardingFeedback: feedback.onboardingFeedback,
      sosFeedback: feedback.sosFeedback,
      moodJournalFeedback: feedback.moodJournalFeedback,
      lettersVaultFeedback: feedback.lettersVaultFeedback,
      messageAnalysisFeedback: feedback.messageAnalysisFeedback,
      aiValueFeedback: feedback.aiValueFeedback,
      paymentFeedback: feedback.paymentFeedback,
      safetyOrDiscomfort: feedback.safetyOrDiscomfort,
      mostValuableFeature: feedback.mostValuableFeature,
      missingFeature: feedback.missingFeature,
      extraNotes: feedback.extraNotes,
    ).toJson();

    await _supabase.from('beta_feedback').insert(payload);
  }
}

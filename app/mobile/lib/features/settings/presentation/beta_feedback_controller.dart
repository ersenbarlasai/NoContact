import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/beta_feedback.dart';
import '../../../data/repositories/providers.dart';

class BetaFeedbackState {
  final bool isLoading;
  final bool isSuccess;
  final String? error;

  BetaFeedbackState({this.isLoading = false, this.isSuccess = false, this.error});

  BetaFeedbackState copyWith({bool? isLoading, bool? isSuccess, String? error}) {
    return BetaFeedbackState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error,
    );
  }
}

class BetaFeedbackController extends StateNotifier<BetaFeedbackState> {
  final Ref _ref;

  BetaFeedbackController(this._ref) : super(BetaFeedbackState());

  Future<void> submit(BetaFeedback feedback) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final repo = _ref.read(betaFeedbackRepositoryProvider);
      
      // Augment with platform info if missing
      final platform = kIsWeb ? 'web' : Platform.operatingSystem;
      final enrichedFeedback = BetaFeedback(
        appVersion: 'MVP', // Hardcoded or fetch from package_info_plus later
        platform: platform,
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
      );

      await repo.submitFeedback(enrichedFeedback);
      state = state.copyWith(isLoading: false, isSuccess: true);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void reset() {
    state = BetaFeedbackState();
  }
}

final betaFeedbackControllerProvider = StateNotifierProvider<BetaFeedbackController, BetaFeedbackState>((ref) {
  return BetaFeedbackController(ref);
});

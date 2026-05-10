enum SubscriptionTier {
  free,
  premium,
}

class EntitlementState {
  final SubscriptionTier tier;
  final int messageAnalysisDailyLimit;
  final int messageAnalysisUsedToday;
  final DateTime lastResetDate;

  EntitlementState({
    required this.tier,
    required this.messageAnalysisDailyLimit,
    required this.messageAnalysisUsedToday,
    required this.lastResetDate,
  });

  bool get isPremium => tier == SubscriptionTier.premium;
  int get remainingMessageAnalyses => (messageAnalysisDailyLimit - messageAnalysisUsedToday).clamp(0, messageAnalysisDailyLimit);
  bool get canUseMessageAnalysis => remainingMessageAnalyses > 0;

  EntitlementState copyWith({
    SubscriptionTier? tier,
    int? messageAnalysisDailyLimit,
    int? messageAnalysisUsedToday,
    DateTime? lastResetDate,
  }) {
    return EntitlementState(
      tier: tier ?? this.tier,
      messageAnalysisDailyLimit: messageAnalysisDailyLimit ?? this.messageAnalysisDailyLimit,
      messageAnalysisUsedToday: messageAnalysisUsedToday ?? this.messageAnalysisUsedToday,
      lastResetDate: lastResetDate ?? this.lastResetDate,
    );
  }

  factory EntitlementState.initial() {
    return EntitlementState(
      tier: SubscriptionTier.free,
      messageAnalysisDailyLimit: 3,
      messageAnalysisUsedToday: 0,
      lastResetDate: DateTime.now(),
    );
  }
}

enum SubscriptionTier {
  free,
  premium,
}

class EntitlementState {
  final SubscriptionTier tier;

  const EntitlementState({required this.tier});

  bool get isPremium => tier == SubscriptionTier.premium;

  EntitlementState copyWith({SubscriptionTier? tier}) {
    return EntitlementState(tier: tier ?? this.tier);
  }

  factory EntitlementState.initial() {
    return const EntitlementState(tier: SubscriptionTier.free);
  }
}

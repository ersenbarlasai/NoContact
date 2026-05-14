import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/subscription/presentation/entitlement_controller.dart';

/// All premium-gated features.
/// SOS, Home, Onboarding and Subscription are intentionally excluded.
enum PremiumFeature {
  moodJournal,
  lettersVault,
  supportCenter,
  library,
  recoveryPath,
  silentReply,
  insights,
  settings,
  betaFeedback,
  generic,
}

/// Set of free (unguarded) top-level routes.
const _freeRoutes = {'/splash', '/onboarding', '/', '/sos', '/subscription'};

/// Returns true if a route path is premium-guarded.
bool isPremiumRoute(String path) {
  // Strip query params if any
  final base = path.split('?').first;
  if (_freeRoutes.contains(base)) return false;
  // Everything else is premium
  return true;
}

/// Navigates to [targetRoute] if the user has premium access.
/// Otherwise pushes /subscription with an optional [feature] context
/// so the paywall can show a feature-specific message.
///
/// Usage:
/// ```dart
/// guardPremiumAccess(context, ref,
///   targetRoute: '/mood-journal',
///   feature: PremiumFeature.moodJournal,
/// );
/// ```
void guardPremiumAccess(
  BuildContext context,
  WidgetRef ref, {
  required String targetRoute,
  PremiumFeature feature = PremiumFeature.generic,
}) {
  final isPremium = ref.read(entitlementControllerProvider).isPremium;
  if (isPremium) {
    context.push(targetRoute);
  } else {
    context.push('/subscription', extra: feature);
  }
}

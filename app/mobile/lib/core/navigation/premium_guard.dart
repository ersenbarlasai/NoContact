import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/subscription/presentation/entitlement_controller.dart';

/// Premium feature keys — used to show contextual paywall messages.
enum PremiumFeature {
  recoveryPath,
  silentReply,
  insights,
}

/// Navigates to [targetRoute] if the user has premium access.
/// Otherwise pushes /subscription with an optional [feature] context
/// so the paywall can show a feature-specific message.
///
/// Usage:
/// ```dart
/// guardPremiumAccess(context, ref,
///   targetRoute: '/recovery-path',
///   feature: PremiumFeature.recoveryPath,
/// );
/// ```
void guardPremiumAccess(
  BuildContext context,
  WidgetRef ref, {
  required String targetRoute,
  PremiumFeature? feature,
}) {
  final isPremium = ref.read(entitlementControllerProvider).isPremium;
  if (isPremium) {
    context.push(targetRoute);
  } else {
    context.push('/subscription', extra: feature);
  }
}

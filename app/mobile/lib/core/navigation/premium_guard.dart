import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/subscription/presentation/entitlement_controller.dart';

/// Routes guarded behind a premium subscription.
/// SOS and core safety features are intentionally excluded.
const premiumRoutes = {
  '/recovery-path',
  '/insights',
  '/silent-reply',
};

/// Navigates to [targetRoute] if the user is premium.
/// Otherwise redirects to the subscription screen.
///
/// Usage:
/// ```dart
/// guardPremiumAccess(context, ref, targetRoute: '/recovery-path');
/// ```
void guardPremiumAccess(
  BuildContext context,
  WidgetRef ref, {
  required String targetRoute,
}) {
  final isPremium = ref.read(entitlementControllerProvider).isPremium;
  if (isPremium) {
    context.push(targetRoute);
  } else {
    context.push('/subscription');
  }
}

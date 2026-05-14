import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../app/theme/app_theme.dart';
import '../../../core/design_system/still_widgets.dart';
import '../../../core/navigation/premium_guard.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/entitlement_state.dart';
import 'entitlement_controller.dart';

class SubscriptionScreen extends ConsumerWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(entitlementControllerProvider);

    // Contextual feature message — passed via GoRouter extra
    final feature = GoRouterState.of(context).extra as PremiumFeature?;
    final gateMessage = _gateMessage(l10n, feature);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: AppColors.onSurfaceVariant),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Spacer(),
                  Text(
                    l10n.subscriptionTitle,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          letterSpacing: 2,
                          color: AppColors.primary,
                        ),
                  ),
                  const Spacer(),
                  const SizedBox(width: 48),
                ],
              ),
              const SizedBox(height: 40),

              // Contextual gate message (feature-specific paywall hint)
              if (gateMessage != null) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.workspace_premium_rounded,
                          color: AppColors.primary, size: 20),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          gateMessage,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
              ],

              StillSectionHeader(
                title: l10n.subscriptionTagline,
                subtitle: l10n.subscriptionSubtitle,
              ),
              const SizedBox(height: 32),

              // Current plan badge
              StillGlassCard(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Icon(
                      state.isPremium
                          ? Icons.workspace_premium_rounded
                          : Icons.eco_outlined,
                      color: AppColors.primary,
                      size: 28,
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.subscriptionCurrentPlan,
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          state.isPremium
                              ? 'Premium'
                              : l10n.subscriptionFreePlan,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary,
                                  ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Free plan features
              _buildPlanSection(
                context,
                title: l10n.subscriptionFreePlan,
                features: const [
                  'SOS Yardımı (Sınırsız)',
                  'No-Contact Sayacı',
                  'Duygu Günlüğü',
                  'Mektup Kasası',
                  'Sakin Kütüphane',
                ],
                isCurrent: !state.isPremium,
                isPremiumPlan: false,
              ),
              const SizedBox(height: 24),

              // Premium plan features
              _buildPlanSection(
                context,
                title: l10n.subscriptionPremiumPlan,
                features: const [
                  '30 Günlük İyileşme Yolu',
                  'Sessiz Cevap Rehberi',
                  'Gelişmiş İçgörüler ve Trendler',
                  'Haftalık İyileşme Özeti',
                  'Kişisel Ritim ve Destek Önerileri',
                ],
                isCurrent: state.isPremium,
                isPremiumPlan: true,
              ),

              const SizedBox(height: 48),

              // Payment note
              StillCard(
                color: AppColors.primary.withValues(alpha: 0.05),
                padding: const EdgeInsets.all(20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.info_outline, color: AppColors.primary),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        l10n.subscriptionPaymentNote,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: AppColors.primary),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              StillPrimaryButton(
                label: l10n.subscriptionContinueBtn,
                onPressed: () => Navigator.pop(context),
              ),

              const SizedBox(height: 16),

              // DEV ONLY — visible only in debug builds
              Center(
                child: TextButton(
                  onPressed: () =>
                      ref.read(entitlementControllerProvider.notifier).toggleMockTier(),
                  child: Text(
                    state.isPremium
                        ? l10n.subscriptionDevToggleToFree
                        : l10n.subscriptionDevToggleToPremium,
                    style: TextStyle(
                      color: AppColors.onSurfaceVariant.withValues(alpha: 0.4),
                      fontSize: 11,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Returns the contextual gate message for the triggering feature.
  String? _gateMessage(AppLocalizations l10n, PremiumFeature? feature) {
    if (feature == null) return null;
    return switch (feature) {
      PremiumFeature.recoveryPath => l10n.subscriptionGateRecoveryPath,
      PremiumFeature.silentReply => l10n.subscriptionGateSilentReply,
      PremiumFeature.insights => l10n.subscriptionGateInsights,
    };
  }

  Widget _buildPlanSection(
    BuildContext context, {
    required String title,
    required List<String> features,
    required bool isCurrent,
    required bool isPremiumPlan,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (isPremiumPlan)
              const Padding(
                padding: EdgeInsets.only(right: 8),
                child: Icon(Icons.workspace_premium_rounded,
                    size: 16, color: AppColors.tertiary),
              ),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isCurrent
                        ? AppColors.onSurface
                        : AppColors.onSurfaceVariant,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...features.map(
          (f) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle_outline,
                  size: 16,
                  color: isCurrent
                      ? AppColors.primary
                      : AppColors.onSurfaceVariant.withValues(alpha: 0.4),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    f,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: isCurrent
                              ? AppColors.onSurface
                              : AppColors.onSurfaceVariant
                                  .withValues(alpha: 0.6),
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

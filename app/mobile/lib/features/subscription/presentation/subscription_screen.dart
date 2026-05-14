import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/theme/app_theme.dart';
import '../../../core/design_system/still_widgets.dart';
import '../domain/entitlement_state.dart';
import 'entitlement_controller.dart';

class SubscriptionScreen extends ConsumerWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(entitlementControllerProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: AppColors.onSurfaceVariant),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Spacer(),
                  Text(
                    'STILL PREMIUM',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          letterSpacing: 2,
                          color: AppColors.primary,
                        ),
                  ),
                  const Spacer(),
                  const SizedBox(width: 48),
                ],
              ),
              const SizedBox(height: 48),

              const StillSectionHeader(
                title: 'İyileşme Yolculuğunu Destekle',
                subtitle:
                    'Premium özellikler, daha derin bir iyileşme deneyimi için tasarlandı.',
              ),
              const SizedBox(height: 32),

              // Current status badge
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
                          'Mevcut Plan',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          state.isPremium ? 'Premium' : 'Ücretsiz',
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

              // Free plan
              _buildPlanSection(
                context,
                title: 'Ücretsiz Plan',
                features: const [
                  'SOS Yardımı (Sınırsız)',
                  'No-Contact Sayacı',
                  'Duygu Günlüğü (Temel)',
                  'Mektup Kasası',
                  'Sakin Kütüphane',
                ],
                isCurrent: !state.isPremium,
                isPremium: false,
              ),
              const SizedBox(height: 24),

              // Premium plan
              _buildPlanSection(
                context,
                title: 'Premium Plan (Yakında)',
                features: const [
                  '30 Günlük İyileşme Yolu',
                  'Sessiz Cevap Rehberi',
                  'Gelişmiş İçgörüler ve Trendler',
                  'Haftalık İyileşme Özeti',
                  'Kişisel Ritim ve Destek Önerileri',
                ],
                isCurrent: state.isPremium,
                isPremium: true,
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
                        'Ödeme entegrasyonu henüz aktif değil. Şu an tüm özellikleri ücretsiz deneyebilirsin.',
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
                label: 'DEVAM ET',
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
                        ? 'Ücretsiz Moduna Dön (DEV)'
                        : 'Premium Moduna Geç (DEV)',
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

  Widget _buildPlanSection(
    BuildContext context, {
    required String title,
    required List<String> features,
    required bool isCurrent,
    required bool isPremium,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (isPremium)
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

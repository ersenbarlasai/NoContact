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
                    'PLAN VE LİMİTLER',
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
                subtitle: 'NoContact gelişim aşamasındadır. Şimdilik tüm özellikleri deneyebilirsin.',
              ),
              const SizedBox(height: 32),

              // Current Status Card
              StillCard(
                color: AppColors.surfaceContainerLow,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Mevcut Planın',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: state.isPremium ? AppColors.tertiaryContainer : AppColors.secondaryContainer,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            state.tier == SubscriptionTier.free ? 'ÜCRETSİZ' : 'PREMIUM',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: state.isPremium ? AppColors.onTertiaryContainer : AppColors.onSecondaryContainer,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      ref.read(entitlementControllerProvider.notifier).usageStatusText,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: state.messageAnalysisUsedToday / state.messageAnalysisDailyLimit,
                      backgroundColor: AppColors.surfaceContainerHigh,
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Plans Comparison
              _buildPlanFeature(
                context,
                'Ücretsiz Plan',
                [
                  'SOS Yardımı (Sınırsız)',
                  'No-Contact Sayacı',
                  'Duygu Günlüğü',
                  'Mektup Kasası',
                  'Günlük 3 Mesaj Analizi',
                ],
                true,
              ),
              const SizedBox(height: 24),
              _buildPlanFeature(
                context,
                'Premium Plan (Yakında)',
                [
                  'Gelişmiş AI Mesaj Analizi (Yüksek Limit)',
                  'Haftalık İyileşme Raporları',
                  'Duygusal Trend Analizleri',
                  'AI İyileşme Koçu Erişimi',
                  'Özel Temalar ve Fontlar',
                ],
                false,
              ),

              const SizedBox(height: 48),

              // Note about payments
              StillCard(
                color: AppColors.primary.withValues(alpha: 0.05),
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline, color: AppColors.primary),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        'Ödeme entegrasyonu henüz aktif değil. Geliştirme sürecinde bize geri bildirim vererek destek olabilirsin.',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.primary),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // CTA
              StillPrimaryButton(
                label: 'DEVAM ET',
                onPressed: () => Navigator.pop(context),
              ),
              const SizedBox(height: 16),
              
              // Dev Toggle
              Center(
                child: TextButton(
                  onPressed: () => ref.read(entitlementControllerProvider.notifier).toggleMockTier(),
                  child: Text(
                    state.isPremium ? 'Ücretsiz Moduna Dön (DEV)' : 'Premium Moduna Geç (DEV)',
                    style: TextStyle(color: AppColors.onSurfaceVariant.withValues(alpha: 0.5), fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlanFeature(BuildContext context, String title, List<String> features, bool isCurrent) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: isCurrent ? AppColors.onSurface : AppColors.onSurfaceVariant,
              ),
        ),
        const SizedBox(height: 12),
        ...features.map((f) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    size: 16,
                    color: isCurrent ? AppColors.primary : AppColors.onSurfaceVariant.withValues(alpha: 0.5),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    f,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: isCurrent ? AppColors.onSurface : AppColors.onSurfaceVariant.withValues(alpha: 0.7),
                        ),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}

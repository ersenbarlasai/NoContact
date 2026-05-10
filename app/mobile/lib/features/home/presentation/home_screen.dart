import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../app/theme/app_theme.dart';
import '../../../core/design_system/still_widgets.dart';
import '../../../data/models/recovery_profile.dart';
import '../../onboarding/presentation/onboarding_controller.dart';
import '../../sos/presentation/sos_controller.dart';
import '../../../data/repositories/providers.dart';

final managedUrgeCountProvider = FutureProvider<int>((ref) async {
  final remoteRepo = ref.watch(sosSessionRepositoryProvider);
  final localRepo = ref.watch(localSosSessionRepositoryProvider);
  
  int count = 0;
  try {
    count = await remoteRepo.getManagedUrgeCount();
  } catch (_) {}

  final localCount = await localRepo.fetchManagedUrgeCount();
  return count > localCount ? count : localCount;
});

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboardingState = ref.watch(onboardingControllerProvider);
    final sosState = ref.watch(sosControllerProvider);
    final managedUrges = ref.watch(managedUrgeCountProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header & Greeting
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hoş geldin, ${onboardingState.name}',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Bugün harika gidiyorsun. Sadece bu anı yaşa.',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.analytics_outlined, color: AppColors.primary),
                        onPressed: () => context.push('/insights'),
                      ),
                      const Icon(Icons.eco_outlined, color: AppColors.primary),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              if (kIsWeb)
                Container(
                  margin: const EdgeInsets.only(bottom: 24),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.5)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.science_outlined, color: AppColors.primary),
                          const SizedBox(width: 12),
                          Text(
                            'Still Web Test Sürümü',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Bu sürüm App Store / Play Store öncesi ürün hissini test etmek için hazırlandı. Mobil uygulamadaki bazı özellikler web’de farklı çalışabilir:',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, bottom: 4),
                        child: Text('• Biyometrik kilit web’de aktif değil.', style: Theme.of(context).textTheme.bodyMedium),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, bottom: 4),
                        child: Text('• Yerel bildirimler web’de aktif değil.', style: Theme.of(context).textTheme.bodyMedium),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, bottom: 4),
                        child: Text('• Web sürümünde gerçek hassas içerik yazmamanı öneririz.', style: Theme.of(context).textTheme.bodyMedium),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Bu testte özellikle ilk izlenimini, onboarding akışını, SOS modunu, günlük/mektup alanlarının güven hissini ve mesaj analizi fikrini değerlendirmek istiyoruz.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Geri bildirimin uygulamanın gerçek mobil sürümünü şekillendirecek.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontStyle: FontStyle.italic,
                              color: AppColors.onSurfaceVariant,
                            ),
                      ),
                    ],
                  ),
                ),

              if (sosState.completedAt != null && 
                  DateTime.now().difference(sosState.completedAt!).inMinutes < 60)
                _SosSuccessMessage(onDismiss: () {
                  ref.read(sosControllerProvider.notifier).reset();
                }),

              // No-Contact Day Counter
              _DayCounterCard(onboardingState: onboardingState),
              const SizedBox(height: 32),

              // Bento Grid
              const StillSectionHeader(title: 'Senin Alanın'),
              const SizedBox(height: 16),
              
              // Row 1: Mood
              _BentoMoodCard(onboardingState: onboardingState),
              const SizedBox(height: 16),
              
              const SizedBox(height: 16),
              
              // Row 2: Stats & Action
              Row(
                children: [
                  Expanded(
                    child: _BentoStatsCard(managedUrges: managedUrges),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _BentoActionCard(onboardingState: onboardingState),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              _RecoveryPathCard(),
              
              const SizedBox(height: 40),
              const StillPrivacyNotice(
                text: 'Verilerin gizlidir ve sadece bu cihazda saklanır.',
              ),
              const SizedBox(height: 80), // Space for FAB
            ],
          ),
        ),
      ),
    );
  }
}

class _DayCounterCard extends StatelessWidget {
  final RecoveryProfile onboardingState;
  const _DayCounterCard({required this.onboardingState});

  @override
  Widget build(BuildContext context) {
    final startDate = onboardingState.noContactStartDate ?? DateTime.now();
    final days = DateTime.now().difference(startDate).inDays;

    return StillCard(
      hasShadow: true,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Center(
        child: Column(
          children: [
            Text(
              'İLETİŞİMSİZ GEÇEN',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            Text(
              '$days Gün',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: AppColors.primary,
                  ),
            ),
            const SizedBox(height: 12),
            Text(
              'Kendini seçtiğin anlar',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.onSurfaceVariant,
                    fontStyle: FontStyle.italic,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BentoMoodCard extends StatelessWidget {
  final RecoveryProfile onboardingState;
  const _BentoMoodCard({required this.onboardingState});

  @override
  Widget build(BuildContext context) {
    return StillCard(
      onTap: () => context.push('/mood-journal'),
      color: AppColors.secondaryContainer.withValues(alpha: 0.3),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'DUYGULARIN',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.bold,
                        color: AppColors.onSecondaryContainer,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Şu an nasıl hissediyorsun?',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 18),
                ),
              ],
            ),
          ),
          const Icon(Icons.favorite, color: AppColors.primary, size: 28),
        ],
      ),
    );
  }
}

class _BentoStatsCard extends StatelessWidget {
  final AsyncValue<int> managedUrges;
  const _BentoStatsCard({required this.managedUrges});

  @override
  Widget build(BuildContext context) {
    return StillCard(
      padding: const EdgeInsets.all(24),
      color: AppColors.tertiaryFixed.withValues(alpha: 0.4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.health_and_safety_outlined, color: AppColors.tertiary, size: 28),
          const SizedBox(height: 24),
          managedUrges.when(
            data: (count) => Text(
              '$count',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: AppColors.tertiary,
                    fontSize: 40,
                  ),
            ),
            loading: () => const CircularProgressIndicator(),
            error: (_, __) => const Text('0'),
          ),
          const SizedBox(height: 4),
          Text(
            'Dürtü Yönetildi',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.onTertiaryContainer,
                ),
          ),
        ],
      ),
    );
  }
}

class _BentoActionCard extends StatelessWidget {
  final RecoveryProfile onboardingState;
  const _BentoActionCard({required this.onboardingState});

  @override
  Widget build(BuildContext context) {
    return StillCard(
      padding: const EdgeInsets.all(24),
      onTap: () => context.push('/letters-vault'),
      color: AppColors.primaryFixed.withValues(alpha: 0.4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.auto_stories, color: AppColors.primary, size: 28),
          const SizedBox(height: 24),
          Text(
            'Göndermeyeceğin Mektup',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  height: 1.2,
                  fontSize: 14,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            'İçini dök',
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ],
      ),
    );
  }
}

class _SosSuccessMessage extends StatelessWidget {
  final VoidCallback onDismiss;
  const _SosSuccessMessage({required this.onDismiss});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle_outline, color: AppColors.primary),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Bir dürtüyü daha başarıyla atlattın.',
              style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.primary),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, size: 20, color: AppColors.outline),
            onPressed: onDismiss,
          ),
        ],
      ),
    );
  }
}

class _RecoveryPathCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StillCard(
      onTap: () => context.push('/recovery-path'),
      color: AppColors.primaryContainer.withValues(alpha: 0.1),
      child: Row(
        children: [
          const Icon(Icons.auto_graph, color: AppColors.primary, size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'İYİLEŞME YOLUN',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Sıradaki nazik adımı gör.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: AppColors.outline),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../app/theme/app_theme.dart';
import '../../../core/design_system/still_widgets.dart';
import '../../../core/design_system/emotional_background.dart';
import '../../../core/design_system/emotional_tokens.dart';
import '../../../data/models/recovery_profile.dart';
import '../../onboarding/presentation/onboarding_controller.dart';
import '../../sos/presentation/sos_controller.dart';
import '../../support_system/presentation/support_controller.dart';
import '../../../data/repositories/providers.dart';
import '../../recovery_path/data/static_30_day_recovery_plan.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboardingState = ref.watch(onboardingControllerProvider);
    final sosState = ref.watch(sosControllerProvider);
    final managedUrges = ref.watch(managedUrgeCountProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: EmotionalBackground(
        variant: EmotionalVariant.home,
        useTimeOfDay: true,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(24, 32, 24, MediaQuery.of(context).padding.bottom + 180),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header & Greeting
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                  fontFamily: 'Literata',
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Bugün harika gidiyorsun. Sadece bu anı yaşa.',
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: AppColors.onSurfaceVariant.withValues(alpha: 0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    IconButton(
                      icon: const Icon(Icons.eco_outlined, color: AppColors.primary, size: 22),
                      onPressed: () => context.push('/recovery-path'),
                      tooltip: 'İyileşme Yolum',
                    ),
                  ],
                ),
                const SizedBox(height: 24),
  
                if (sosState.completedAt != null && 
                    DateTime.now().difference(sosState.completedAt!).inMinutes < 60)
                  _SosSuccessMessage(onDismiss: () {
                    ref.read(sosControllerProvider.notifier).reset();
                  }),
  
                // No-Contact Day Counter
                _DayCounterCard(onboardingState: onboardingState),
                const SizedBox(height: 32),
  
                // Today's Support (Priority Card)
                const _BentoSupportCard(),
                const SizedBox(height: 32),
  
                // Bento Grid
                const StillSectionHeader(title: 'Senin Alanın'),
                const SizedBox(height: 16),
                
                // Row 1: Today's Step & Library
                Row(
                  children: [
                    Expanded(
                      child: _TodayStepMiniCard(onboardingState: onboardingState),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _BentoLibraryCard(),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Row 2: Mood & Silent Reply
                Row(
                  children: [
                    Expanded(
                      child: _BentoMoodCard(onboardingState: onboardingState),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _BentoSilentReplyCard(),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                
                // Row 3: Stats & Letters
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
                
                const SizedBox(height: 24),
                
                const StillPrivacyNotice(
                  text: 'Veriler bu cihazda şifreli saklanır.',
                ),
                const SizedBox(height: 180), // Safe space for bottom nav & FAB
              ],
            ),
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

    return StillGlassCard(
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Center(
        child: Column(
          children: [
            Text(
              'İLETİŞİMSİZ GEÇEN',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold,
                    color: AppColors.onSurfaceVariant.withValues(alpha: 0.6),
                  ),
            ),
            const SizedBox(height: 16),
            Text(
              '$days Gün',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: AppColors.primary,
                    fontFamily: 'Literata',
                  ),
            ),
            const SizedBox(height: 12),
            Text(
              'Kendini seçtiğin anlar',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.onSurfaceVariant.withValues(alpha: 0.7),
                    fontStyle: FontStyle.italic,
                    fontFamily: 'Literata',
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
                  'Nasıl hissediyorsun?',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 16),
                ),
              ],
            ),
          ),
          const Icon(Icons.favorite, color: AppColors.primary, size: 24),
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
      padding: const EdgeInsets.all(20),
      color: AppColors.tertiaryFixed.withValues(alpha: 0.4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.health_and_safety_outlined, color: AppColors.tertiary, size: 24),
          const SizedBox(height: 20),
          managedUrges.when(
            data: (count) => Text(
              '$count',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: AppColors.tertiary,
                    fontSize: 32,
                  ),
            ),
            loading: () => const SizedBox(height: 32, child: CircularProgressIndicator(strokeWidth: 2)),
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
          const SizedBox(height: 4),
          Text(
            'Temas etmeden atlattığın anlar',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.onTertiaryContainer.withValues(alpha: 0.7),
                  fontSize: 10,
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
      padding: const EdgeInsets.all(20),
      onTap: () => context.push('/letters-vault'),
      color: AppColors.primaryFixed.withValues(alpha: 0.4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.auto_stories, color: AppColors.primary, size: 24),
          const SizedBox(height: 20),
          Text(
            'Göndermeyeceğin Mektup',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  height: 1.2,
                  fontSize: 13,
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

class _BentoSupportCard extends ConsumerWidget {
  const _BentoSupportCard();

  String _formatDuration(Duration? duration) {
    if (duration == null) return '';
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    return '${hours}s ${minutes}dk kaldı';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final supportState = ref.watch(supportControllerProvider);
    final status = supportState.pauseStatus;
    final latestNote = supportState.latestNote;

    final isActive = status == SupportPauseStatus.active;
    final isExpired = status == SupportPauseStatus.expired;

    String title = 'BUGÜNÜN DESTEĞİ';
    String subtitle = latestNote?.body ?? 'Şu an ihtiyacın olan küçük adımı seç.';
    IconData icon = Icons.shield_outlined;
    Color cardColor = AppColors.surfaceContainerLow;

    if (isActive) {
      title = '24 SAATLİK DURAKLAMA AKTİF';
      subtitle = '${_formatDuration(supportState.remainingPauseTime)}\nKararını şu an koruyorsun.';
      icon = Icons.timer_outlined;
      cardColor = AppColors.primaryContainer.withValues(alpha: 0.2);
    } else if (isExpired) {
      title = 'DURAKLAMA TAMAMLANDI';
      subtitle = 'Şimdi daha sakin bir yerden karar verebilirsin.';
      icon = Icons.check_circle_outline;
      cardColor = AppColors.primaryContainer.withValues(alpha: 0.2);
    } else {
      cardColor = AppColors.surfaceContainerLowest.withValues(alpha: 0.7);
    }

    return StillGlassCard(
      onTap: () => context.push('/support-center'),
      opacity: (isActive || isExpired) ? 0.8 : 0.6,
      padding: const EdgeInsets.all(28),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.primary, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.onSurface,
                    fontFamily: (isActive || isExpired) ? 'Literata' : null,
                    fontStyle: (isActive || isExpired) ? FontStyle.italic : null,
                  ),
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

class _BentoLibraryCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StillCard(
      padding: const EdgeInsets.all(20),
      onTap: () => context.push('/library'),
      color: AppColors.secondaryContainer.withValues(alpha: 0.3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.local_library_outlined, color: AppColors.secondary, size: 24),
          const SizedBox(height: 20),
          Text(
            'Sessiz Kütüphane',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  height: 1.2,
                  fontSize: 13,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            'Sakin içerikler',
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ],
      ),
    );
  }
}

class _BentoSilentReplyCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StillCard(
      padding: const EdgeInsets.all(20),
      onTap: () => context.push('/silent-reply'),
      color: AppColors.primaryContainer.withValues(alpha: 0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.chat_bubble_outline, color: AppColors.primary, size: 24),
          const SizedBox(height: 20),
          Text(
            'Sessiz Cevap',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  height: 1.2,
                  fontSize: 13,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            'Göndermeden yaz.',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ],
      ),
    );
  }
}
class _TodayStepMiniCard extends StatelessWidget {
  final RecoveryProfile onboardingState;
  const _TodayStepMiniCard({required this.onboardingState});

  @override
  Widget build(BuildContext context) {
    final startDate = onboardingState.noContactStartDate ?? DateTime.now();
    final days = DateTime.now().difference(startDate).inDays;
    final step = Static30DayRecoveryPlan.getStepForDay(days);

    return StillCard(
      padding: const EdgeInsets.all(20),
      onTap: () => context.push('/recovery-path'),
      color: AppColors.tertiaryFixed.withValues(alpha: 0.3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.flare_outlined, color: AppColors.tertiary, size: 24),
          const SizedBox(height: 20),
          Text(
            'GÜN ${step.dayNumber}',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.tertiary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            'Bugünün Adımı',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 13),
          ),
        ],
      ),
    );
  }
}

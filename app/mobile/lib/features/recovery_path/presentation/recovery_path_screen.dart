import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../app/theme/app_theme.dart';
import '../../../core/design_system/still_widgets.dart';
import '../../../core/design_system/emotional_background.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/recovery_path_step.dart';
import 'recovery_path_controller.dart';
import '../data/static_30_day_recovery_plan.dart';
import '../domain/daily_recovery_step.dart';
import '../../library/domain/library_item.dart';

class RecoveryPathScreen extends ConsumerWidget {
  const RecoveryPathScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(recoveryPathControllerProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: EmotionalBackground(
        variant: EmotionalVariant.recovery,
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
            SliverAppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              floating: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: AppColors.primary),
                onPressed: () => context.pop(),
              ),
              title: Text(
                AppLocalizations.of(context).recoveryPathTitle,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Literata',
                    ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StillSectionHeader(
                      title: AppLocalizations.of(context).recoveryPathTitle,
                      subtitle: AppLocalizations.of(context).recoveryPathMilestone,
                    ),
                    const SizedBox(height: 32),
                    _ProgressCard(
                      ncDays: state.journeyDays,
                      progress: state.progressPercent,
                      activeStepTitle: state.activeStep?.title ?? 'Tüm adımlar tamamlandı',
                    ),
                    const SizedBox(height: 32),
                    _TodayStepCard(
                      step: Static30DayRecoveryPlan.getStepForDay(state.journeyDays),
                    ),
                    const SizedBox(height: 48),
                  ],
                ),
              ),
            ),
            if (state.isLoading)
              const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              )
            else
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final step = state.steps[index];
                    final isLast = index == state.steps.length - 1;
                    final isFirst = index == 0;

                    return _PathStepItem(
                      step: step,
                      isFirst: isFirst,
                      isLast: isLast,
                    );
                  },
                  childCount: state.steps.length,
                ),
              ),
            const SliverPadding(padding: EdgeInsets.only(bottom: 180)),
          ],
        ),
      ),
    ),
  );
}
}

class _TodayStepCard extends StatelessWidget {
  final DailyRecoveryStep step;

  const _TodayStepCard({required this.step});

  @override
  Widget build(BuildContext context) {
    return StillGlassCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.tertiary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'GÜN ${step.dayNumber}',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.tertiary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                step.theme.toUpperCase(),
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  letterSpacing: 1.5,
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            step.title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontFamily: 'Literata',
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            step.shortExplanation,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.onSurface,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),
          
          // Task Section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.tertiary.withValues(alpha: 0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.task_alt, size: 18, color: AppColors.tertiary),
                    const SizedBox(width: 8),
                    Text(
                      'Küçük Görev',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: AppColors.tertiary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  step.smallTask,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          StillPrimaryButton(
            label: AppLocalizations.of(context).recoveryPathOpenStep,
            onPressed: () => _handleToolAction(context, step.linkedTool),
          ),
        ],
      ),
    );
  }

  void _handleToolAction(BuildContext context, LibrarySuggestedAction tool) {
    switch (tool) {
      case LibrarySuggestedAction.sos:
        context.push('/sos');
        break;
      case LibrarySuggestedAction.lettersVault:
        context.push('/letters-vault');
        break;
      case LibrarySuggestedAction.supportWait:
        context.push('/support-center');
        break;
      case LibrarySuggestedAction.moodJournal:
        context.push('/mood-journal');
        break;
      case LibrarySuggestedAction.supportCenter:
        context.push('/support-center');
        break;
    }
  }
}

class _ProgressCard extends StatelessWidget {
  final int ncDays;
  final double progress;
  final String activeStepTitle;

  const _ProgressCard({
    required this.ncDays,
    required this.progress,
    required this.activeStepTitle,
  });

  @override
  Widget build(BuildContext context) {
    return StillGlassCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context).recoveryPathMilestone,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColors.primary,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    activeStepTitle,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppColors.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    ncDays.toString(),
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          color: AppColors.primary,
                          fontFamily: 'Literata',
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    AppLocalizations.of(context).recoveryPathDayCount,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColors.onSurfaceVariant,
                        ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          Stack(
            children: [
              Container(
                height: 6,
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              FractionallySizedBox(
                widthFactor: progress,
                child: Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PathStepItem extends StatelessWidget {
  final RecoveryPathStep step;
  final bool isFirst;
  final bool isLast;

  const _PathStepItem({
    required this.step,
    this.isFirst = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool isCompleted = step.status == StepStatus.completed;
    final bool isActive = step.status == StepStatus.active;
    final bool isLocked = step.status == StepStatus.locked;

    return InkWell(
      onTap: isLocked ? null : () {
        if (step.suggestedActionRoute != null) {
          context.push(step.suggestedActionRoute!);
        }
      },
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(width: 24),
            Column(
              children: [
                if (!isFirst)
                  Container(
                    width: 2,
                    height: 24,
                    color: isCompleted ? AppColors.primary : AppColors.surfaceContainerHighest,
                  ),
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: isCompleted
                        ? AppColors.primary
                        : (isActive ? AppColors.primary.withValues(alpha: 0.1) : AppColors.surfaceContainerLow),
                    shape: BoxShape.circle,
                    border: isActive
                        ? Border.all(color: AppColors.primary, width: 2)
                        : null,
                  ),
                  child: Icon(
                    isCompleted ? Icons.check : (step.icon ?? step.phase.icon),
                    color: isCompleted
                        ? Colors.white
                        : (isActive ? AppColors.primary : AppColors.onSurfaceVariant.withValues(alpha: 0.5)),
                    size: 24,
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: isCompleted ? AppColors.primary : AppColors.surfaceContainerHighest,
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 32, right: 24),
                child: Opacity(
                  opacity: isLocked ? 0.5 : 1.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            step.phase.label.toUpperCase(),
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  color: isCompleted ? AppColors.primary : AppColors.onSurfaceVariant,
                                  letterSpacing: 1.2,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '• ${step.phase.dayRange}',
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  color: AppColors.onSurfaceVariant.withValues(alpha: 0.7),
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        step.title,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: AppColors.onSurface,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        step.description,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.onSurfaceVariant,
                              height: 1.5,
                            ),
                      ),
                      if (isActive && step.suggestedActionRoute != null) ...[
                        const SizedBox(height: 16),
                        StillPrimaryButton(
                          label: AppLocalizations.of(context).recoveryPathOpenStep,
                          icon: Icons.play_arrow_rounded,
                          onPressed: () => context.push(step.suggestedActionRoute!),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

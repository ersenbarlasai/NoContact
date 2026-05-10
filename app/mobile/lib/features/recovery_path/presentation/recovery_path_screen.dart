import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../app/theme/app_theme.dart';
import '../../../core/design_system/still_widgets.dart';
import '../domain/recovery_path_step.dart';
import 'recovery_path_controller.dart';

class RecoveryPathScreen extends ConsumerWidget {
  const RecoveryPathScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(recoveryPathControllerProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColors.background,
            floating: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.primary),
              onPressed: () => context.pop(),
            ),
            title: Text(
              'İyileşme Yolun',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const StillSectionHeader(
                    title: 'Yolculuğun',
                    subtitle: 'Bu bir yarış değil. Sadece sıradaki nazik adım.',
                  ),
                  const SizedBox(height: 32),
                  _ProgressCard(
                    ncDays: state.ncDays,
                    progress: state.progressPercent,
                    activeStepTitle: state.activeStep?.title ?? 'Tüm adımlar tamamlandı',
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
          const SliverPadding(padding: EdgeInsets.only(bottom: 100)),
        ],
      ),
    );
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
    return StillCard(
      padding: const EdgeInsets.all(24),
      hasShadow: true,
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
                    'Mevcut Kilometre Taşı'.toUpperCase(),
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
                    '/ 30 Gün',
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

    return IntrinsicHeight(
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
                        label: 'ADIMI AT',
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
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/theme/app_theme.dart';
import '../../../core/design_system/still_widgets.dart';
import 'milestone_controller.dart';

class MilestoneOverlay extends ConsumerWidget {
  const MilestoneOverlay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(milestoneControllerProvider);
    final milestone = state.pendingMilestone;

    if (milestone == null) return const SizedBox.shrink();

    return Container(
      color: AppColors.onSurface.withValues(alpha: 0.15),
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: StillCard(
              padding: const EdgeInsets.all(32),
              hasShadow: true,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.eco_rounded,
                      color: AppColors.primary,
                      size: 32,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    milestone.title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Literata',
                        ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    milestone.message,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.onSurfaceVariant,
                          height: 1.6,
                        ),
                  ),
                  const SizedBox(height: 40),
                  StillPrimaryButton(
                    label: 'Yoluma Dön',
                    onPressed: () => ref.read(milestoneControllerProvider.notifier).dismissMilestone(),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () => ref.read(milestoneControllerProvider.notifier).dismissMilestone(),
                    child: Text(
                      'Bunu fark ettim',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: AppColors.onSurfaceVariant.withValues(alpha: 0.6),
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

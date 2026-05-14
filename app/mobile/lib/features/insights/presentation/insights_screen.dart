import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../app/theme/app_theme.dart';
import '../../../core/design_system/still_widgets.dart';
import '../../../core/design_system/emotional_background.dart';
import '../../milestones/domain/milestone.dart';
import 'insights_controller.dart';
import '../domain/insights_data.dart';

class InsightsScreen extends ConsumerWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(insightsControllerProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: EmotionalBackground(
        variant: EmotionalVariant.neutral,
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
                'Yansımalar',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Literata',
                    ),
              ),
            ),
            if (state.isLoading)
              const SliverFillRemaining(
                child: Center(child: StillProgressIndicator(currentStep: 1, totalSteps: 3)),
              )
            else
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 140),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const StillSectionHeader(
                        title: 'Sessiz Gelişim',
                        subtitle: 'İyileşme yolculuğunun nazik bir özeti.',
                      ),
                      const SizedBox(height: 32),
                      _SummaryGrid(state: state),
                      const SizedBox(height: 48),
                      _MoodInsights(distribution: state.moodDistribution),
                      const SizedBox(height: 48),
                      _MilestoneHistory(history: state.milestoneHistory),
                      const SizedBox(height: 48),
                      _SosReflection(managedUrges: state.managedUrgeCount),
                      const SizedBox(height: 64),
                      const StillPrivacyNotice(
                        text: 'Bu alan yalnızca cihazındaki özet verilerle hazırlanır. Günlük notların ve mektup içeriklerin burada gösterilmez.',
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    ),
  );
}
}

class _SummaryGrid extends StatelessWidget {
  final InsightsData state;
  const _SummaryGrid({required this.state});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.1,
      children: [
        _StatCard(
          label: 'İletişimsiz',
          value: '${state.ncDays} Gün',
          icon: Icons.calendar_today_outlined,
          color: AppColors.primary,
        ),
        _StatCard(
          label: 'Duygu Serisi',
          value: '${state.moodStreak} Gün',
          icon: Icons.favorite_border_rounded,
          color: AppColors.secondary,
        ),
        _StatCard(
          label: 'Yönetilen Dürtü',
          value: '${state.managedUrgeCount}',
          icon: Icons.health_and_safety_outlined,
          color: AppColors.tertiary,
        ),
        _StatCard(
          label: 'Kilometre Taşı',
          value: '${state.milestoneCount}',
          icon: Icons.eco_outlined,
          color: AppColors.primary,
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return StillGlassCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 12),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            label.toUpperCase(),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.onSurfaceVariant,
                  letterSpacing: 1,
                  fontSize: 10,
                ),
          ),
        ],
      ),
    );
  }
}

class _MoodInsights extends StatelessWidget {
  final Map<String, int> distribution;
  const _MoodInsights({required this.distribution});

  @override
  Widget build(BuildContext context) {
    if (distribution.isEmpty) return const SizedBox.shrink();

    final total = distribution.values.fold(0, (sum, val) => sum + val);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const StillSectionHeader(
          title: 'Duygu Dengesi',
          subtitle: 'Son 14 gündeki baskın hislerin.',
        ),
        const SizedBox(height: 24),
        StillGlassCard(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: distribution.entries.map((entry) {
              final percent = entry.value / total;
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          entry.key,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        Text(
                          '${(percent * 100).toInt()}%',
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: AppColors.onSurfaceVariant,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Stack(
                      children: [
                        Container(
                          height: 4,
                          decoration: BoxDecoration(
                            color: AppColors.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: percent,
                          child: Container(
                            height: 4,
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.6),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _MilestoneHistory extends StatelessWidget {
  final List<Milestone> history;
  const _MilestoneHistory({required this.history});

  @override
  Widget build(BuildContext context) {
    if (history.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const StillSectionHeader(
          title: 'Yol İzleri',
          subtitle: 'Geride bıraktığın anlamlı anlar.',
        ),
        const SizedBox(height: 24),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: history.length,
          itemBuilder: (context, index) {
            final milestone = history[index];
            final dateStr = milestone.seenAt != null 
                ? DateFormat('d MMMM', 'tr_TR').format(milestone.seenAt!)
                : '';

            return IntrinsicHeight(
              child: Row(
                children: [
                  Column(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.3),
                          shape: BoxShape.circle,
                        ),
                      ),
                      if (index != history.length - 1)
                        Expanded(
                          child: Container(
                            width: 2,
                            color: AppColors.surfaceContainerHighest,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            dateStr.toUpperCase(),
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  color: AppColors.onSurfaceVariant,
                                  letterSpacing: 1,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            milestone.title,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Literata',
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            milestone.message,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColors.onSurfaceVariant,
                                  height: 1.5,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class _SosReflection extends StatelessWidget {
  final int managedUrges;
  const _SosReflection({required this.managedUrges});

  @override
  Widget build(BuildContext context) {
    return StillCard(
      padding: const EdgeInsets.all(24),
      color: AppColors.tertiary.withValues(alpha: 0.05),
      child: Row(
        children: [
          const Icon(Icons.shield_outlined, color: AppColors.tertiary, size: 32),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'GÜÇLÜ DURUŞ',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.tertiary,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Yönettiğin $managedUrges dürtü.',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Her duraklama, kendini seçtiğin bir andı.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.onSurfaceVariant,
                        fontStyle: FontStyle.italic,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

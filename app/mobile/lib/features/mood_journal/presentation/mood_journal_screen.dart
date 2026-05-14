import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../app/theme/app_theme.dart';
import '../../../core/design_system/still_widgets.dart';
import '../../../core/design_system/emotional_background.dart';
import '../../../data/models/mood_entry.dart';
import 'mood_journal_controller.dart';
import '../../privacy_lock/presentation/privacy_lock_gate.dart';

class MoodJournalScreen extends ConsumerWidget {
  const MoodJournalScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Ensure state is fresh for today
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(moodJournalControllerProvider.notifier).prepareForEntry();
    });

    final state = ref.watch(moodJournalControllerProvider);

    return PrivacyLockGate(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: EmotionalBackground(
          variant: EmotionalVariant.mood,
          child: state.isLoading
              ? const Center(child: StillProgressIndicator(currentStep: 1, totalSteps: 3)) // Simple loader
              : SafeArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(24, 32, 24, 180),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const StillSectionHeader(
                          title: 'Akşam Yansıması',
                          subtitle: 'Şu an nasıl hissettiğini onurlandırmak için sessiz bir alan.',
                        ),
                        const SizedBox(height: 32),
                        _WeeklySnapshot(state: state),
                        const SizedBox(height: 48),
                        _TodayCheckIn(state: state),
                        const SizedBox(height: 48),
                        _History(state: state),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

class _TodayCheckIn extends ConsumerStatefulWidget {
  final MoodJournalState state;
  const _TodayCheckIn({required this.state});

  @override
  ConsumerState<_TodayCheckIn> createState() => _TodayCheckInState();
}

class _TodayCheckInState extends ConsumerState<_TodayCheckIn> {
  final _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _noteController.text = widget.state.todayEntry?.note ?? '';
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final entry = widget.state.todayEntry;
    final controller = ref.read(moodJournalControllerProvider.notifier);

    // Sync controller if state changes from external load/reset
    ref.listen(moodJournalControllerProvider.select((s) => s.todayEntry?.note), (prev, next) {
      if (next != null && next != _noteController.text) {
        _noteController.text = next;
      } else if (next == null) {
        _noteController.clear();
      }
    });

    final moodItems = [
      {'label': 'Ağır', 'icon': Icons.water_drop},
      {'label': 'Yumuşak', 'icon': Icons.filter_vintage},
      {'label': 'Donuk', 'icon': Icons.air},
      {'label': 'Keskin', 'icon': Icons.bolt},
      {'label': 'Huzursuz', 'icon': Icons.grain},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StillGlassCard(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.state.isEditing) ...[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.edit_note, size: 16, color: AppColors.primary),
                      const SizedBox(width: 8),
                      Text(
                        'Bugünkü yansımanı düzenliyorsun.',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppColors.primary),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],
              const StillSectionHeader(title: 'Kalbin nasıl hissediyor?'),
              const SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                clipBehavior: Clip.none,
                child: Row(
                  children: moodItems.map((item) {
                    final isSelected = entry?.mood == item['label'];
                    return Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: GestureDetector(
                        onTap: () => controller.updateMood(item['label'] as String),
                        child: Column(
                          children: [
                            Container(
                              width: 64,
                              height: 64,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isSelected ? AppColors.primaryContainer : AppColors.surfaceContainerHigh,
                                border: isSelected ? Border.all(color: AppColors.primary, width: 2) : null,
                              ),
                              child: Icon(
                                item['icon'] as IconData,
                                color: isSelected ? AppColors.onPrimaryContainer : AppColors.primary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              item['label'] as String,
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: isSelected ? AppColors.primary : AppColors.onSurfaceVariant,
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const StillSectionHeader(title: 'Yoğunluk'),
                  Text(
                    '${entry?.intensity ?? 3}',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppColors.primary),
                  ),
                ],
              ),
              Slider(
                value: (entry?.intensity ?? 3).toDouble(),
                min: 1,
                max: 5,
                divisions: 4,
                activeColor: AppColors.primary,
                inactiveColor: AppColors.surfaceContainerHigh,
                onChanged: (value) => controller.updateIntensity(value.toInt()),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Fısıltı', style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppColors.outline)),
                    Text('Fırtına', style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppColors.outline)),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              const StillSectionHeader(title: 'Buna ne sebep oldu?'),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: triggerOptions.map((trigger) {
                  final isSelected = entry?.triggers.contains(trigger) ?? false;
                  return GestureDetector(
                    onTap: () => controller.toggleTrigger(trigger),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.tertiaryFixed : Colors.transparent, // More readable warm terracotta
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected ? AppColors.tertiary : AppColors.outlineVariant,
                        ),
                      ),
                      child: Text(
                        trigger,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: isSelected ? AppColors.onTertiaryFixed : AppColors.onSurfaceVariant,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 40),
              const StillSectionHeader(title: 'Özel Not (Opsiyonel)'),
              const SizedBox(height: 16),
              StillTextField(
                controller: _noteController,
                hintText: 'Zihninden geçenleri buraya dök...',
                isLarge: true,
                onChanged: (value) => controller.updateNote(value),
              ),
              const SizedBox(height: 40),
              StillPrimaryButton(
                label: widget.state.isEditing ? 'YANSIMAYI GÜNCELLE' : 'YANSIMAYI KAYDET',
                onPressed: () async {
                  await controller.saveTodayEntry();
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          widget.state.isEditing ? 'Bugünkü yansıman güncellendi.' : 'Yansıman güvenle saklandı.',
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _WeeklySnapshot extends StatelessWidget {
  final MoodJournalState state;
  const _WeeklySnapshot({required this.state});

  @override
  Widget build(BuildContext context) {
    return StillCard(
      padding: const EdgeInsets.all(24),
      color: AppColors.surfaceContainerLow,
      borderRadius: 32,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'HAFTALIK ÖZET',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColors.onSurfaceVariant,
                          letterSpacing: 2,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Dengeyi Bulmak',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppColors.primary),
                  ),
                ],
              ),
              SizedBox(
                height: 48,
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: List.generate(7, (index) {
                    final day = DateTime.now().subtract(Duration(days: 6 - index));
                    final hasEntry = state.entries.any((e) =>
                        e.date.year == day.year &&
                        e.date.month == day.month &&
                        e.date.day == day.day);
                    
                    return Container(
                      width: 8,
                      margin: const EdgeInsets.only(left: 4),
                      height: hasEntry ? 40 : 12,
                      decoration: BoxDecoration(
                        color: hasEntry ? AppColors.primary : AppColors.primary.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              const Icon(Icons.trending_up, color: AppColors.primary, size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Bu hafta ${state.currentStreak} günlük bir seri yakaladın. En sık tetikleyicin: ${state.mostCommonTrigger}.',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppColors.onSurfaceVariant),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _History extends StatelessWidget {
  final MoodJournalState state;
  const _History({required this.state});

  @override
  Widget build(BuildContext context) {
    final sortedEntries = List<MoodEntry>.from(state.entries)
      ..sort((a, b) => b.date.compareTo(a.date));

    if (sortedEntries.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const StillSectionHeader(title: 'Geçmiş Kayıtlar'),
        const SizedBox(height: 24),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: sortedEntries.length,
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final entry = sortedEntries[index];
            return StillGlassCard(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat('d MMMM y', 'tr_TR').format(entry.date).toUpperCase(),
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: AppColors.onSurfaceVariant,
                              letterSpacing: 1,
                              fontSize: 10,
                            ),
                      ),
                      Row(
                        children: List.generate(
                          5,
                          (i) => Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Icon(
                              Icons.circle,
                              size: 6,
                              color: i < entry.intensity ? AppColors.primary : AppColors.surfaceContainerHighest,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    entry.mood,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 18),
                  ),
                  if (entry.note != null && entry.note!.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      entry.note!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontFamily: 'Literata',
                            fontStyle: FontStyle.italic,
                            color: AppColors.onSurfaceVariant,
                          ),
                    ),
                  ],
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

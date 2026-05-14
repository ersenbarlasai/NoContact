import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../app/theme/app_theme.dart';
import '../../../core/design_system/still_widgets.dart';
import '../../../core/design_system/emotional_background.dart';
import '../../../data/models/recovery_profile.dart';
import '../../../l10n/app_localizations.dart';
import 'onboarding_controller.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _totalSteps = 11;

  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _pageController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _totalSteps - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      ref.read(onboardingControllerProvider.notifier).completeOnboarding();
      context.go('/');
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(onboardingControllerProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: EmotionalBackground(
        variant: EmotionalVariant.onboarding,
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: StillProgressIndicator(
                  currentStep: _currentPage,
                  totalSteps: _totalSteps,
                ),
              ),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (page) => setState(() => _currentPage = page),
                  children: [
                    _StepWelcome(onNext: _nextPage),
                    _StepName(
                      controller: _nameController,
                      onNext: (name) {
                        ref.read(onboardingControllerProvider.notifier).updateName(name);
                        _nextPage();
                      },
                    ),
                    _StepReason(
                      selectedReason: state.reason,
                      onSelected: (reason) {
                        ref.read(onboardingControllerProvider.notifier).updateReason(reason);
                        _nextPage();
                      },
                    ),
                    _StepRelationshipDuration(
                      selectedDuration: state.relationshipDuration,
                      onSelected: (duration) {
                        ref.read(onboardingControllerProvider.notifier).updateRelationshipDuration(duration);
                        _nextPage();
                      },
                    ),
                    _StepTimeSinceBreakup(
                      selectedTime: state.timeSinceBreakup,
                      onSelected: (time) {
                        ref.read(onboardingControllerProvider.notifier).updateTimeSinceBreakup(time);
                        _nextPage();
                      },
                    ),
                    _StepWhoEnded(
                      selectedWho: state.whoEnded,
                      onSelected: (who) {
                        ref.read(onboardingControllerProvider.notifier).updateWhoEnded(who);
                        _nextPage();
                      },
                    ),
                    _StepNoContactDate(
                      selectedDate: state.noContactStartDate ?? DateTime.now(),
                      onSelected: (date) {
                        ref.read(onboardingControllerProvider.notifier).updateNoContactStartDate(date);
                        _nextPage();
                      },
                      onSkip: _nextPage,
                    ),
                    _StepEmotion(
                      selectedEmotion: state.dominantEmotion,
                      onSelected: (emotion) {
                        ref.read(onboardingControllerProvider.notifier).updateDominantEmotion(emotion);
                        _nextPage();
                      },
                    ),
                    _StepTriggers(
                      selectedTriggers: state.contactTriggers,
                      onToggle: (trigger) {
                        ref.read(onboardingControllerProvider.notifier).toggleContactTrigger(trigger);
                      },
                      onNext: _nextPage,
                    ),
                    _StepContract(
                      onCommit: () {
                        ref.read(onboardingControllerProvider.notifier).commitToContract();
                        _nextPage();
                      },
                    ),
                    _StepPlanPreview(
                      state: state,
                      onComplete: () async {
                        final router = GoRouter.of(context);
                        await ref.read(onboardingControllerProvider.notifier).completeOnboarding();
                        if (mounted) router.go('/');
                      },
                    ),
                  ],
                ),
              ),
              if (_currentPage > 0 && _currentPage < _totalSteps - 1)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: TextButton(
                    onPressed: _previousPage,
                    child: Text(l10n.backBtn, style: Theme.of(context).textTheme.labelLarge?.copyWith(color: AppColors.onSurfaceVariant)),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StepWelcome extends StatelessWidget {
  final VoidCallback onNext;
  const _StepWelcome({required this.onNext});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 48),
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 240,
                  height: 240,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary.withOpacity(0.05),
                  ),
                ),
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLow,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.05),
                        blurRadius: 40,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.spa_outlined,
                      size: 80,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 48),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              children: [
                Text(
                  l10n.onboardingWelcomeHeadline1,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 32),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.onboardingWelcomeHeadline2,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 32, color: AppColors.primary),
                ),
                const SizedBox(height: 24),
                Text(
                  l10n.onboardingWelcomeSubtitle,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.onSurfaceVariant),
                ),
              ],
            ),
          ),
          const SizedBox(height: 64),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: StillPrimaryButton(
              label: l10n.onboardingStartBtn,
              onPressed: onNext,
            ),
          ),
          const SizedBox(height: 48),
        ],
      ),
    );
  }
}

class _StepName extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String) onNext;
  const _StepName({required this.controller, required this.onNext});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.onboardingNameTitle, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 12),
          Text(
            l10n.onboardingNameSubtitle,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.onSurfaceVariant),
          ),
          const SizedBox(height: 48),
          StillTextField(controller: controller, hintText: l10n.onboardingNameHint),
          const Spacer(),
          StillPrimaryButton(
            label: l10n.continueBtn,
            onPressed: () {
              if (controller.text.isNotEmpty) {
                onNext(controller.text);
              }
            },
          ),
        ],
      ),
    );
  }
}

class _StepReason extends StatelessWidget {
  final String selectedReason;
  final void Function(String) onSelected;
  const _StepReason({required this.selectedReason, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final reasons = [
      l10n.onboardingReason1,
      l10n.onboardingReason2,
      l10n.onboardingReason3,
      l10n.onboardingReason4,
      l10n.onboardingReason5,
    ];
    return _BuildSelectionStep(
      title: l10n.onboardingReasonTitle,
      options: reasons,
      selectedOption: selectedReason,
      onSelected: onSelected,
    );
  }
}

class _StepRelationshipDuration extends StatelessWidget {
  final String selectedDuration;
  final void Function(String) onSelected;
  const _StepRelationshipDuration({required this.selectedDuration, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final options = [
      l10n.onboardingRelDuration1,
      l10n.onboardingRelDuration2,
      l10n.onboardingRelDuration3,
      l10n.onboardingRelDuration4,
      l10n.onboardingRelDuration5,
      l10n.onboardingRelDuration6,
    ];
    return _BuildSelectionStep(
      title: l10n.onboardingRelDurationTitle,
      options: options,
      selectedOption: selectedDuration,
      onSelected: onSelected,
    );
  }
}

class _StepTimeSinceBreakup extends StatelessWidget {
  final String selectedTime;
  final void Function(String) onSelected;
  const _StepTimeSinceBreakup({required this.selectedTime, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final options = [
      l10n.onboardingBreakupTime1,
      l10n.onboardingBreakupTime2,
      l10n.onboardingBreakupTime3,
      l10n.onboardingBreakupTime4,
    ];
    return _BuildSelectionStep(
      title: l10n.onboardingBreakupTimeTitle,
      options: options,
      selectedOption: selectedTime,
      onSelected: onSelected,
    );
  }
}

class _StepWhoEnded extends StatelessWidget {
  final String selectedWho;
  final void Function(String) onSelected;
  const _StepWhoEnded({required this.selectedWho, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final options = [
      l10n.onboardingWhoEndedMe,
      l10n.onboardingWhoEndedThem,
      l10n.onboardingWhoEndedMutual,
    ];
    return _BuildSelectionStep(
      title: l10n.onboardingWhoEndedTitle,
      options: options,
      selectedOption: selectedWho,
      onSelected: onSelected,
    );
  }
}

class _StepNoContactDate extends StatelessWidget {
  final DateTime selectedDate;
  final void Function(DateTime) onSelected;
  final VoidCallback onSkip;
  const _StepNoContactDate({
    required this.selectedDate,
    required this.onSelected,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toString();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.onboardingNoContactDateTitle, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 12),
            Text(
              l10n.onboardingNoContactDateSubtitle,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.onSurfaceVariant),
            ),
            const SizedBox(height: 64),
            Center(
              child: StillGlassCard(
                padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
                child: Column(
                  children: [
                    Text(
                      DateFormat('dd MMMM yyyy', locale).format(selectedDate),
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 24),
                    OutlinedButton.icon(
                      onPressed: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: selectedDate,
                          firstDate: DateTime.now().subtract(const Duration(days: 365 * 2)),
                          lastDate: DateTime.now(),
                        );
                        if (picked != null) onSelected(picked);
                      },
                      icon: const Icon(Icons.calendar_today, size: 18),
                      label: Text(l10n.onboardingChangeDateBtn),
                      style: OutlinedButton.styleFrom(
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 64),
            StillPrimaryButton(
              label: l10n.continueBtn,
              onPressed: () => onSelected(selectedDate),
            ),
            const SizedBox(height: 16),
            Center(
              child: TextButton(
                onPressed: onSkip,
                child: Text(l10n.onboardingSkipDateBtn, style: TextStyle(color: AppColors.onSurfaceVariant)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StepEmotion extends StatelessWidget {
  final String selectedEmotion;
  final void Function(String) onSelected;
  const _StepEmotion({required this.selectedEmotion, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final options = [
      l10n.emotionSad,
      l10n.emotionAngry,
      l10n.emotionAnxious,
      l10n.emotionCalm,
      l10n.emotionConfused,
      l10n.emotionMissing,
    ];
    return _BuildSelectionStep(
      title: l10n.onboardingEmotionTitle,
      options: options,
      selectedOption: selectedEmotion,
      onSelected: onSelected,
    );
  }
}

class _StepTriggers extends StatelessWidget {
  final List<String> selectedTriggers;
  final void Function(String) onToggle;
  final VoidCallback onNext;
  const _StepTriggers({
    required this.selectedTriggers,
    required this.onToggle,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final options = [
      l10n.onboardingTrigger1,
      l10n.onboardingTrigger2,
      l10n.onboardingTrigger3,
      l10n.onboardingTrigger4,
      l10n.onboardingTrigger5,
    ];

    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.onboardingTriggersTitle, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 12),
          Text(
            l10n.onboardingTriggersSubtitle,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.onSurfaceVariant),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: ListView.builder(
              itemCount: options.length,
              itemBuilder: (context, index) {
                final option = options[index];
                return StillOptionTile(
                  title: option,
                  isSelected: selectedTriggers.contains(option),
                  onTap: () => onToggle(option),
                );
              },
            ),
          ),
          StillPrimaryButton(
            label: l10n.continueBtn,
            onPressed: selectedTriggers.isEmpty ? null : onNext,
          ),
        ],
      ),
    );
  }
}

class _StepContract extends StatelessWidget {
  final VoidCallback onCommit;
  const _StepContract({required this.onCommit});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            StillSectionHeader(
              title: l10n.onboardingContractTitle,
              subtitle: l10n.onboardingContractSubtitle,
              centered: true,
            ),
            const SizedBox(height: 16),
            Text(
              l10n.onboardingContractBody,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.onSurfaceVariant),
            ),
            const SizedBox(height: 48),
            _ContractItem(
              icon: Icons.emergency,
              title: l10n.onboardingContract1Title,
              subtitle: l10n.onboardingContract1Subtitle,
              color: AppColors.primary,
            ),
            _ContractItem(
              icon: Icons.visibility_off,
              title: l10n.onboardingContract2Title,
              subtitle: l10n.onboardingContract2Subtitle,
              color: AppColors.tertiary,
            ),
            _ContractItem(
              icon: Icons.psychology_alt,
              title: l10n.onboardingContract3Title,
              subtitle: l10n.onboardingContract3Subtitle,
              color: AppColors.secondary,
            ),
            const SizedBox(height: 48),
            Text(
              l10n.onboardingContractSealHint,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 32),
            _HoldToCommitButton(onCommit: onCommit),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}

class _ContractItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  const _ContractItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: StillGlassCard(
        padding: const EdgeInsets.all(24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 18)),
                  const SizedBox(height: 8),
                  Text(subtitle, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.onSurfaceVariant)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HoldToCommitButton extends StatefulWidget {
  final VoidCallback onCommit;
  const _HoldToCommitButton({required this.onCommit});

  @override
  State<_HoldToCommitButton> createState() => _HoldToCommitButtonState();
}

class _HoldToCommitButtonState extends State<_HoldToCommitButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isHolding = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          widget.onCommit();
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return GestureDetector(
      onTapDown: (_) {
        setState(() => _isHolding = true);
        _controller.forward();
      },
      onTapUp: (_) {
        setState(() => _isHolding = false);
        _controller.reverse();
      },
      onTapCancel: () {
        setState(() => _isHolding = false);
        _controller.reverse();
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 140,
            height: 140,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (_, __) => CircularProgressIndicator(
                value: _controller.value,
                strokeWidth: 8,
                backgroundColor: AppColors.primary.withOpacity(0.1),
                valueColor: const AlwaysStoppedAnimation(AppColors.primary),
              ),
            ),
          ),
          AnimatedScale(
            scale: _isHolding ? 0.95 : 1.0,
            duration: const Duration(milliseconds: 200),
            child: Container(
              width: 120,
              height: 120,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary,
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4)),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.fingerprint, color: Colors.white, size: 40),
                  const SizedBox(height: 8),
                  Text(
                    l10n.onboardingContractSealBtn,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StepPlanPreview extends StatelessWidget {
  final RecoveryProfile state;
  final VoidCallback onComplete;
  const _StepPlanPreview({required this.state, required this.onComplete});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final days = DateTime.now().difference(state.noContactStartDate ?? DateTime.now()).inDays;
    final mainTrigger = state.contactTriggers.isNotEmpty ? state.contactTriggers.first : l10n.onboardingPlanTriggerUnknown;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StillSectionHeader(
              title: l10n.onboardingPlanTitle,
              subtitle: l10n.onboardingPlanSubtitle(state.name),
            ),
            const SizedBox(height: 48),
            _buildInfoRow(context, Icons.timer_outlined, l10n.onboardingPlanDurationLabel, l10n.onboardingPlanDurationValue(days)),
            _buildInfoRow(context, Icons.mood_outlined, l10n.onboardingPlanMoodLabel, state.dominantEmotion),
            _buildInfoRow(context, Icons.warning_amber_outlined, l10n.onboardingPlanTriggerLabel, mainTrigger),
            const SizedBox(height: 48),
            StillCard(
              color: AppColors.primary.withOpacity(0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.onboardingPlanFirst24Title,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(letterSpacing: 1.2, color: AppColors.primary),
                  ),
                  const SizedBox(height: 12),
                  Text(l10n.onboardingPlanFirst24Body, style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
            const SizedBox(height: 48),
            Center(
              child: Text(
                l10n.appDisclaimer,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.onSurfaceVariant),
              ),
            ),
            const SizedBox(height: 24),
            StillPrimaryButton(label: l10n.onboardingStartJourneyBtn, onPressed: onComplete),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: AppColors.surfaceContainerHigh, shape: BoxShape.circle),
            child: Icon(icon, color: AppColors.primary, size: 24),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: Theme.of(context).textTheme.labelSmall),
                Text(value, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 18)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BuildSelectionStep extends StatelessWidget {
  final String title;
  final List<String> options;
  final String selectedOption;
  final void Function(String) onSelected;

  const _BuildSelectionStep({
    required this.title,
    required this.options,
    required this.selectedOption,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 48),
          Expanded(
            child: ListView.builder(
              itemCount: options.length,
              itemBuilder: (context, index) {
                final option = options[index];
                return StillOptionTile(
                  title: option,
                  isSelected: selectedOption == option,
                  onTap: () => onSelected(option),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

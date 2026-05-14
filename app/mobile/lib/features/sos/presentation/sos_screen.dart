import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';
import '../../../app/theme/app_theme.dart';
import '../../../core/design_system/still_widgets.dart';
import '../../../core/design_system/emotional_background.dart';
import '../../../l10n/app_localizations.dart';
import '../../onboarding/presentation/onboarding_controller.dart';
import '../../support_system/presentation/support_controller.dart';
import 'sos_controller.dart';

class SosScreen extends ConsumerStatefulWidget {
  const SosScreen({super.key});
  @override
  ConsumerState<SosScreen> createState() => _SosScreenState();
}

class _SosScreenState extends ConsumerState<SosScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(sosControllerProvider.notifier).startSession();
    });
  }

  @override
  void dispose() { _pageController.dispose(); super.dispose(); }

  void _nextPage() {
    if (_currentPage < 3) {
      _pageController.nextPage(duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
    } else {
      context.go('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: EmotionalBackground(
        variant: EmotionalVariant.sos,
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close, color: AppColors.onSurfaceVariant),
                      onPressed: () => context.go('/'),
                    ),
                    Text(
                      l10n.sosTitle.toUpperCase(),
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            letterSpacing: 4, color: AppColors.primary,
                            fontFamily: 'Manrope', fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: StillProgressIndicator(currentStep: _currentPage, totalSteps: 4),
              ),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (page) => setState(() => _currentPage = page),
                  children: [
                    _StepBreathe(onNext: _nextPage),
                    _StepRemember(onNext: _nextPage),
                    _StepWrite(onNext: _nextPage),
                    _StepChoose(onComplete: () async {
                      final router = GoRouter.of(context);
                      await ref.read(sosControllerProvider.notifier).finishSession();
                      if (mounted) router.go('/');
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StepBreathe extends StatefulWidget {
  final VoidCallback onNext;
  const _StepBreathe({required this.onNext});
  @override
  State<_StepBreathe> createState() => _StepBreatheState();
}

class _StepBreatheState extends State<_StepBreathe> with TickerProviderStateMixin {
  late AnimationController _breathingController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  bool _isInhale = true;
  int _secondsLeft = 60;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _breathingController = AnimationController(vsync: this, duration: const Duration(seconds: 4))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() => _isInhale = false);
          _breathingController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          setState(() => _isInhale = true);
          _breathingController.forward();
        }
      });
    _scaleAnimation = Tween<double>(begin: 0.85, end: 1.15).animate(
        CurvedAnimation(parent: _breathingController, curve: Curves.easeInOut));
    _opacityAnimation = Tween<double>(begin: 0.4, end: 0.8).animate(
        CurvedAnimation(parent: _breathingController, curve: Curves.easeInOut));
    _breathingController.forward();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft > 0 && mounted) setState(() => _secondsLeft--);
    });
  }

  @override
  void dispose() { _breathingController.dispose(); _timer?.cancel(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      children: [
        const SizedBox(height: 32),
        StillSectionHeader(title: l10n.sosStep1Title, subtitle: l10n.sosSubtitle, centered: true),
        const Spacer(),
        AnimatedBuilder(
          animation: _breathingController,
          builder: (context, child) => SizedBox(
            width: 320, height: 320,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 300 * _scaleAnimation.value, height: 300 * _scaleAnimation.value,
                  decoration: BoxDecoration(shape: BoxShape.circle,
                    gradient: RadialGradient(colors: [
                      AppColors.primary.withValues(alpha: 0.15 * _opacityAnimation.value),
                      AppColors.primary.withValues(alpha: 0.0)])),
                ),
                Container(
                  width: 160 * _scaleAnimation.value, height: 160 * _scaleAnimation.value,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle, color: AppColors.primary.withValues(alpha: 0.1),
                    boxShadow: [BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.05 * _opacityAnimation.value),
                      blurRadius: 60, spreadRadius: 20)]),
                  child: Center(
                    child: Text(
                      _isInhale ? l10n.sosBreathIn : l10n.sosBreathOut,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: AppColors.primary, fontStyle: FontStyle.italic,
                            fontFamily: 'Literata', fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: StillPrimaryButton(
            label: l10n.sosBetterBtn,
            onPressed: _secondsLeft < 52 ? widget.onNext : null,
          ),
        ),
        const SizedBox(height: 16),
        Text('$_secondsLeft', style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColors.onSurfaceVariant, fontWeight: FontWeight.bold)),
        const SizedBox(height: 32),
      ],
    );
  }
}

class _StepRemember extends ConsumerWidget {
  final VoidCallback onNext;
  const _StepRemember({required this.onNext});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final profile = ref.watch(onboardingControllerProvider);
    final supportState = ref.watch(supportControllerProvider);
    final pinnedCards = supportState.cards.where((c) => c.isPinned).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StillSectionHeader(title: l10n.supportReasonTitle, subtitle: l10n.onboardingContractBody),
          const SizedBox(height: 32),
          if (pinnedCards.isNotEmpty)
            ...pinnedCards.map((card) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: StillCard(
                    color: AppColors.tertiaryFixed.withOpacity(0.3),
                    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      const Icon(Icons.favorite, color: AppColors.tertiary),
                      const SizedBox(width: 16),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(card.title, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 18)),
                        const SizedBox(height: 8),
                        Text(card.body, style: Theme.of(context).textTheme.bodyMedium),
                      ])),
                    ]),
                  ),
                ))
          else
            StillCard(
              color: AppColors.tertiaryFixed.withOpacity(0.3),
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Icon(Icons.favorite, color: AppColors.tertiary),
                const SizedBox(width: 16),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(profile.name, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 18)),
                  const SizedBox(height: 8),
                  Text('"${profile.reason}"', style: Theme.of(context).textTheme.bodyMedium),
                ])),
              ]),
            ),
          const SizedBox(height: 24),
          StillSectionHeader(title: l10n.onboardingContractTitle),
          const SizedBox(height: 16),
          _commitItem(context, l10n.onboardingContract1Title, l10n.onboardingContract1Subtitle, Icons.emergency, AppColors.primary),
          _commitItem(context, l10n.onboardingContract2Title, l10n.onboardingContract2Subtitle, Icons.visibility_off, AppColors.tertiary),
          const SizedBox(height: 32),
          StillPrimaryButton(label: l10n.continueBtn, onPressed: onNext),
        ],
      ),
    );
  }

  Widget _commitItem(BuildContext context, String title, String subtitle, IconData icon, Color color) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: StillCard(
          padding: const EdgeInsets.all(20),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 16),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: 4),
              Text(subtitle, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.onSurfaceVariant)),
            ])),
          ]),
        ),
      );
}

class _StepWrite extends ConsumerStatefulWidget {
  final VoidCallback onNext;
  const _StepWrite({required this.onNext});
  @override
  ConsumerState<_StepWrite> createState() => _StepWriteState();
}

class _StepWriteState extends ConsumerState<_StepWrite> {
  final TextEditingController _controller = TextEditingController();
  @override
  void dispose() { _controller.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32.0).copyWith(bottom: MediaQuery.viewInsetsOf(context).bottom + 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          StillSectionHeader(title: l10n.sosWriteTitle, subtitle: l10n.sosWriteSubtitle, centered: true),
          const SizedBox(height: 32),
          StillGlassCard(
            padding: const EdgeInsets.all(24),
            opacity: 0.4,
            child: Column(
              children: [
                TextField(
                  controller: _controller,
                  minLines: 6,
                  maxLines: 12,
                  textAlignVertical: TextAlignVertical.top,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.6, color: AppColors.onSurface),
                  decoration: InputDecoration(
                    hintText: l10n.sosWriteHint,
                    hintStyle: TextStyle(color: AppColors.outline.withValues(alpha: 0.8), fontStyle: FontStyle.italic),
                    border: InputBorder.none,
                    fillColor: Colors.transparent,
                  ),
                  onChanged: (val) => ref.read(sosControllerProvider.notifier).updateUrgeText(val),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.lock_outline, size: 14, color: AppColors.onSurfaceVariant),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(l10n.sosWritePrivacyNote,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              fontStyle: FontStyle.italic,
                              color: AppColors.onSurfaceVariant.withValues(alpha: 0.6))),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          StillPrimaryButton(
            label: l10n.sosWriteReleaseBtn,
            icon: Icons.auto_awesome,
            onPressed: () { if (_controller.text.isNotEmpty) widget.onNext(); },
          ),
          const SizedBox(height: 16),
          const Icon(Icons.air, color: AppColors.tertiary, size: 24),
        ],
      ),
    );
  }
}

class _StepChoose extends ConsumerStatefulWidget {
  final VoidCallback onComplete;
  const _StepChoose({required this.onComplete});
  @override
  ConsumerState<_StepChoose> createState() => _StepChooseState();
}

class _StepChooseState extends ConsumerState<_StepChoose> {
  bool _stillStruggling = false;
  bool _completed = false;

  @override
  Widget build(BuildContext context) {
    if (_completed) return _buildCompletionState(context);
    if (_stillStruggling) return _buildExtraGroundingState(context);
    final l10n = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.primary.withOpacity(0.05)),
            child: const Icon(Icons.shield_outlined, size: 64, color: AppColors.primary),
          ),
          const SizedBox(height: 48),
          StillSectionHeader(title: l10n.sosChooseTitle, subtitle: l10n.sosChooseSubtitle, centered: true),
          const Spacer(),
          StillPrimaryButton(
            label: l10n.sosChooseYes,
            onPressed: () {
              ref.read(sosControllerProvider.notifier).setOutcome('maintained_nc');
              setState(() => _completed = true);
            },
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {
              ref.read(sosControllerProvider.notifier).setOutcome('still_struggling');
              setState(() => _stillStruggling = true);
            },
            child: Text(l10n.sosChooseStillStruggling,
                style: TextStyle(color: AppColors.onSurfaceVariant, fontWeight: FontWeight.w600)),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildCompletionState(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.spa, size: 80, color: AppColors.primary),
          const SizedBox(height: 48),
          StillSectionHeader(title: l10n.sosCompletionTitle, subtitle: l10n.sosCompletionSubtitle, centered: true),
          const Spacer(),
          StillPrimaryButton(label: l10n.sosReturnBtn, onPressed: widget.onComplete),
          const SizedBox(height: 48),
        ],
      ),
    );
  }

  Widget _buildExtraGroundingState(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final actions = [
      {'title': l10n.sosGroundingAction1, 'icon': Icons.water_drop},
      {'title': l10n.sosGroundingAction2, 'icon': Icons.phonelink_erase},
      {'title': l10n.sosGroundingAction3, 'icon': Icons.air},
    ];

    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StillSectionHeader(title: l10n.sosGroundingTitle, subtitle: l10n.sosGroundingSubtitle),
          const SizedBox(height: 32),
          Expanded(
            child: ListView(
              children: actions.map((a) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: StillOptionTile(
                      title: a['title'] as String,
                      icon: a['icon'] as IconData,
                      isSelected: false,
                      onTap: () => ref.read(sosControllerProvider.notifier)
                          .toggleGroundingAction(a['title'] as String),
                    ),
                  )).toList(),
            ),
          ),
          const SizedBox(height: 24),
          StillCard(
            color: AppColors.errorContainer.withOpacity(0.1),
            child: Text(l10n.sosCrisisWarning,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.error, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
          ),
          const SizedBox(height: 32),
          StillPrimaryButton(label: l10n.sosBetterBtn, onPressed: widget.onComplete),
        ],
      ),
    );
  }
}

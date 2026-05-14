import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../app/theme/app_theme.dart';
import '../../../core/design_system/emotional_background.dart';
import '../../../core/design_system/still_widgets.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/silent_reply_need.dart';
import 'silent_reply_controller.dart';
import '../../support_system/presentation/support_controller.dart';

class SilentReplyScreen extends ConsumerStatefulWidget {
  const SilentReplyScreen({super.key});

  @override
  ConsumerState<SilentReplyScreen> createState() => _SilentReplyScreenState();
}

class _SilentReplyScreenState extends ConsumerState<SilentReplyScreen> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    ref.read(silentReplyControllerProvider.notifier).nextStep();
  }

  void _previousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    ref.read(silentReplyControllerProvider.notifier).previousStep();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(silentReplyControllerProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: EmotionalBackground(
        variant: EmotionalVariant.support,
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(context, state),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _Step1Write(onNext: _nextPage),
                    _Step2Notice(onNext: _nextPage, onBack: _previousPage),
                    _Step3Choose(onBack: _previousPage),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, SilentReplyState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.close, color: AppColors.onSurfaceVariant),
            onPressed: () {
              ref.read(silentReplyControllerProvider.notifier).reset();
              context.pop();
            },
          ),
          Row(
            children: List.generate(3, (index) {
              final isActive = index <= state.currentStep;
              return Container(
                width: 32,
                height: 4,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: isActive ? AppColors.primary : AppColors.outline.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(2),
                ),
              );
            }),
          ),
          const SizedBox(width: 48), // Spacer for balance
        ],
      ),
    );
  }
}

class _Step1Write extends ConsumerWidget {
  final VoidCallback onNext;
  const _Step1Write({required this.onNext});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(silentReplyControllerProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 180),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StillSectionHeader(
            title: AppLocalizations.of(context).silentReplyTitle,
            subtitle: AppLocalizations.of(context).silentReplySubtitle,
          ),
          const SizedBox(height: 32),
          StillGlassCard(
            padding: EdgeInsets.zero,
            child: TextField(
              maxLines: 12,
              onChanged: (val) => ref.read(silentReplyControllerProvider.notifier).updateDraftText(val),
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context).silentReplyHint,
                hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.onSurfaceVariant.withValues(alpha: 0.5),
                ),
                contentPadding: const EdgeInsets.all(24),
                border: InputBorder.none,
              ),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                height: 1.6,
                fontFamily: 'Manrope',
              ),
            ),
          ),
          const SizedBox(height: 24),
          if (state.error != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                state.error!,
                style: const TextStyle(color: Colors.redAccent, fontSize: 13),
              ),
            ),
          StillPrimaryButton(
            label: AppLocalizations.of(context).continueBtn,
            onPressed: state.draftText.trim().isNotEmpty ? onNext : null,
          ),
          const SizedBox(height: 32),
          StillPrivacyNotice(
            text: AppLocalizations.of(context).silentReplyPrivacyNote,
          ),
        ],
      ),
    );
  }
}

class _Step2Notice extends ConsumerWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const _Step2Notice({required this.onNext, required this.onBack});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(silentReplyControllerProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 180),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const StillSectionHeader(
            title: 'Bu cevabın altında ne var?',
            subtitle: 'Bazen göndermek istediğimiz cevap, aslında bir ihtiyacın sesidir.',
          ),
          const SizedBox(height: 32),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: SilentReplyNeed.values.map((need) {
              final isSelected = state.selectedNeed == need;
              return InkWell(
                onTap: () => ref.read(silentReplyControllerProvider.notifier).selectNeed(need),
                borderRadius: BorderRadius.circular(16),
                child: StillGlassCard(
                  padding: EdgeInsets.zero,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary.withValues(alpha: 0.1) : Colors.transparent,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isSelected ? Icons.check_circle : Icons.circle_outlined,
                          size: 18,
                          color: isSelected ? AppColors.primary : AppColors.outline,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          need.label,
                          style: TextStyle(
                            color: isSelected ? AppColors.primary : AppColors.onSurface,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 48),
          if (state.error != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                state.error!,
                style: const TextStyle(color: Colors.redAccent, fontSize: 13),
              ),
            ),
          StillPrimaryButton(
            label: AppLocalizations.of(context).silentReplyShowOptions,
            onPressed: state.selectedNeed != null ? onNext : null,
          ),
          const SizedBox(height: 16),
          StillSecondaryButton(
            label: AppLocalizations.of(context).backBtn,
            onPressed: onBack,
          ),
        ],
      ),
    );
  }
}

class _Step3Choose extends ConsumerStatefulWidget {
  final VoidCallback onBack;
  const _Step3Choose({required this.onBack});

  @override
  ConsumerState<_Step3Choose> createState() => _Step3ChooseState();
}

class _Step3ChooseState extends ConsumerState<_Step3Choose> {
  bool _showBoundarySentence = false;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(silentReplyControllerProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 180),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StillSectionHeader(
            title: AppLocalizations.of(context).silentReplyStep3Title,
            subtitle: AppLocalizations.of(context).silentReplyStep3Subtitle,
          ),
          const SizedBox(height: 32),
          
          if (_showBoundarySentence && state.selectedNeed != null) ...[
            StillGlassCard(
              padding: EdgeInsets.zero,
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.primaryContainer.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.auto_awesome, size: 16, color: AppColors.primary),
                        const SizedBox(width: 8),
                        Text(
                          AppLocalizations.of(context).silentReplyTitle,
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      state.selectedNeed!.boundarySentence,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontStyle: FontStyle.italic,
                        fontFamily: 'Literata',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],

          _OptionItem(
            icon: Icons.lock_outline,
            title: AppLocalizations.of(context).silentReplySaveToVault,
            description: AppLocalizations.of(context).silentReplyPrivacyNote,
            onTap: () async {
              final success = await ref.read(silentReplyControllerProvider.notifier).saveToVault();
              if (success && mounted) {
                final l10n = AppLocalizations.of(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n.silentReplySavedSnackbar)),
                );
                context.go('/');
              }
            },
          ),
          const SizedBox(height: 16),
          _OptionItem(
            icon: Icons.timer_outlined,
            title: '24 saat beklet',
            description: 'Bu cevaba bugün karar verme. Yarın tekrar bakarsın.',
            onTap: () async {
              await ref.read(supportControllerProvider.notifier).start24hPause(source: 'silent_reply_wait');
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Kararını yarına bıraktın.')),
                );
                context.go('/');
              }
            },
          ),
          const SizedBox(height: 16),
          _OptionItem(
            icon: Icons.health_and_safety_outlined,
            title: 'SOS’a geç',
            description: 'Dürtü çok güçlüyse önce bedenini sakinleştir.',
            onTap: () => context.push('/sos'),
          ),
          const SizedBox(height: 16),
          if (!_showBoundarySentence)
            _OptionItem(
              icon: Icons.psychology_outlined,
              title: 'Sınır cümlesine dönüştür',
              description: 'Göndermek zorunda olmadığın, sakin bir cümle gör.',
              onTap: () => setState(() => _showBoundarySentence = true),
            ),
          
          const SizedBox(height: 32),
          StillSecondaryButton(
            label: AppLocalizations.of(context).backBtn,
            onPressed: widget.onBack,
          ),
        ],
      ),
    );
  }
}

class _OptionItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;

  const _OptionItem({
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return StillGlassCard(
      onTap: onTap,
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, size: 18, color: AppColors.outline),
        ],
      ),
    );
  }
}

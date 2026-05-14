import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../app/theme/app_theme.dart';
import '../../../core/design_system/still_widgets.dart';
import '../../../core/design_system/emotional_background.dart';
import '../../../data/models/unsent_letter.dart';
import 'letters_vault_controller.dart';

import '../../privacy_lock/presentation/privacy_lock_gate.dart';

class LettersVaultScreen extends ConsumerWidget {
  const LettersVaultScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(lettersVaultControllerProvider);

    return PrivacyLockGate(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: EmotionalBackground(
          variant: EmotionalVariant.recovery,
          child: SafeArea(
            child: Column(
              children: [
                // Top Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: AppColors.onSurfaceVariant),
                        onPressed: () => context.go('/'),
                      ),
                      Text(
                        'MEKTUP KASASI',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              letterSpacing: 2,
                              color: AppColors.primary,
                            ),
                      ),
                      const SizedBox(width: 48),
                    ],
                  ),
                ),
                
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: StillPrivacyNotice(
                    text: 'Buraya yazdıkların bu cihazda şifreli saklanır ve asla kimseye gönderilmez.',
                  ),
                ),
                
                Expanded(
                  child: state.isLoading
                      ? const Center(child: StillProgressIndicator(currentStep: 1, totalSteps: 3))
                      : DefaultTabController(
                          length: 2,
                          child: Column(
                            children: [
                              const TabBar(
                                labelColor: AppColors.primary,
                                unselectedLabelColor: AppColors.onSurfaceVariant,
                                indicatorColor: AppColors.primary,
                                tabs: [
                                  Tab(text: 'Aktif Mektuplar'),
                                  Tab(text: 'Arşivlenenler'),
                                ],
                              ),
                              Expanded(
                                child: TabBarView(
                                  children: [
                                    // Aktif Mektuplar Tab
                                    state.activeLetters.isEmpty
                                        ? const _EmptyState(
                                            title: 'Henüz burada sakladığın bir mektup yok.',
                                            subtitle: 'Yazmak istediğinde burası güvenli alanın.',
                                          )
                                        : ListView.builder(
                                            padding: const EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 100),
                                            itemCount: state.activeLetters.length,
                                            itemBuilder: (context, index) {
                                              return _LetterCard(letter: state.activeLetters[index]);
                                            },
                                          ),
                                    // Arşivlenenler Tab
                                    state.archivedLetters.isEmpty
                                        ? const _EmptyState(
                                            title: 'Henüz arşivlediğin bir mektup yok.',
                                            subtitle: 'Hazır olduğunda bazı mektupları gözünün önünden kaldırabilirsin.',
                                          )
                                        : ListView.builder(
                                            padding: const EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 100),
                                            itemCount: state.archivedLetters.length,
                                            itemBuilder: (context, index) {
                                              return _LetterCard(letter: state.archivedLetters[index], isArchived: true);
                                            },
                                          ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            final draft = ref.read(lettersVaultControllerProvider.notifier).createDraft();
            context.push('/letters-vault/editor', extra: draft);
          },
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          label: const Text('MEKTUP YAZ'),
          icon: const Icon(Icons.history_edu),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final String title;
  final String subtitle;

  const _EmptyState({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerHigh,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.mail_outline, size: 64, color: AppColors.primary),
            ),
            const SizedBox(height: 32),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontFamily: 'Literata',
                  ),
            ),
            const SizedBox(height: 16),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}

class _LetterCard extends StatelessWidget {
  final UnsentLetter letter;
  final bool isArchived;

  const _LetterCard({required this.letter, this.isArchived = false});

  @override
  Widget build(BuildContext context) {
    final preview = letter.body.split('\n').first;
    final date = DateFormat('d MMMM y', 'tr_TR').format(isArchived ? letter.archivedAt! : letter.updatedAt);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: StillCard(
        onTap: () => context.push('/letters-vault/editor', extra: letter),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    letter.title != null && letter.title!.isNotEmpty ? letter.title! : preview,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontSize: 18,
                          fontFamily: 'Literata',
                        ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        date.toUpperCase(),
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: AppColors.onSurfaceVariant,
                              fontSize: 10,
                              letterSpacing: 1,
                            ),
                      ),
                      if (letter.emotion != null) ...[
                        const SizedBox(width: 8),
                        Container(
                          width: 4,
                          height: 4,
                          decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.outline),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          letter.emotion!.toUpperCase(),
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: AppColors.tertiary,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.outlineVariant),
          ],
        ),
      ),
    );
  }
}

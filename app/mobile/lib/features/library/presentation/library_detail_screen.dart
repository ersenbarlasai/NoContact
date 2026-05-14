import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../app/theme/app_theme.dart';
import '../../../core/design_system/emotional_background.dart';
import '../../../core/design_system/still_widgets.dart';
import '../data/static_library_repository.dart';
import '../domain/library_item.dart';

class LibraryDetailScreen extends StatelessWidget {
  final String itemId;

  const LibraryDetailScreen({super.key, required this.itemId});

  @override
  Widget build(BuildContext context) {
    final item = StaticLibraryRepository.getById(itemId);

    if (item == null) {
      return const Scaffold(body: Center(child: Text('İçerik bulunamadı.')));
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: EmotionalBackground(
        variant: EmotionalVariant.support,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 24, 0),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: AppColors.onSurfaceVariant),
                  onPressed: () => context.pop(),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 180),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item.category.label.toUpperCase(),
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              letterSpacing: 2,
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${item.estimatedMinutes} dk ${item.type.label}',
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: AppColors.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        item.title,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontFamily: 'Literata',
                          fontWeight: FontWeight.bold,
                          color: AppColors.onSurface,
                        ),
                      ),
                      const SizedBox(height: 32),
                      Text(
                        item.body,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          height: 1.6,
                          color: AppColors.onSurface.withValues(alpha: 0.9),
                        ),
                      ),
                      const SizedBox(height: 48),
                      StillGlassCard(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.psychology_outlined, color: AppColors.primary),
                            const SizedBox(height: 16),
                            Text(
                              'Kendine Sor',
                              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              item.reflectionQuestion,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontStyle: FontStyle.italic,
                                color: AppColors.onSurface,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 48),
                      const StillSectionHeader(
                        title: 'Önerilen Adım',
                        subtitle: 'Bu okumayı bir aksiyonla pekiştir.',
                      ),
                      const SizedBox(height: 16),
                      StillPrimaryButton(
                        label: item.suggestedActionLabel,
                        onPressed: () => _handleAction(context, item.suggestedActionType),
                      ),
                      const SizedBox(height: 48),
                      const StillPrivacyNotice(
                        text: 'Okuma geçmişin bu cihazda kalır ve kimseyle paylaşılmaz.',
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

  void _handleAction(BuildContext context, LibrarySuggestedAction action) {
    switch (action) {
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

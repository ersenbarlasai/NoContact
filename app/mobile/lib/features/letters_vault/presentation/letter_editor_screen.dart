import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../app/theme/app_theme.dart';
import '../../../core/design_system/still_widgets.dart';
import '../../../core/design_system/emotional_background.dart';
import '../../../data/models/unsent_letter.dart';
import 'letters_vault_controller.dart';
import '../../privacy_lock/presentation/privacy_lock_gate.dart';

class LetterEditorScreen extends ConsumerStatefulWidget {
  final UnsentLetter letter;
  const LetterEditorScreen({super.key, required this.letter});

  @override
  ConsumerState<LetterEditorScreen> createState() => _LetterEditorScreenState();
}

class _LetterEditorScreenState extends ConsumerState<LetterEditorScreen> {
  late TextEditingController _titleController;
  late TextEditingController _bodyController;
  String? _selectedEmotion;

  final List<String> _emotions = [
    'Üzgün',
    'Öfkeli',
    'Özlüyorum',
    'Kırgın',
    'Sakinleşmek istiyorum'
  ];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.letter.title);
    _bodyController = TextEditingController(text: widget.letter.body);
    _selectedEmotion = widget.letter.emotion;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                        icon: const Icon(Icons.close, color: AppColors.onSurfaceVariant),
                        onPressed: () => context.pop(),
                      ),
                      Text(
                        'MEKTUP TASLAĞI',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              letterSpacing: 2,
                              color: AppColors.primary,
                            ),
                      ),
                      Row(
                        children: [
                          if (widget.letter.body.isNotEmpty) ...[
                            if (widget.letter.archivedAt != null)
                              IconButton(
                                tooltip: 'Tekrar kasaya taşı',
                                icon: const Icon(Icons.unarchive_outlined, color: AppColors.primary),
                                onPressed: () => _handleRestore(),
                              )
                            else
                              IconButton(
                                tooltip: 'Gözümün önünden kaldır',
                                icon: const Icon(Icons.visibility_off_outlined, color: AppColors.onSurfaceVariant),
                                onPressed: () => _handleArchive(),
                              ),
                          ],
                          IconButton(
                            tooltip: 'Kalıcı olarak sil',
                            icon: const Icon(Icons.delete_outline, color: AppColors.error),
                            onPressed: () => _handleDelete(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const StillSectionHeader(title: 'Duygu Durumu'),
                        const SizedBox(height: 12),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          clipBehavior: Clip.none,
                          child: Row(
                            children: _emotions.map((e) {
                              final isSelected = _selectedEmotion == e;
                              return Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: GestureDetector(
                                  onTap: () => setState(() => _selectedEmotion = isSelected ? null : e),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: isSelected ? AppColors.tertiaryContainer : Colors.transparent,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: isSelected ? AppColors.tertiaryContainer : AppColors.outlineVariant,
                                      ),
                                    ),
                                    child: Text(
                                      e,
                                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                            color: isSelected ? AppColors.onTertiaryContainer : AppColors.onSurfaceVariant,
                                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                          ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: 32),
                        const StillSectionHeader(title: 'Mektup'),
                        const SizedBox(height: 16),
                        StillTextField(
                          controller: _titleController,
                          hintText: 'Başlık (İsteğe bağlı)...',
                        ),
                        const SizedBox(height: 16),
                        StillTextField(
                          controller: _bodyController,
                          hintText: 'Ona ne söylemek istiyorsan buraya yaz, asla duyulmayacak olsa bile...',
                          isLarge: true,
                        ),
                        const SizedBox(height: 140), // More space for bottom action
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomSheet: _BottomAction(onSave: _handleSave),
      ),
    );
  }

  Future<void> _handleSave() async {
    if (_bodyController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Boş mektup kaydedilemez.')),
      );
      return;
    }

    final updated = widget.letter.copyWith(
      title: _titleController.text.trim(),
      body: _bodyController.text.trim(),
      emotion: _selectedEmotion,
    );

    await ref.read(lettersVaultControllerProvider.notifier).saveLetter(updated);
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Yazdın. Göndermedin. Bu da bir ilerleme.')),
      );
      context.pop();
    }
  }

  Future<void> _handleArchive() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Gözümün önünden kaldır'),
        content: const Text('Bu mektup silinmez. Sadece Arşivlenenler bölümüne taşınır.'),
        actions: [
          TextButton(onPressed: () => context.pop(false), child: const Text('VAZGEÇ')),
          TextButton(
            onPressed: () => context.pop(true), 
            child: const Text('KALDIR', style: TextStyle(color: AppColors.primary)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref.read(lettersVaultControllerProvider.notifier).archiveLetter(widget.letter.id);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Mektup arşive kaldırıldı.')),
        );
        context.pop();
      }
    }
  }

  Future<void> _handleRestore() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tekrar kasaya taşı'),
        content: const Text('Bu mektup tekrar Aktif Mektuplar listesinde görünür.'),
        actions: [
          TextButton(onPressed: () => context.pop(false), child: const Text('VAZGEÇ')),
          TextButton(
            onPressed: () => context.pop(true), 
            child: const Text('TAŞI', style: TextStyle(color: AppColors.primary)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref.read(lettersVaultControllerProvider.notifier).restoreLetter(widget.letter.id);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Mektup aktif listeye geri taşındı.')),
        );
        context.pop();
      }
    }
  }

  Future<void> _handleDelete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Bu mektubu kalıcı olarak silmek istiyor musun?'),
        content: const Text('Bu işlem geri alınamaz.'),
        actions: [
          TextButton(onPressed: () => context.pop(false), child: const Text('Vazgeç')),
          TextButton(
            onPressed: () => context.pop(true), 
            child: const Text('Kalıcı Olarak Sil', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref.read(lettersVaultControllerProvider.notifier).hardDeleteLetter(widget.letter.id);
      if (mounted) context.pop();
    }
  }
}

class _BottomAction extends StatelessWidget {
  final VoidCallback onSave;
  const _BottomAction({required this.onSave});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(24, 24, 24, 32 + MediaQuery.of(context).padding.bottom),
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.94),
        border: Border(top: BorderSide(color: AppColors.surfaceContainerHigh)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const StillPrivacyNotice(text: 'Bu mektup asla gönderilmez. Sadece içinden çıkarman için.'),
          const SizedBox(height: 32),
          StillPrimaryButton(
            label: 'MEKTUBU SERBEST BIRAK',
            icon: Icons.auto_awesome,
            onPressed: onSave,
          ),
        ],
      ),
    );
  }
}

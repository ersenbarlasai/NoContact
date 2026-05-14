import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';
import '../../../app/theme/app_theme.dart';
import '../../../core/design_system/still_widgets.dart';
import '../domain/crisis_card.dart';
import 'support_controller.dart';
import '../../../core/design_system/emotional_background.dart';

class SupportCenterScreen extends ConsumerStatefulWidget {
  const SupportCenterScreen({super.key});

  @override
  ConsumerState<SupportCenterScreen> createState() => _SupportCenterScreenState();
}

class _SupportCenterScreenState extends ConsumerState<SupportCenterScreen> {
  final _noteController = TextEditingController();

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(supportControllerProvider);
    final status = state.pauseStatus;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: EmotionalBackground(
        variant: EmotionalVariant.support,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 32, 24, 180),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: AppColors.onSurfaceVariant),
                  onPressed: () => context.pop(),
                ),
                const SizedBox(height: 24),
                const StillSectionHeader(
                  title: 'Bugünün Desteği',
                  subtitle: 'Şu an ihtiyacın olan küçük adımı seç.',
                ),
                const SizedBox(height: 32),
                
                // Actions Grid/List
                _ActionCard(
                  title: 'Neden Başlamıştım?',
                  subtitle: 'Verdiğin sözü ve nedenlerini hatırla.',
                  icon: Icons.favorite_border,
                  onTap: () => _showReasonStarted(context, state),
                ),
                const SizedBox(height: 16),
                _ActionCard(
                  title: 'Tek Cümle Not',
                  subtitle: 'Şu anki kendine bir hatırlatma bırak.',
                  icon: Icons.edit_note_outlined,
                  onTap: () => _showSupportNoteDialog(context),
                ),
                const SizedBox(height: 16),
                _ActionCard(
                  title: '24 Saat Bekle',
                  subtitle: status == SupportPauseStatus.active 
                      ? 'Kararını şu an koruyorsun.' 
                      : (status == SupportPauseStatus.expired ? 'Duraklama tamamlandı.' : 'Dürtüyü yarına ertele, bugün kendine alan aç.'),
                  icon: status == SupportPauseStatus.active ? Icons.timer_outlined : (status == SupportPauseStatus.expired ? Icons.check_circle_outline : Icons.timer_outlined),
                  onTap: () => _show24hCommitment(context, state),
                  isActive: status != SupportPauseStatus.none,
                ),
                const SizedBox(height: 16),
                _ActionCard(
                  title: 'Sessiz Cevap',
                  subtitle: 'Cevabı göndermeden önce kendine duyur.',
                  icon: Icons.chat_bubble_outline,
                  onTap: () => context.push('/silent-reply'),
                ),
                
                const SizedBox(height: 48),
                const StillPrivacyNotice(
                  text: 'Bu kişisel hatırlatmalar bu cihazda şifreli saklanır ve buluta gönderilmez.',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showReasonStarted(BuildContext context, SupportState state) {
    final reasonCard = state.pinnedReason;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.favorite, color: AppColors.primary, size: 48),
            const SizedBox(height: 24),
            Text(
              'Neden Başladın?',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            StillCard(
              color: AppColors.primaryContainer.withValues(alpha: 0.1),
              child: Text(
                reasonCard?.body ?? 'Henüz bir neden kaydetmedin. Ama burada olman, kendine verdiğin en büyük söz.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontStyle: FontStyle.italic,
                  fontFamily: 'Literata',
                ),
              ),
            ),
            const SizedBox(height: 32),
            StillPrimaryButton(
              label: 'BUNU ŞİMDİ OKUDUM',
              onPressed: () => Navigator.pop(context),
            ),
            const SizedBox(height: 12),
            StillSecondaryButton(
              label: 'SOS\'A GEÇ',
              onPressed: () {
                Navigator.pop(context);
                context.push('/sos');
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showSupportNoteDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          left: 32,
          right: 32,
          top: 32,
          bottom: MediaQuery.of(context).viewInsets.bottom + 32,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kendime Not',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Şu an kendine tek cümleyle ne hatırlatmak istersin?',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            StillTextField(
              controller: _noteController,
              hintText: 'Örn: Sadece bugün için sabrediyorum...',
              autofocus: true,
              maxLength: 100,
            ),
            const SizedBox(height: 32),
            StillPrimaryButton(
              label: 'KAYDET',
              onPressed: () async {
                if (_noteController.text.trim().isNotEmpty) {
                  await ref.read(supportControllerProvider.notifier).saveSupportNote(_noteController.text);
                  if (context.mounted) {
                    Navigator.pop(context);
                    _noteController.clear();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Bunu kendin için bıraktın.')),
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _show24hCommitment(BuildContext context, SupportState state) {
    final status = state.pauseStatus;

    if (status == SupportPauseStatus.active) {
      final remaining = state.remainingPauseTime!;
      
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: AppColors.background,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        builder: (context) => SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(32, 32, 32, 32 + MediaQuery.of(context).padding.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.timer_outlined, color: AppColors.primary, size: 48),
                const SizedBox(height: 24),
                Text(
                  '24 Saatlik Duraklama Aktif',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
                Text(
                  'Kalan süre: ${remaining.inHours}s ${remaining.inMinutes % 60}dk.\nKararını şu an koruyorsun.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(height: 1.5),
                ),
                const SizedBox(height: 32),
                StillPrimaryButton(
                  label: 'TAMAM', 
                  onPressed: () => Navigator.pop(context),
                ),
                const SizedBox(height: 12),
                StillSecondaryButton(
                  label: 'NEDEN BAŞLADIĞIMI HATIRLA',
                  onPressed: () {
                    Navigator.pop(context);
                    _showReasonStarted(context, state);
                  },
                ),
                const SizedBox(height: 12),
                StillSecondaryButton(
                  label: 'KENDİME NOT BIRAK',
                  onPressed: () {
                    Navigator.pop(context);
                    _showSupportNoteDialog(context);
                  },
                ),
              ],
            ),
          ),
        ),
      );
      return;
    }

    if (status == SupportPauseStatus.expired) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: AppColors.background,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        builder: (context) => SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(32, 32, 32, 32 + MediaQuery.of(context).padding.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.check_circle_outline, color: AppColors.primary, size: 48),
                const SizedBox(height: 24),
                Text(
                  'Duraklama Tamamlandı',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Şimdi daha sakin bir yerden karar verebilirsin.',
                  textAlign: TextAlign.center,
                  style: TextStyle(height: 1.5),
                ),
                const SizedBox(height: 32),
                StillPrimaryButton(
                  label: 'KAPAT', 
                  onPressed: () async {
                    await ref.read(supportControllerProvider.notifier).dismissPause();
                    if (context.mounted) Navigator.pop(context);
                  },
                ),
                const SizedBox(height: 12),
                StillSecondaryButton(
                  label: 'NEDEN BAŞLADIĞIMI HATIRLA',
                  onPressed: () {
                    Navigator.pop(context);
                    _showReasonStarted(context, state);
                  },
                ),
                const SizedBox(height: 12),
                StillSecondaryButton(
                  label: 'SESSİZ CEVAP YAZ',
                  onPressed: () {
                    Navigator.pop(context);
                    context.push('/silent-reply');
                  },
                ),
              ],
            ),
          ),
        ),
      );
      return;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(32, 32, 32, 32 + MediaQuery.of(context).padding.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.timer, color: AppColors.tertiary, size: 48),
              const SizedBox(height: 24),
              Text(
                '24 Saatlik Alan',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              const Text(
                'Bu mesajı bugün göndermeyeceğim. 24 saat sonra daha sakin karar vereceğim.',
                textAlign: TextAlign.center,
                style: TextStyle(height: 1.5),
              ),
              const SizedBox(height: 32),
              StillPrimaryButton(
                label: '24 SAAT BEKLEMEYE AL',
                onPressed: () async {
                  await ref.read(supportControllerProvider.notifier).start24hPause();
                  if (context.mounted) Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;
  final bool isActive;

  const _ActionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return StillCard(
      onTap: onTap,
      color: isActive ? AppColors.primaryContainer.withValues(alpha: 0.1) : null,
      child: Row(
        children: [
          Icon(icon, color: isActive ? AppColors.primary : AppColors.outline, size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isActive ? AppColors.primary : null,
                  ),
                ),
                const SizedBox(height: 4),
                Text(subtitle, style: Theme.of(context).textTheme.labelSmall),
              ],
            ),
          ),
          if (isActive)
            const Icon(Icons.check_circle, color: AppColors.primary, size: 20)
          else
            const Icon(Icons.chevron_right, color: AppColors.outline),
        ],
      ),
    );
  }
}

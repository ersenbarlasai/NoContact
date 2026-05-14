import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/app_theme.dart';
import '../../../core/design_system/still_widgets.dart';
import '../../../data/repositories/providers.dart';
import '../../onboarding/presentation/onboarding_controller.dart';
import '../../mood_journal/presentation/mood_journal_controller.dart';
import '../../letters_vault/presentation/letters_vault_controller.dart';
import '../../../app/bootstrap/app_startup_controller.dart';
import '../../privacy_lock/presentation/privacy_lock_controller.dart';
import '../../daily_rhythm/presentation/rhythm_controller.dart';
import '../../../core/design_system/emotional_background.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: EmotionalBackground(
        variant: EmotionalVariant.neutral,
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 180),
            children: [
              // Top Bar
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'AYARLAR',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            letterSpacing: 4,
                            color: AppColors.primary,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              
              const StillSectionHeader(title: 'Hesap ve Profil'),
              const SizedBox(height: 16),
              StillGlassCard(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.person_outline, color: AppColors.primary),
                      title: const Text('Profil Ayarları'),
                      trailing: const Icon(Icons.chevron_right, size: 20, color: AppColors.outlineVariant),
                      onTap: () {},
                    ),
                    const Divider(height: 1, indent: 56),
                    ListTile(
                      leading: const Icon(Icons.star_outline, color: AppColors.primary),
                      title: const Text('Plan ve Limitler'),
                      trailing: const Icon(Icons.chevron_right, size: 20, color: AppColors.outlineVariant),
                      onTap: () => context.push('/subscription'),
                    ),
                    const Divider(height: 1, indent: 56),
                    ListTile(
                      leading: const Icon(Icons.feedback_outlined, color: AppColors.primary),
                      title: const Text('Beta geri bildirimi gönder'),
                      trailing: const Icon(Icons.open_in_new, size: 20, color: AppColors.outlineVariant),
                      onTap: () => context.push('/beta-feedback'),
                    ),
                    const Divider(height: 1, indent: 56),
                    Consumer(
                      builder: (context, ref, child) {
                        final rhythmState = ref.watch(rhythmControllerProvider);
                        final rhythmController = ref.read(rhythmControllerProvider.notifier);
                        
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // ─── Ana Günlük Ritim ──────────────────────────
                            ListTile(
                              leading: const Icon(Icons.notifications_outlined, color: AppColors.primary),
                              title: const Text('Günlük Ritim'),
                              subtitle: const Text('İyileşme yolculuğun için nazik hatırlatmalar.'),
                              trailing: Switch(
                                value: rhythmState.isEnabled,
                                activeColor: AppColors.primary,
                                onChanged: (value) => rhythmController.toggleEnabled(value),
                              ),
                            ),

                            // İzin reddedildi uyarısı
                            if (!rhythmState.isEnabled && rhythmState.hasRequestedPermission)
                              Padding(
                                padding: const EdgeInsets.only(left: 56, right: 16, bottom: 12),
                                child: Text(
                                  'Bildirim izni verilmedi. Cihaz ayarlarından uygulamaya bildirim iznini açman gerekiyor.',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColors.tertiary,
                                  ),
                                ),
                              ),

                            // ─── Ana Saat Seçimi ───────────────────────────
                            if (rhythmState.isEnabled) ...[
                              Padding(
                                padding: const EdgeInsets.only(left: 56, right: 16, bottom: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Ana Hatırlatma Saati',
                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        color: AppColors.onSurfaceVariant,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        final time = await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay(hour: rhythmState.hour, minute: rhythmState.minute),
                                          builder: (context, child) {
                                            return Theme(
                                              data: Theme.of(context).copyWith(
                                                colorScheme: const ColorScheme.light(
                                                  primary: AppColors.primary,
                                                  onPrimary: Colors.white,
                                                  onSurface: AppColors.onSurface,
                                                ),
                                              ),
                                              child: child!,
                                            );
                                          },
                                        );
                                        if (time != null) {
                                          await rhythmController.updateTime(time.hour, time.minute);
                                        }
                                      },
                                      child: Text(
                                        '${rhythmState.hour.toString().padLeft(2, '0')}:${rhythmState.minute.toString().padLeft(2, '0')}',
                                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const Divider(height: 1, indent: 56),

                              // ─── Sabah Nazik Başlangıç ─────────────────────
                              ListTile(
                                leading: const Icon(Icons.wb_sunny_outlined, color: AppColors.primary, size: 22),
                                title: const Text('Sabah Nazik Başlangıç'),
                                subtitle: const Text('~08:00 · "Bugün kendine sert davranmadan ilerleyebilirsin."'),
                                trailing: Switch(
                                  value: rhythmState.morningEnabled,
                                  activeColor: AppColors.primary,
                                  onChanged: (v) => rhythmController.toggleMorning(v),
                                ),
                              ),

                              // ─── Öğlen Kısa Duraklama ──────────────────────
                              ListTile(
                                leading: const Icon(Icons.self_improvement_outlined, color: AppColors.primary, size: 22),
                                title: const Text('Öğlen Kısa Duraklama'),
                                subtitle: const Text('~12:30 · "Bir an durup bedenini fark etmek ister misin?"'),
                                trailing: Switch(
                                  value: rhythmState.middayEnabled,
                                  activeColor: AppColors.primary,
                                  onChanged: (v) => rhythmController.toggleMidday(v),
                                ),
                              ),

                              // ─── Akşam Yansıması ───────────────────────────
                              ListTile(
                                leading: const Icon(Icons.bedtime_outlined, color: AppColors.primary, size: 22),
                                title: const Text('Akşam Yansıması'),
                                subtitle: const Text('~21:00 · "Bugün içinden geçenleri güvenli bir yere bırakabilirsin."'),
                                trailing: Switch(
                                  value: rhythmState.eveningEnabled,
                                  activeColor: AppColors.primary,
                                  onChanged: (v) => rhythmController.toggleEvening(v),
                                ),
                              ),

                              const Divider(height: 1, indent: 56),

                              // ─── Bağlama Göre Akıllı Bildirimler ──────────
                              ListTile(
                                leading: const Icon(Icons.tips_and_updates_outlined, color: AppColors.primary, size: 22),
                                title: const Text('Bağlama Göre Hatırlatmalar'),
                                subtitle: const Text('SOS, 24 saat bekleme veya güvenli çıkış sonrasında nazik takip.'),
                                trailing: Switch(
                                  value: rhythmState.contextualEnabled,
                                  activeColor: AppColors.primary,
                                  onChanged: (v) => rhythmController.toggleContextual(v),
                                ),
                              ),
                            ],

                            // Debug-only test butonu
                            if (kDebugMode && rhythmState.isEnabled)
                              Padding(
                                padding: const EdgeInsets.only(left: 56, right: 16, bottom: 8),
                                child: Row(
                                  children: [
                                    const Icon(Icons.science_outlined, size: 16, color: AppColors.onSurfaceVariant),
                                    const SizedBox(width: 8),
                                    TextButton(
                                      onPressed: () async {
                                        await rhythmController.sendTestNotification();
                                        if (context.mounted) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text('Test bildirimi 1 dakika sonra gelecek.'),
                                              duration: Duration(seconds: 3),
                                            ),
                                          );
                                        }
                                      },
                                      child: Text(
                                        '1 dk sonra test bildirimi gönder',
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          color: AppColors.onSurfaceVariant,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                            const Padding(
                              padding: EdgeInsets.only(left: 56, right: 16, bottom: 16),
                              child: StillPrivacyNotice(
                                text: 'Tüm bildirimler cihazında planlanır. Mektup, günlük veya SOS içeriğin bildirimlerde hiçbir zaman görünmez.',
                              ),
                            ),
                          ],
                        );
                      },
                    ),

                  ],
                ),
              ),
              const SizedBox(height: 32),
              const StillSectionHeader(title: 'Veri ve Gizlilik'),
              const SizedBox(height: 16),
              StillGlassCard(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    Consumer(
                      builder: (context, ref, child) {
                        final lockState = ref.watch(privacyLockControllerProvider);
                        final lockController = ref.read(privacyLockControllerProvider.notifier);
                        
                        return ListTile(
                          leading: const Icon(Icons.fingerprint_outlined, color: AppColors.primary),
                          title: const Text('Biyometrik Kilit'),
                          subtitle: const Text('Günlük ve mektuplarını açmadan önce cihaz doğrulaması ister.'),
                          trailing: Switch(
                            value: lockState.isEnabled,
                            activeColor: AppColors.primary,
                            onChanged: lockState.isAvailable 
                              ? (value) => lockController.toggleLock(value)
                              : null,
                          ),
                        );
                      },
                    ),
                    const Divider(height: 1, indent: 56),
                    ListTile(
                      leading: const Icon(Icons.cleaning_services_outlined, color: AppColors.tertiary),
                      title: const Text('Yerel Verileri Temizle'),
                      subtitle: const Text('Uygulamayı sıfırlar ve başlangıca döner.'),
                      onTap: () async => _handleClearData(context, ref),
                    ),
                    const Divider(height: 1, indent: 56),
                    ListTile(
                      leading: const Icon(Icons.delete_forever_outlined, color: AppColors.error),
                      title: const Text('Verileri Kalıcı Olarak Sil', style: TextStyle(color: AppColors.error)),
                      onTap: () {
                        // TODO: Implement full account deletion
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 48),
              Center(
                child: Column(
                  children: [
                    Text(
                      'STILL v1.0.0',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppColors.primary,
                            letterSpacing: 2,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'The Quiet Companion',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.onSurfaceVariant,
                            fontStyle: FontStyle.italic,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleClearData(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Emin misiniz?'),
        content: const Text('Tüm yerel verileriniz (günlükler, mektuplar) silinecek.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('VAZGEÇ')),
          TextButton(
            onPressed: () => Navigator.pop(context, true), 
            child: const Text('TEMİZLE', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref.read(localRecoveryProfileRepositoryProvider).clearProfile();
      await ref.read(localSosSessionRepositoryProvider).clearStats();
      await ref.read(localMoodJournalRepositoryProvider).clearMoodEntries();
      await ref.read(localLettersVaultRepositoryProvider).clearLetters();
      await ref.read(localManagedUrgeRepositoryProvider).clearEvents();
      
      ref.invalidate(onboardingControllerProvider);
      ref.invalidate(appStartupProvider);
      ref.invalidate(moodJournalControllerProvider);
      ref.invalidate(lettersVaultControllerProvider);
      
      if (context.mounted) {
        context.go('/onboarding');
      }
    }
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../app/theme/app_theme.dart';
import '../../../core/design_system/still_widgets.dart';
import '../../../data/repositories/providers.dart';
import '../../onboarding/presentation/onboarding_controller.dart';
import '../../mood_journal/presentation/mood_journal_controller.dart';
import '../../letters_vault/presentation/letters_vault_controller.dart';
import '../../../app/bootstrap/app_startup_controller.dart';
import '../../privacy_lock/presentation/privacy_lock_controller.dart';
import '../../daily_rhythm/presentation/rhythm_controller.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
            
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(24),
                children: [
                  const StillSectionHeader(title: 'Hesap ve Profil'),
                  const SizedBox(height: 16),
                  StillCard(
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
                          onTap: () async {
                            if (kIsWeb) {
                              context.push('/beta-feedback');
                              return;
                            }
                            const formUrl = String.fromEnvironment('BETA_FEEDBACK_FORM_URL');
                            if (formUrl.isNotEmpty) {
                              final uri = Uri.parse(formUrl);
                              try {
                                await launchUrl(uri, mode: LaunchMode.externalApplication);
                              } catch (_) {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Form açılamadı. Lütfen bağlantınızı kontrol edin.')),
                                  );
                                }
                              }
                            } else {
                              // Fallback if not web and no URL
                              context.push('/beta-feedback');
                            }
                          },
                        ),
                        const Divider(height: 1, indent: 56),
                        Consumer(
                          builder: (context, ref, child) {
                            final rhythmState = ref.watch(rhythmControllerProvider);
                            final rhythmController = ref.read(rhythmControllerProvider.notifier);
                            
                              if (kIsWeb) {
                                return const ListTile(
                                  leading: Icon(Icons.notifications_outlined, color: AppColors.primary),
                                  title: Text('Günlük Ritim'),
                                  subtitle: Text('Web sürümünde kullanılamaz. Mobil uygulamada aktif olacak.'),
                                );
                              } else {
                                return Column(
                                  children: [
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
                                    if (rhythmState.isEnabled)
                                      Padding(
                                        padding: const EdgeInsets.only(left: 56, right: 16, bottom: 16),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Hatırlatma Saati',
                                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.onSurfaceVariant),
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
                                                  rhythmController.updateTime(time.hour, time.minute);
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
                                    const Padding(
                                      padding: EdgeInsets.only(left: 56, right: 16, bottom: 16),
                                      child: StillPrivacyNotice(
                                        text: 'Hatırlatmalar cihazında planlanır; özel notların bildirimlerde görünmez.',
                                      ),
                                    ),
                                  ],
                                );
                              }
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  const StillSectionHeader(title: 'Veri ve Gizlilik'),
                  const SizedBox(height: 16),
                  StillCard(
                    padding: EdgeInsets.zero,
                    child: Column(
                      children: [
                        Consumer(
                          builder: (context, ref, child) {
                            final lockState = ref.watch(privacyLockControllerProvider);
                            final lockController = ref.read(privacyLockControllerProvider.notifier);
                            
                            if (kIsWeb)
                              return const ListTile(
                                leading: Icon(Icons.fingerprint_outlined, color: AppColors.primary),
                                title: Text('Biyometrik Kilit'),
                                subtitle: Text('Web sürümünde kullanılamaz. Mobil uygulamada aktif olacak.'),
                              );

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
          ],
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

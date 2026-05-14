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
import '../../../l10n/app_localizations.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
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
                      l10n.settingsTitle.toUpperCase(),
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            letterSpacing: 4,
                            color: AppColors.primary,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              
              StillSectionHeader(title: l10n.settingsProfileSection),
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
                                title: Text(l10n.settingsMorningLabel),
                                subtitle: Text('~08:00 · "${l10n.notifMorningBody}"'),
                                trailing: Switch(
                                  value: rhythmState.morningEnabled,
                                  activeColor: AppColors.primary,
                                  onChanged: (v) => rhythmController.toggleMorning(v),
                                ),
                              ),

                              // ─── Öğlen Kısa Duraklama ──────────────────────
                              ListTile(
                                leading: const Icon(Icons.self_improvement_outlined, color: AppColors.primary, size: 22),
                                title: Text(l10n.settingsMiddayLabel),
                                subtitle: Text('~12:30 · "${l10n.notifMiddayBody}"'),
                                trailing: Switch(
                                  value: rhythmState.middayEnabled,
                                  activeColor: AppColors.primary,
                                  onChanged: (v) => rhythmController.toggleMidday(v),
                                ),
                              ),

                              // ─── Akşam Yansıması ───────────────────────────
                              ListTile(
                                leading: const Icon(Icons.bedtime_outlined, color: AppColors.primary, size: 22),
                                title: Text(l10n.settingsEveningLabel),
                                subtitle: Text('~21:00 · "${l10n.notifEveningBody}"'),
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
                                title: Text(l10n.settingsContextualLabel),
                                subtitle: Text(l10n.settingsContextualSubtitle),
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
                                            SnackBar(
                                              content: Text(l10n.settingsTestNotifSnackbar),
                                              duration: const Duration(seconds: 3),
                                            ),
                                          );
                                        }
                                      },
                                      child: Text(
                                        l10n.settingsTestNotifBtn,
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          color: AppColors.onSurfaceVariant,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                            Padding(
                              padding: const EdgeInsets.only(left: 56, right: 16, bottom: 16),
                              child: StillPrivacyNotice(
                                text: l10n.settingsPrivacyNotice,
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
              StillSectionHeader(title: l10n.settingsDataSection),
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
                          title: Text(l10n.settingsBiometricLabel),
                          subtitle: Text(l10n.settingsBiometricSubtitle),
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
                      title: Text(l10n.settingsClearDataLabel),
                      subtitle: Text(l10n.settingsClearDataSubtitle),
                      onTap: () async => _handleClearData(context, ref),
                    ),
                    const Divider(height: 1, indent: 56),
                    ListTile(
                      leading: const Icon(Icons.delete_forever_outlined, color: AppColors.error),
                      title: Text(l10n.settingsDeleteDataLabel, style: const TextStyle(color: AppColors.error)),
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
      builder: (ctx) {
        final dl10n = AppLocalizations.of(ctx);
        return AlertDialog(
          title: Text(dl10n.settingsClearConfirmTitle),
          content: Text(dl10n.settingsClearConfirmBody),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(dl10n.settingsClearCancelBtn)),
            TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: Text(dl10n.settingsClearBtn, style: const TextStyle(color: AppColors.error)),
            ),
          ],
        );
      },
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

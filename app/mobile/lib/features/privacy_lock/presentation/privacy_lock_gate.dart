import 'package:flutter/foundation.dart'; // Added for kIsWeb
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/theme/app_theme.dart';
import '../../../core/design_system/still_widgets.dart';
import 'privacy_lock_controller.dart';

class PrivacyLockGate extends ConsumerWidget {
  final Widget child;

  const PrivacyLockGate({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (kIsWeb) return child; // Bypass on web

    ref.watch(privacyLockControllerProvider);
    final lockController = ref.read(privacyLockControllerProvider.notifier);
    final isLocked = lockController.shouldShowLockGate();

    if (!isLocked) {
      return child;
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.fingerprint_rounded,
                size: 64,
                color: AppColors.primary,
              ),
              const SizedBox(height: 32),
              Text(
                'GÜVENLİ ALAN KİLİTLİ',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold,
                      color: AppColors.onSurface,
                    ),
              ),
              const SizedBox(height: 16),
              Text(
                'Günlük ve mektuplarını açmak için cihaz doğrulaması gerekiyor.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.onSurfaceVariant,
                    ),
              ),
              const SizedBox(height: 48),
              StillPrimaryButton(
                label: 'KİLİDİ AÇ',
                onPressed: () async {
                  await ref.read(privacyLockControllerProvider.notifier).authenticate();
                },
              ),
              const SizedBox(height: 16),
              StillSecondaryButton(
                label: 'GERİ DÖN',
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              const SizedBox(height: 32),
              const StillPrivacyNotice(
                text: 'Biyometrik verileriniz cihazınızda güvenle saklanır ve uygulama tarafından asla erişilemez.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

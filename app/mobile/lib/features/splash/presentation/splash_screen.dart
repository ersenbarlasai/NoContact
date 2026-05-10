import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/bootstrap/app_startup_controller.dart';
import '../../../app/theme/app_theme.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startupState = ref.watch(appStartupProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.05),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.eco_outlined,
                color: AppColors.primary,
                size: 48,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'STILL',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                letterSpacing: 8,
                color: AppColors.primary,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 64),
            if (startupState.status == AppStartupStatus.loading) ...[
              const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Yolculuğun hazırlanıyor...',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.onSurfaceVariant,
                  letterSpacing: 0.5,
                ),
              ),
            ] else if (startupState.error != null) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48),
                child: Text(
                  startupState.error!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: AppColors.error),
                ),
              ),
              const SizedBox(height: 24),
              TextButton(
                onPressed: () => ref.read(appStartupProvider.notifier).retry(),
                child: const Text('TEKRAR DENE'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

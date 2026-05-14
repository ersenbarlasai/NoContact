import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app/router/app_router.dart';
import 'app/theme/app_theme.dart';
import 'l10n/app_localizations.dart';

import 'core/services/supabase_service.dart';
import 'core/storage/local_storage_service.dart';
import 'core/notifications/notification_service.dart';
import 'core/notifications/timezone_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseService.initialize();
  await LocalStorageService.init();
  await TimezoneHelper.init();
  await NotificationService.init();
  runApp(
    const ProviderScope(
      child: NoContactApp(),
    ),
  );
}

class NoContactApp extends ConsumerWidget {
  const NoContactApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouter);

    return MaterialApp.router(
      title: 'STILL',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: router,
      // --- Localization ---
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      // Cihaz dili Türkçe ise Türkçe, değilse İngilizce fallback
      localeResolutionCallback: (deviceLocale, supportedLocales) {
        if (deviceLocale != null &&
            deviceLocale.languageCode == 'tr') {
          return const Locale('tr', 'TR');
        }
        return const Locale('en', 'US');
      },
    );
  }
}

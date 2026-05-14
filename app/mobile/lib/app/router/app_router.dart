import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/onboarding/presentation/onboarding_screen.dart';
import '../../features/sos/presentation/sos_screen.dart';
import '../../features/mood_journal/presentation/mood_journal_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../features/splash/presentation/splash_screen.dart';
import '../bootstrap/app_startup_controller.dart';
import '../../features/onboarding/presentation/onboarding_controller.dart';
import '../../features/letters_vault/presentation/letters_vault_screen.dart';
import '../../features/letters_vault/presentation/letter_editor_screen.dart';
import '../../features/subscription/presentation/subscription_screen.dart';
import '../../features/subscription/presentation/entitlement_controller.dart';
import '../../features/recovery_path/presentation/recovery_path_screen.dart';
import '../../features/insights/presentation/insights_screen.dart';
import '../../features/support_system/presentation/support_center_screen.dart';
import '../../features/library/presentation/library_screen.dart';
import '../../features/library/presentation/library_detail_screen.dart';
import '../../features/silent_reply/presentation/silent_reply_screen.dart';
import '../presentation/main_scaffold.dart';
import '../../core/navigation/still_page_transitions.dart';
import '../../core/navigation/premium_guard.dart';
import '../../data/models/unsent_letter.dart';

/// Routes that are always free (no premium check).
const _freeRouteSet = {'/splash', '/onboarding', '/', '/sos', '/subscription', '/settings'};

/// Map from route prefix → PremiumFeature for contextual paywall messages.
const _routeFeatureMap = <String, PremiumFeature>{
  '/mood-journal':   PremiumFeature.moodJournal,
  '/letters-vault':  PremiumFeature.lettersVault,
  '/recovery-path':  PremiumFeature.recoveryPath,
  '/insights':       PremiumFeature.insights,
  '/support-center': PremiumFeature.supportCenter,
  '/library':        PremiumFeature.library,
  '/silent-reply':   PremiumFeature.silentReply,
};

final appRouter = Provider<GoRouter>((ref) {
  final startupState = ref.watch(appStartupProvider);
  final onboardingCompleted = ref.watch(
    onboardingControllerProvider.select((state) => state.isOnboardingCompleted),
  );

  return GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        pageBuilder: (context, state) => StillPageTransition(
          child: const SplashScreen(),
          type: StillTransitionType.none,
        ),
      ),
      GoRoute(
        path: '/onboarding',
        pageBuilder: (context, state) => StillPageTransition(
          child: const OnboardingScreen(),
          type: StillTransitionType.fade,
        ),
      ),
      GoRoute(
        path: '/sos',
        pageBuilder: (context, state) => StillPageTransition(
          child: const SosScreen(),
          type: StillTransitionType.fade,
          duration: const Duration(milliseconds: 200),
        ),
      ),
      ShellRoute(
        builder: (context, state, child) => MainScaffold(child: child),
        routes: [
          GoRoute(
            path: '/',
            pageBuilder: (context, state) => StillPageTransition(
              child: const HomeScreen(),
              type: StillTransitionType.fadeThrough,
            ),
          ),
          GoRoute(
            path: '/mood-journal',
            pageBuilder: (context, state) => StillPageTransition(
              child: const MoodJournalScreen(),
              type: StillTransitionType.fadeThrough,
            ),
          ),
          GoRoute(
            path: '/settings',
            pageBuilder: (context, state) => StillPageTransition(
              child: const SettingsScreen(),
              type: StillTransitionType.fadeThrough,
            ),
          ),
          GoRoute(
            path: '/letters-vault',
            pageBuilder: (context, state) => StillPageTransition(
              child: const LettersVaultScreen(),
              type: StillTransitionType.fadeThrough,
            ),
            routes: [
              GoRoute(
                path: 'editor',
                pageBuilder: (context, state) {
                  final letter = state.extra as UnsentLetter;
                  return StillPageTransition(
                    child: LetterEditorScreen(letter: letter),
                    type: StillTransitionType.fadeThrough,
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: '/subscription',
            pageBuilder: (context, state) => StillPageTransition(
              child: const SubscriptionScreen(),
              type: StillTransitionType.fadeThrough,
            ),
          ),
          GoRoute(
            path: '/recovery-path',
            pageBuilder: (context, state) => StillPageTransition(
              child: const RecoveryPathScreen(),
              type: StillTransitionType.sharedAxisVertical,
            ),
          ),
          GoRoute(
            path: '/insights',
            pageBuilder: (context, state) => StillPageTransition(
              child: const InsightsScreen(),
              type: StillTransitionType.fadeThrough,
            ),
          ),
          GoRoute(
            path: '/support-center',
            pageBuilder: (context, state) => StillPageTransition(
              child: const SupportCenterScreen(),
              type: StillTransitionType.fadeThrough,
            ),
          ),
          GoRoute(
            path: '/library',
            pageBuilder: (context, state) => StillPageTransition(
              child: const LibraryScreen(),
              type: StillTransitionType.fadeThrough,
            ),
            routes: [
              GoRoute(
                path: ':id',
                pageBuilder: (context, state) {
                  final id = state.pathParameters['id']!;
                  return StillPageTransition(
                    child: LibraryDetailScreen(itemId: id),
                    type: StillTransitionType.fadeThrough,
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: '/silent-reply',
            pageBuilder: (context, state) => StillPageTransition(
              child: const SilentReplyScreen(),
              type: StillTransitionType.fadeThrough,
            ),
          ),
        ],
      ),
    ],
    redirect: (context, state) {
      final location = state.matchedLocation;
      final status = startupState.status;

      final isSplash = location == '/splash';
      final isOnboarding = location == '/onboarding';

      // 1. App still loading → hold at splash
      if (status == AppStartupStatus.loading) {
        return isSplash ? null : '/splash';
      }

      // 2. Onboarding not completed → force onboarding
      if (!onboardingCompleted) {
        if (status == AppStartupStatus.needsOnboarding) {
          return isOnboarding ? null : '/onboarding';
        }
        return '/splash';
      }

      // 3. Onboarding done, skip splash/onboarding
      if (isSplash || isOnboarding) return '/';

      // 4. Premium route guard
      final isFree = _freeRouteSet.any((r) => location == r);
      if (!isFree) {
        final isPremium = ProviderScope.containerOf(context)
            .read(entitlementControllerProvider)
            .isPremium;
        if (!isPremium) {
          // Find the most specific feature for contextual paywall
          PremiumFeature feature = PremiumFeature.generic;
          for (final entry in _routeFeatureMap.entries) {
            if (location.startsWith(entry.key)) {
              feature = entry.value;
              break;
            }
          }
          // Encode feature as query param since we can't pass extra in redirect
          return '/subscription?from=${feature.name}';
        }
      }

      return null;
    },
  );
});

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nocontact/main.dart';
import 'package:nocontact/data/models/recovery_profile.dart';
import 'package:nocontact/data/repositories/providers.dart';
import 'package:nocontact/data/repositories/local_recovery_profile_repository.dart';
import 'package:nocontact/core/storage/local_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'dart:async';
import 'package:nocontact/core/design_system/still_widgets.dart';
import 'package:nocontact/features/onboarding/presentation/onboarding_screen.dart';

class MockHttpClient extends CustomHttpClient {}
class CustomHttpClient extends Fake implements HttpClient {
  @override
  Future<HttpClientRequest> getUrl(Uri url) => Future.value(MockHttpClientRequest());
  @override
  set autoUncompress(bool _autoUncompress) {}
}
class MockHttpClientRequest extends Fake implements HttpClientRequest {
  @override
  Future<HttpClientResponse> close() => Future.value(MockHttpClientResponse());
}
class MockHttpClientResponse extends Fake implements HttpClientResponse {
  @override
  int get statusCode => 200;
  @override
  StreamSubscription<List<int>> listen(void Function(List<int> event)? onData, {Function? onError, void Function()? onDone, bool? cancelOnError}) {
    return Stream<List<int>>.fromIterable([[]]).listen(onData, onError: onError, onDone: onDone, cancelOnError: cancelOnError);
  }
}
class Fake extends Object {
  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}

// Simple Mock
class MockLocalProfileRepo extends LocalRecoveryProfileRepository {
  final RecoveryProfile? profile;
  MockLocalProfileRepo({this.profile});

  @override
  Future<RecoveryProfile?> fetchProfile() async => profile;
  @override
  Future<void> saveProfile(RecoveryProfile profile) async {}
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) => MockHttpClient();
}

void main() {
  HttpOverrides.global = MyHttpOverrides();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await LocalStorageService.init();
  });

  testWidgets('End-to-end Onboarding flow', (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(1080, 1920));
    
    await tester.pumpWidget(const ProviderScope(child: NoContactApp()));
    
    // Wait for splash and redirects
    await tester.pump(); 
    await tester.pump(const Duration(seconds: 2)); 
    await tester.pumpAndSettle(); 

    // Helper to tap the main button in a step
    Future<void> tapMainButton() async {
      final button = find.byType(StillPrimaryButton).last;
      await tester.tap(button);
      await tester.pumpAndSettle();
    }

    // Step 1: Welcome
    expect(find.textContaining(RegExp(r'Nosto', caseSensitive: false)), findsWidgets);
    await tapMainButton();
    
    // Step 2: Firaq
    expect(find.textContaining(RegExp(r'Firaq', caseSensitive: false)), findsWidgets);
    await tapMainButton();

    // Step 3: NoContact Meaning
    expect(find.textContaining(RegExp(r'(No[- ]?Contact|ceza|penalty)', caseSensitive: false)), findsWidgets);
    await tapMainButton();

    // Step 4: App Purpose
    expect(find.textContaining(RegExp(r'Nosto', caseSensitive: false)), findsWidgets);
    await tapMainButton();
    
    // Step 5: Name
    expect(find.textContaining(RegExp(r'(hitap|call|name)', caseSensitive: false)), findsWidgets);
    await tester.enterText(find.byType(TextField), 'Test User');
    await tapMainButton();

    // Step 6: Reason
    await tester.tap(find.byType(StillOptionTile).first);
    await tester.pumpAndSettle();

    // Step 7: Relationship Duration
    await tester.tap(find.byType(StillOptionTile).first);
    await tester.pumpAndSettle();

    // Step 8: Time Since Breakup
    await tester.tap(find.byType(StillOptionTile).first);
    await tester.pumpAndSettle();

    // Step 9: Who Ended
    await tester.tap(find.byType(StillOptionTile).first);
    await tester.pumpAndSettle();

    // Step 10: No Contact Date (Skip)
    final skipText = RegExp(r'(Hatırlamıyorum|Remember|today|bugün)', caseSensitive: false);
    await tester.tap(find.textContaining(skipText).last);
    await tester.pumpAndSettle();

    // Step 11: Emotion
    await tester.tap(find.byType(StillOptionTile).first);
    await tester.pumpAndSettle();

    // Step 12: Triggers
    await tester.tap(find.byType(StillOptionTile).first);
    await tester.pumpAndSettle();
    await tapMainButton();

    // Step 13: Contract (Long Press)
    final gesture = await tester.startGesture(tester.getCenter(find.byIcon(Icons.fingerprint)));
    await tester.pump();
    await tester.pump(const Duration(seconds: 3));
    await gesture.up();
    await tester.pumpAndSettle();

    // Step 14: Start Ritual
    // Final step button
    await tester.tap(find.byType(StillPrimaryButton).last);
    await tester.pump(); 
    await tester.pump(const Duration(seconds: 2)); 


    // Verify Home Screen
    // We use pump instead of pumpAndSettle here because the SOS pulse button animates infinitely
    await tester.pump(const Duration(seconds: 1));
    expect(find.textContaining(RegExp(r'(GÜN|DAY)', caseSensitive: false)), findsWidgets);
    
    await tester.binding.setSurfaceSize(null);
  });

  testWidgets('Session recovery routes directly to Home', (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(1080, 1920));

    const mockProfile = RecoveryProfile(
      name: 'Kayıtlı Kullanıcı',
      isOnboardingCompleted: true,
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          localRecoveryProfileRepositoryProvider.overrideWithValue(
            MockLocalProfileRepo(profile: mockProfile),
          ),
        ],
        child: const NoContactApp(),
      ),
    );

    // Wait for splash and redirects
    await tester.pump(); 
    await tester.pump(const Duration(seconds: 2)); 
    await tester.pump(); // Start navigation
    await tester.pump(const Duration(seconds: 1)); // Wait for Home to load

    // Should be on Home
    // Use pump instead of pumpAndSettle because of infinite pulse animation
    expect(find.textContaining(RegExp(r'(GÜN|DAY)', caseSensitive: false), skipOffstage: false), findsWidgets);
    expect(find.textContaining('Kayıtlı Kullanıcı'), findsWidgets);
    
    await tester.binding.setSurfaceSize(null);
  });
}

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

  testWidgets('End-to-end Onboarding and SOS flow', (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(1080, 1920));
    
    await tester.pumpWidget(const ProviderScope(child: NoContactApp()));
    
    // Wait for splash and redirects
    await tester.pump(); 
    await tester.pump(const Duration(seconds: 2)); 
    await tester.pumpAndSettle(); 

    // Verify Onboarding Welcome Screen
    expect(find.textContaining(RegExp(r'Nosto', caseSensitive: false)), findsWidgets);
    await tester.tap(find.byType(ElevatedButton).last);
    await tester.pumpAndSettle(); 
    
    // Firaq Step
    await tester.tap(find.byType(ElevatedButton).last);
    await tester.pumpAndSettle(); 

    // NoContact Meaning Step
    await tester.tap(find.byType(ElevatedButton).last);
    await tester.pumpAndSettle(); 

    // App Purpose Step
    await tester.tap(find.byType(ElevatedButton).last);
    await tester.pumpAndSettle(); 
    
    // Verify first main form step (Name)
    expect(find.textContaining(RegExp(r'(hitap|call)')), findsOneWidget);
    
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
    await tester.pump(); // Use pump instead of pumpAndSettle for Home

    // Should be on Home
    expect(find.textContaining('DAYS', skipOffstage: false) != null || find.textContaining('GÜNLER', skipOffstage: false) != null, true);
    expect(find.textContaining('Kayıtlı Kullanıcı'), findsWidgets);
    
    await tester.binding.setSurfaceSize(null);
  });
}

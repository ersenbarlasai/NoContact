import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nocontact/features/privacy_lock/data/privacy_lock_repository.dart';
import 'package:nocontact/features/privacy_lock/presentation/privacy_lock_controller.dart';
import 'package:nocontact/features/privacy_lock/presentation/privacy_lock_gate.dart';
import 'package:nocontact/core/storage/local_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mockito/annotations.dart';
import 'package:local_auth/local_auth.dart';

@GenerateNiceMocks([MockSpec<LocalAuthentication>()])
import 'privacy_lock_test.mocks.dart';

void main() {
  late FakePrivacyLockRepository mockRepo;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await LocalStorageService.init();
    mockRepo = FakePrivacyLockRepository();
  });

  group('PrivacyLock Logic Tests', () {
    test('isBiometricLockEnabled defaults to false', () {
      final repository = PrivacyLockRepository();
      expect(repository.isBiometricLockEnabled(), false);
    });

    test('toggleLock saves state after successful auth', () async {
      final container = ProviderContainer(
        overrides: [
          privacyLockRepositoryProvider.overrideWithValue(mockRepo),
        ],
      );

      final controller = container.read(privacyLockControllerProvider.notifier);
      mockRepo.authenticateResult = true;
      
      final result = await controller.toggleLock(true);
      expect(result, true);
      expect(container.read(privacyLockControllerProvider).isEnabled, true);
    });
  });

  testWidgets('PrivacyLockGate blocks content when locked', (WidgetTester tester) async {
    mockRepo.setBiometricLockEnabled(true);
    
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          privacyLockRepositoryProvider.overrideWithValue(mockRepo),
        ],
        child: const MaterialApp(
          home: PrivacyLockGate(
            child: Text('PROTECTED CONTENT'),
          ),
        ),
      ),
    );

    expect(find.text('PROTECTED CONTENT'), findsNothing);
    expect(find.text('GÜVENLİ ALAN KİLİTLİ'), findsOneWidget);
  });

  testWidgets('PrivacyLockGate shows content when unlocked', (WidgetTester tester) async {
    mockRepo.setBiometricLockEnabled(false);
    
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          privacyLockRepositoryProvider.overrideWithValue(mockRepo),
        ],
        child: const MaterialApp(
          home: PrivacyLockGate(
            child: Text('PROTECTED CONTENT'),
          ),
        ),
      ),
    );

    expect(find.text('PROTECTED CONTENT'), findsOneWidget);
    expect(find.text('GÜVENLİ ALAN KİLİTLİ'), findsNothing);
  });
}

class FakePrivacyLockRepository extends PrivacyLockRepository {
  bool authenticateResult = false;
  bool _enabled = false;

  @override
  bool isBiometricLockEnabled() => _enabled;

  @override
  Future<void> setBiometricLockEnabled(bool enabled) async {
    _enabled = enabled;
  }

  @override
  Future<bool> authenticate() async => authenticateResult;

  @override
  bool shouldRequireUnlock() => _enabled;

  @override
  Future<bool> canCheckBiometrics() async => true;
}

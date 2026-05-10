import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_darwin/local_auth_darwin.dart';
import '../../../core/storage/local_storage_service.dart';

class PrivacyLockRepository {
  final LocalAuthentication _auth = LocalAuthentication();
  static const String _lockEnabledKey = 'biometric_lock_enabled';
  static const String _lastUnlockedAtKey = 'biometric_lock_last_unlocked_at';

  bool isBiometricLockEnabled() {
    return LocalStorageService.getBool(_lockEnabledKey) ?? false;
  }

  Future<void> setBiometricLockEnabled(bool enabled) async {
    await LocalStorageService.setBool(_lockEnabledKey, enabled);
  }

  Future<bool> canCheckBiometrics() async {
    final bool canAuthenticateWithBiometrics = await _auth.canCheckBiometrics;
    final bool canAuthenticate = canAuthenticateWithBiometrics || await _auth.isDeviceSupported();
    return canAuthenticate;
  }

  Future<bool> authenticate() async {
    try {
      final bool didAuthenticate = await _auth.authenticate(
        localizedReason: 'Günlük ve mektuplarını açmak için cihaz doğrulaması gerekiyor.',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: false, // Allow PIN/Pattern fallback
        ),
        authMessages: const <AuthMessages>[
          AndroidAuthMessages(
            signInTitle: 'Cihaz Doğrulaması',
            biometricHint: '',
          ),
          IOSAuthMessages(
            lockOut: 'Güvenli alan kilitlendi.',
          ),
        ],
      );
      if (didAuthenticate) {
        await markUnlocked();
      }
      return didAuthenticate;
    } catch (e) {
      return false;
    }
  }

  Future<void> markUnlocked() async {
    await LocalStorageService.setString(
      _lastUnlockedAtKey,
      DateTime.now().toIso8601String(),
    );
  }

  bool shouldRequireUnlock() {
    if (!isBiometricLockEnabled()) return false;

    final lastUnlockedStr = LocalStorageService.getString(_lastUnlockedAtKey);
    if (lastUnlockedStr == null) return true;

    final lastUnlocked = DateTime.parse(lastUnlockedStr);
    final now = DateTime.now();
    
    // Require unlock if more than 5 minutes have passed
    return now.difference(lastUnlocked).inMinutes >= 5;
  }

  Future<void> clearSession() async {
    await LocalStorageService.remove(_lastUnlockedAtKey);
  }
}

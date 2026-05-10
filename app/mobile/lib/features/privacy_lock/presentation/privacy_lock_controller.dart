import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/privacy_lock_repository.dart';

class PrivacyLockState {
  final bool isEnabled;
  final bool isAvailable;
  final bool isAuthenticating;
  final bool isAuthenticated;

  PrivacyLockState({
    this.isEnabled = false,
    this.isAvailable = false,
    this.isAuthenticating = false,
    this.isAuthenticated = false,
  });

  PrivacyLockState copyWith({
    bool? isEnabled,
    bool? isAvailable,
    bool? isAuthenticating,
    bool? isAuthenticated,
  }) {
    return PrivacyLockState(
      isEnabled: isEnabled ?? this.isEnabled,
      isAvailable: isAvailable ?? this.isAvailable,
      isAuthenticating: isAuthenticating ?? this.isAuthenticating,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }
}

final privacyLockRepositoryProvider = Provider((ref) => PrivacyLockRepository());

class PrivacyLockController extends StateNotifier<PrivacyLockState> {
  final PrivacyLockRepository _repository;

  PrivacyLockController(this._repository)
      : super(PrivacyLockState(isEnabled: _repository.isBiometricLockEnabled())) {
    _init();
  }

  Future<void> _init() async {
    final available = await _repository.canCheckBiometrics();
    state = state.copyWith(isAvailable: available);
  }

  Future<bool> authenticate() async {
    if (!state.isEnabled) return true;
    
    // Check if we already have an active session
    if (!_repository.shouldRequireUnlock()) {
      state = state.copyWith(isAuthenticated: true);
      return true;
    }

    state = state.copyWith(isAuthenticating: true, isAuthenticated: false);
    final success = await _repository.authenticate();
    state = state.copyWith(isAuthenticating: false, isAuthenticated: success);
    return success;
  }

  Future<bool> toggleLock(bool enabled) async {
    // Authenticate before allowing toggle
    final success = await _repository.authenticate();
    if (success) {
      await _repository.setBiometricLockEnabled(enabled);
      state = state.copyWith(isEnabled: enabled);
      return true;
    }
    return false;
  }

  void lock() {
    _repository.clearSession();
    state = state.copyWith(isAuthenticated: false);
  }

  bool shouldShowLockGate() {
    return state.isEnabled && _repository.shouldRequireUnlock() && !state.isAuthenticated;
  }
}

final privacyLockControllerProvider = StateNotifierProvider<PrivacyLockController, PrivacyLockState>((ref) {
  final repository = ref.watch(privacyLockRepositoryProvider);
  return PrivacyLockController(repository);
});

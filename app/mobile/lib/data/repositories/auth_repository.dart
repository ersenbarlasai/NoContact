import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/services/supabase_service.dart';

class AuthRepository {
  final SupabaseClient? _client = SupabaseService.client;

  bool get isAuthenticated => _client?.auth.currentUser != null;

  String? get currentUserId => _client?.auth.currentUser?.id;

  Future<void> signInAnonymously() async {
    if (_client == null) return;
    if (isAuthenticated) return;

    try {
      await _client.auth.signInAnonymously();
    } catch (e) {
      // Log error safely
    }
  }

  Future<void> signOut() async {
    await _client?.auth.signOut();
  }
}

import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/services/supabase_service.dart';
import '../models/recovery_profile.dart';

class RecoveryProfileRepository {
  final SupabaseClient? _client = SupabaseService.client;

  Future<void> upsertRecoveryProfile(RecoveryProfile profile) async {
    if (_client == null || _client.auth.currentUser == null) return;

    final userId = _client.auth.currentUser!.id;
    final data = profile.toJson();
    data['user_id'] = userId;

    try {
      await _client.from('recovery_profiles').upsert(data, onConflict: 'user_id');
    } catch (e) {
      // Handle error safely
    }
  }

  Future<RecoveryProfile?> fetchRecoveryProfile() async {
    if (_client == null || _client.auth.currentUser == null) return null;

    final userId = _client.auth.currentUser!.id;

    try {
      final response = await _client
          .from('recovery_profiles')
          .select()
          .eq('user_id', userId)
          .maybeSingle();

      if (response == null) return null;
      return RecoveryProfile.fromJson(response);
    } catch (e) {
      return null;
    }
  }
}

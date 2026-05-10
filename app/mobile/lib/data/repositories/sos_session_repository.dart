import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/services/supabase_service.dart';
import '../models/sos_session.dart';

class SosSessionRepository {
  final SupabaseClient? _client = SupabaseService.client;

  Future<void> saveSosSession(SosSession session) async {
    if (_client == null || _client.auth.currentUser == null) return;

    final userId = _client.auth.currentUser!.id;
    final data = session.toJson();
    data['user_id'] = userId;

    try {
      await _client.from('sos_sessions').insert(data);
    } catch (e) {
      // Handle error safely
    }
  }

  Future<List<SosSession>> fetchRecentSosSessions({int limit = 10}) async {
    if (_client == null || _client.auth.currentUser == null) return [];

    final userId = _client.auth.currentUser!.id;

    try {
      final response = await _client
          .from('sos_sessions')
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false)
          .limit(limit);

      return (response as List).map((json) => SosSession.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<int> getManagedUrgeCount() async {
    if (_client == null || _client.auth.currentUser == null) return 0;

    final userId = _client.auth.currentUser!.id;

    try {
      final response = await _client
          .from('sos_sessions')
          .select('id')
          .eq('user_id', userId)
          .eq('selected_outcome', 'maintained_nc');
      
      return (response as List).length;
    } catch (e) {
      return 0;
    }
  }
}

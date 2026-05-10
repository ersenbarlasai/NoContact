import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/foundation.dart';

class SupabaseService {
  static SupabaseClient? _client;

  static SupabaseClient? get client => _client;

  static bool get isInitialized => _client != null;

  static Future<void> initialize() async {
    const url = String.fromEnvironment('SUPABASE_URL');
    const anonKey = String.fromEnvironment('SUPABASE_ANON_KEY');

    if (url.isEmpty || anonKey.isEmpty) {
      if (kDebugMode) {
        print('Supabase configuration missing. Persistence will be disabled.');
      }
      return;
    }

    try {
      await Supabase.initialize(
        url: url,
        anonKey: anonKey,
      );
      _client = Supabase.instance.client;
    } catch (e) {
      if (kDebugMode) {
        print('Failed to initialize Supabase: $e');
      }
    }
  }
}

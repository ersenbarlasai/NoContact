import 'package:supabase_flutter/supabase_flutter.dart';
import '../domain/message_analysis_result.dart';

class MessageAnalysisRepository {
  final SupabaseClient _supabase;

  MessageAnalysisRepository(this._supabase);

  Future<MessageAnalysisResult> analyzeMessage(String message) async {
    try {
      final response = await _supabase.functions.invoke(
        'analyze-message',
        body: {'message': message},
      );

      if (response.status != 200) {
        final error = response.data['error'] ?? 'Bilinmeyen bir hata oluştu.';
        throw Exception(error);
      }

      return MessageAnalysisResult.fromJson(response.data as Map<String, dynamic>);
    } on FunctionException catch (e) {
      throw Exception(e.reasonPhrase ?? 'Sunucu hatası oluştu.');
    } catch (e) {
      throw Exception('Analiz başarısız oldu: ${e.toString()}');
    }
  }
}

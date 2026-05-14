import 'dart:convert';
import '../../../core/storage/encrypted_storage_service.dart';
import '../../../core/storage/local_storage_service.dart';
import '../domain/crisis_card.dart';

class LocalSupportRepository {
  static const String _cardsKey = 'crisis_cards_v1';
  static const String _pauseTimestampKey = 'support_24h_pause_timestamp';

  // --- Crisis Cards ---

  Future<List<CrisisCard>> getCrisisCards() async {
    final list = await EncryptedStorageService.getJsonList(_cardsKey);
    if (list == null) return [];
    return list.map((e) => CrisisCard.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<void> saveCrisisCards(List<CrisisCard> cards) async {
    final jsonList = cards.map((e) => e.toJson()).toList();
    await EncryptedStorageService.setJsonList(_cardsKey, jsonList);
  }

  Future<void> addOrUpdateCard(CrisisCard card) async {
    final cards = await getCrisisCards();
    final index = cards.indexWhere((e) => e.id == card.id);
    if (index != -1) {
      cards[index] = card;
    } else {
      cards.add(card);
    }
    await saveCrisisCards(cards);
  }

  // --- 24-Hour Pause ---

  Future<void> start24hPause() async {
    await LocalStorageService.setString(
      _pauseTimestampKey, 
      DateTime.now().toIso8601String()
    );
  }

  DateTime? getPauseStartTime() {
    final str = LocalStorageService.getString(_pauseTimestampKey);
    if (str == null) return null;
    return DateTime.tryParse(str);
  }

  bool isPauseActive() {
    final startTime = getPauseStartTime();
    if (startTime == null) return false;
    final diff = DateTime.now().difference(startTime);
    return diff.inHours < 24;
  }

  Future<void> clearPause() async {
    await LocalStorageService.remove(_pauseTimestampKey);
  }
}

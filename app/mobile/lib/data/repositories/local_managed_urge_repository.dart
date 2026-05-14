import 'dart:convert';
import 'package:uuid/uuid.dart';
import '../../core/storage/local_storage_service.dart';
import '../models/managed_urge_event.dart';
import 'local_sos_session_repository.dart';

class LocalManagedUrgeRepository {
  static const String _eventsKey = 'managed_urge_events';
  final LocalSosSessionRepository _sosRepo;

  LocalManagedUrgeRepository(this._sosRepo);

  List<ManagedUrgeEvent> fetchEvents() {
    final jsonString = LocalStorageService.getString(_eventsKey);
    if (jsonString == null) return [];

    try {
      final list = json.decode(jsonString) as List;
      return list.map((e) => ManagedUrgeEvent.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> saveEvent(String source) async {
    final events = fetchEvents();
    
    // Deduplication / Debounce logic:
    // Ürün kararı: Kullanıcı bir kriz anında arka arkaya birden fazla güvenli 
    // çıkış (örn. SOS bitirip hemen ardından Sessiz Cevap) kullanabilir.
    // Bu ardışık eylemler tek bir "krizin yönetilmesi" olarak kabul edilmelidir.
    // Bu yüzden kaynağı ne olursa olsun, son 2 dakika içinde kaydedilmiş bir
    // olay varsa yeni olay sayacı artırmaz (tek bir kriz anı sayılır).
    if (events.isNotEmpty) {
      final lastEvent = events.last;
      if (DateTime.now().difference(lastEvent.createdAt).inMinutes < 2) {
        return;
      }
    }

    events.add(ManagedUrgeEvent(
      id: const Uuid().v4(),
      source: source,
      createdAt: DateTime.now(),
    ));

    await LocalStorageService.setString(
      _eventsKey,
      json.encode(events.map((e) => e.toJson()).toList()),
    );
  }

  Future<int> getUnifiedCount() async {
    final events = fetchEvents();
    // Fetch legacy count from the old system (this won't increase anymore)
    final legacySosCount = await _sosRepo.fetchManagedUrgeCount();
    
    return legacySosCount + events.length;
  }

  Future<void> clearEvents() async {
    await LocalStorageService.remove(_eventsKey);
  }
}

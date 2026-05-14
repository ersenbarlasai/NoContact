import 'dart:convert';
import '../../../core/storage/local_storage_service.dart';
import '../domain/milestone.dart';

class MilestoneRepository {
  static const String _milestonesKey = 'user_milestones';

  Future<List<Milestone>> fetchMilestones() async {
    final jsonString = LocalStorageService.getString(_milestonesKey);
    if (jsonString == null) return [];

    try {
      final decoded = json.decode(jsonString) as List<dynamic>;
      return decoded.map((item) => Milestone.fromJson(item as Map<String, dynamic>)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> saveMilestones(List<Milestone> milestones) async {
    final jsonString = json.encode(milestones.map((m) => m.toJson()).toList());
    await LocalStorageService.setString(_milestonesKey, jsonString);
  }

  Future<void> markAsSeen(String id) async {
    final milestones = await fetchMilestones();
    final updated = milestones.map((m) {
      if (m.id == id) {
        return m.copyWith(isSeen: true, seenAt: DateTime.now());
      }
      return m;
    }).toList();
    await saveMilestones(updated);
  }
}

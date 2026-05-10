import '../../core/storage/local_storage_service.dart';
import '../models/recovery_profile.dart';

class LocalRecoveryProfileRepository {
  static const String _profileKey = 'recovery_profile';

  Future<void> saveProfile(RecoveryProfile profile) async {
    await LocalStorageService.setJson(_profileKey, profile.toJson());
  }

  Future<RecoveryProfile?> fetchProfile() async {
    final json = LocalStorageService.getJson(_profileKey);
    if (json != null) {
      return RecoveryProfile.fromJson(json);
    }
    return null;
  }

  Future<void> clearProfile() async {
    await LocalStorageService.remove(_profileKey);
  }
}

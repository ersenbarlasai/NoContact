import '../../core/storage/encrypted_storage_service.dart';
import '../models/unsent_letter.dart';

class LocalLettersVaultRepository {
  static const String _storageKey = 'encrypted_unsent_letters';

  Future<List<UnsentLetter>> fetchLetters() async {
    final jsonList = await EncryptedStorageService.getJsonList(_storageKey);
    if (jsonList != null) {
      return jsonList
          .map((e) => UnsentLetter.fromJson(e as Map<String, dynamic>))
          .where((e) => e.deletedAt == null)
          .toList();
    }
    return [];
  }

  Future<UnsentLetter?> fetchLetterById(String id) async {
    final letters = await fetchLetters();
    try {
      return letters.firstWhere((e) => e.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<void> saveLetter(UnsentLetter letter) async {
    final letters = await fetchLetters();
    final index = letters.indexWhere((e) => e.id == letter.id);

    if (index >= 0) {
      letters[index] = letter;
    } else {
      letters.add(letter);
    }

    await _saveAll(letters);
  }

  Future<void> archiveLetter(String id) async {
    final letters = await fetchLetters();
    final index = letters.indexWhere((e) => e.id == id);
    if (index >= 0) {
      letters[index] = letters[index].copyWith(
        archivedAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      await _saveAll(letters);
    }
  }

  Future<void> restoreLetter(String id) async {
    final letters = await fetchLetters();
    final index = letters.indexWhere((e) => e.id == id);
    if (index >= 0) {
      letters[index] = letters[index].copyWith(
        archivedAt: null,
        updatedAt: DateTime.now(),
      );
      await _saveAll(letters);
    }
  }

  Future<void> deleteLetter(String id) async {
    final letters = await fetchLetters();
    final index = letters.indexWhere((e) => e.id == id);
    if (index >= 0) {
      // Soft delete
      letters[index] = letters[index].copyWith(
        deletedAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      await _saveAll(letters);
    }
  }

  Future<void> hardDeleteLetter(String id) async {
    final letters = await fetchLetters();
    letters.removeWhere((e) => e.id == id);
    await _saveAll(letters);
  }


  Future<void> clearLetters() async {
    await EncryptedStorageService.delete(_storageKey);
  }

  Future<void> _saveAll(List<UnsentLetter> letters) async {
    await EncryptedStorageService.setJsonList(
      _storageKey,
      letters.map((e) => e.toJson()).toList(),
    );
  }
}

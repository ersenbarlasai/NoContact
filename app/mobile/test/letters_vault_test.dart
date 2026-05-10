import 'package:flutter_test/flutter_test.dart';
import 'package:nocontact/data/models/unsent_letter.dart';
import 'package:nocontact/data/repositories/local_letters_vault_repository.dart';
import 'package:nocontact/core/storage/local_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Letters Vault Logic & Encryption Tests', () {
    late LocalLettersVaultRepository repository;
    final Map<String, String> mockSecureStorage = {};

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await LocalStorageService.init();
      repository = LocalLettersVaultRepository();
      mockSecureStorage.clear();

      // Mock FlutterSecureStorage Platform Channel
      const MethodChannel('plugins.it_nomads.com/flutter_secure_storage')
          .setMockMethodCallHandler((MethodCall methodCall) async {
        switch (methodCall.method) {
          case 'write':
            mockSecureStorage[methodCall.arguments['key'] as String] = methodCall.arguments['value'] as String;
            return null;
          case 'read':
            return mockSecureStorage[methodCall.arguments['key'] as String];
          case 'delete':
            mockSecureStorage.remove(methodCall.arguments['key'] as String);
            return null;
          case 'deleteAll':
            mockSecureStorage.clear();
            return null;
          default:
            return null;
        }
      });
    });

    test('saveLetter and fetchLetters: data is encrypted and retrieved', () async {
      final now = DateTime.now();
      final letter = UnsentLetter(
        id: 'letter_1',
        title: 'Veda',
        body: 'Bu sana son mektubum.',
        emotion: 'Üzgün',
        createdAt: now,
        updatedAt: now,
      );

      await repository.saveLetter(letter);

      final letters = await repository.fetchLetters();
      expect(letters.length, 1);
      expect(letters.first.id, 'letter_1');
      expect(letters.first.body, 'Bu sana son mektubum.');
      
      // Verify it's in mock secure storage
      expect(mockSecureStorage.containsKey('encrypted_unsent_letters'), isTrue);
    });

    test('update existing letter keeps the same ID', () async {
      final now = DateTime.now();
      final letter = UnsentLetter(
        id: 'letter_1',
        body: 'İlk versiyon',
        createdAt: now,
        updatedAt: now,
      );

      await repository.saveLetter(letter);
      
      final updated = letter.copyWith(body: 'Güncellenmiş versiyon');
      await repository.saveLetter(updated);

      final letters = await repository.fetchLetters();
      expect(letters.length, 1);
      expect(letters.first.body, 'Güncellenmiş versiyon');
    });

    test('archiveLetter sets archivedAt timestamp', () async {
      final now = DateTime.now();
      final letter = UnsentLetter(
        id: 'letter_1',
        body: 'Test',
        createdAt: now,
        updatedAt: now,
      );

      await repository.saveLetter(letter);
      await repository.archiveLetter('letter_1');

      final letters = await repository.fetchLetters();
      expect(letters.first.archivedAt, isNotNull);
    });

    test('deleteLetter performs soft delete (removed from fetchLetters)', () async {
      final now = DateTime.now();
      final letter = UnsentLetter(
        id: 'letter_1',
        body: 'Silinecek',
        createdAt: now,
        updatedAt: now,
      );

      await repository.saveLetter(letter);
      await repository.deleteLetter('letter_1');

      final letters = await repository.fetchLetters();
      expect(letters.isEmpty, isTrue);
    });

    test('clearLetters removes all encrypted data', () async {
      final now = DateTime.now();
      final letter = UnsentLetter(
        id: '1',
        body: 'A',
        createdAt: now,
        updatedAt: now,
      );

      await repository.saveLetter(letter);
      expect(mockSecureStorage.isNotEmpty, isTrue);

      await repository.clearLetters();
      expect(mockSecureStorage.isEmpty, isTrue);
    });
  });
}

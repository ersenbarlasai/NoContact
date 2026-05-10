import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

class EncryptedStorageService {
  static const FlutterSecureStorage _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock,
    ),
  );

  static Future<void> write(String key, String value) async {
    try {
      await _storage.write(key: key, value: value);
    } catch (e) {
      // Handle potential secure storage errors gracefully
      print('EncryptedStorage Error (write): $e');
    }
  }

  static Future<String?> read(String key) async {
    try {
      return await _storage.read(key: key);
    } catch (e) {
      print('EncryptedStorage Error (read): $e');
      return null;
    }
  }

  static Future<void> delete(String key) async {
    try {
      await _storage.delete(key: key);
    } catch (e) {
      print('EncryptedStorage Error (delete): $e');
    }
  }

  static Future<void> clearAll() async {
    try {
      await _storage.deleteAll();
    } catch (e) {
      print('EncryptedStorage Error (clearAll): $e');
    }
  }

  // Helpers for JSON
  static Future<void> setJson(String key, Map<String, dynamic> json) async {
    await write(key, jsonEncode(json));
  }

  static Future<Map<String, dynamic>?> getJson(String key) async {
    final value = await read(key);
    if (value != null) {
      try {
        return jsonDecode(value) as Map<String, dynamic>;
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  static Future<void> setJsonList(String key, List<dynamic> list) async {
    await write(key, jsonEncode(list));
  }

  static Future<List<dynamic>?> getJsonList(String key) async {
    final value = await read(key);
    if (value != null) {
      try {
        return jsonDecode(value) as List<dynamic>;
      } catch (e) {
        return null;
      }
    }
    return null;
  }
}

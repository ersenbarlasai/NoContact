import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Generic methods
  static Future<void> setString(String key, String value) async {
    await _prefs?.setString(key, value);
  }

  static String? getString(String key) {
    return _prefs?.getString(key);
  }

  static Future<void> setInt(String key, int value) async {
    await _prefs?.setInt(key, value);
  }

  static int? getInt(String key) {
    return _prefs?.getInt(key);
  }

  static Future<void> setBool(String key, bool value) async {
    await _prefs?.setBool(key, value);
  }

  static bool? getBool(String key) {
    return _prefs?.getBool(key);
  }

  static Future<void> remove(String key) async {
    await _prefs?.remove(key);
  }

  static Future<void> clearAll() async {
    await _prefs?.clear();
  }

  // Helper for JSON
  static Future<void> setJson(String key, Map<String, dynamic> json) async {
    await setString(key, jsonEncode(json));
  }

  static Map<String, dynamic>? getJson(String key) {
    final value = getString(key);
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
    await setString(key, jsonEncode(list));
  }

  static List<dynamic>? getJsonList(String key) {
    final value = getString(key);
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

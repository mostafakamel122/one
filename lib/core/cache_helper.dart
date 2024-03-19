import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? prefs;
  static const _tokenKey = 'token';
  static const _id = 'id';
  static const _langKey = 'language';
  static const _mode = 'mode';

  static const _ifFirstTimeKey = 'IfFirstTime';

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> saveIfNotFirstTime() async {
    try {
      return await prefs?.setBool(_ifFirstTimeKey, false) ?? false;
    } catch (e) {
      print("Error saving IfFirstTime: $e");
      return false;
    }
  }

  static bool getIfFirstTime() {
    try {
      return prefs?.getBool(_ifFirstTimeKey) ?? true;
    } catch (e) {
      print("Error getting IfFirstTime: $e");
      return true;
    }
  }

  static Future saveToken(String token) async {
    try {
      prefs?.setString(_tokenKey, token);
      return await prefs?.setString('token', token) ?? '';
    } catch (e) {
      print("Error saving token: $e");
      return false;
    }
  }

  static String getToken() {
    try {
      return prefs?.getString('token') ?? "";
    } catch (e) {
      print("Error getting token: $e");
      return "";
    }
  }

  static Future saveid(String id) async {
    try {
      prefs?.setString(_id, id);
      return await prefs?.setString('id', id) ?? '';
    } catch (e) {
      print("Error saving token: $e");
      return false;
    }
  }

  static String getid() {
    try {
      return prefs?.getString(_id) ?? "";
    } catch (e) {
      print("Error getting token: $e");
      return "";
    }
  }

  static Future<bool> saveLang(String lang) async {
    try {
      return await prefs?.setString(_langKey, lang) ?? false;
    } catch (e) {
      return false;
    }
  }

  static String getLang() {
    try {
      return prefs?.getString(_langKey) ?? "";
    } catch (e) {
      return "";
    }
  }

  static Future<bool> saveMode(String lang) async {
    try {
      return await prefs?.setString(_mode, lang) ?? false;
    } catch (e) {
      return false;
    }
  }

  static String getMode() {
    try {
      return prefs?.getString(_mode) ?? "";
    } catch (e) {
      return "";
    }
  }

  //lastinsert Refresh
  static Future<bool> saveLastInsertRefresh() async {
    try {
      return await prefs?.setString(
              'Refresh', DateTime.now().toUtc().toIso8601String()) ??
          false;
    } catch (e) {
      return false;
    }
  }

  static String getLastInsertRefresh() {
    try {
      return prefs?.getString('Refresh') ?? "";
    } catch (e) {
      return "";
    }
  }

  //lastinsert Refresh
  static Future<Object?> clearShared() async {
    try {
      return prefs?.clear();
    } catch (e) {
      return false;
    }
  }
}

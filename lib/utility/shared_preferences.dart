import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SharedPreferencesService {
  static final SharedPreferencesService _singleton =
      SharedPreferencesService._internal();

  factory SharedPreferencesService() {
    return _singleton;
  }

  SharedPreferencesService._internal();

  static Future<String> getFromShared(String key) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    return await storage.read(key: key) ?? "";
  }

  static void setInShared(String key, String value) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    await storage.write(key: key, value: value);
  }

  static Future<bool> getIsLoggedIn() {
    return getFromShared("accessToken").then((value) {
      return value != "";
    });
  }

  static Future<bool> getIsOnboardingDone() {
    return getFromShared("onboarding").then((value) {
      return value == "done";
    });
  }

  static void emptMemmory() async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    await storage.deleteAll();
  }
}

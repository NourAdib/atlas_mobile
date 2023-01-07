import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Shared {
  static final Shared _singleton = Shared._internal();

  factory Shared() {
    return _singleton;
  }

  Shared._internal();

  static Future<String> getFromShared(String key) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    return await storage.read(key: key) ?? "";
  }

  static void setInShared(String key, String value) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    await storage.write(key: key, value: value);
  }

  static void emptMemmory() async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    await storage.deleteAll();
  }
}

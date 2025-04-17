import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecuredStorage {
  static const storage = FlutterSecureStorage();

  static Future<void> addCredential(String email, String password) async {
    await storage.write(key: email, value: password);
  }

  static Future<bool> checkPassword(String email, String password) async {
    String pass = await storage.read(key: email) ?? "";
    if (pass == password) {
      return true;
    }
    return false;
  }

  static Future<void> removeAccound(String email) async {
    await storage.delete(key: email);
  }

  static Future<void> login(String email) async {
    await storage.write(key: "logged_in", value: email);
  }

  static Future<String?> isLogin() async {
    return await storage.read(key: "logged_in");
  }

  static Future<bool> isRegistered(String email) async {
    if (await storage.read(key: email) == null) {
      return false;
    }
    return true;
  }
}

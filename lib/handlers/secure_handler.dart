import 'package:flutter_secure_storage/flutter_secure_storage.dart';



class StorageHandler {
  static FlutterSecureStorage storage = const FlutterSecureStorage();

  static Future<void> saveUserName([String? username]) async {
    if (username != null)
      await storage.write(key: 'USER', value: username);
  }

  static Future<String> getUserName() async {
   String? value = await storage.read(key: 'USER');
    String? username;
    String? data = value;
    if (data != null) {
      username = data;
    }else{
      username = '';
    }
    return username;
  }

  static Future<void> saveAgentId([String? id]) async {
    if (id != null)
      await storage.write(key: 'ID', value: id);
  }

  static Future<String> getAgentId() async {
   String? value = await storage.read(key: 'ID');
    String? id;
    String? data = value;
    if (data != null) {
      id = data;
    }else{
      id = '';
    }
    return id;
  }

  static Future<void> clearUserDetails() async {
    await storage.delete(key: 'USER');
  }

  static Future<void> clearCache() async {
    await storage.deleteAll();
  }

  
}

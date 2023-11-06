import 'package:flutter_secure_storage/flutter_secure_storage.dart';



class StorageHandler {
  static FlutterSecureStorage storage = const FlutterSecureStorage();

  static Future<void> saveUserName([String? username]) async {
    if (username != null)
      await storage.write(key: 'USER', value: username);
  }
  static Future<void> saveEmail([String? username]) async {
    if (username != null)
      await storage.write(key: 'EMAIL', value: username);
  }

  static Future<void> saveUserPetState([String? petState]) async {
    if (petState != null)
      await storage.write(key: 'PETSTATE', value: petState);
  }

  static Future<void> saveUserId([String? userId]) async {
    if (userId != null)
      await storage.write(key: 'ID', value: userId);
  }

   static Future<void> saveUserPassword([String? password]) async {
    if (password != null)
      await storage.write(key: 'PASSWORD', value: password);
  }

  static Future<void> saveOnboardState([String? onBoard]) async {
    if (onBoard != null)
      await storage.write(key: 'ONBOARD', value: onBoard);
  }

  static Future<void> saveIsLoggedIn([String? isLoggedIn]) async {
    if (isLoggedIn != null)
      await storage.write(key: 'LOGGEDIN', value: isLoggedIn);
  }

   static Future<void> saveIsUserType([String? isUserType]) async {
    if (isUserType != null)
      await storage.write(key: 'USERTYPE', value: isUserType);
  }

static Future<void> saveAgentId(String id) async {
    
      await storage.write(key: 'AGENT_ID', value: id);
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

   static Future<String> getUserEmail() async {
   String? value = await storage.read(key: 'EMAIL');
    String? email;
    String? data = value;
    if (data != null) {
      email = data;
    }else{
      email = '';
    }
    return email;
  }

   static Future<String> getUserPetState() async {
   String? value = await storage.read(key: 'PETSTATE');
    String? userId;
    String? data = value;
    if (data != null) {
      userId = data;
    }else{
      userId = '';
    }
    return userId;
  }

  static Future<String> getUserId() async {
   String? value = await storage.read(key: 'ID');
    String? userId;
    String? data = value;
    if (data != null) {
      userId = data;
    }else{
      userId = '';
    }
    return userId;
  }

  static Future<String> getOnBoardState() async {
   String? value = await storage.read(key: 'ONBOARD');
    String? onboard;
    String? data = value;
    if (data != null) {
      onboard = data;
    }else{
      onboard = '';
    }
    return onboard;
  }

  static Future<String> getLoggedInState() async {
   String? value = await storage.read(key: 'LOGGEDIN');
    String? loggedin;
    String? data = value;
    if (data != null) {
      loggedin = data;
    }else{
      loggedin = '';
    }
    return loggedin;
  }

  static Future<String> getUserType() async {
   String? value = await storage.read(key: 'USERTYPE');
    String? usertype;
    String? data = value;
    if (data != null) {
      usertype = data;
    }else{
      usertype = '';
    }
    return usertype;
  }

   static Future<String> getUserPassword() async {
   String? value = await storage.read(key: 'PASSWORD');
    String? password;
    String? data = value;
    if (data != null) {
      password = data;
    }else{
      password = '';
    }
    return password;
  }

  

  static Future<String> getAgentId() async {
   String? value = await storage.read(key: 'AGENT_ID');
    String? id;
    String? data = value;
    if (data != null) {
      id = data;
    }else{
      id = '';
    }
    return id;
  }

  

  static Future<void> clearCache() async {
    await storage.deleteAll();
  }

  
}

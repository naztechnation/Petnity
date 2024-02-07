import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageHandler {
  static FlutterSecureStorage storage = const FlutterSecureStorage();

  static Future<void> saveUserName([String? username]) async {
    if (username != null) await storage.write(key: 'USER', value: username);
  }

  static Future<void> saveEmail([String? username]) async {
    if (username != null) await storage.write(key: 'EMAIL', value: username);
  }

  static Future<void> saveUserPetState([String? petState]) async {
    if (petState != null) await storage.write(key: 'PETSTATE', value: petState);
  }

  static Future<void> saveFireBaseToken([String? token]) async {
    if (token != null) await storage.write(key: 'FIREBASETOKEN', value: token);
  }

  static Future<void> saveUserPicture([String? picture]) async {
    if (picture != null) await storage.write(key: 'DP', value: picture);
  }

  static Future<void> saveUserPhone([String? phone]) async {
    if (phone != null) await storage.write(key: 'PHONE', value: phone);
  }

  static Future<void> saveUserId([String? userId]) async {
    if (userId != null) await storage.write(key: 'ID', value: userId);
  }

   static Future<void> saveAgentId([String? username]) async {
    if (username != null) await storage.write(key: 'AGENTID', value: username);
  }

  static Future<void> saveUserPassword([String? password]) async {
    if (password != null) await storage.write(key: 'PASSWORD', value: password);
  }

  static Future<void> saveOnboardState([String? onBoard]) async {
    if (onBoard != null) await storage.write(key: 'ONBOARD', value: onBoard);
  }

  static Future<void> saveIsLoggedIn([String? isLoggedIn]) async {
    if (isLoggedIn != null)
      await storage.write(key: 'LOGGEDIN', value: isLoggedIn);
  }

  static Future<void> saveIsUserType([String? isUserType]) async {
    if (isUserType != null)
      await storage.write(key: 'USERTYPE', value: isUserType);
  }



  static Future<void> saveUserToken([String? token]) async {
    if (token != null) await storage.write(key: 'TOKEN', value: token);
  }

  static Future<String> getUserName() async {
    String? value = await storage.read(key: 'USER');
    String? username;
    String? data = value;
    if (data != null) {
      username = data;
    } else {
      username = '';
    }
    return username;
  }

   static Future<String> getUserToken() async {
    String? value = await storage.read(key: 'TOKEN');
    String? token;
    String? data = value;
    if (data != null) {
      token = data;
    } else {
      token = '';
    }
    return token;
  }

   static Future<String> getAgentId() async {
    String? value = await storage.read(key: 'AGENTID');
    String? agentId;
    String? data = value;
    if (data != null) {
      agentId = data;
    } else {
      agentId = '';
    }
    return agentId;
  }

    static Future<String> getFirebaseToken() async {
    String? value = await storage.read(key: 'FIREBASETOKEN');
    String? token;
    String? data = value;
    if (data != null) {
      token = data;
    } else {
      token = '';
    }
    return token;
  }

  static Future<String> getUserPicture() async {
    String? value = await storage.read(key: 'DP');
    String? dp;
    String? data = value;
    if (data != null) {
      dp = data;
    } else {
      dp = '';
    }
    return dp;
  }

  static Future<String> getUserEmail() async {
    String? value = await storage.read(key: 'EMAIL');
    String? email;
    String? data = value;
    if (data != null) {
      email = data;
    } else {
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
    } else {
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
    } else {
      userId = '';
    }
    return userId;
  }

  static Future<String> getUserPhone() async {
    String? value = await storage.read(key: 'PHONE');
    String? userId;
    String? data = value;
    if (data != null) {
      userId = data;
    } else {
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
    } else {
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
    } else {
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
    } else {
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
    } else {
      password = '';
    }
    return password;
  }

 

  static Future<void> clearCache() async {
    await storage.deleteAll();
  }
}

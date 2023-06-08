

import 'package:uuid/uuid.dart';

class AppHandler{

  static void logPrint(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }

  static String generateUniqueId()=> const Uuid().v4();

}
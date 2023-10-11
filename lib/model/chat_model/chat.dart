import 'package:cloud_firestore/cloud_firestore.dart';

import '../../ui/constants/firebase_constants.dart';

class MessageChat {
  String idFrom;
  String idTo;
  var timestamp;
  String content;
  

  MessageChat({
    required this.idFrom,
    required this.idTo,
    required this.timestamp,
    required this.content,
    
  });

  Map<String, dynamic> toJson() {
    return {
      FirestoreConstants.idFrom: this.idFrom,
      FirestoreConstants.idTo: this.idTo,
      FirestoreConstants.timestamp: this.timestamp,
      FirestoreConstants.content: this.content,
     
    };
  }

  factory MessageChat.fromDocument(DocumentSnapshot doc) {
    String idFrom = doc.get(FirestoreConstants.idFrom);
    String idTo = doc.get(FirestoreConstants.idTo);
    var timestamp = doc.get(FirestoreConstants.timestamp);
    String content = doc.get(FirestoreConstants.content);
  
    return MessageChat(idFrom: idFrom, idTo: idTo, timestamp: timestamp, content: content);
  }
}
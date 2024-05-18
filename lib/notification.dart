import 'dart:convert';
import 'package:http/http.dart' as http;


Future<void> sendPushNotification(String userToken, String title, String body) async {

  String serverKey = 'AAAAHXOa4oA:APA91bG3PcQwkNGCATsoKDoXjvROAGN2NSHcfIU6c4dcMqWRz93ThsBzUB9GmCsj77PakBLHcDQ_UQQTMluQYxb_DjufHO1wkKXXriAYX6wnmHPxaBQ9kQ3nYXIIH7bogx7NlDMuByNk';

  String fcmUrl = 'https://fcm.googleapis.com/fcm/send';

  Map<String, dynamic> notification = {
    'to': userToken,
    'notification': {'title': title, 'body': body},
  };

  String jsonBody = json.encode(notification);

  try {
    final response = await http.post(
      Uri.parse(fcmUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverKey',
      },
      body: jsonBody,
    );

    if (response.statusCode == 200) {
      print('Push notification sent successfully');
    } else {
      print('Failed to send push notification: ${response.statusCode}');
    }
  } catch (e) {
    print('Error sending push notification: $e');
  }


    
}


 Future<void> sendTopicNotification(String topic, String title, String body) async {
    // JSON body of the push notification
   String serverKey = 'AAAAEiJ_eRc:APA91bHHE8Mqr8q1qOvNc-wE3y22GAz5EfJaWivQlW21cwDmviS6XysZKkwWeoA6hqKaxuVE80YGc7LQ4fuCewU564L-ujpEbLbeLzV_8Zm9JZ7M_4_NQA0uBs04MkQwsTFafZ2CaX65';

  String fcmUrl = 'https://fcm.googleapis.com/fcm/send';

   
    Map<String, dynamic> notification = {
      'notification': {'title': title, 'body': body},
      'to': '/topic/$topic',
    };

    // Encode the notification as JSON
    String jsonBody = json.encode(notification);

    // Sending POST request to FCM
    try {
      final response = await http.post(
        Uri.parse(fcmUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverKey',
        },
        body: jsonBody,
      );

      if (response.statusCode == 200) {
        print('Push notification sent to topic "$topic" successfully');
      } else {
        print('Failed to send push notification to topic "$topic": ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending push notification: $e');
    }
  }

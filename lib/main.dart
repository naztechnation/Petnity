import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:petnity/ui/widgets/modals.dart';
import 'package:provider/provider.dart';
import 'handlers/secure_handler.dart';
import 'model/view_models/firebase_auth_viewmodel.dart';
import 'model/view_models/service_provider_inapp.dart';
import 'model/view_models/service_provider_view_model.dart';
import 'model/view_models/account_view_model.dart';
import 'model/view_models/user_view_model.dart';
import 'res/app_routes.dart';
import 'res/app_strings.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await setupFlutterNotifications();
  showFlutterNotification(message);
}



// Create a notification channel for Flutter Local Notifications
AndroidNotificationChannel channel = const AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description: 'This channel is used for important notifications.', // description
  importance: Importance.high,
);

bool isFlutterLocalNotificationsInitialized = false;

// Function to set up Flutter Local Notifications
Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  isFlutterLocalNotificationsInitialized = true;
}

// Function to show Flutter Local Notification
void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null && !kIsWeb) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: '@drawable/launcher_icon',
        ),
      ),
    );
  }
}


FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

 
  _firebaseMessaging.getToken().then((token) async {
    await StorageHandler.saveFireBaseToken(token.toString());

  });

  
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (message.data != {}) {
     
      Future.delayed(Duration(seconds: 10), () {});
      showFlutterNotification(message);
    }
  });
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AccountViewModel(), lazy: false),
      ChangeNotifierProvider(create: (_) => ServiceProviderViewModel(), lazy: false),
      ChangeNotifierProvider(create: (_) => UserViewModel(), lazy: false),
      ChangeNotifierProvider(create: (_) => FirebaseAuthProvider(), lazy: false),
      ChangeNotifierProvider(create: (_) => ServiceProviderInAppViewModel(), lazy: false),
    ], 
    child: const Lucacify(),
  ));
}

class Lucacify extends StatelessWidget {
  const Lucacify({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      themeMode: ThemeMode.light,
      theme: ThemeData(fontFamily: AppStrings.satoshi, ),
      routes: AppRoutes.routes,

      
       initialRoute: AppRoutes.splashScreen,

      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}

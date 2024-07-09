import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:petnity/fcm.dart';
import 'package:provider/provider.dart';
import 'model/view_models/chat_controller.dart';
import 'model/view_models/firebase_auth_viewmodel.dart';
import 'model/view_models/service_provider_inapp.dart';
import 'model/view_models/service_provider_view_model.dart';
import 'model/view_models/account_view_model.dart';
import 'model/view_models/user_view_model.dart';
import 'res/app_routes.dart';
import 'res/app_strings.dart';

 
Future _firebaseBackgroundMessage(RemoteMessage message) async {
  if (message.notification != null) {
    
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    if (message.notification != null) {
      
    //  navigatorKey.currentState!.pushNamed(AppRoutes.message, arguments: message);
    }
  });

  PushNotifications.init();
  PushNotifications.localNotiInit();
   
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);

   
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    String payloadData = jsonEncode(message.data);
    
    if (message.notification != null) {
      PushNotifications.showSimpleNotification(
          title: message.notification!.title!,
          body: message.notification!.body!,
          payload: payloadData);
    }
  });

 
  final RemoteMessage? message =
      await FirebaseMessaging.instance.getInitialMessage();

  if (message != null) {
    Future.delayed(Duration(seconds: 1), () {

      
     // navigatorKey.currentState!.pushNamed(AppRoutes.message, arguments: message);
    });
  }
  


  
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AccountViewModel(), lazy: false),
      ChangeNotifierProvider(
          create: (_) => ServiceProviderViewModel(), lazy: false),
      ChangeNotifierProvider(create: (_) => UserViewModel(), lazy: false),
      ChangeNotifierProvider(
          create: (_) => FirebaseAuthProvider(), lazy: false),
      ChangeNotifierProvider(
          create: (_) => ServiceProviderInAppViewModel(), lazy: false),
      ChangeNotifierProvider(create: (_) => MessageController(), lazy: false),
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
      theme: ThemeData(
        fontFamily: AppStrings.satoshi,
      ),
      routes: AppRoutes.routes,
      initialRoute: AppRoutes.splashScreen,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}

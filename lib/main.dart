import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'model/view_models/user_view_model.dart';
import 'res/app_routes.dart';
import 'res/app_strings.dart';

Future<void> main() async {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserViewModel(), lazy: false),
    ],
    child: const Petnity(),
  ));
}

class Petnity extends StatelessWidget {
  const Petnity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      themeMode: ThemeMode.light,
      theme: ThemeData(fontFamily: AppStrings.montserrat),
      routes: AppRoutes.routes,

      //initialRoute: AppRoutes.serviceProviderLandingPage,
       initialRoute: AppRoutes.signInScreen,
      //initialRoute: AppRoutes.serviceProviderLandingPage,
      // initialRoute: AppRoutes.welcomeScreen,

      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'res/app_routes.dart';
import 'res/app_strings.dart';

Future<void> main() async {
  runApp(
    const Petnity(),
  );
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
      initialRoute: AppRoutes.landingPage,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}

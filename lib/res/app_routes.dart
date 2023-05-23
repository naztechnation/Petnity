
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petnity/ui/auth/otp_screen.dart';
import 'package:petnity/ui/auth/sign_up.dart';
import 'package:petnity/ui/kyc/kyc_screen_one.dart';

import '../ui/auth/reg_successful_screen.dart';
import '../ui/auth/sign_in.dart';
import '../ui/on_boarding/welcome_screen.dart';
import '../splash_screen.dart';


class AppRoutes {
  ///Route names used through out the app will be specified as static constants here in this format
  static const String splashScreen = 'splashScreen';
  static const String welcomeScreen = 'welcomeScreen';
  static const String signInScreen = 'signInScreen';
  static const String signUpScreen = 'signUpScreen';
  static const String otpScreen = 'otpScreen';
  static const String successScreen = 'successScreen';
  static const String kycScreenOne = 'kycScreenOne';
  

  static Map<String, Widget Function(BuildContext)> routes = {
    ///Named routes to be added here in this format
    splashScreen: (context) => const SplashScreen(),
    welcomeScreen: (context) => const WelcomeScreen(),
    signUpScreen: (context) => const SignUpScreen(),
    signInScreen: (context) => const SignInScreen(),
    otpScreen: (context) => const OtpScreen(),
    successScreen: (context) => const RegSuccessful(),
    kycScreenOne: (context) => const KycScreenOne(),
    
  };

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Add your screen here as well as the transition you want
      case splashScreen:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
     case welcomeScreen:
        return MaterialPageRoute(
          builder: (context) => const WelcomeScreen(),
        );
         case signUpScreen:
        return MaterialPageRoute(
          builder: (context) => const SignUpScreen(),
        );
         case signInScreen:
        return MaterialPageRoute(
          builder: (context) => const SignInScreen(),
        );
        case otpScreen:
        return MaterialPageRoute(
          builder: (context) => const OtpScreen(),
        );
        case successScreen:
        return MaterialPageRoute(
          builder: (context) => const RegSuccessful(),
        );
         case kycScreenOne:
        return MaterialPageRoute(
          builder: (context) => const KycScreenOne(),
        );
      //Default Route is error route
      default:
        return CupertinoPageRoute(
            builder: (context) => errorView(settings.name!));
    }
  }

  static Widget errorView(String name) {
    return Scaffold(body: Center(child: Text('404 $name View not found')));
  }
}

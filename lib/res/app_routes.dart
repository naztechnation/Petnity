import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petnity/ui/service_povider_section/landing_page.dart';
import 'package:petnity/ui/service_povider_section/service_provider_home/service_provider_home.dart';
import 'package:petnity/ui/auth/otp_screen.dart';
import 'package:petnity/ui/auth/sign_up_screen.dart';
import 'package:petnity/ui/user/user_kyc/kyc_screen_one.dart';
import 'package:petnity/ui/landing_page/shop_screen/cart.dart';
import 'package:petnity/ui/landing_page/shop_screen/product_detail_screen.dart';
import 'package:petnity/ui/settings/acount_deleted.dart';
import 'package:petnity/ui/settings/change_email.dart';
import 'package:petnity/ui/settings/change_email_&_number_option.dart';
import 'package:petnity/ui/settings/change_number.dart';
import 'package:petnity/ui/settings/change_password.dart';
import 'package:petnity/ui/settings/payment_and_card.dart';
import 'package:petnity/ui/settings/privacy_policy.dart';
import 'package:petnity/ui/settings/saved_cards.dart';
import 'package:petnity/ui/settings/settings.dart';
import 'package:petnity/ui/settings/transactions.dart';
import 'package:petnity/ui/support/faq.dart';
import 'package:petnity/ui/support/live_support_chat.dart';
import 'package:petnity/ui/support/report_a_bug.dart';
import 'package:petnity/ui/support/report_a_vendor.dart';
import 'package:petnity/ui/support/report_an_issue.dart';

import '../ui/auth/reg_successful_screen.dart';
import '../ui/auth/sign_in_screen.dart';
import '../ui/service_provider/service_provider_kyc/service_kyc_one.dart';
import '../ui/user/user_kyc/kyc_screen_two.dart';
import '../ui/landing_page/landing_screen.dart';
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
  static const String kycScreenTwo = 'kycScreenTwo';
  static const String landingPage = 'landingPage';
  static const String serviceProviderHomePage = 'serviceProviderHomePage';
  static const String productDetailScreen = 'productDetailScreen';
  static const String serviceProviderKycOneScreen = 'serviceProviderKycOneScreen';

  static const String cartScreen = 'cartScreen';

  static const String changeEmail = 'changeEmail';

  static const String changeNumber = 'changeNumber';

  static const String transactions = 'transactions';

  static const String savedCards = 'savedCards';

  static const String privacyPolicy = 'privacyPolicy';
  static const String faqs = 'faqs';
  static const String changeEmailandNumber = 'changeEmailandNumber';
  static const String paymentAndCard = 'paymentAndCard';
  static const String changePassword = 'changePassword';
  static const String accountDeleted = 'accountDeleted';
  static const String settingsScreen = 'settingsScreen';
  static const String liveSupport = 'liveSupport';
  static const String reportIssue = 'reportIssue';
  static const String reportVendor = 'reportVendor';
  static const String reportBug = 'reportBug';
  static const String serviceProviderLandingPage = 'serviceProviderLandingPage';

  static Map<String, Widget Function(BuildContext)> routes = {
    ///Named routes to be added here in this format
    splashScreen: (context) => const SplashScreen(),
    welcomeScreen: (context) => const WelcomeScreen(),
    signUpScreen: (context) =>   SignUpScreen(),
    signInScreen: (context) =>   SignInScreen(),
    otpScreen: (context) => const OtpScreen(),
    serviceProviderHomePage: (context) => ServiceProviderHomePage(),
    successScreen: (context) => const RegSuccessful(),
    kycScreenOne: (context) => KycScreenOne(),
    kycScreenTwo: (context) => KycScreenTwo(),
    landingPage: (context) => LandingScreen(),
    serviceProviderLandingPage: (context) => ServiceProviderLandingPage(),
    productDetailScreen: (context) => ProductDetailScreen('', '','' ),
    serviceProviderKycOneScreen: (context) => KycServiceScreenOne(),

    cartScreen: (context) => CartScreen(),

    changeEmail: (context) => ChangeEmail(),
    changeNumber: (context) => ChangeNumber(),
    transactions: (context) => Transactions(),
    savedCards: (context) => SavedCards(),
    privacyPolicy: (context) => PrivacyPolicy(),
    faqs: (context) => FAQs(),
    changeEmailandNumber: (context) => ChangeEmailAndNumber(),
    paymentAndCard: (context) => PaymentAndCard(),
    changePassword: (context) => ChangePassword(),
    accountDeleted: (context) => AccountDeleted(),
    settingsScreen: (context) => SettingsScreen(),
    liveSupport: (context) => LiveSupport(),
    reportBug: (context) => ReportBug(),
    reportIssue: (context) => ReportIssue(),
    reportVendor: (context) => ReportVendor(),
    // productDetailScreen: (context) => ProductDetailScreen(),
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
      case productDetailScreen:
        return MaterialPageRoute(
          builder: (context) => ProductDetailScreen('', '', ''),
        );
      case serviceProviderHomePage:
        return MaterialPageRoute(
          builder: (context) => ServiceProviderHomePage(),
        );

      case serviceProviderLandingPage:
        return MaterialPageRoute(
          builder: (context) => ServiceProviderLandingPage(),
        );
      case cartScreen:
        return MaterialPageRoute(
          builder: (context) => CartScreen(),
        );
      case changeEmail:
        return MaterialPageRoute(
          builder: (context) => ChangeEmail(),
        );
      case changeNumber:
        return MaterialPageRoute(
          builder: (context) => ChangeNumber(),
        );
      case transactions:
        return MaterialPageRoute(
          builder: (context) => Transactions(),
        );
      case savedCards:
        return MaterialPageRoute(
          builder: (context) => SavedCards(),
        );
      case privacyPolicy:
        return MaterialPageRoute(
          builder: (context) => PrivacyPolicy(),
        );
      case faqs:
        return MaterialPageRoute(
          builder: (context) => FAQs(),
        );
      case changeEmailandNumber:
        return MaterialPageRoute(
          builder: (context) => ChangeEmailAndNumber(),
        );
      case paymentAndCard:
        return MaterialPageRoute(
          builder: (context) => PaymentAndCard(),
        );
      case changePassword:
        return MaterialPageRoute(
          builder: (context) => ChangePassword(),
        );
      case accountDeleted:
        return MaterialPageRoute(
          builder: (context) => AccountDeleted(),
        );
      case settingsScreen:
        return MaterialPageRoute(
          builder: (context) => SettingsScreen(),
        );
      case reportBug:
        return MaterialPageRoute(
          builder: (context) => ReportBug(),
        );
      case reportIssue:
        return MaterialPageRoute(
          builder: (context) => ReportIssue(),
        );
      case reportVendor:
        return MaterialPageRoute(
          builder: (context) => ReportVendor(),
        );

      case liveSupport:
        return MaterialPageRoute(
          builder: (context) => LiveSupport(),
        );

      case signUpScreen:
        return MaterialPageRoute(
          builder: (context) =>   SignUpScreen(),
        );
      case signInScreen:
        return MaterialPageRoute(
          builder: (context) =>   SignInScreen(),
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
          builder: (context) => KycScreenOne(),
        );
      case kycScreenTwo:
        return MaterialPageRoute(
          builder: (context) => KycScreenTwo(),
        );
      case landingPage:
        return MaterialPageRoute(
          builder: (context) => LandingScreen(),
        );
        case serviceProviderKycOneScreen:
        return MaterialPageRoute(
          builder: (context) => KycServiceScreenOne(),
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

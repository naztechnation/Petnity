import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:petnity/handlers/secure_handler.dart';

import '../../res/app_images.dart';
import '../res/app_routes.dart';
import '../utils/navigator/page_navigator.dart';
import 'res/app_colors.dart';
import 'res/app_constants.dart';
import 'res/app_strings.dart';
import 'ui/on_boarding/widgets/fading_sliding_in.dart';
import 'ui/widgets/custom_text.dart';
import 'ui/widgets/image_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  startTimeout() {
    return Timer(const Duration(seconds: 5), handleTimeout);
  }

  late AnimationController _animationController;

  void handleTimeout() {
    changeScreen();
  }

  String userType = '';
  String userLoggedIn = '';
  String isonBoarding = '';

  getUserDetails() async {
    userType = await StorageHandler.getUserType();
    userLoggedIn = await StorageHandler.getLoggedInState();
    isonBoarding = await StorageHandler.getOnBoardState();
  }

  Future<void> changeScreen() async {
    if (isonBoarding == '') {
      AppNavigator.pushAndReplaceName(context, name: AppRoutes.welcomeScreen);
    } else if (userLoggedIn == '') {
      AppNavigator.pushAndReplaceName(context, name: AppRoutes.signInScreen);
    } else if (userType != '') {
      if (userType == 'user') {
        AppNavigator.pushAndReplaceName(context, name: AppRoutes.landingPage);
      } else if (userType == 'service_provider') {
        AppNavigator.pushAndReplaceName(context,
            name: AppRoutes.serviceProviderLandingPage);
      }
    }

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  @override
  void initState() {
    getUserDetails();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1700),
    )..forward();
    super.initState();
    startTimeout();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightSecondary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: screenSize(context).height * 0.4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FadingSlidingWidget(
                animationController: _animationController,
                interval: const Interval(0.5, 0.9),
                child: ImageView.asset(AppImages.splashIcon,
                    color: AppColors.lightPrimary,
                    fit: BoxFit.fitWidth,
                    width: 50),
              ),
              const SizedBox(
                width: 6,
              ),
              const CustomText(
                text: AppStrings.appName,
                weight: FontWeight.w700,
                size: 22,
                fontFamily: AppStrings.montserrat,
                color: AppColors.lightPrimary,
              ),
            ],
          ),
          const SizedBox(height: 15),
          ScaleTransition(
            scale: _animationController.drive(
              Tween<double>(begin: 1.3, end: 1.0).chain(
                CurveTween(
                  curve: Interval(0.2, 0.4, curve: Curves.elasticInOut),
                ),
              ),
            ),
            child: const CustomText(
                text: '',
                weight: FontWeight.w700,
                size: 16,
                color: AppColors.lightPrimary,
                fontFamily: AppStrings.interSans),
          ),
          Spacer(),
          ScaleTransition(
              scale: _animationController.drive(
                Tween<double>(begin: 1.3, end: 1.0).chain(
                  CurveTween(
                    curve: Interval(0.2, 0.4, curve: Curves.elasticInOut),
                  ),
                ),
              ),
              child: const CustomText(
                  text: 'From mejortech',
                  weight: FontWeight.w700,
                  size: 14,
                  color: AppColors.lightPrimary,
                  fontFamily: AppStrings.montserrat)),
          const SizedBox(height: 38),
        ],
      ),
    );
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../res/app_images.dart';
import '../res/app_routes.dart';
import '../utils/navigator/page_navigator.dart';
import 'res/app_colors.dart';
import 'res/app_strings.dart';
import 'ui/widgets/custom_text.dart';
import 'ui/widgets/image_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTimeout() {
    return Timer(const Duration(seconds: 1), handleTimeout);
  }

  void handleTimeout() {
    changeScreen();
  }

  Future<void> changeScreen() async {
          AppNavigator.pushAndReplaceName(context, name: AppRoutes.welcomeScreen);


    //Show status bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  @override
  void initState() {
    super.initState();
  //  startTimeout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightSecondary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.4,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ImageView.asset(AppImages.splashIcon,
                  color: AppColors.lightPrimary,
                  fit: BoxFit.fitWidth,
                  width: 50),
                  const SizedBox(width: 6,),
                const CustomText(text: AppStrings.appName,
                weight: FontWeight.w700,size: 22,fontFamily: AppStrings.montserrat, color: AppColors.lightPrimary,),
                  
            ],
          ),
          const SizedBox(height: 15),
                const CustomText(text: 'For service providers',weight: FontWeight.w700,size: 16,
                 color: AppColors.lightPrimary,fontFamily: AppStrings.interSans),
          Spacer(),
                const CustomText(text: 'From mejortech',weight: FontWeight.w700,size: 14, color: AppColors.lightPrimary,fontFamily: AppStrings.montserrat),
          const SizedBox(height: 38),

        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

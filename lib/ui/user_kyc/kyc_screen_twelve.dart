

import 'package:flutter/material.dart';
import 'package:petnity/res/app_images.dart';

import '../../res/app_colors.dart';
import '../../res/app_constants.dart';
import '../../res/app_routes.dart';
import '../../res/app_strings.dart';
import '../../utils/navigator/page_navigator.dart';
import '../widgets/button_view.dart';
import '../widgets/custom_text.dart';
import '../widgets/image_view.dart';

class KycScreenTwelve extends StatelessWidget {
  final String selectedPet;

  KycScreenTwelve({super.key, this.selectedPet = ''});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: screenSize(context).height * 0.35,
            ),
            Padding(
              padding: const EdgeInsets.all(22.0),
              child: Material(
                elevation: 0.5,
                type: MaterialType.card,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22.0)),
                child: Container(
                  height: 160,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      ImageView.asset(
                        AppImages.celebIcon,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: CustomText(
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          text:
                              'Yaay, you have completed your dogs KYC\nsuccessfully now lets get started',
                          weight: FontWeight.w600,
                          size: 13,
                          fontFamily: AppStrings.interSans,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenSize(context).height * 0.2,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20),
              child: ButtonView(
                onPressed: () {
                  AppNavigator.pushAndStackNamed(context,
                      name: AppRoutes.landingPage);
                },
                color: AppColors.lightSecondary,
                child: CustomText(
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  text: 'Go to home',
                  weight: FontWeight.w700,
                  size: 18,
                  fontFamily: AppStrings.interSans,
                  color: Colors.white,
                ),
              ),
            ),
           
          ],
        ),
      ),
    );
  }
}


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

class RegSuccessful extends StatelessWidget {
  const RegSuccessful({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
             SizedBox(height: screenSize(context).height * 0.35,),

             Padding(
               padding: const EdgeInsets.all(22.0),
               child: Material(
                elevation: 1,
                type: MaterialType.card,
                shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22.0)),
                child: Container(
                  height: 160,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
               SizedBox(height: 20,),

                    ImageView.asset(AppImages.celebIcon,fit: BoxFit.cover,),
               SizedBox(height: 10,),
             
                      Center(
                        child: CustomText(
                                            textAlign: TextAlign.center,
                                            maxLines: 3,
                                            text: 'Your account has been successfully created,\nnow you are ready to get access to a slue \nof pets and pets services',
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
                SizedBox(height: screenSize(context).height * 0.2,),

                                 Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 0.0, horizontal: 20),
                                child: ButtonView(
                                  onPressed: () {
                                      AppNavigator.pushAndReplaceName(context,
                    name: AppRoutes.successScreen);
                                  },
                                  color: AppColors.lightSecondary,
                                  child:  CustomText(
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        text: 'Lets get to know your pet',
                                        weight: FontWeight.w400,
                                        size: 16,
                                        fontFamily: AppStrings.interSans,
                                        color: Colors.white,
                                      ),
                                ),),
                                const SizedBox(height: 12),
                                  CustomText(
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  text: 'Skip and go to home',
                                  weight: FontWeight.w400,
                                  size: 14,
                                  fontFamily: AppStrings.interSans,
                                  color: AppColors.lightSecondary,
                                ),
          ],
        ),
      ),
    );
  }
}
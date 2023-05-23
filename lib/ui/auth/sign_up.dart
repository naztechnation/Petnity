

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_images.dart';
import 'package:petnity/ui/widgets/image_view.dart';

import '../../res/app_routes.dart';
import '../../res/app_strings.dart';
import '../../utils/navigator/page_navigator.dart';
import '../widgets/button_view.dart';
import '../widgets/custom_text.dart';
import '../widgets/text_edit_view.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body: Container(
        height: screenSize(context).height,
        decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [AppColors.scaffoldColor, Colors.red.shade50],
                    begin: Alignment.topRight,
                    end: Alignment.topLeft)),
        child: Padding(
                        padding: const EdgeInsets.only(left:25.0, right: 25),
      
          child: ListView(
            shrinkWrap: true,
            children: [
                SizedBox(height: screenSize(context).height * 0.13,),
              CustomText(
                                textAlign: TextAlign.left,
                                maxLines: 2,
                                text: 'Create an account',
                                weight: FontWeight.w700,
                                size: 24,
                                fontFamily: AppStrings.interSans,
                                color: Colors.black,
                              ),
                             
                              SizedBox(height: 24,),
      
                              TextEditView(controller: TextEditingController(), 
                              isDense: true,
                              textViewTitle: 'Your  Email',
                              hintText: 'Enter email',
                              suffixIcon: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: ImageView.svg(AppImages.messageIcon,),
                              ),
                              fillColor: AppColors.lightPrimary,borderColor: AppColors.lightPrimary,),
                              SizedBox(height: 20,),
      
                              TextEditView(controller: TextEditingController(),
                              isDense: true,

                              textViewTitle: 'Your Number',
                              hintText: 'Enter Number',
                              suffixIcon: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: ImageView.svg(AppImages.personIcon,),
                              ),
                              fillColor: AppColors.lightPrimary,borderColor: AppColors.lightPrimary,),
                               SizedBox(height: 20,),
      
                              TextEditView(controller: TextEditingController(), 
                              isDense: true,

                              textViewTitle: 'Password',
                              hintText: 'Enter your password',
                              suffixIcon: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: ImageView.svg(AppImages.visibleIcon,),
                              ),
                              fillColor: AppColors.lightPrimary,borderColor: AppColors.lightPrimary,),
                               SizedBox(height: 35,),
                               ImageView.asset(AppImages.line),
                               SizedBox(height: 45,),
                               Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                ImageView.asset(AppImages.facebookIcon),
                               SizedBox(width: 15,),
      
                                ImageView.asset(AppImages.appleIcon),
                               SizedBox(width: 15,),
      
                                ImageView.asset(AppImages.goggleIcon),
                               ],),
                              SizedBox(height: 30,),
                              Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0.0, horizontal: 20),
                              child: ButtonView(
                                onPressed: () {
                                    AppNavigator.pushAndReplaceName(context,
                  name: AppRoutes.otpScreen);
                                },
                                color: AppColors.lightSecondary,
                                child:  CustomText(
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      text: 'Create account',
                                      weight: FontWeight.w400,
                                      size: 16,
                                      fontFamily: AppStrings.interSans,
                                      color: Colors.white,
                                    ),
                              ),
                            ),
                              SizedBox(height: 20,),
      
      Center(
        child:   RichText(
          text: TextSpan(
        children: [
          TextSpan(
            text: 'Have an account already?',
            style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
            recognizer: TapGestureRecognizer()..onTap = () {
              // Single tapped.
            },
          ),
          TextSpan(
            text: '  Sign In',
            style: TextStyle(color: AppColors.lightSecondary, fontSize: 16, fontWeight: FontWeight.w500),
            recognizer:  TapGestureRecognizer()..onTap = () {
              AppNavigator.pushAndReplaceName(context,
                  name: AppRoutes.signInScreen);
            }
          ),
          TextSpan(
            text: '  in here',
            style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
            recognizer: TapGestureRecognizer()..onTap = () {
              // Long Pressed.
            },
          ),
        ],
          ),
        ),
      )
      
      
      
      
            ],
          ),
        ),
      ),
    );
  }
}
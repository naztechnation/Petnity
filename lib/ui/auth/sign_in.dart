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

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: screenSize(context).height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [AppColors.scaffoldColor, Colors.red.shade50],
                begin: Alignment.topRight,
                end: Alignment.topLeft)),
        child: Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25),
          child: ListView(
            shrinkWrap: true,
            children: [
              SizedBox(
                height: screenSize(context).height * 0.13,
              ),
              CustomText(
                textAlign: TextAlign.left,
                maxLines: 2,
                text: 'Sign in',
                weight: FontWeight.w700,
                size: 24,
                fontFamily: AppStrings.interSans,
                color: Colors.black,
              ),
              SizedBox(
                height: 5,
              ),
              CustomText(
                textAlign: TextAlign.left,
                maxLines: 2,
                text: 'Hey welcome back',
                weight: FontWeight.w400,
                size: 16,
                fontFamily: AppStrings.interSans,
                color: Colors.black,
              ),
              SizedBox(
                height: 24,
              ),
              TextEditView(
                controller: TextEditingController(),
                isDense: true,
                textViewTitle: 'Your  Email',
                hintText: 'Enter email',
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ImageView.svg(
                    AppImages.messageIcon,
                  ),
                ),
                fillColor: AppColors.lightPrimary,
                borderColor: AppColors.lightPrimary,
              ),
              SizedBox(
                height: 20,
              ),
              TextEditView(
                controller: TextEditingController(),
                isDense: true,
                textViewTitle: 'Your Number',
                hintText: 'Enter Number',
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ImageView.svg(
                    AppImages.personIcon,
                  ),
                ),
                fillColor: AppColors.lightPrimary,
                borderColor: AppColors.lightPrimary,
              ),
              SizedBox(
                height: 20,
              ),
              TextEditView(
                controller: TextEditingController(),
                isDense: true,
                textViewTitle: 'Password',
                hintText: 'Enter your password',
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ImageView.svg(
                    AppImages.visibleIcon,
                  ),
                ),
                fillColor: AppColors.lightPrimary,
                borderColor: AppColors.lightPrimary,
              ),
              SizedBox(
                height: 35,
              ),
              ImageView.asset(AppImages.line),
              SizedBox(
                height: 45,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ImageView.asset(AppImages.facebookIcon),
                  SizedBox(
                    width: 15,
                  ),
                  ImageView.asset(AppImages.appleIcon),
                  SizedBox(
                    width: 15,
                  ),
                  ImageView.asset(AppImages.goggleIcon),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20),
                child: ButtonView(
                  onPressed: () {},
                  color: AppColors.lightSecondary,
                  child: CustomText(
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    text: 'Sign In',
                    weight: FontWeight.w400,
                    size: 16,
                    fontFamily: AppStrings.interSans,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Don\'t Have an account?',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Single tapped.
                          },
                      ),
                      TextSpan(
                          text: '  Create Account',
                          style: TextStyle(color: AppColors.lightSecondary),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              AppNavigator.pushAndReplaceName(context,
                                  name: AppRoutes.signUpScreen);
                            }),
                      TextSpan(
                        text: '  in here',
                        style: TextStyle(color: Colors.black),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
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

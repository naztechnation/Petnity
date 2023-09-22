import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:petnity/res/app_colors.dart';
import '../../res/app_constants.dart';
import '../../res/app_routes.dart';
import '../../res/app_strings.dart';
import '../../utils/navigator/page_navigator.dart';
import '../widgets/button_view.dart';
import '../widgets/custom_text.dart';
import '../widgets/pin_code_view.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _formKey = GlobalKey<FormState>();

  final _pinController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: screenSize(context).height * 0.35,
            ),
            CustomText(
              textAlign: TextAlign.center,
              maxLines: 2,
              text: 'Confirm the code sent to\nyour Email',
              weight: FontWeight.w700,
              size: 24,
              fontFamily: AppStrings.interSans,
              color: Colors.black,
            ),
            SizedBox(
              height: 63,
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: PinCodeView(
                  length: 6,
                  controller: _pinController,
                  onChanged: (_) {},
                  onCompleted: (_) {},
                  // validator: Validator.validate
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: InkWell(
                onTap: () {},
                child: Text.rich(
                    TextSpan(
                        text: 'Resend  ',
                        style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.lightSecondary,
                            fontWeight: FontWeight.w500,
                            fontFamily: AppStrings.interSans,
                            height: 2),
                        children: [
                          TextSpan(
                              text: 'in 30 seconds',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ))
                        ]),
                    textAlign: TextAlign.start),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20),
              child: ButtonView(
                onPressed: () {
                  AppNavigator.pushAndReplaceName(context,
                      name: AppRoutes.successScreen);
                },
                color: AppColors.lightSecondary,
                child: CustomText(
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  text: 'Confirm',
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
                      text: 'Have an account already?',
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
                        text: '  Sign In',
                        style: TextStyle(
                            color: AppColors.lightSecondary,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            AppNavigator.pushAndReplaceName(context,
                                name: AppRoutes.signInScreen);
                          }),
                    TextSpan(
                      text: '  in here',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
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
    );
  }
}

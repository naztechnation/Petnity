

import 'package:flutter/material.dart';

import '../../res/app_strings.dart';
import '../widgets/custom_text.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body: Center(child: CustomText(
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        text: 'This is SignUp Page',
                        weight: FontWeight.w900,
                        size: 22,
                        fontFamily: AppStrings.montserrat,
                        color: Colors.black,
                      ),),
    );
  }
}
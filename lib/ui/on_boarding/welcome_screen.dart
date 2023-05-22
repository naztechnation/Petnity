

import 'package:flutter/material.dart';

import '../widgets/custom_text.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body: Center(child: CustomText(text: 'OnBoarding Screen')),
    );
  }
}
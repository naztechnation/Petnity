

import 'dart:io';

import 'package:flutter/material.dart';

import '../../res/app_colors.dart';
import '../../res/app_constants.dart';
import '../../res/app_strings.dart';
import '../widgets/back_button.dart';
import '../widgets/custom_text.dart';

class PaymentDetailsScreen extends StatelessWidget {
  const PaymentDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        height: screenSize(context).height,
        width: screenSize(context).width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [AppColors.scaffoldColor, Colors.red.shade50],
                begin: Alignment.topRight,
                end: Alignment.topLeft)),
        child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SafeArea(child: SizedBox(height: (Platform.isAndroid) ? 44 : 0)),
            Row(
              children: [
                backButton(context),
                const SizedBox(
                  width: 40,
                ),
                CustomText(
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  text: 'Payment details',
                  weight: FontWeight.w700,
                  size: 22,
                  fontFamily: AppStrings.interSans,
                  color: Colors.black,
                ),
              ],
            ),
            SizedBox(
              height: 22,
            ),
          ]),
        ),
      ),
    );
  }
}
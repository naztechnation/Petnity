import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../res/app_colors.dart';
import '../../../../res/app_constants.dart';
import '../../../../res/app_strings.dart';
import '../../../widgets/back_button.dart';
import '../../../widgets/custom_text.dart';

class TrainingScreen extends StatelessWidget {
  const TrainingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: screenSize(context).height,
        width: screenSize(context).width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [AppColors.scaffoldColor, Colors.red.shade50],
                begin: Alignment.topRight,
                end: Alignment.topLeft)),
        child: Column(
          children: [
            SafeArea(
                child: Container(
                    color: AppColors.cardColor,
                    height: (Platform.isAndroid) ? 0 : 0)),
            Container(
              padding: const EdgeInsets.only(bottom: 0, top: 30),
              child: Row(
                children: [
                  backButton(context),
                  const SizedBox(
                    width: 40,
                  ),
                  CustomText(
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    text: 'Training packages',
                    weight: FontWeight.w700,
                    size: 20,
                    fontFamily: AppStrings.interSans,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: CustomText(
                      textAlign: TextAlign.left,
                      maxLines: 2,
                      text: 'Select package',
                      weight: FontWeight.w500,
                      size: 16,
                      fontFamily: AppStrings.interSans,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}

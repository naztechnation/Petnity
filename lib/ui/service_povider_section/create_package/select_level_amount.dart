import 'dart:io';

import 'package:flutter/material.dart';

import '../../../res/app_colors.dart';
import '../../../res/app_constants.dart';
import '../../../res/app_strings.dart';
import '../../widgets/back_button.dart';
import '../../widgets/button_view.dart';
import '../../widgets/custom_text.dart';
import 'widgets/selected_container.dart';

class SelectPackageLevelAmount extends StatelessWidget {
  final String serviceType;
  const SelectPackageLevelAmount({super.key, required this.serviceType});

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(child: SizedBox(height: (Platform.isAndroid) ? 30 : 0)),
            Row(
              children: [
                backButton(context),
                const SizedBox(
                  width: 40,
                ),
                CustomText(
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  text: '$serviceType  packages',
                  weight: FontWeight.w800,
                  size: 16,
                  fontFamily: AppStrings.interSans,
                  color: Colors.black,
                ),
              ],
            ),
             const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: CustomText(
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    text: 'select package level amount',
                    weight: FontWeight.w800,
                    size: 16,
                    fontFamily: AppStrings.interSans,
                    color: Colors.black,
                  ),
            ),
            const SizedBox(
              height: 60,
            ),
            SelectLevelContainer(),
            Spacer(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20),
              child: ButtonView(
                onPressed: () {},
                color: AppColors.lightSecondary,
                borderRadius: 22,
                borderColor: Colors.white,
                child: CustomText(
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  text: 'Select',
                  weight: FontWeight.w400,
                  size: 16,
                  fontFamily: AppStrings.interSans,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../res/app_colors.dart';
import '../../../../res/app_constants.dart';
import '../../../../res/app_strings.dart';
import '../../../widgets/back_button.dart';
import '../../../widgets/custom_text.dart';
import '../track_services/widget/profile.dart';

class TrackServices extends StatefulWidget {
  const TrackServices({super.key});

  @override
  State<TrackServices> createState() => _TrackServicesState();
}

class _TrackServicesState extends State<TrackServices> {
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
                    text: 'Track service',
                    weight: FontWeight.w700,
                    size: 20,
                    fontFamily: AppStrings.interSans,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
                    child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          textAlign: TextAlign.left,
                          maxLines: 2,
                          text: 'Service provider details',
                          weight: FontWeight.w700,
                          size: 12,
                          fontFamily: AppStrings.interSans,
                          color: Colors.black,
                        ),
                        Row(
                          children: [
                            CustomText(
                              textAlign: TextAlign.left,
                              maxLines: 2,
                              text: 'Service',
                              weight: FontWeight.w400,
                              size: 12,
                              fontFamily: AppStrings.interSans,
                              color: Colors.black,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            CustomText(
                              textAlign: TextAlign.left,
                              maxLines: 2,
                              text: 'Dog sales',
                              weight: FontWeight.w700,
                              size: 12,
                              fontFamily: AppStrings.interSans,
                              color: Colors.black,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  serviceProfile(context),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Container(
                      height: 60,
                      width: screenSize(context).width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30)),
                      child: Center(
                        child: CustomText(
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          text: 'Pet Profile',
                          weight: FontWeight.w700,
                          size: 12,
                          fontFamily: AppStrings.interSans,
                          color: AppColors.lightSecondary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ))),
          ],
        ),
      ),
    );
  }
}

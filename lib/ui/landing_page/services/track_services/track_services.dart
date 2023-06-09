
import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../res/app_colors.dart';
import '../../../../res/app_constants.dart';
import '../../../../res/app_strings.dart';
import '../../../widgets/back_button.dart';
import '../../../widgets/custom_text.dart';
import 'track_service_body.dart';

class TrackServicesScreen extends StatelessWidget {
  const TrackServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body: Container(
        height: screenSize(context).height,
            width: screenSize(context).width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [AppColors.scaffoldColor, Colors.red.shade50],
                    begin: Alignment.topRight,
                    end: Alignment.topLeft)),
        child: SingleChildScrollView(child: Column(children: [
            SafeArea(child: Container(
                  color: AppColors.cardColor ,
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
                const SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:15.0),
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
                  Row(children: [
                    CustomText(
                          textAlign: TextAlign.left,
                          maxLines: 2,
                          text: 'Service',
                          weight: FontWeight.w400,
                          size: 12,
                          fontFamily: AppStrings.interSans,
                          color: Colors.black,
                        ),
                        const SizedBox(width: 5,),
                        CustomText(
                          textAlign: TextAlign.left,
                          maxLines: 2,
                          text: 'Dog sitting',
                          weight: FontWeight.w700,
                          size: 12,
                          fontFamily: AppStrings.interSans,
                          color: Colors.black,
                        ),
                  ],)
                  ],),
                ),
                const SizedBox(height: 20,),
                TrackServicesBody()
      ],)),),
    );
  }
}
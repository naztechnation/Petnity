import 'dart:io';

import 'package:flutter/material.dart';

import '../../res/app_colors.dart';
import '../../res/app_constants.dart';
import '../../res/app_images.dart';
import '../../res/app_strings.dart';
import '../widgets/back_button.dart';
import '../widgets/button_view.dart';
import '../widgets/custom_text.dart';
import '../widgets/profile_image.dart';

class SessionDetailsScreen extends StatelessWidget {
  const SessionDetailsScreen({super.key});

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
          child: SingleChildScrollView(
        child: Column(
          children: [
            SafeArea(child: SizedBox(height: (Platform.isAndroid) ? 35 : 0)),
                  Align(
                    alignment: Alignment.topLeft,
                    child: backButton(context)),

            ProfileImage(
                    placeHolder: AppImages.person,
                    '',
                    height: 80,
                    width: 80,
                    radius: 50,
                    fit: BoxFit.cover,
                    borderColor: AppColors.cardColor,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
CustomText(
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        text: 'Audrey jhay',
                        weight: FontWeight.w700,
                        size: 14,
                        fontFamily: AppStrings.interSans,
                        color: Colors.black,
                      ),
                      const SizedBox(
                    height: 10,
                  ),
                      CustomText(
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        text: 'Pet date',
                        weight: FontWeight.w500,
                        size: 14,
                        fontFamily: AppStrings.interSans,
                        color: Colors.black,
                      ),
                       const SizedBox(
                    height: 10,
                  ),
                      Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Container(
                width: 120,
                height: 40,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(41),
                  color: Colors.green.shade50,
                ),
                child: Center(
                  child: Text(
                    'Accepted',
                    style: TextStyle(
                        color: Colors.green[900],
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  ),
                ),
              ),
            ),
                        SizedBox(height: screenSize(context).height * 0.15,),
                      Container(
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30)),
                        child: CustomText(
                        textAlign: TextAlign.justify,
                        maxLines: 4,
                        text: 'Audrey jhay has accepted your dog pet date session. Click on the button below to text and make a schedule for date',
                        weight: FontWeight.w500,
                        size: 14,
                        fontFamily: AppStrings.interSans,
                        color: Colors.black,
                      ),)
          ],
        ),
      )),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [AppColors.scaffoldColor, Colors.red.shade50],
                begin: Alignment.topRight,
                end: Alignment.topLeft)),
        height: 100,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
         
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: ButtonView(
              onPressed: () {
                // AppNavigator.pushAndStackPage(context, page: ChatPage());
              },
              expanded: true,
              borderRadius: 41,
              child: Text(
                'text message',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 18),
              ),
              color: AppColors.lightSecondary,
            ),
          ),
          SizedBox(
            height: 30,
          ),
        ]),
      ),
    );
  }
}

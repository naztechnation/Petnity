
 

import 'dart:io';

import 'package:flutter/material.dart';

import '../../res/app_colors.dart';
import '../../res/app_constants.dart';
import '../../res/app_strings.dart';
import '../../utils/navigator/page_navigator.dart';
import '../widgets/back_button.dart';
import '../widgets/button_view.dart';
import '../widgets/custom_text.dart';
import 'kyc_screen_nine.dart';
import 'kyc_screen_ten.dart';

class KycScreenEight extends StatelessWidget {
  final String selectedPet;

  KycScreenEight({super.key, this.selectedPet = ''});

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
        child: SingleChildScrollView(
        child: Column(
          children: [
             SafeArea(child: SizedBox(height: (Platform.isAndroid) ? 44 : 0)),
                    backButton(context),
            Padding(
                     padding:                   EdgeInsets.symmetric(vertical: 0.0, horizontal: 15),

              child: Column(children: [
            
                    SizedBox(
                      height: screenSize(context).height * 0.25,
                    ),
                    CustomText(
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      text: 'Your $selectedPet health',
                      weight: FontWeight.w700,
                      size: 28,
                      fontFamily: AppStrings.montserrat,
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: 28,
                    ),
                     CustomText(
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      text: 'Does your $selectedPet have health issues?',
                      weight: FontWeight.w500,
                      size: 16,
                      fontFamily: AppStrings.interSans,
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: 45,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Expanded(
                        child: Padding(
                        padding:
                            const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8),
                        child: ButtonView(
                          onPressed: () {
                           AppNavigator.pushAndStackPage(context,
                                page: KycScreenNine(
                                  selectedPet: selectedPet,
                                ));
                          },
                          color: Colors.redAccent.shade100,
                          borderRadius: 32,
                          
                          expanded: false,
                          borderColor: Colors.white,
                          child: CustomText(
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            text: 'Yes',
                            weight: FontWeight.w600,
                            size: 18,
                            fontFamily: AppStrings.interSans,
                            color: Colors.red,
                          ),
                        ),
                                    ),
                      ),
                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8),
                        child: ButtonView(
                          onPressed: () {
                             AppNavigator.pushAndStackPage(context,
                                page: KycScreenTen(
                                  selectedPet: selectedPet,
                                ));
                          },
                          color: Colors.greenAccent.shade100,
                          borderRadius: 32,
                          expanded: false,
            
                          borderColor: Colors.white,
                          child: CustomText(
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            text: 'No',
                            weight: FontWeight.w600,
                            size: 18,
                            fontFamily: AppStrings.interSans,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ),
                    ],)
              ],),
            ),
          ],
        ),
      ),),
    );
  }
}
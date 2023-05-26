



import 'dart:io';

import 'package:flutter/material.dart';

import '../../res/app_colors.dart';
import '../../res/app_constants.dart';
import '../../res/app_strings.dart';
import '../../utils/navigator/page_navigator.dart';
import '../widgets/back_button.dart';
import '../widgets/button_view.dart';
import '../widgets/custom_text.dart';
import '../widgets/text_edit_view.dart';
import 'kyc_screen_ten.dart';
import 'kyc_screen_twelve.dart';

class KycScreenEleven extends StatelessWidget {
  final String selectedPet;

  KycScreenEleven({super.key, this.selectedPet = ''});

  TextEditingController _illnessNameController = TextEditingController();
  TextEditingController _drugNameController = TextEditingController();
  TextEditingController _prescribeNameController = TextEditingController();

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
                    text: 'Your $selectedPet health',
                    weight: FontWeight.w700,
                    size: 22,
                    fontFamily: AppStrings.interSans,
                    color: Colors.black,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: TextEditView(
                        isDense: true,
                        controller: _illnessNameController,
                        filled: true,
                        fillColor: AppColors.lightPrimary,
                        borderRadius: 30,
                        textViewTitle: 'What\'s the name of the allergy',
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: TextEditView(
                        isDense: true,
                        controller: _drugNameController,
                        filled: true,
                        fillColor: AppColors.lightPrimary,
                        borderRadius: 30,
                        textViewTitle: 'Drug administered',
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: TextEditView(
                        isDense: true,
                        controller: _prescribeNameController,
                        filled: true,
                        fillColor: AppColors.lightPrimary,
                        borderRadius: 30,
                        textViewTitle: 'Drug prescription',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 150,),
              Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0.0, horizontal: 20),
                              child: ButtonView(
                                onPressed: () {
                                  AppNavigator.pushAndStackPage(context,
                                page: KycScreenTwelve(
                                  selectedPet: selectedPet,
                                ));
                                },
                                color: AppColors.lightSecondary,
                                borderRadius: 30,
                                borderColor: Colors.white,
                                child:  CustomText(
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      
                                      text: 'Confirm and register',
                                      weight: FontWeight.w600,
                                      size: 18,
                                      fontFamily: AppStrings.interSans,
                                      color: Colors.white,
                                    ),
                              ),
                            ),
            ],
          ),
        ),
      ),
    );
  }
}

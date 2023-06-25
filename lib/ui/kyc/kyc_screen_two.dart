

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:petnity/ui/widgets/image_view.dart';

import '../../res/app_colors.dart';
import '../../res/app_constants.dart';
import '../../res/app_images.dart';
import '../../res/app_strings.dart';
import '../../utils/navigator/page_navigator.dart';
import '../widgets/back_button.dart';
import '../widgets/button_view.dart';
import '../widgets/custom_text.dart';
import '../widgets/text_edit_view.dart';
import 'kyc_screen_three.dart';



class KycScreenTwo extends StatelessWidget {
  final String selectedPet;

    KycScreenTwo({super.key,  this.selectedPet = ''});

  final TextEditingController _petNameController = TextEditingController(); 

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.lightPrimary,
      body: SingleChildScrollView(
        child: Container(
          height: screenSize(context).height,
          width: screenSize(context).width,
          decoration: BoxDecoration(
             
                  ),
          child: Column(children: [
            SafeArea(child:   SizedBox(height: (Platform.isAndroid) ?44 : 0)),
            backButton(context),
            SizedBox(height: screenSize(context).height * 0.2,),
            ImageView.asset(AppImages.dogWalking),
            SizedBox(height: 55),

            CustomText(
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  text:'$selectedPet name',
                                  weight: FontWeight.w700,
                                  size: 32,
                                  fontFamily: AppStrings.interSans,
                                  color: Colors.black,
                                ),
            SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0),
              child: TextEditView(controller: _petNameController,),
            ),
            const Spacer(),
          if(_petNameController.text.isNotEmpty)   Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0.0, horizontal: 20),
                              child: ButtonView(
                                onPressed: () {
                                   AppNavigator.pushAndStackPage(context, page: KycScreenThree(selectedPet: selectedPet,));
                                },
                                color: AppColors.lightSecondary,
                                borderRadius: 22,
                                borderColor: Colors.white,
                                child:  CustomText(
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      
                                      text: 'Next',
                                      weight: FontWeight.w700,
                                      size: 20,
                                      fontFamily: AppStrings.interSans,
                                      color: Colors.white,
                                    ),
                              ),
                            ),
                             SizedBox(
                  height: 50,
                ),
          ]),
        ),
      ),
    );
  }
}
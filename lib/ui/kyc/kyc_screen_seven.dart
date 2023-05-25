


import 'package:flutter/material.dart';

import '../../res/app_colors.dart';
import '../../res/app_constants.dart';
import '../../res/app_images.dart';
import '../../res/app_strings.dart';
import '../widgets/back_button.dart';
import '../widgets/custom_text.dart';
import '../widgets/image_view.dart';

class KycScreenSeven extends StatelessWidget {
  
   final String selectedPet;

  KycScreenSeven({super.key, this.selectedPet = ''});
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
        child: SingleChildScrollView(child: Column(children: [

           SafeArea(
                child: const SizedBox(
              height: 44,
            )),
            backButton(context),
            SizedBox(
              height: screenSize(context).height * 0.13,
            ),
            CustomText(
              textAlign: TextAlign.center,
              maxLines: 2,
              text: 'Upload your $selectedPet \npicture ',
              weight: FontWeight.w700,
              size: 28,
              fontFamily: AppStrings.montserrat,
              color: Colors.black,
            ),
             SizedBox(
              height: 20,
            ),
            ImageView.asset(AppImages.appleIcon)
      ],),),),
    );
  }
}
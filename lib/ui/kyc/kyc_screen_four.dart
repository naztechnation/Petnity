import 'package:flutter/material.dart';
import 'package:petnity/ui/kyc/widgets/pet_type_container.dart';
import 'package:petnity/ui/widgets/image_view.dart';

import '../../res/app_colors.dart';
import '../../res/app_constants.dart';
import '../../res/app_strings.dart';
import '../../utils/navigator/page_navigator.dart';
import '../widgets/back_button.dart';
import '../widgets/custom_text.dart';
import '../widgets/filter_search_section.dart';
import 'kyc_screen_five.dart';
import 'kyc_screen_two.dart';
import 'widgets/pet_type_body.dart';

class KycScreenFour extends StatelessWidget {
  final String selectedPet;
  KycScreenFour({super.key, required this.selectedPet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Container(
          height: screenSize(context).height,
          width: screenSize(context).width,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [AppColors.scaffoldColor, Colors.red.shade50],
                  begin: Alignment.topRight,
                  end: Alignment.topLeft)),
          child: ListView(
            shrinkWrap: true,
            children: [
              SafeArea(
                  child: const SizedBox(
                height: 30,
              )),
              backButton(context),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      textAlign: TextAlign.left,
                      maxLines: 2,
                      text: '$selectedPet breed',
                      weight: FontWeight.w700,
                      size: 24,
                      fontFamily: AppStrings.montserrat,
                      color: Colors.black,
                    ),
                    SizedBox(height: 27),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: CustomText(
                        textAlign: TextAlign.left,
                        maxLines: 1,
                        text: 'Select your $selectedPet breed',
                        weight: FontWeight.w500,
                        size: 16,
                        fontFamily: AppStrings.interSans,
                        color: Colors.black,
                      ),
                    ),
                    FilterSearchView(hintText: 'Select breed', showFilter: false,),
                   
                    SizedBox(height: 20),
                    PetTypeBody(onPressed: (petType){
                {
                AppNavigator.pushAndStackPage(context,
                    page: KycScreenFive(
                      selectedPet: petType
                    ));
              }
               }),
                  ],
                ),
              ),
            ],
          ),
        ),
     
    );
  }
}

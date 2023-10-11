import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/view_models/account_view_model.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_constants.dart';
import '../../../res/app_strings.dart';
import '../../../utils/navigator/page_navigator.dart';
import '../../widgets/back_button.dart';
import '../../widgets/button_view.dart';
import '../../widgets/custom_text.dart';
import 'kyc_screen_eleven.dart';
import 'kyc_screen_twelve.dart';

class KycScreenTen extends StatelessWidget {
  final String selectedPet;

  KycScreenTen({super.key, this.selectedPet = ''});

  @override
  Widget build(BuildContext context) {

    final petProfile = Provider.of<AccountViewModel>(context, listen: false);

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
              backButton(context),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 15),
                child: Column(
                  children: [
                    SizedBox(
                      height: screenSize(context).height * 0.25,
                    ),
                    CustomText(
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      text: 'Allergies',
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
                      text: 'Does your ${petProfile.petType} have any allergies?',
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
                            padding: const EdgeInsets.symmetric(
                                vertical: 0.0, horizontal: 8),
                            child: ButtonView(
                              onPressed: () {
                                AppNavigator.pushAndStackPage(context,
                                    page: KycScreenEleven(
                                    ));
                              },
                              color: Colors.red.shade100,
                              borderRadius: 32,
                              expanded: false,
                              borderColor: Colors.white,
                              child: CustomText(
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                text: 'Yes',
                                weight: FontWeight.w700,
                                size: 20,
                                fontFamily: AppStrings.interSans,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 0.0, horizontal: 8),
                            child: ButtonView(
                              onPressed: () {
                                AppNavigator.pushAndStackPage(context,
                                    page: KycScreenTwelve(
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
                                weight: FontWeight.w700,
                                size: 20,
                                fontFamily: AppStrings.interSans,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

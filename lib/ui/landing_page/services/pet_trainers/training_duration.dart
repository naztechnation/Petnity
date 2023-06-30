import 'dart:io';

import 'package:flutter/material.dart';
import 'package:petnity/ui/landing_page/services/pet_trainers/date_selection.dart';
import 'package:petnity/utils/navigator/page_navigator.dart';

import '../../../../res/app_colors.dart';
import '../../../../res/app_constants.dart';
import '../../../../res/app_strings.dart';
import '../../../widgets/back_button.dart';
import '../../../widgets/button_view.dart';
import '../../../widgets/custom_text.dart';

class TrainingDuraion extends StatelessWidget {
  const TrainingDuraion({super.key});

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
                      text: 'Training duration',
                      weight: FontWeight.w700,
                      size: 20,
                      fontFamily: AppStrings.interSans,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: screenSize(context).height,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 3,
                    itemBuilder: (_, __) {
                      return Container(
                        margin: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 25),
                        padding: const EdgeInsets.symmetric(
                            vertical: 25, horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              text: '1 Month',
                              weight: FontWeight.w700,
                              size: 16,
                              fontFamily: AppStrings.interSans,
                              color: Colors.black,
                            ),
                            CustomText(
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              text: '\$450',
                              weight: FontWeight.w700,
                              size: 16,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(bottom: 50, left: 20, right: 20),
        child: ButtonView(
          borderRadius: 30,
          onPressed: () {
            AppNavigator.pushAndStackPage(context, page: DateSelection());
          },
          child: CustomText(
            textAlign: TextAlign.center,
            maxLines: 2,
            text: 'Next',
            weight: FontWeight.w700,
            size: 16,
            fontFamily: AppStrings.interSans,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

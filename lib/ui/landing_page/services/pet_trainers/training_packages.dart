import 'dart:io';

import 'package:flutter/material.dart';
import 'package:petnity/ui/landing_page/services/pet_trainers/training_duration.dart';
import 'package:petnity/utils/navigator/page_navigator.dart';

import '../../../../model/dummy_models/trainers_data.dart';
import '../../../../res/app_colors.dart';
import '../../../../res/app_constants.dart';
import '../../../../res/app_strings.dart';
import '../../../widgets/back_button.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/image_view.dart';

class TrainingScreen extends StatelessWidget {
  const TrainingScreen({super.key});

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
                  text: 'Training packages',
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: CustomText(
                        textAlign: TextAlign.left,
                        maxLines: 2,
                        text: 'Select package',
                        weight: FontWeight.w500,
                        size: 16,
                        fontFamily: AppStrings.interSans,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: screenSize(context).height,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: trainersData.length,
                          itemBuilder: (__, index) {
                            return GestureDetector(
                              onTap: () {
                                AppNavigator.pushAndStackPage(context,
                                    page: TrainingDuraion());
                              },
                              child: Container(
                                  margin: const EdgeInsets.only(bottom: 20),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 20),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: ListTile(
                                    leading: ImageView.asset(
                                        trainersData[index].image),
                                    title: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: CustomText(
                                        textAlign: TextAlign.left,
                                        maxLines: 3,
                                        text: trainersData[index].title,
                                        weight: FontWeight.w700,
                                        size: 14,
                                        fontFamily: AppStrings.interSans,
                                        color: Colors.black,
                                      ),
                                    ),
                                    subtitle: CustomText(
                                      textAlign: TextAlign.left,
                                      maxLines: 2,
                                      text: trainersData[index].subtitles,
                                      weight: FontWeight.w500,
                                      size: 16,
                                      fontFamily: AppStrings.interSans,
                                      color: Colors.black,
                                    ),
                                  )),
                            );
                          }),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

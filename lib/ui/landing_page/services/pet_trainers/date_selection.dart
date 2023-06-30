import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../res/app_colors.dart';
import '../../../../res/app_constants.dart';
import '../../../../res/app_images.dart';
import '../../../../res/app_strings.dart';
import '../../../widgets/back_button.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/image_view.dart';
import '../widgets/contact_bottom.dart';

class DateSelection extends StatelessWidget {
  const DateSelection({super.key});

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
                    text: 'Date selection',
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
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    ImageView.svg(
                                      AppImages.calender,
                                      height: 18,
                                    ),
                                    SizedBox(width: 5),
                                    CustomText(
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      text: 'Date Start',
                                      weight: FontWeight.w700,
                                      size: 16,
                                      fontFamily: AppStrings.interSans,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: screenSize(context).width - 40,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 15),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomText(
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        text: 'Select date',
                                        weight: FontWeight.w700,
                                        size: 16,
                                        fontFamily: AppStrings.interSans,
                                        color: Colors.black,
                                      ),
                                      ImageView.svg(AppImages.arrowDown)
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    ImageView.svg(
                                      AppImages.calender,
                                      height: 18,
                                    ),
                                    SizedBox(width: 5),
                                    CustomText(
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      text: 'Stop Date',
                                      weight: FontWeight.w700,
                                      size: 16,
                                      fontFamily: AppStrings.interSans,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: screenSize(context).width - 40,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 15),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomText(
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        text: 'Select date',
                                        weight: FontWeight.w700,
                                        size: 16,
                                        fontFamily: AppStrings.interSans,
                                        color: Colors.black,
                                      ),
                                      ImageView.svg(AppImages.arrowDown)
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ContactBottom(
        buttonText: 'Finish up and review',
      ),
    );
  }
}

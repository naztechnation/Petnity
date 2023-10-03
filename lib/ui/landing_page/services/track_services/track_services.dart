import 'dart:io';

import 'package:flutter/material.dart';
import 'package:petnity/ui/widgets/button_view.dart';
import 'package:provider/provider.dart';

import '../../../../model/view_models/account_view_model.dart';
import '../../../../res/app_colors.dart';
import '../../../../res/app_constants.dart';
import '../../../../res/app_strings.dart';
import '../../../../res/enum.dart';
import '../../../../utils/navigator/page_navigator.dart';
import '../../../widgets/back_button.dart';
import '../../../widgets/custom_text.dart';
import '../pet_trainers/date_selection.dart';
import 'track_service_body.dart';

class TrackServicesScreen extends StatelessWidget {
  const TrackServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
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
                        text: Provider.of<AccountViewModel>(context, listen: false)
                                    .selectedService ==
                                Services.trainer
                            ? 'Service request'
                            : 'Track service',
                        weight: FontWeight.w700,
                        size: 20,
                        fontFamily: AppStrings.interSans,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                      child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              textAlign: TextAlign.left,
                              maxLines: 2,
                              text: 'Service provider details',
                              weight: FontWeight.w700,
                              size: 12,
                              fontFamily: AppStrings.interSans,
                              color: Colors.black,
                            ),
                            Row(
                              children: [
                                CustomText(
                                  textAlign: TextAlign.left,
                                  maxLines: 2,
                                  text: 'Service',
                                  weight: FontWeight.w400,
                                  size: 12,
                                  fontFamily: AppStrings.interSans,
                                  color: Colors.black,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                CustomText(
                                  textAlign: TextAlign.left,
                                  maxLines: 2,
                                  text: 'Dog sitting',
                                  weight: FontWeight.w700,
                                  size: 12,
                                  fontFamily: AppStrings.interSans,
                                  color: Colors.black,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TrackServicesBody()
                    ],
                  )),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Container(
              margin: const EdgeInsets.only(bottom: 50, left: 20, right: 20),
              child: ButtonView(
                borderRadius: 30,
                onPressed: () {
                  AppNavigator.pushAndStackPage(context, page: DateSelection());
                },
                child: CustomText(
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  text: 'Release payment',
                  weight: FontWeight.w700,
                  size: 16,
                  fontFamily: AppStrings.interSans,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

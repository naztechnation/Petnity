import 'dart:io';

import 'package:flutter/material.dart';
import 'package:petnity/ui/widgets/button_view.dart';

import '../../../../res/app_colors.dart';
import '../../../../res/app_constants.dart';
import '../../../../res/app_strings.dart';
import '../../../widgets/back_button.dart';
import '../../../widgets/custom_text.dart';
import '../track_services/widget/profile.dart';

class PurchaseRequests extends StatelessWidget {
  const PurchaseRequests({super.key});

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
            crossAxisAlignment: CrossAxisAlignment.start,
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
                      text: 'Puchase request',
                      weight: FontWeight.w700,
                      size: 20,
                      fontFamily: AppStrings.interSans,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      CustomText(
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        text: 'Pet seller details',
                        weight: FontWeight.w600,
                        size: 12,
                        fontFamily: AppStrings.interSans,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      serviceProfile(context, hideImage: true),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          CustomText(
                            textAlign: TextAlign.start,
                            maxLines: 2,
                            text: 'Pet name',
                            weight: FontWeight.w600,
                            size: 12,
                            fontFamily: AppStrings.interSans,
                            color: Colors.black,
                          ),
                          CustomText(
                            textAlign: TextAlign.start,
                            maxLines: 2,
                            text: ' - Thanos',
                            weight: FontWeight.w700,
                            size: 14,
                            color: Colors.black,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ButtonView(
                        color: Colors.white,
                        onPressed: () {},
                        borderRadius: 30,
                        borderColor: Colors.white,
                        child: CustomText(
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          text: 'View pet profile',
                          weight: FontWeight.w700,
                          size: 13,
                          color: AppColors.lightSecondary,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      ButtonView(
                        color: Colors.blue.shade50,
                        onPressed: () {},
                        borderRadius: 30,
                        borderColor: Colors.white,
                        child: CustomText(
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          text: 'View seller profile',
                          weight: FontWeight.w700,
                          size: 13,
                          color: AppColors.lightSecondary,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

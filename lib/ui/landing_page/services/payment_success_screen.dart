import 'dart:io';

import 'package:flutter/material.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/res/app_images.dart';
import 'package:petnity/ui/landing_page/landing_screen.dart';
import 'package:petnity/ui/landing_page/services/track_services/track_services.dart';
import 'package:petnity/ui/widgets/image_view.dart';
import 'package:provider/provider.dart';

import '../../../model/view_models/account_view_model.dart';
import '../../../res/app_constants.dart';
import '../../../res/app_strings.dart';
import '../../../utils/app_utils.dart';
import '../../../utils/navigator/page_navigator.dart';

import '../../widgets/button_view.dart';
import '../../widgets/custom_text.dart';

class PaymentSuccessScreen extends StatelessWidget {
  final String txId;
  const PaymentSuccessScreen({super.key, required this.txId});

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
              SafeArea(child: SizedBox(height: (Platform.isAndroid) ? 30 : 0)),
              SizedBox(
                height: screenSize(context).height * 0.07,
              ),
              ImageView.asset(
                AppImages.check,
                width: 70,
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Container(
                      width: screenSize(context).width,
                      padding: const EdgeInsets.all(25.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: AppColors.lightPrimary),
                      child: Column(children: [
                        CustomText(
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          text: 'Successful',
                          weight: FontWeight.w700,
                          size: 18,
                          fontFamily: AppStrings.montserrat,
                          color: Colors.black,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        CustomText(
                          textAlign: TextAlign.justify,
                          maxLines: 3,
                          text:
                              'your  transaction for payment off ₦${AppUtils.convertPrice(Provider.of<AccountViewModel>(context, listen: false).servicePrice)} successful. click on button below to track session',
                          weight: FontWeight.w500,
                          size: 16,
                          color: Colors.black,
                        ),
                      ]),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      height: 60,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30)),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              text: 'Purchase ID',
                              weight: FontWeight.w500,
                              size: 16,
                              fontFamily: AppStrings.interSans,
                              color: Colors.black,
                            ),
                            CustomText(
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              text: txId.toString(),
                              weight: FontWeight.w600,
                              size: 14,
                              color: Colors.black,
                            ),
                          ]),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.info,
                          color: Color(0xFFFFE3E3),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        CustomText(
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          text: 'NOTE',
                          weight: FontWeight.w600,
                          size: 14,
                          color: Colors.black,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomText(
                      textAlign: TextAlign.left,
                      maxLines: 2,
                      text:
                          'If session is rejected, funds would be refunded back to your card.',
                      weight: FontWeight.w500,
                      size: 14,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      height: 45,
                    ),
                    ButtonView(
                      color: AppColors.lightSecondary,
                      borderColor: Colors.white,
                      borderRadius: 40,
                      onPressed: () {
                        AppNavigator.pushAndStackPage(context,
                            page: TrackServicesScreen());
                      },
                      child: CustomText(
                        textAlign: TextAlign.left,
                        maxLines: 2,
                        text: 'Track',
                        weight: FontWeight.w600,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 40,),
                    GestureDetector(
                      onTap: (() {
                        AppNavigator.pushAndReplacePage(context,
                            page: LandingScreen());
                      }),
                      child: CustomText(
                          textAlign: TextAlign.left,
                          maxLines: 2,
                          text: 'Home',
                          weight: FontWeight.w600,
                          size: 16,
                          color: AppColors.lightSecondary,
                        ),
                    ),
                    const SizedBox(height: 120,),

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

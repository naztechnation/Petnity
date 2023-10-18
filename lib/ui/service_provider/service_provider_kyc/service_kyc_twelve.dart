import 'dart:io';

import 'package:flutter/material.dart';
import 'package:petnity/res/app_images.dart';
import 'package:provider/provider.dart';

import '../../../model/view_models/account_view_model.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_constants.dart';
import '../../../res/app_routes.dart';
import '../../../res/app_strings.dart';
import '../../../utils/navigator/page_navigator.dart';
import '../../widgets/button_view.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/image_view.dart';

class KycServiceScreenTwelve extends StatelessWidget {
  const KycServiceScreenTwelve({super.key});

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<AccountViewModel>(context, listen: true);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
              SafeArea(child: SizedBox(height: (Platform.isAndroid) ? 30 : 0)),

             Row(
                children: [
                  const SizedBox(
                    width: 40,
                  ),
                  CustomText(
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    text: 'KYC  Registration',
                    weight: FontWeight.w800,
                    size: 16,
                    fontFamily: AppStrings.interSans,
                    color: Colors.black,
                  ),
                ],
              ),
            SizedBox(
              height: screenSize(context).height * 0.35,
            ),
            
            Padding(
              padding: const EdgeInsets.all(22.0),
              child: Material(
                elevation: 1,
                type: MaterialType.card,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22.0)),
                child: Container(
                  height: 160,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      ImageView.asset(
                        AppImages.celebIcon,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: CustomText(
                            textAlign: TextAlign.justify,
                            maxLines: 3,
                            text:
                          'Your Id upload is successful and is being reviewed, reviews normally take between 2-4 working days.',
                            weight: FontWeight.w500,
                            size: 15,
                            
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenSize(context).height * 0.1,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20),
              child: ButtonView(
                onPressed: () {
                  AppNavigator.pushAndReplaceName (context,
                      name: AppRoutes.serviceProviderLandingPage);
                 
                },
                color: AppColors.lightSecondary,
                child: CustomText(
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  text:  'Go to Home',
                  weight: FontWeight.w400,
                  size: 16,
                  fontFamily: AppStrings.interSans,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 12),
        
          ],
        ),
      ),
    );
  }
}





import 'package:flutter/material.dart';
import 'package:petnity/ui/user/landing_screen.dart'; 

import '../../../res/app_colors.dart';
import '../../../res/app_constants.dart';
import '../../../res/app_routes.dart';
import '../../../res/app_strings.dart';
import '../../../utils/navigator/page_navigator.dart';
import '../../widgets/button_view.dart';
import '../../widgets/custom_text.dart';

class ShopUploadSuccessful extends StatelessWidget {
  const ShopUploadSuccessful({super.key});

  @override
  Widget build(BuildContext context) {
 

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                      Center(
                        child: CustomText(
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          text:
                         'Successful',
                          weight: FontWeight.w800,
                          size: 16,
                          fontFamily: AppStrings.interSans,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: CustomText(
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          text:
                         'Product uploaded successfully',
                          weight: FontWeight.w600,
                          size: 13,
                          fontFamily: AppStrings.interSans,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenSize(context).height * 0.2,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20),
              child: ButtonView(
                onPressed: () {
                 AppNavigator.pushAndReplaceName(context,
            name: AppRoutes.serviceProviderLandingPage);
                 
                },
                color: AppColors.lightSecondary,
                child: CustomText(
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  text:  'Done',
                  weight: FontWeight.w400,
                  size: 16,
                  fontFamily: AppStrings.interSans,
                  color: Colors.white,
                ),
              ),
            ),
           
          ],
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:petnity/ui/widgets/image_view.dart';
import 'package:provider/provider.dart';

import '../../../model/view_models/account_view_model.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_constants.dart';
import '../../../res/app_images.dart';
import '../../../res/app_strings.dart';
import '../../../utils/navigator/page_navigator.dart';
import '../../widgets/back_button.dart';
import '../../widgets/button_view.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/text_edit_view.dart';
import 'kyc_screen_three.dart';

class KycScreenTwo extends StatelessWidget {

  KycScreenTwo({super.key,});

  final TextEditingController _petNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final petProfile = Provider.of<AccountViewModel>(context, listen: false);

    return Scaffold(
      backgroundColor: AppColors.lightPrimary,
      body: SingleChildScrollView(
        child: Container(
          height: screenSize(context).height,
          width: screenSize(context).width,
          decoration: BoxDecoration(),
          child: Column(children: [
            SafeArea(child: SizedBox(height: (Platform.isAndroid) ? 44 : 0)),
             Row(
                children: [
                  backButton(context),
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
              height: screenSize(context).height * 0.2,
            ),
            ImageView.asset(AppImages.dogWalking),
            SizedBox(height: 55),
            CustomText(
              textAlign: TextAlign.center,
              maxLines: 1,
              text: '${petProfile.petType } name',
              weight: FontWeight.w700,
              size: 32,
              fontFamily: AppStrings.interSans,
              color: Colors.black,
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0),
              child: TextEditView(
                controller: _petNameController,
                isDense: true,
              ),
            ),
            const Spacer(),
            if (_petNameController.text.isNotEmpty)
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20),
                child: ButtonView(
                  onPressed: () {
                    petProfile.setPetName(_petNameController.text);

                    AppNavigator.pushAndStackPage(context,
                        page: KycScreenThree(
                           
                        ));
                  },
                  color: AppColors.lightSecondary,
                  borderRadius: 22,
                  borderColor: Colors.white,
                  child: CustomText(
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    text: 'Next',
                    weight: FontWeight.w700,
                    size: 16,
                    fontFamily: AppStrings.interSans,
                    color: Colors.white,
                  ),
                ),
              ),
            SizedBox(
              height: 50,
            ),
          ]),
        ),
      ),
    );
  }
}

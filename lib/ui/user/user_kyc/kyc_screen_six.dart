import 'dart:io';

import 'package:flutter/material.dart';
import 'package:petnity/ui/widgets/text_edit_view.dart';
import 'package:provider/provider.dart';

import '../../../model/view_models/account_view_model.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_constants.dart';
import '../../../res/app_strings.dart';
import '../../../utils/navigator/page_navigator.dart';
import '../../widgets/back_button.dart';
import '../../widgets/button_view.dart';
import '../../widgets/custom_text.dart';
import 'kyc_screen_seven.dart';

class KycScreenSix extends StatelessWidget {
  final String selectedPet;

  KycScreenSix({super.key, this.selectedPet = ''});

  final TextEditingController commentController = TextEditingController();

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
            SizedBox(
              height: screenSize(context).height * 0.13,
            ),
            CustomText(
              textAlign: TextAlign.center,
              maxLines: 2,
              text: 'Tell us about \nyour ${petProfile.petType}',
              weight: FontWeight.w700,
              size: 28,
              fontFamily: AppStrings.montserrat,
              color: Colors.black,
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0),
              child: TextEditView(
                controller: commentController,
                fillColor: AppColors.cardColor,
                maxLines: 10,
                borderRadius: 22,
                textInputAction: TextInputAction.done,
                maxLength: 2000,
              ),
            ),
            SizedBox(
              height: screenSize(context).height * 0.10,
            ),
            if (commentController.text != '')
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20),
                child: ButtonView(
                  onPressed: () {
                    petProfile.setAboutPet(commentController.text);
                    AppNavigator.pushAndStackPage(context,
                        page: KycScreenSeven(
                          selectedPet: selectedPet,
                        ));
                  },
                  color: AppColors.lightSecondary,
                  borderRadius: 32,
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
          ],
        )),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:petnity/ui/user/user_kyc/kyc_screen_six.dart';
import 'package:provider/provider.dart';

import '../../../model/view_models/account_view_model.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_constants.dart';
import '../../../res/app_images.dart';
import '../../../res/app_strings.dart';
import '../../../utils/navigator/page_navigator.dart';
import '../../widgets/back_button.dart';
import '../../widgets/button_view.dart';
import '../../widgets/custom_multi_toogle.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/image_view.dart';

class KycScreenFive extends StatefulWidget {
  final String selectedPet;

  KycScreenFive({super.key, this.selectedPet = ''});

  @override
  State<KycScreenFive> createState() => _KycScreenFiveState();
}

class _KycScreenFiveState extends State<KycScreenFive> {

  List<String> dogSizes = ['0-7', '8-18', '19-45', '45-100'];

  String selectedItem = '';

  @override
  Widget build(BuildContext context) {

    final petProfile = Provider.of<AccountViewModel>(context, listen: false);

    return Scaffold(
      backgroundColor: AppColors.lightPrimary,
      body: SingleChildScrollView(
        child: Container(
          height: screenSize(context).height,
          width: screenSize(context).width,
          
          child: Column(children: [
            SafeArea(
                child: const SizedBox(
              height: 44,
            )),
            backButton(context),
            SizedBox(
              height: screenSize(context).height * 0.13,
            ),
            ImageView.asset(AppImages.dogWalking),
            SizedBox(height: 55),
            CustomText(
              textAlign: TextAlign.center,
              maxLines: 1,
              text: '${widget.selectedPet} size',
              weight: FontWeight.w700,
              size: 32,
              fontFamily: AppStrings.interSans,
              color: Colors.black,
            ),
            SizedBox(height: 30),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 22.0),
                child: CustomText(
                  textAlign: TextAlign.left,
                  maxLines: 1,
                  text: 'Select your ${petProfile.petType} size',
                  weight: FontWeight.w500,
                  size: 16,
                  fontFamily: AppStrings.interSans,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 30),
            CustomMultiToggle(
              title: dogSizes,
              color: AppColors.lightPrimary,
              selectedTextColor: AppColors.lightPrimary,
              height: 45,
              contentMargin: const EdgeInsets.all(5),
              onSelected: (index) {

               setState(() {
                  selectedItem = dogSizes[index];
                  petProfile.setPetSize(selectedItem);
               });
               
              },
            ),
            const Spacer(),
            if (selectedItem != '')
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20),
                child: ButtonView(
                  onPressed: () {
                    petProfile.setPetSize(selectedItem);
                    AppNavigator.pushAndStackPage(context,
                        page: KycScreenSix(
                          selectedPet: widget.selectedPet,
                        ));
                  },
                  color: AppColors.lightSecondary,
                  borderRadius: 32,
                  borderColor: AppColors.lightSecondary,
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

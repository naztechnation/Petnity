import 'dart:io';

import 'package:flutter/material.dart';
import 'package:petnity/res/enum.dart';
import 'package:provider/provider.dart';

import '../../../model/view_models/service_provider_view_model.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_constants.dart';
import '../../../res/app_strings.dart';
import '../../../utils/navigator/page_navigator.dart';
import '../../user/user_kyc/widgets/choice_card.dart';
import '../../widgets/back_button.dart';
import '../../widgets/button_view.dart';
import '../../widgets/custom_text.dart';
import 'service_kyc_four.dart';

class KycServiceScreenThree extends StatefulWidget {
  KycServiceScreenThree({
    super.key,
  });

  @override
  State<KycServiceScreenThree> createState() => _KycServiceScreenThreeState();
}

class _KycServiceScreenThreeState extends State<KycServiceScreenThree> {
  PetGenderType _petGenderType = PetGenderType.none;

  @override
  Widget build(BuildContext context) {
    final serviceProvider =
        Provider.of<ServiceProviderViewModel>(context, listen: false);

    return Scaffold(
      backgroundColor: AppColors.lightPrimary,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: Container(
            height: screenSize(context).height,
            width: screenSize(context).width,
            decoration: BoxDecoration(),
            child: Column(children: [
              SafeArea(child: SizedBox(height: (Platform.isAndroid) ? 30 : 0)),
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
              SizedBox(height: 55),
              CustomText(
                textAlign: TextAlign.center,
                maxLines: 1,
                text: 'Your gender',
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
                    text: 'Select gender',
                    weight: FontWeight.w500,
                    size: 16,
                    fontFamily: AppStrings.interSans,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ChoiceCard(_petGenderType == PetGenderType.male, 'Male', () {
                    setState(() {
                      _petGenderType = PetGenderType.male;
                    });
                  }),
                  ChoiceCard(_petGenderType == PetGenderType.female, 'Female',
                      () {
                    setState(() {
                      _petGenderType = PetGenderType.female;
                    });
                  })
                ],
              ),
              const Spacer(),
              if (_petGenderType != PetGenderType.none)
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 20),
                  child: ButtonView(
                    onPressed: () {
                      serviceProvider
                          .setServiceProviderGender(_petGenderType.name);
                      AppNavigator.pushAndStackPage(context,
                          page: KycServiceScreenFour());
                    },
                    color: AppColors.lightSecondary,
                    borderRadius: 32,
                    borderColor: Colors.white,
                    child: CustomText(
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      text: 'Next',
                      weight: FontWeight.w400,
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
      ),
    );
  }
}

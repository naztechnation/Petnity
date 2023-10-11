import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/view_models/account_view_model.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_constants.dart';
import '../../../res/app_strings.dart';
import '../../../utils/navigator/page_navigator.dart';
import '../../widgets/button_view.dart';
import '../../widgets/custom_text.dart';
import 'service_kyc_two.dart';

class KycServiceScreenOne extends StatelessWidget {
  KycServiceScreenOne({
    super.key,
  });

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
          child: Column(
            children: [
              SizedBox(
                height: screenSize(context).height * 0.4,
              ),
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: CustomText(
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      text: 'Now lets get to know \nabout you.',
                      weight: FontWeight.w700,
                      size: 28,
                      fontFamily: AppStrings.interSans,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.3),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20),
                  child: ButtonView(
                    onPressed: () {
                      petProfile.setPetName(_petNameController.text);

                      AppNavigator.pushAndStackPage(context,
                          page: KycServiceScreenTwo());
                    },
                    color: AppColors.lightSecondary,
                    borderRadius: 22,
                    borderColor: Colors.white,
                    child: CustomText(
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      text: 'Continue',
                      weight: FontWeight.w500,
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
            ],
          ),
        ),
      ),
    );
  }
}

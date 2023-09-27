import 'dart:io';

import 'package:flutter/material.dart';
import 'package:petnity/ui/widgets/image_view.dart';
import 'package:provider/provider.dart';

import '../../model/view_models/service_provider_view_model.dart';
import '../../model/view_models/user_view_model.dart';
import '../../res/app_colors.dart';
import '../../res/app_constants.dart';
import '../../res/app_images.dart';
import '../../res/app_strings.dart';
import '../../utils/navigator/page_navigator.dart';
import '../widgets/back_button.dart';
import '../widgets/button_view.dart';
import '../widgets/custom_text.dart';
import '../widgets/text_edit_view.dart';
import 'service_kyc_three.dart';

class KycServiceScreenTwo extends StatelessWidget {
  KycServiceScreenTwo({
    super.key,
  });

  final TextEditingController _serviceProviderNameController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final serviceProvider =
        Provider.of<ServiceProviderViewModel>(context, listen: false);

    return Scaffold(
      backgroundColor: AppColors.lightPrimary,
      body: SingleChildScrollView(
        child: Container(
          height: screenSize(context).height,
          width: screenSize(context).width,
          decoration: BoxDecoration(),
          child: Column(children: [
            SafeArea(child: SizedBox(height: (Platform.isAndroid) ? 44 : 0)),
            backButton(context),
            SizedBox(
              height: screenSize(context).height * 0.2,
            ),
            SizedBox(height: 55),
            CustomText(
              textAlign: TextAlign.center,
              maxLines: 1,
              text: 'Your name',
              weight: FontWeight.w700,
              size: 32,
              fontFamily: AppStrings.interSans,
              color: Colors.black,
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0),
              child: TextEditView(
                controller: _serviceProviderNameController,
                isDense: true,
                labelText: 'input name',
              ),
            ),
            const Spacer(),
            if (_serviceProviderNameController.text.isNotEmpty)
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20),
                child: ButtonView(
                  onPressed: () {
                    serviceProvider.setServiceProviderName(
                        _serviceProviderNameController.text);

                    AppNavigator.pushAndStackPage(context,
                        page: KycServiceScreenThree());
                  },
                  color: AppColors.lightSecondary,
                  borderRadius: 22,
                  borderColor: Colors.white,
                  child: CustomText(
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    text: 'Next',
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
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:petnity/ui/widgets/modals.dart';
import 'package:provider/provider.dart';

import '../../../model/view_models/service_provider_view_model.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_constants.dart';

import '../../../res/app_strings.dart';
import '../../../utils/navigator/page_navigator.dart';

import '../../widgets/back_button.dart';
import '../../widgets/button_view.dart';
import '../../widgets/custom_text.dart';
import 'service_kyc_six.dart';

class KycServiceScreenFive extends StatelessWidget {
  KycServiceScreenFive({
    super.key,
  });

  String state = '';
  String country = '';
  String city = '';

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
                text: 'Your Location',
                weight: FontWeight.w500,
                size: 18,
                fontFamily: AppStrings.interSans,
                color: Colors.black,
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: CSCPicker(
                  onCountryChanged: (value) {
                    serviceProvider.setCountryServiceProvider(value);
                    country = value;
                  },
                  onStateChanged: (value) {
                    serviceProvider.setStateServiceProvider(value ?? '');
                    state = value ?? '';
                  },
                  onCityChanged: (value) {
                    serviceProvider.setCityServiceProvider(value ?? '');
                    city = value ?? '';
                  },
                ),
              ),
              const Spacer(),
              if (serviceProvider.serviceProviderAge != '')
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20),
                  child: ButtonView(
                    onPressed: () {

                    // serviceProvider.setCountryServiceProvider('Nigeria');
                    // serviceProvider.setStateServiceProvider('Enugu');
                    // serviceProvider.setCityServiceProvider( 'Nkanu');

                    //  AppNavigator.pushAndStackPage(context,
                    //         page: KycServiceScreenSix());

                      if (country == '') {
                        Modals.showToast('please select a country');
                      } else if (state == '') {
                        Modals.showToast('please select a state');
                      } else if (city == '') {
                        Modals.showToast('please select a city');
                      } else {
                        AppNavigator.pushAndStackPage(context,
                            page: KycServiceScreenSix());
                      }
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
      ),
    );
  }
}

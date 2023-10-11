import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/view_models/service_provider_view_model.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_constants.dart';

import '../../../res/app_strings.dart';
import '../../../utils/navigator/page_navigator.dart';

import '../../widgets/back_button.dart';
import '../../widgets/button_view.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/text_edit_view.dart';
import 'service_kyc_five.dart';

class KycServiceScreenFour extends StatelessWidget {
  KycServiceScreenFour({
    super.key,
  });

  final TextEditingController _serviceProviderAgeController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final serviceProvider =
        Provider.of<ServiceProviderViewModel>(context, listen: true);

    return Scaffold(
      backgroundColor: AppColors.lightPrimary,
      body: GestureDetector(
        onTap: (){
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
                text: 'Your age',
                weight: FontWeight.w700,
                size: 32,
                fontFamily: AppStrings.interSans,
                color: Colors.black,
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: TextEditView(
                  controller: _serviceProviderAgeController,
                  isDense: true,
                  readOnly: true,
                  labelText: 'Year/Month/Day',
                  suffixIcon: Icon(
                    Icons.arrow_drop_down,
                    size: 32,
                  ),
                  onTap: () async {
                    await serviceProvider.showDatePickerDialog(context);
      
                    _serviceProviderAgeController.text =
                        serviceProvider.serviceProviderAge;
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
                      serviceProvider.setServiceProviderAge(
                          _serviceProviderAgeController.text);
      
                      AppNavigator.pushAndStackPage(context,
                          page: KycServiceScreenFive());
                    },
                    color: AppColors.lightSecondary,
                    borderRadius: 22,
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

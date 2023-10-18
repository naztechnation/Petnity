import 'dart:io';

import 'package:flutter/material.dart';
import 'package:petnity/ui/service_provider/service_provider_kyc/service_kyc_eleven.dart';
import 'package:provider/provider.dart';

import '../../../model/view_models/service_provider_view_model.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_constants.dart';
import '../../../res/app_strings.dart';
import '../../../utils/navigator/page_navigator.dart';
import '../../widgets/back_button.dart';
import '../../widgets/button_view.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/modals.dart';

class KycServiceScreenTen extends StatelessWidget {
    KycServiceScreenTen({super.key});
  
   String selectedOption = 'Select';

  List<String> options = ["Select","NIN", "PVC", "International passport", "National ID card", "Drivers license", "Others"];


  @override
  Widget build(BuildContext context) {
    final serviceProvider = Provider.of<ServiceProviderViewModel>(context, listen: true);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
           height: screenSize(context).height,
      width: screenSize(context).width,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [AppColors.scaffoldColor, Colors.red.shade50],
              begin: Alignment.topRight,
              end: Alignment.topLeft)),
          child: Column(
            children: [
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
                height: screenSize(context).height * 0.35,
              ),
              CustomText(
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      text: 'Upload your ID card',
                      weight: FontWeight.w900,
                      size: 24,
                      fontFamily: AppStrings.interSans,
                      color: Colors.black,
                    ),
                    const SizedBox(height: 30,),
                     Align(
                      alignment: Alignment.centerLeft,
                       child: Padding(
                         padding: const EdgeInsets.only(left:18.0),
                         child: CustomText(
                          textAlign: TextAlign.left,
                          maxLines: 1,
                          text: 'ID Card type',
                          weight: FontWeight.w400,
                          size: 16,
                          fontFamily: AppStrings.interSans,
                          color: Colors.black,
                                         ),
                       ),
                     ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:22.0, vertical: 12),
                child: Container(
                   padding: EdgeInsets.symmetric(horizontal: 12.0),
                   height: 50,
                decoration: BoxDecoration(
                  color: AppColors.lightPrimary,
                  borderRadius: BorderRadius.circular(30.0), // Adjust the border radius as needed.
                 ), 
                  child: DropdownButtonFormField<String>(
                  value: selectedOption,
                  onChanged: (value) {
                     selectedOption = value!;
                      serviceProvider.setPhotoId(options.indexOf(value).toString());
                    },
                  items: options.map((String option) {
                    return DropdownMenuItem<String>(
                      value: option, // Ensure each value is unique.
                      child: Text(option),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                                     border: InputBorder.none, 
                
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

                    if(selectedOption != 'Select'){
                       AppNavigator.pushAndStackPage(context,
                          page: KycServiceScreenEleven(idType: selectedOption,));
                    }else{
                      Modals.showToast('Please select an id Type');
                    }
                  
                  },
                  color: AppColors.lightSecondary,
                  borderRadius: 30,
                  child: CustomText(
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    text: 'Next',
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
      ),
    );
  }
}

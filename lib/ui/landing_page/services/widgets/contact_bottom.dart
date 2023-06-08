

import 'package:flutter/material.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/utils/navigator/page_navigator.dart';

import '../../../../res/app_strings.dart';
import '../../../widgets/button_view.dart';
import '../../../widgets/custom_text.dart';
import '../review_screen.dart';

class ContactBottom extends StatefulWidget {
  
  const ContactBottom({super.key});

  @override
  State<ContactBottom> createState() => _ContactBottomState();
}

class _ContactBottomState extends State<ContactBottom> {

  bool _value = true;
  @override
  Widget build(BuildContext context) {
    return Container(height: 320,
    color: Colors.grey.shade100,
  padding: const EdgeInsets.all(20),
  child: Column(children: [
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
      CustomText(
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    text: 'Notify when Dera accepts session?',
                    weight: FontWeight.w500,
                    size: 14,
                    fontFamily: AppStrings.interSans,
                    color: Colors.black,
                  ),
                  Switch.adaptive(
                    activeColor: AppColors.lightSecondary,
            
      value: _value,
      onChanged: (newValue) => setState(() => _value = newValue),
    ),
    ],),
    const SizedBox(height: 20,),
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 60,decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
      CustomText(
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    text: 'Fee',
                    weight: FontWeight.w600,
                    size: 14,
                    fontFamily: AppStrings.interSans,
                    color: Colors.black,
                  ),
                   CustomText(
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    text: '\$129',
                    weight: FontWeight.w600,
                    size: 14,
                    color: Colors.black,
                  ),
    ]),
    ),
    const SizedBox(height: 45,),
    ButtonView(
                              color: AppColors.lightSecondary,
                              
                              borderColor: Colors.white,
                              borderRadius: 40,
                              onPressed: () {
                                AppNavigator.pushAndStackPage(context, page: ReviewScreen());
                              },
                              child: CustomText(
                                textAlign: TextAlign.left,
                                maxLines: 2,
                                text: 'Finish up and review',
                                weight: FontWeight.w600,
                                size: 16,
                                color: Colors.white,
                              ),
                            )
  ],),
  );
  }
}
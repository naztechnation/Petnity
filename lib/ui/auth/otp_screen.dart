


import 'package:flutter/material.dart';

import '../../res/app_constants.dart';
import '../../res/app_strings.dart';
import '../widgets/custom_text.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body: ListView(children: [
          SizedBox(height: screenSize(context).height * 0.13,),
              CustomText(
                                textAlign: TextAlign.left,
                                maxLines: 2,
                                text: 'Confirm the  code sent to\nyour E mail',
                                weight: FontWeight.w700,
                                size: 24,
                                fontFamily: AppStrings.interSans,
                                color: Colors.black,
                              ),
                             
                              SizedBox(height: 24,),
      ],),
    );
  }
}
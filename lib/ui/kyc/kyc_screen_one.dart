

import 'package:flutter/material.dart';

import '../../res/app_colors.dart';
import '../../res/app_constants.dart';
import '../../res/app_strings.dart';
import '../widgets/custom_text.dart';

class KycScreenOne extends StatelessWidget {
  const KycScreenOne({super.key});

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: screenSize(context).height,
          width: screenSize(context).width,

        decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [AppColors.scaffoldColor, Colors.red.shade50],
                    begin: Alignment.topRight,
                    end: Alignment.topLeft)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              SizedBox(
                  height: 58,
                ),
                  
                  CustomText(
                                      textAlign: TextAlign.left,
                                      maxLines: 2,
                                      text: 'Pet type',
                                      weight: FontWeight.w700,
                                      size: 24,
                                      fontFamily: AppStrings.montserrat,
                                      color: Colors.black,
                                    ),

                                     SizedBox(
                  height: 20,
                ),
                Material(child: Container(
                  height: 77,
                  width: 155,
                  decoration: BoxDecoration()))
            ],),
          ),
        ),
      ),
    );
  }
}
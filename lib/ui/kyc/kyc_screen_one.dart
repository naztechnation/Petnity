

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
        decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [AppColors.scaffoldColor, Colors.red.shade50],
                    begin: Alignment.topRight,
                    end: Alignment.topLeft)),
          child: Column(children: [
            SizedBox(
                height: screenSize(context).height * 0.15,
              ),
        
                CustomText(
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    text: 'Pet type',
                                    weight: FontWeight.w700,
                                    size: 32,
                                    fontFamily: AppStrings.montserrat,
                                    color: Colors.black,
                                  ),
          ],),
        ),
      ),
    );
  }
}
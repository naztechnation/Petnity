

import 'dart:io';

import 'package:flutter/material.dart';

import '../../../res/app_colors.dart';
import '../../../res/app_constants.dart';
import '../../widgets/back_button.dart';

class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body: Container(height: screenSize(context).height,
        width: screenSize(context).width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [AppColors.scaffoldColor, Colors.red.shade50],
                begin: Alignment.topRight,
                end: Alignment.topLeft)),
                child: SingleChildScrollView(child: Column(children: [
              SafeArea(child: SizedBox(height: (Platform.isAndroid) ? 30 : 0)),
                  backButton(context),
                              SizedBox(height: screenSize(context).height * 0.1,)
                              

                ],),),
                ),
    );
  }
}
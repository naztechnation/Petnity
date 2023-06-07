import 'dart:io';

import 'package:flutter/material.dart';
import 'package:petnity/res/app_images.dart';
import 'package:petnity/ui/landing_page/services/widgets/contact_bottom.dart';

import '../../../res/app_colors.dart';
import '../../../res/app_constants.dart';
import '../../../res/app_strings.dart';
import '../../widgets/back_button.dart';
import '../../widgets/button_view.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/image_view.dart';
import 'widgets/contact_top.dart';

class ContactProvider extends StatelessWidget {
  const ContactProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: screenSize(context).height,
        width: screenSize(context).width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [AppColors.scaffoldColor, Colors.red.shade50],
                begin: Alignment.topRight,
                end: Alignment.topLeft)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    maxLines: 2,
                    text: 'Contact dera',
                    weight: FontWeight.w600,
                    size: 18,
                    fontFamily: AppStrings.montserrat,
                    color: Colors.black,
                  ),
                ],
              ),
              const SizedBox(
                height: 28,
              ),
              contactTop (),

            ],
          ),
        ),
      ),
      bottomNavigationBar: ContactBottom(),
    );
  }
}

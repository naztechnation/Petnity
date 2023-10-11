import 'package:flutter/material.dart';

import '../../../../res/app_colors.dart';
import '../../../../res/app_strings.dart';
import '../../../widgets/button_view.dart';
import '../../../widgets/custom_text.dart';

Widget ChoiceCard(bool isSelected, String text, VoidCallback onPressed) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: ButtonView(
        expanded: false,
        onPressed: () {
          onPressed();
        },
        color: (isSelected) ? AppColors.lightSecondary : AppColors.cardColor,
        borderRadius: 32,
        borderColor: Colors.white,
        child: CustomText(
          textAlign: TextAlign.center,
          maxLines: 1,
          text: text,
          weight: FontWeight.w700,
          size: 16,
          fontFamily: AppStrings.interSans,
          color: (isSelected) ? AppColors.cardColor : Colors.black,
        ),
      ),
    ),
  );
}

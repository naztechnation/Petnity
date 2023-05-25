


import 'package:flutter/material.dart';
import 'package:petnity/res/app_colors.dart';

import '../../../res/app_strings.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/image_view.dart';

class PetType extends StatelessWidget {
  final String imageUrl;
  final double spacing;
  final String petName;
  final bool isPetType;
  final VoidCallback onPressed;

    PetType({super.key, required this.imageUrl, required this.petName,  this.spacing = 0, this.isPetType = false, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap:  onPressed ,
      child: AnimatedContainer( 
        duration: const Duration (seconds: 1),
       curve: Curves.fastOutSlowIn,
        height: 63,
        decoration: BoxDecoration(
          color: isPetType ? AppColors.lightSecondary : AppColors.cardColor,
                      borderRadius: BorderRadius.circular(40),

        ),
        child: Material(
                      borderRadius: BorderRadius.circular(40),
                      color: isPetType ? AppColors.lightSecondary : AppColors.cardColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          CustomText(
                                            textAlign: TextAlign.left,
                                            maxLines: 1,
                                            text: petName,
                                            weight: FontWeight.w700,
                                            size: 16,
                                            fontFamily: AppStrings.interSans,
                                            color: isPetType ? AppColors.lightPrimary :  Colors.black,
                                          ),
                                        SizedBox(width: spacing,),
                                          ImageView.asset(imageUrl)
                        ],),
                      )),
      ),
    );
  }
}
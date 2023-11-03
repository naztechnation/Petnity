


import 'package:flutter/material.dart';
import 'package:petnity/res/app_colors.dart';

import '../../../../res/app_strings.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/image_view.dart';

class PetType extends StatelessWidget {
  final String imageUrl;
  final double spacing;
  final String petName;
  final bool isPetType;
  final VoidCallback onPressed;

    PetType({super.key, required this.imageUrl, 
    required this.petName,  this.spacing = 0, 
    this.isPetType = false, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap:  onPressed ,
      child: AnimatedContainer( 
        duration: const Duration (milliseconds: 1000),
       curve: Curves.fastOutSlowIn,
        height: 43,
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          Expanded(
                            child: CustomText(
                                              textAlign: TextAlign.left,
                                              maxLines: 2,
                                              text: petName,
                                              weight: FontWeight.w600,
                                              size: 15,
                                              fontFamily: AppStrings.interSans,
                                              color: isPetType ? AppColors.lightPrimary :  Colors.black,
                                            ),
                          ),
                                        SizedBox(width: 15,),
                                          ImageView.asset(imageUrl, height: 40,)
                        ],),
                      )),
      ),
    );
  }
}
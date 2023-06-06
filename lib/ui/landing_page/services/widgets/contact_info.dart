

import 'package:flutter/material.dart';
import 'package:petnity/res/app_images.dart';
import 'package:petnity/ui/widgets/custom_text.dart';

import '../../../../res/app_colors.dart';
import '../../../../res/app_strings.dart';
import '../../../widgets/image_view.dart';

Widget contactInfo(){

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
       const SizedBox(
                height: 30,
              ),
              CustomText(
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    text: 'Contact info',
                    weight: FontWeight.w600,
                    size: 14,
                    fontFamily: AppStrings.interSans,
                    color: Colors.black,
                  ),
                  const SizedBox(height: 10,),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            ImageView.svg(AppImages.phoneIcon, width: 16,), 
            const SizedBox(width: 12,),
            CustomText(
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        text: 'Phone',
                        weight: FontWeight.w600,
                        size: 14,
                        // fontFamily: AppStrings.interSans,
                        color: Colors.black,
                      ),
          ],),
          CustomText(
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        text: '+233123257865',
                        weight: FontWeight.w600,
                        size: 14,
                        // fontFamily: AppStrings.interSans,
                        color: Colors.black,
                      ),
        ],
      ),
      const SizedBox(
                height: 10,
              ),
              Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            ImageView.svg(AppImages.messageIcon, color: AppColors.lightSecondary,), 
            const SizedBox(width: 12,),
            CustomText(
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        text: 'Email',
                        weight: FontWeight.w600,
                        size: 14,
                        // fontFamily: AppStrings.interSans,
                        color: Colors.black,
                      ),
          ],),
          CustomText(
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        text: 'example@gmail.com',
                        weight: FontWeight.w600,
                        size: 14,
                        // fontFamily: AppStrings.interSans,
                        color: Colors.black,
                      ),
        ],
      ),
      const SizedBox(
                height: 30,
              ),
    ],
  );

}
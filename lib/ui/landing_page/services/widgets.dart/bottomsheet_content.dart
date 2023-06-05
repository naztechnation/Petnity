

import 'package:flutter/material.dart';

import '../../../../res/app_strings.dart';
import '../../../widgets/custom_text.dart';

Widget bottomSheetContent(BuildContext context){

  return Container(
    padding: const EdgeInsets.all(30),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        CustomText(
              textAlign: TextAlign.left,
              maxLines: 2,
              text: 'Filter',
              weight: FontWeight.w900,
              size: 24,
              fontFamily: AppStrings.montserrat,
              color: Colors.black,
            ),
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: CustomText(
                textAlign: TextAlign.right,
                maxLines: 2,
                text: 'Close',
                weight: FontWeight.w700,
                size: 14,
                fontFamily: AppStrings.interSans,
                color: Colors.red[700],
              ),
            ),
      ],),
      const SizedBox(height: 15,),
      CustomText(
              textAlign: TextAlign.start,
              maxLines: 2,
              text: 'Filter by',
              weight: FontWeight.w700,
              size: 14,
              fontFamily: AppStrings.interSans,
              color: Colors.black,
            ),
    ],),
  );

}
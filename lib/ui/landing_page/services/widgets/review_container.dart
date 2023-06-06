

import 'package:flutter/material.dart';

import '../../../../res/app_constants.dart';
import '../../../../res/app_images.dart';
import '../../../../res/app_strings.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/profile_image.dart';
import '../../../widgets/ratings_views.dart';

class ReviewContainer extends StatefulWidget {
  const ReviewContainer({super.key});

  @override
  State<ReviewContainer> createState() => _ReviewContainerState();
}

class _ReviewContainerState extends State<ReviewContainer> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: const EdgeInsets.symmetric(horizontal:30, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal:10, vertical: 20),
      decoration: BoxDecoration(
        borderRadius:  BorderRadius.circular(30),
        color: Colors.white,
      ),
  
  width: screenSize(context).width,

  child: Column(
    children: [
      ListTile(
                  
                  leading: ProfileImage(placeHolder: AppImages.person,  '', height: 75,width: 55,radius: 20,),
                  title: CustomText(
                          textAlign: TextAlign.left,
                          maxLines: 1,
                          text: 'Audrey jhay',
                          weight: FontWeight.w700,
                          size: 16,
                          fontFamily: AppStrings.interSans,
                          color: Colors.black,
                        ),
                       
                  subtitle:RatingView(
                            rating: 4,
                            onSelected: (rating) {
                              // setState(() {
                              //   ratings = rating;
                              // });
                            },
                          ),),
                          CustomText(
                          textAlign: TextAlign.left,
                          maxLines: 4,
                          text: 'Lorem ipsum dolor sit amet consectetur. Vitae magna blandit nisl pulvinar ac nunc. Turpis pulvinar amet at erat fames venenatis. Est mi egestas eget feugiat nunc. Mattis sapien diam.',
                          weight: FontWeight.w500,
                          size: 14,
                          fontFamily: AppStrings.interSans,
                          color: Colors.black,
                        ),
    ],
  ),
);
  }
}
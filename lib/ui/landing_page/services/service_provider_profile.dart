

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:petnity/ui/widgets/button_view.dart';
import 'package:petnity/utils/navigator/page_navigator.dart';

import '../../../res/app_colors.dart';
import '../../../res/app_constants.dart';
import '../../../res/app_images.dart';
import '../../../res/app_strings.dart';
import '../../location/set_location_screen.dart';
import '../../widgets/back_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/image_view.dart';
import '../../widgets/profile_image.dart';
import 'widgets/gallary_rating_section.dart';
import 'widgets/providers_profile_body.dart';

class ServiceProviderProfile extends StatelessWidget {
  const ServiceProviderProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body: Stack(
        children: [
          Container(
            height: screenSize(context).height,
            width: screenSize(context).width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [AppColors.scaffoldColor, Colors.red.shade50],
                    begin: Alignment.topRight,
                    end: Alignment.topLeft)),
               child: SingleChildScrollView(child: Column(crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SafeArea(child: Container(
                  color: AppColors.cardColor ,
                  height: (Platform.isAndroid) ? 30 : 0)),
                Container(
                  color: AppColors.cardColor ,
                  padding: const EdgeInsets.only(bottom: 20, top: 30),
                  child: Row(
                    children: [
                      backButton(context),
                      const SizedBox(
                        width: 40,
                      ),
                      CustomText(
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        text: 'Service profile',
                        weight: FontWeight.w700,
                        size: 20,
                        fontFamily: AppStrings.interSans,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12,),
                 SizedBox(
                          width: 130,
                          child: Row(
                            children: [
                              ImageView.svg(AppImages.location),
                              SizedBox(
                                width: 5,
                              ),
                              CustomText(
                                textAlign: TextAlign.start,
                                maxLines: 2,
                                text: 'Ikeja, Lagos',
                                weight: FontWeight.w300,
                                size: 14,
                                fontFamily: AppStrings.interSans,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                const SizedBox(height: 12,),

                        ProfileImage(
                      AppImages.person,
                      placeHolder: AppImages.person,
                      radius: 55,
                      height: 120,
                      width: 120,
                    ),
                const SizedBox(height: 12,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          text: 'Dera Jessica',
                          weight: FontWeight.w700,
                          size: 14,
                          fontFamily: AppStrings.interSans,
                          color: Colors.black,
                        ),
                        const SizedBox(width: 12,),
                        ImageView.svg(AppImages.verified),
               
                      ],
                    ),
                         const SizedBox(height: 12,),

                    CustomText(
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          text: 'Verified',
                          weight: FontWeight.w300,
                          size: 11,
                          fontFamily: AppStrings.interSans,
                          color: Colors.black,
                        ),
                         const SizedBox(height: 12,),

                        CustomText(
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      text: '322 Completed walks',
                      weight: FontWeight.w400,
                      size: 12,
                      fontFamily: AppStrings.interSans,
                      color: Colors.black,
                    ),
                       const SizedBox(height: 12,),

                    
                    ProviderProfileBody(),
                    GallaryRatingSection(),
                       const SizedBox(height: 150,),

               ],)),     
                    ),
                    Positioned(
                      bottom: 30,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal:20.0),
                        child: Row(children: [
                          Expanded(
                            flex: 6,
                            child: ButtonView(onPressed: (){
                              AppNavigator.pushAndStackPage(context, page: SetLocationScreen());
                            }, child:  CustomText(
                            textAlign: TextAlign.start,
                            maxLines: 2,
                            text: 'Book session',
                            weight: FontWeight.w400,
                            size: 12,
                            fontFamily: AppStrings.interSans,
                            color: Colors.white,
                                              ),),
                          ), 
                          const SizedBox(width: 14,),
                          Expanded(
                            flex: 2,
                            child: ButtonView(
                              color: Color(0xFFEAF0FF),
                              onPressed: (){}, child:  ImageView.svg(AppImages.messageArrow, ), expanded: false,))
                        ],),
                      ),
                    )
        ],
      ),
    );
  }
}
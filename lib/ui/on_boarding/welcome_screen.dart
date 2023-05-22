

import 'package:flutter/material.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/ui/widgets/button_view.dart';

import '../../res/app_constants.dart';
import '../../res/app_strings.dart';
import '../widgets/custom_text.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(gradient: LinearGradient(
                  colors: [AppColors.scaffoldColor, Colors.red.shade200],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter
                )),
            ),
            Positioned(
              bottom:0,
              left: 0,
              right: 0,
              child: Container(
                height: screenSize(context).height * 0.5,
                
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.elliptical(
              screenSize(context).width, 90.0))
                ),
                child: Column(children: [
                  const SizedBox(height: 47,),
                   const CustomText(
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    text: 'Connect with our pet \ncare givers',
                weight: FontWeight.w900,size: 22,
                fontFamily: AppStrings.montserrat, color: Colors.black,),
                const SizedBox(height: 34,),
                   const CustomText(
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    text: 'Find and meet and book world class \npet sitters and walkers',
                weight: FontWeight.w400,size: 16,
                fontFamily: AppStrings.interSans, color: Colors.black,),
          const SizedBox(height: 15),

                 Padding(
                   padding: const EdgeInsets.symmetric(vertical:14.0, horizontal: 20),
                   child: ButtonView(onPressed: (){}, child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    CustomText(
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      text: 'Continue',
                                 weight: FontWeight.w400,size: 16,
                                 fontFamily: AppStrings.interSans, color: Colors.white,),
                    const SizedBox(width: 6,),
                 
                                 Icon(Icons.arrow_forward, color: Colors.white,)
                                 ],),),
                 ),

          const SizedBox(height: 15),


                 Padding(
                                      padding: const EdgeInsets.symmetric(vertical:14.0, horizontal: 20),

                   child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Container(height: 5, width: 60, decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: AppColors.lightSecondary,),),
                    const SizedBox(width: 6,),
                    
                     Container(height: 5, width: 60, decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: Colors.grey.withOpacity(0.8),),),
                  
                   const SizedBox(width: 6,),
                    
                     Container(height: 5, width: 60, decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: Colors.grey.withOpacity(0.8),),),
                      const SizedBox(width: 6,),
                    
                     Container(height: 5, width: 60, decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: Colors.grey.withOpacity(0.8),),),
                      const SizedBox(width: 6,),
                    
                     Container(height: 5, width: 60, decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: Colors.grey.withOpacity(0.8),),)
                   ],),
                 )
                ],),
                )),
               
        ],
      ),
    );
  }
}


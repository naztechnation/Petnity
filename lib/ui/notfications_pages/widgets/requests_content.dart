

import 'package:flutter/material.dart';
import 'package:petnity/res/app_images.dart';

import '../../../res/app_colors.dart';
import '../../../res/app_strings.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/profile_image.dart';

class RequestsContent extends StatelessWidget {
  final bool isChat;
  final bool isRequestAccepted;
    final dontShow;
    RequestsContent({super.key, required this.isChat, required this.isRequestAccepted, this.dontShow = false});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal:15.0, vertical: 3),
      child: Container(
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            child: ListTile(
              dense: true,
              // isThreeLine: true,
              leading: ProfileImage(placeHolder: AppImages.person,  '', height: 57,width: 57,),
              title: CustomText(
                      textAlign: TextAlign.left,
                      maxLines: 1,
                      text: 'Audrey jhay',
                      weight: FontWeight.w700,
                      size: 16,
                      fontFamily: AppStrings.interSans,
                      color: Colors.black,
                    ),
                   
              subtitle: CustomText(
                      textAlign: TextAlign.left,
                      maxLines: 2,
                      text: 'Lorem ipsum dolor sit amet consectetur. Sit nisi eget tortor...',
                      weight: FontWeight.w400,
                      size: 14,
                      fontFamily: AppStrings.interSans,
                      color: Colors.black,
                    ),
                     trailing: (dontShow) ? SizedBox.shrink() : (isChat) ?Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.lightSecondary),
                child: Center(
                  child: Text(
                    '20',
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                ),
              ) : Container(
                height: 42,
                width: 115,
                decoration: BoxDecoration(color: isRequestAccepted ?
                 Colors.green.shade100 : Colors.red.shade100, borderRadius: BorderRadius.circular(30)),
                 child: Center(
                   child: CustomText(text: isRequestAccepted ? 'Accepted' : 'Rejected', color: isRequestAccepted ?
                   Colors.green[900] : Colors.red[900], textAlign: TextAlign.center,),
                 ),
                 ),
            ),
          ),
        ),
    );
  }
}
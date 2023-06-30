import 'package:flutter/material.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_images.dart';
import 'package:petnity/ui/widgets/image_view.dart';
import 'package:petnity/ui/widgets/profile_image.dart';

import '../../../../../res/app_strings.dart';
import '../../../../widgets/custom_text.dart';

Widget serviceProfile(BuildContext context, {bool hideImage = false}) {
  return ListTile(
    contentPadding: const EdgeInsets.all(0),
    leading: ProfileImage(
      '',
      radius: 30,
      placeHolder: AppImages.person,
    ),
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          textAlign: TextAlign.left,
          maxLines: 2,
          text: 'Seller',
          weight: FontWeight.w700,
          size: 12,
          fontFamily: AppStrings.interSans,
          color: Colors.black,
        ),
        const SizedBox(
          height: 5,
        ),
        CustomText(
          textAlign: TextAlign.left,
          maxLines: 2,
          text: 'Sandra lee',
          weight: FontWeight.w700,
          size: 12,
          fontFamily: AppStrings.interSans,
          color: Colors.black,
        ),
      ],
    ),
    trailing: (hideImage)
        ? ImageView.svg(AppImages.messageBorder)
        : SizedBox(
            width: screenSize(context).width * 0.45,
            child: Row(
              children: [
                ImageView.svg(AppImages.callBorder),
                const SizedBox(
                  width: 5,
                ),
                ImageView.svg(AppImages.messageBorder),
                const SizedBox(
                  width: 5,
                ),
                ImageView.svg(AppImages.videoBorder),
                const SizedBox(
                  width: 5,
                ),
              ],
            ),
          ),
  );
}

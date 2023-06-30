import 'package:flutter/material.dart';

import '../../../../../res/app_constants.dart';
import '../../../../../res/app_images.dart';
import '../../../../../res/app_strings.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/image_view.dart';
import '../../../../widgets/profile_image.dart';

class PetOwner extends StatelessWidget {
  const PetOwner({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.all(0),
          leading: ProfileImage(
            '',
            placeHolder: 'assets/images/petowner.png',
            radius: 30,
          ),
          title: CustomText(
            text: 'Sandra Jhay',
            fontFamily: AppStrings.interSans,
          ),
          subtitle: Text('Pet Owner'),
          trailing: SizedBox(
            width: screenSize(context).width * 0.38,
            child: Row(
              children: [
                ImageView.svg(AppImages.callBorder),
                const SizedBox(
                  width: 10,
                ),
                ImageView.svg(AppImages.messageBorder),
                const SizedBox(
                  width: 10,
                ),
                ImageView.svg(AppImages.videoBorder),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

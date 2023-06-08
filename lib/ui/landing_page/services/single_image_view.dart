

import 'package:flutter/material.dart';
import 'package:petnity/res/app_constants.dart';

import '../../../res/app_images.dart';
import '../../widgets/back_button.dart';
import '../../widgets/image_view.dart';

class SingleImageView extends StatelessWidget {
  const SingleImageView({super.key});

  @override
  Widget build(BuildContext context) {
    return   Stack(
      children: [
        Container(
            height: screenSize(context).height,
            width: screenSize(context).width,
            child: ImageView.asset(AppImages.playing, height: screenSize(context).height, fit: BoxFit.cover,),
            ),
            Container(
 height: screenSize(context).height,
            width: screenSize(context).width,
            color: Colors.black26,
            ),

                Positioned(
                  top: 30,
                  left: 0,
                  child: backButton(context)),

      ],
    );
  }
}
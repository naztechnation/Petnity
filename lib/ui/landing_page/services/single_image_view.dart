import 'package:flutter/material.dart';
import 'package:petnity/res/app_constants.dart';

import '../../../res/app_images.dart';
import '../../widgets/back_button.dart';
import '../../widgets/image_view.dart';

class SingleImageView extends StatelessWidget {
  final String image;
  const SingleImageView({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: screenSize(context).height,
          width: screenSize(context).width,
          child: ImageView.network(
            image,
            placeholder: AppImages.logo,
            height: screenSize(context).height,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          height: screenSize(context).height,
          width: screenSize(context).width,
          color: Colors.black26,
        ),
        Positioned(top: 30, left: 0, child: backButton(context)),
      ],
    );
  }
}

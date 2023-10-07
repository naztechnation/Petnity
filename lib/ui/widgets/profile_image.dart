import 'package:flutter/material.dart';
import 'package:petnity/res/app_colors.dart';

import '../../res/app_images.dart';
import 'image_view.dart';

class ProfileImage extends StatelessWidget {
  final String url;
  final String? placeHolder;
  final String hero;
  final double height;
  final double width;
  final double scale;
  final double radius;
  final double borderWidth;
  final BoxFit fit;
  final Color? borderColor;
  final EdgeInsetsGeometry? margin;
  final void Function()? onPressed;
  final bool isFood;
  const ProfileImage(this.url,
      {this.hero = 'profile image',
      this.height = 45,
      this.width = 45,
      this.scale = 1,
      this.radius = 15,
      this.borderWidth = 1.0,
      this.placeHolder,
      this.margin,
      this.onPressed,
      this.fit = BoxFit.cover,
      this.borderColor,
      Key? key,
      this.isFood = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
          padding: margin,
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            shape: BoxShape.circle,
            border: Border.all(
                width: borderWidth,
                color: borderColor ?? Theme.of(context).colorScheme.secondary),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100.0),
            child: CircleAvatar(
                radius: radius,
                backgroundColor: AppColors.lightPrimary,
                child: ImageView.network(url,
                    placeholder: placeHolder,
                    fit: fit,
                    height: height,
                    width: width,
                    scale: scale,
                    
                    imageErrorBuilder: (context, error, stackTrace) =>
                        ImageView.asset(placeHolder,
                            fit: BoxFit.cover, height: height, width: width))),
          )),
    );
  }
}

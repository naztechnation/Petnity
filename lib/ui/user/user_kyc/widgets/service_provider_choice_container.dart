import 'package:flutter/material.dart';
import 'package:petnity/res/app_colors.dart';
import '../../../../res/app_strings.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/image_view.dart';

class ServiceProviderChoice extends StatelessWidget {
  final String imageUrl;
  final double spacing;
  final String serviceName;
  final bool isSelected;
  final VoidCallback onPressed;

  ServiceProviderChoice(
      {super.key,
      required this.imageUrl,
      required this.serviceName,
      this.spacing = 0,
      this.isSelected = false,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    
    return InkWell(
      onTap: onPressed ,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 1000),
        curve: Curves.fastOutSlowIn,
        height: 63,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.lightSecondary : AppColors.cardColor,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Material(
            borderRadius: BorderRadius.circular(40),
            color: isSelected ? AppColors.lightSecondary : AppColors.cardColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomText(
                      textAlign: TextAlign.left,
                      maxLines: 2,
                      text: serviceName,
                      weight: FontWeight.w600,
                      size: 15,
                      fontFamily: AppStrings.interSans,
                      color: isSelected ? AppColors.lightPrimary : Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  ImageView.asset(
                    imageUrl,
                  )
                ],
              ),
            )),
      ),
    );
  }
}

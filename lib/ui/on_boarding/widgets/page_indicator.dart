

import 'package:flutter/material.dart';
import 'package:petnity/res/app_colors.dart';

class PageIndicator extends StatelessWidget {
  final bool isIndex;
  const PageIndicator({super.key, required this.isIndex, });

  @override
  Widget build(BuildContext context) {
    return                  
       Expanded(
         child: Container(height: 5, width: 60, 
         decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
         color: (isIndex) ? AppColors.lightSecondary : Colors.grey.withOpacity(0.8),),),
       );

  }
}
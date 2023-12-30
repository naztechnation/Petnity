


import 'package:flutter/material.dart';

import '../../../../res/app_colors.dart';

class ProgressBar extends StatelessWidget {
  final double totalTime ;
  final double remainingTime;

  const ProgressBar({super.key, required this.totalTime, required this.remainingTime});

  @override
  Widget build(BuildContext context) {
     double progress = (totalTime - remainingTime) == 0 ? 1.0 : (totalTime - remainingTime) / totalTime;

    return  Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 10.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [
                AppColors.lightSecondary,
                AppColors.lightSecondary.withOpacity(0.5), 
                
              ],
              stops: [progress, progress],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
      );
  }
}






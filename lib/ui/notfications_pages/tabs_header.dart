

 import 'package:flutter/material.dart';

import '../../res/app_colors.dart';
import '../../res/enum.dart';

Widget tabHeader(FilterStatus filterStatus, bool isTapped, bool showBadge) {
    return Stack(
      children: [
        Container(
          height: 35,
          decoration: BoxDecoration(
              color: isTapped ? Colors.grey.shade300 : AppColors.cardColor,
              borderRadius: BorderRadius.circular(20)),
          child: Center(
            child: Text(
           (filterStatus.name == 'request') ? 'Session requests':  filterStatus.name,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
        if (showBadge)
          Positioned(
            top: 0,
            right: 5,
            child: Container(
              height: 25,
              width: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.lightSecondary),
              child: Center(
                child: Text(
                  '12',
                  style: TextStyle(color: Colors.white, fontSize: 11),
                ),
              ),
            ),
          )
      ],
    );
  }
import 'package:flutter/material.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/res/app_images.dart';
import 'package:petnity/ui/landing_page/widgets/listofservices_widget.dart';
import 'package:petnity/ui/widgets/image_view.dart';

class ServicesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.lightBackground,
        body: Container(
          color: AppColors.lightBackground,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('All services'),
                    InkWell(
                      child: ImageView.svg(AppImages.filterIcon),
                    ),
                  ],
                ),
              ),
              ListOfServices()
            ],
          ),
        ));
  }
}

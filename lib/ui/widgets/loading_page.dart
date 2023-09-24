import 'package:flutter/material.dart';
import 'package:petnity/res/app_images.dart';
import 'package:petnity/ui/widgets/image_view.dart';

import '../../res/app_colors.dart';
import '../../res/app_constants.dart';

class LoadingPage extends StatelessWidget {
  final int length;
  const LoadingPage({this.length = 5, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: screenSize(context).height,
        width: screenSize(context).width,
        decoration: BoxDecoration(
            color:AppColors.lightPrimary,),
        child: Align(child: ImageView.asset(AppImages.loading, height: 50,)),
      ),
    );
    
    }}
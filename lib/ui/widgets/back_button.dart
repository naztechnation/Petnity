

import 'package:flutter/material.dart';

import '../../res/app_images.dart';
import 'image_view.dart';

Widget backButton(BuildContext context){

  return GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 22.0),
                  child: ImageView.svg(AppImages.backButton, height: 30,width: 30,),
                )),
            );

}
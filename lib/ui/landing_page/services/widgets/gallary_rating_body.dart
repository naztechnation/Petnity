

import 'package:flutter/material.dart';
import 'package:petnity/res/app_images.dart';
import 'package:petnity/ui/widgets/image_view.dart';
import 'package:petnity/utils/navigator/page_navigator.dart';

import '../single_image_view.dart';
import 'review_container.dart';

class GallaryRatingBody extends StatelessWidget {
  final bool isGallary;
  const GallaryRatingBody({super.key, required this.isGallary});

  @override
  Widget build(BuildContext context) {
     
    
    
   if(isGallary) return Container(
      height: 230,
      margin: const EdgeInsets.symmetric(horizontal: 25),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(40),
      color: Colors.white
    ),
    child: GridView.builder(
       padding: const EdgeInsets.all(10.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,
          ),
      itemCount: 6,
      itemBuilder: (ctx, i) {
        return Container(
           decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(40),
      color: Colors.white
    ),
          child: GestureDetector(
            onTap: (){
              AppNavigator.pushAndStackPage(context, page: SingleImageView());
            },
            child: ImageView.asset(AppImages.playing)));
      },
    ),
   );
   
else {
 return  ListView.builder(
  physics: NeverScrollableScrollPhysics(),
  shrinkWrap: true,
  itemCount: 2,
  itemBuilder: (_,__){
 
  return ReviewContainer();
 });
}
  }
}
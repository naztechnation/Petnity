import 'package:flutter/material.dart';

import '../../../../res/app_colors.dart';
import '../../../../res/app_constants.dart';
import '../../../../res/enum.dart';
import 'gallary_rating_body.dart';

class GallaryRatingSection extends StatefulWidget {
  GallaryRatingSection({super.key});

  @override
  State<GallaryRatingSection> createState() => _GallaryRatingSectionState();
}

class _GallaryRatingSectionState extends State<GallaryRatingSection> {
  GallaryRating type = GallaryRating.gallary;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          width: screenSize(context).width * 0.53,
          height: 50,
          decoration: BoxDecoration(
            color: AppColors.lightPrimary,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    type = GallaryRating.gallary;
                  });
                },
                child: Padding(
                  padding: EdgeInsets.only(
                      left: type == GallaryRating.gallary ? 10 : 0,
                      right: type == GallaryRating.ratings ? 10 : 0),
                  child: tabContent(
                      GallaryRating.gallary, type == GallaryRating.gallary),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    type = GallaryRating.ratings;
                  });
                },
                child: Padding(
                  padding: EdgeInsets.only(
                      left: type == GallaryRating.gallary ? 10 : 0,
                      right: type == GallaryRating.ratings ? 10 : 0),
                  child: tabContent(
                      GallaryRating.ratings, type == GallaryRating.ratings),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30,),
        GallaryRatingBody(isGallary:type == GallaryRating.gallary),
      ],
    );
  }

  tabContent(
    GallaryRating type,
    bool isTapped,
  ) {
    return Container(
      height: 35,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
          color: isTapped ? Colors.grey.shade300 : AppColors.cardColor,
          borderRadius: BorderRadius.circular(20)),
      child: Center(
        child: Text(
          (type.name == 'gallary') ? 'Gallery' : 'Ratings',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

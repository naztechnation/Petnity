import 'package:flutter/material.dart';

import '../../../../res/app_colors.dart';
import '../../../../res/app_constants.dart';
import '../../../../res/enum.dart' as gallary;
import 'gallary_rating_body.dart';

class GallaryRatingSection extends StatefulWidget {

  final String userId; 

  GallaryRatingSection({super.key, required this.userId});

  @override
  State<GallaryRatingSection> createState() => _GallaryRatingSectionState();
}

class _GallaryRatingSectionState extends State<GallaryRatingSection> {
  gallary.GallaryRating type = gallary.GallaryRating.gallary;

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
                    type = gallary.GallaryRating.gallary;
                  });
                },
                child: Padding(
                  padding: EdgeInsets.only(
                      left: type == gallary.GallaryRating.gallary ? 10 : 0,
                      right: type == gallary.GallaryRating.ratings ? 10 : 0),
                  child: tabContent(
                      gallary.GallaryRating.gallary, type == gallary.GallaryRating.gallary),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    type = gallary.GallaryRating.ratings;
                  });
                },
                child: Padding(
                  padding: EdgeInsets.only(
                      left: type == gallary.GallaryRating.gallary ? 10 : 0,
                      right: type == gallary.GallaryRating.ratings ? 10 : 0),
                  child: tabContent(
                      gallary.GallaryRating.ratings, type == gallary.GallaryRating.ratings),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30,),
        GallaryRatingBody(isGallary:type == gallary.GallaryRating.gallary, userId: widget.userId,),
      ],
    );
  }

  tabContent(
    gallary.GallaryRating type,
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

import 'package:flutter/material.dart';

import '../../../../res/app_colors.dart';
import '../../../../res/app_constants.dart';
import '../../../../res/enum.dart' as gallery;
import 'gallery_rating_body.dart';

class GalleryRatingSection extends StatefulWidget {

  final String userId; 

  GalleryRatingSection({super.key, required this.userId});

  @override
  State<GalleryRatingSection> createState() => _GalleryRatingSectionState();
}

class _GalleryRatingSectionState extends State<GalleryRatingSection> {
  gallery.GalleryRating type = gallery.GalleryRating.gallery;

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
                    type = gallery.GalleryRating.gallery;
                  });
                },
                child: Padding(
                  padding: EdgeInsets.only(
                      left: type == gallery.GalleryRating.gallery ? 10 : 0,
                      right: type == gallery.GalleryRating.ratings ? 10 : 0),
                  child: tabContent(
                      gallery.GalleryRating.gallery, type == gallery.GalleryRating.gallery),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    type = gallery.GalleryRating.ratings;
                  });
                },
                child: Padding(
                  padding: EdgeInsets.only(
                      left: type == gallery.GalleryRating.gallery ? 10 : 0,
                      right: type == gallery.GalleryRating.ratings ? 10 : 0),
                  child: tabContent(
                      gallery.GalleryRating.ratings, type == gallery.GalleryRating.ratings),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30,),
        GalleryRatingBody(isGallery:type == gallery.GalleryRating.gallery, userId: widget.userId,),
      ],
    );
  }

  tabContent(
    gallery.GalleryRating type,
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
          (type.name == 'gallery') ? 'Gallery' : 'Ratings',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

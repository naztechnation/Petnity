import 'package:flutter/material.dart';
import 'package:petnity/res/app_images.dart';
import 'package:petnity/ui/landing_page/widgets/rating_widget.dart';

import '../../../../model/user_models/get_product_reviews.dart';

class ReviewWidget extends StatelessWidget {
  final ProductReviews reviews;
  const ReviewWidget({super.key, required this.reviews,});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Card(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(AppImages.catPic),
                ),
                title: Text('Andy Davies'),
                subtitle: RatingWidget(coloredStars: reviews.rating!),
              ),
              Text(
                reviews.comment ?? '',
                textAlign: TextAlign.justify,
              )
            ],
          ),
        ),
      ),
    );
  }
}

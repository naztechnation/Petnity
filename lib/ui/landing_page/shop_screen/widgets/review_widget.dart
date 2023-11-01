import 'package:flutter/material.dart';
import 'package:petnity/ui/landing_page/widgets/rating_widget.dart';
import 'package:petnity/ui/widgets/image_view.dart';

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
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
          child: Column(
            children: [
              ListTile(
                minLeadingWidth: 4,
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: SizedBox(height: 60, width: 50,child: ImageView.network('', height: 60,))),
                title: Text(reviews.profile?.user?.username ?? ""),
                subtitle: RatingWidget(coloredStars: reviews.rating!, size: 20,),
              ),
              
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left:28.0),
                  child: Text(
                    reviews.comment ?? '',
                    textAlign: TextAlign.justify,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

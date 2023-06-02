import 'package:flutter/material.dart';

class RatingWidget extends StatelessWidget {
  final int coloredStars;
  final double size;
  const RatingWidget({required this.coloredStars, this.size = 16});
  @override
  Widget build(BuildContext context) {
    var uncoloredStars = 5 - coloredStars;
    return Container(
      child: Row(
        children: [
          for (var i = 0; i < coloredStars; i++)
            Icon(
              Icons.star,
              color: Colors.orange,
              size: size,
            ),
          for (var i = 0; i < uncoloredStars; i++)
            Icon(
              Icons.star,
              color: Colors.grey,
              size: size,
            )
        ],
      ),
    );
  }
}

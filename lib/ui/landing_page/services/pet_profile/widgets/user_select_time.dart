import 'package:flutter/material.dart';
import 'package:petnity/res/app_images.dart';
import 'package:petnity/ui/widgets/image_view.dart';

class UserSelectTime extends StatelessWidget {
  const UserSelectTime({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Date
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageView.svg(AppImages.calender),
            SizedBox(
              width: 10,
            ),
            Text(
              'Date',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        SizedBox(
          height: 3,
        ),
        Container(
          height: 53,
          width: 184,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('20-022023'),
              IconButton(
                  onPressed: () {}, icon: Icon(Icons.keyboard_arrow_down))
            ],
          ),
        ),
        SizedBox(
          height: 49,
        ),
        //Time
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageView.svg(AppImages.time),
            SizedBox(
              width: 10,
            ),
            Text(
              'Time',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        SizedBox(
          height: 3,
        ),
        Container(
          height: 53,
          width: 184,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('20-022023'),
              IconButton(
                  onPressed: () {}, icon: Icon(Icons.keyboard_arrow_down))
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_images.dart';

import 'package:petnity/ui/widgets/button_view.dart';
import 'package:petnity/ui/widgets/image_view.dart';

class OngoingDeliveryWidget extends StatelessWidget {
  final String label;
  OngoingDeliveryWidget({this.label = 'Details'});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Container(
        height: screenSize(context).height * .3,
        width: screenSize(context).width * .9,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(AppImages.dogsPic),
                  radius: 40,
                ),
                Container(
                  width: screenSize(context).width * .3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dera Jessica',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('Dog Walking')
                    ],
                  ),
                ),
                Container(
                  // width: screenSize(context).width * .3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Drop off time',
                        style: TextStyle(fontSize: 10),
                      ),
                      Text('4pm')
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Time per Sitting: 3hrs',
                  style: TextStyle(fontSize: 10),
                ),
                Text('Time remaining per sitting: 2hrs',
                    style: TextStyle(fontSize: 10)),
                SizedBox(width: 8),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(100)),
                    child: ImageView.svg(AppImages.gift)),
                Container(
                  width: screenSize(context).width * .2,
                  height: 4,
                  color: Colors.blue,
                ),
                Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(100)),
                    child: ImageView.svg(AppImages.ticket)),
                Container(
                  width: screenSize(context).width * .2,
                  height: 4,
                  color: Colors.blue,
                ),
                Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(100)),
                    child: ImageView.svg(AppImages.tag)),
                Container(
                  width: screenSize(context).width * .2,
                  height: 4,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          Colors.blue,
                          Colors.grey.shade400,
                          Colors.grey.shade400,
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        stops: [0.3, 0.4, 1.0]),
                  ),
                ),
                Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(100)),
                    child: ImageView.svg(AppImages.checked)),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Contact dog walker',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: screenSize(context).width * .13,
                  child: ButtonView(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    borderColor: Colors.red,
                    borderWidth: 2,
                    color: Colors.white,
                    onPressed: () {},
                    child: Icon(
                      Icons.call_outlined,
                      color: Colors.red,
                      size: 20,
                    ),
                    borderRadius: 100,
                  ),
                ),
                Container(
                  width: screenSize(context).width * .13,
                  child: ButtonView(
                    borderColor: Colors.green,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    borderWidth: 2,
                    color: Colors.white,
                    onPressed: () {},
                    child: Icon(
                      Icons.chat,
                      color: Colors.green,
                      size: 20,
                    ),
                    borderRadius: 100,
                  ),
                ),
                Container(
                  width: screenSize(context).width * .13,
                  child: ButtonView(
                    borderColor: Colors.purple,
                    borderWidth: 2,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    color: Colors.white,
                    onPressed: () {},
                    child: Icon(
                      Icons.video_call,
                      color: Colors.purple,
                      size: 20,
                    ),
                    borderRadius: 100,
                  ),
                ),
                Container(
                  width: screenSize(context).width * .23,
                  child: ButtonView(
                    color: Colors.blue,
                    onPressed: () {},
                    child: Text(label),
                    borderRadius: 30,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

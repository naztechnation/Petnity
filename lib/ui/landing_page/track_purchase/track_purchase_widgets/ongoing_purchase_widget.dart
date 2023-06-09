import 'package:flutter/material.dart';

import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_images.dart';

import 'package:petnity/ui/widgets/button_view.dart';

class OngoingPurchaseWidget extends StatelessWidget {
  const OngoingPurchaseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: screenSize(context).height * .32,
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
                        'Pet type',
                        style: TextStyle(fontSize: 13),
                      ),
                      Text(
                        'Dog',
                        style: TextStyle(fontSize: 12),
                      )
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
              height: 20,
            ),
            LinearProgressIndicator(
              value: 0.5, // Represents the progress value (from 0.0 to 1.0)
              minHeight: 8, // Adjust the height of the progress line
              backgroundColor: Colors.grey[300], // Color of the remaining line
              valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.blue), // Color of the progress line
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Contact Seller',
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
                    child: Text('Details'),
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

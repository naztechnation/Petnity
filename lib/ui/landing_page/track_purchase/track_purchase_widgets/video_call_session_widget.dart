import 'package:flutter/material.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_images.dart';

import 'package:petnity/ui/widgets/button_view.dart';

class VideoCallSessionWidget extends StatelessWidget {
  const VideoCallSessionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: screenSize(context).height * .3,
        width: screenSize(context).width * .9,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(AppImages.dogsPic),
                  radius: 40,
                ),
                Container(
                  width: screenSize(context).width * .2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text('John Doe'), Text('Vet')],
                  ),
                ),
                Container(
                  // width: screenSize(context).width * .3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Session time',
                        style: TextStyle(fontSize: 10),
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.schedule, size: 12),
                              SizedBox(width: 4),
                              Text('6pm', style: TextStyle(fontSize: 10)),
                            ],
                          ),
                          SizedBox(width: 8),
                          Row(
                            children: [
                              Icon(Icons.calendar_today, size: 10),
                              SizedBox(width: 4),
                              Text('02-06-2023',
                                  style: TextStyle(fontSize: 10)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Session time: 2hrs',
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(width: 25),
                Text('Session type', style: TextStyle(fontSize: 12)),
                SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: EdgeInsets.all(5.0),
                  child: Row(
                    children: [
                      Text('Video call',
                          style: TextStyle(fontSize: 12, color: Colors.blue)),
                      Icon(
                        Icons.video_call,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ButtonView(
                child: Text('Details'),
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}

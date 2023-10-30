import 'package:flutter/material.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_images.dart';
import 'package:petnity/res/app_strings.dart';

import 'package:petnity/ui/widgets/button_view.dart';
import 'package:petnity/ui/widgets/custom_text.dart';

class VideoCallSessionWidget extends StatelessWidget {
  final String buttonText;
  const VideoCallSessionWidget({super.key, this.buttonText = 'Details'});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: screenSize(context).width * .9,
        margin:
            EdgeInsets.symmetric(horizontal: screenSize(context).width * .04),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(AppImages.dogsPic),
                  radius: 30,
                ),
                Container(
                  width: screenSize(context).width * .2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: 'John Doe',
                        size: 14,
                        weight: FontWeight.bold,
                      ),
                      CustomText(
                        text: 'Vet',
                        size: 13,
                      )
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: 'Session time',
                        size: 10,
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: Text(
                    'Session time: 2hrs',
                    style: TextStyle(
                        fontSize: 12, fontFamily: AppStrings.interSans),
                  ),
                ),
                SizedBox(width: 5),
                Text('Session type',
                    style: TextStyle(
                        fontSize: 12, fontFamily: AppStrings.interSans)),
                SizedBox(width: 5),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.3),
                borderRadius: BorderRadius.circular(15),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Video call',
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.blue,
                          fontFamily: AppStrings.interSans)),
                SizedBox(width: 12),

                  Icon(
                    Icons.video_call,
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 0),
              child: ButtonView(
                borderRadius: 30,
                child: CustomText(
                  text: buttonText,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}

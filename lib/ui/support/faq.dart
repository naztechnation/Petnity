import 'package:flutter/material.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_images.dart';
import 'package:petnity/ui/widgets/image_view.dart';

class FAQs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.lightBackground,
      appBar: PreferredSize(
        preferredSize: screenSize(context) * .1,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: AppBar(
            elevation: 0,
            backgroundColor: AppColors.lightBackground,
            leading: InkWell(
              child: ImageView.svg(AppImages.backButton),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              'FAQs',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'FAQs',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Icon(
                      Icons.circle,
                      color: Colors.blue,
                    ),
                  ),
                  Text('Lorem Ipsum dolor cedit my nig'),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Answer',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: screenSize(context).width * .9,
              child: Text(
                'All plans come with integrations for  Slack & Microsoft Teams in order to cut down on pings, limit distractions and make the tools even more powerful. Business and Enterprise customers get access to Jira, GitHub & Okta integrations.',
                textAlign: TextAlign.justify,
              ),
            )
          ],
        ),
      ),
    );
  }
}

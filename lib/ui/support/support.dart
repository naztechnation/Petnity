import 'package:flutter/material.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_images.dart';
import 'package:petnity/ui/settings/card_details.dart';
import 'package:petnity/ui/settings/update_successful_page.dart';
import 'package:petnity/ui/support/live_support_chat.dart';
import 'package:petnity/ui/support/report_a_vendor.dart';
import 'package:petnity/ui/support/report_an_issue.dart';
import 'package:petnity/ui/widgets/button_view.dart';
import 'package:petnity/ui/widgets/image_view.dart';
import 'report_a_bug.dart';

class Support extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: screenSize(context).height * .1,
        width: screenSize(context).width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: screenSize(context).width * .5,
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.email),
                title: Text('Email'),
                subtitle: Text(
                  'myexampleemail@sample.com',
                  style: TextStyle(fontSize: 13),
                ),
              ),
            ),
            Container(
              height: screenSize(context).height * .06,
              color: Colors.black.withOpacity(0.5),
              width: 3,
            ),
            Container(
              width: screenSize(context).width * .35,
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.call),
                title: Text('Number'),
                subtitle: Text(
                  '09150515270',
                  style: TextStyle(fontSize: 13),
                ),
              ),
            )
          ],
        ),
      ),
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.lightBackground,
      appBar: PreferredSize(
        preferredSize: screenSize(context) * .08,
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
              'Support',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        width: screenSize(context).width,
        height: screenSize(context).height * .9,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: screenSize(context).width * .5,
                height: screenSize(context).height * .2,
                color: Colors.red,
              ),
              Container(
                margin: EdgeInsets.all(10),
                width: screenSize(context).width * .6,
                child: ButtonView(
                    expanded: false,
                    borderColor: Colors.transparent,
                    color: Colors.blue.withOpacity(0.2),
                    onPressed: () {
                      Navigator.pushNamed(context, 'liveSupport');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.message,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Live Chat',
                          style: TextStyle(color: Colors.blue),
                        )
                      ],
                    )),
              ),
              InkWell(
                onTap: () => Navigator.pushNamed(context, 'reportIssue'),
                child: Container(
                  width: screenSize(context).width * .9,
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Icon(
                          Icons.edit_document,
                        ),
                      ),
                      Text('Report an issue'),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () => Navigator.pushNamed(context, 'reportBug'),
                child: Container(
                  width: screenSize(context).width * .9,
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Icon(
                          Icons.file_copy,
                        ),
                      ),
                      Text('Report a bug'),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () => Navigator.pushNamed(context, 'reportVendor'),
                child: Container(
                  width: screenSize(context).width * .9,
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Icon(
                          Icons.file_copy,
                        ),
                      ),
                      Text('Report a vendor'),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: screenSize(context).width,
                padding: EdgeInsets.all(5),
                child: Text(
                  'FAQs',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                height: screenSize(context).height * .28,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.circle,
                        color: Colors.blue,
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                      title: Text(
                        'Lorem Ipsum dolor cedit something',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.circle,
                        color: Colors.yellow,
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                      title: Text(
                        'Lorem Ipsum dolor cedit something',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.circle,
                        color: Colors.red,
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                      title: Text(
                        'Lorem Ipsum dolor cedit something',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.circle,
                        color: Colors.green,
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                      title: Text(
                        'Lorem Ipsum dolor cedit something',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              )
            ],
          ),
        ),
      ),
    );
  }
}

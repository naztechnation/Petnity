import 'package:flutter/material.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_images.dart';
import 'package:petnity/res/app_strings.dart';
import 'package:petnity/ui/widgets/back_button.dart';
import 'package:petnity/ui/widgets/button_view.dart';
import 'package:petnity/ui/widgets/image_view.dart';

import '../widgets/custom_text.dart';

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
                leading: Icon(Icons.email_outlined),
                title: CustomText(
                  text: 'Email',
                  fontFamily: AppStrings.interSans,
                ),
                subtitle: CustomText(
                  text: 'myexampleemail@sample.com',
                  fontFamily: AppStrings.interSans,
                  size: 13,
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
                title: CustomText(
                  text: 'Number',
                  fontFamily: AppStrings.interSans,
                ),
                subtitle: CustomText(
                  text: '09150515270',
                  fontFamily: AppStrings.interSans,
                  size: 13,
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
            leading: backButton(context),
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
                child: ImageView.asset(AppImages.supportPic),
              ),
              Container(
                margin: EdgeInsets.all(10),
                width: screenSize(context).width * .6,
                child: ButtonView(
                    expanded: false,
                    borderRadius: 30,
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
                        size: 16,
                        color: Colors.blue,
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                      ),
                      title: Text(
                        'Lorem Ipsum dolor cedit something',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.circle,
                        size: 16,
                        color: Colors.yellow,
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                      ),
                      title: Text(
                        'Lorem Ipsum dolor cedit something',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.circle,
                        color: Colors.red,
                        size: 16,
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                      ),
                      title: Text(
                        'Lorem Ipsum dolor cedit something',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.circle,
                        color: Colors.green,
                        size: 16,
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                      ),
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

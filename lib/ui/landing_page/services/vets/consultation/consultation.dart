import 'package:flutter/material.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/enum.dart';
import 'package:petnity/ui/landing_page/services/vets/consultation/sessionDuration.dart';
import 'package:petnity/ui/widgets/back_button.dart';
import 'package:petnity/ui/widgets/button_view.dart';
import 'package:petnity/utils/navigator/page_navigator.dart';

class Consultation extends StatefulWidget {
  @override
  State<Consultation> createState() => _ConsultationState();
}

class _ConsultationState extends State<Consultation> {
  bool chat = false;

  bool call = false;

  bool video = false;
  var type;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(
        leading: backButton(context),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Vets',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: 'InterSans'),
        ),
      ),
      bottomNavigationBar: Container(
        height: screenSize(context).height * .13,
        padding: EdgeInsets.symmetric(vertical: 23, horizontal: 20),
        child: ButtonView(
            borderRadius: 50,
            onPressed: () {
              AppNavigator.pushAndStackPage(context, page: SessionDuration());
            },
            child: Text('Select')),
      ),
      body: Container(
        height: screenSize(context).height * .9,
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              width: screenSize(context).width,
              child: Text(
                'Select session medium',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'InterSans'),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                type = sessionMedium.chat;
                setState(() {
                  chat = true;
                  call = false;
                  video = false;
                });
              },
              child: Container(
                height: screenSize(context).height * .07,
                width: screenSize(context).width * .9,
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: chat ? Colors.blue : Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Chat',
                      style: TextStyle(
                          color: chat ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'InterSans'),
                    ),
                    Icon(
                      Icons.message,
                      color: chat ? Colors.white : Colors.black,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                type = sessionMedium.call;
                setState(() {
                  chat = false;
                  call = true;
                  video = false;
                });
              },
              // onTap: () =>
              // AppNavigator.pushAndStackPage(context, page: Treatment()),
              child: Container(
                height: screenSize(context).height * .07,
                width: screenSize(context).width * .9,
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: call ? Colors.blue : Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Voice call',
                      style: TextStyle(
                          color: call ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'InterSans'),
                    ),
                    Icon(
                      Icons.phone,
                      color: call ? Colors.white : Colors.black,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                type = sessionMedium.video;
                setState(() {
                  chat = false;
                  call = false;
                  video = true;
                });
              },
              child: Container(
                height: screenSize(context).height * .07,
                width: screenSize(context).width * .9,
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: video ? Colors.blue : Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Video',
                      style: TextStyle(
                          color: video ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'InterSans'),
                    ),
                    Icon(
                      Icons.video_call,
                      color: video ? Colors.white : Colors.black,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

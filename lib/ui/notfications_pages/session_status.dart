import 'dart:io';

import 'package:flutter/material.dart';
import 'package:petnity/ui/notfications_pages/session_details.dart';
import 'package:petnity/ui/widgets/button_view.dart';
import 'package:petnity/utils/navigator/page_navigator.dart';

import '../../res/app_colors.dart';
import '../../res/app_constants.dart';
import '../../res/app_images.dart';
import '../../res/app_strings.dart';
import '../widgets/back_button.dart';
import '../widgets/custom_text.dart';
import 'chat_pages/chat_page.dart';
import 'widgets/requests_content.dart';

class SessionStatusScreen extends StatelessWidget {
  const SessionStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: screenSize(context).height,
        width: screenSize(context).width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [AppColors.scaffoldColor, Colors.red.shade50],
                begin: Alignment.topRight,
                end: Alignment.topLeft)),
        child: SingleChildScrollView(
            child: Column(
          children: [
            SafeArea(child: SizedBox(height: (Platform.isAndroid) ? 44 : 0)),
            Row(
              children: [
                backButton(context),
                const SizedBox(
                  width: 40,
                ),
                CustomText(
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  text: 'Session status',
                  weight: FontWeight.w700,
                  size: 22,
                  fontFamily: AppStrings.interSans,
                  color: Colors.black,
                ),
              ],
            ),
            SizedBox(
              height: 22,
            ),
            RequestsContent(
              isChat: false,
              isRequestAccepted: true,
              dontShow: true,
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Container(
                width: screenSize(context).width,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(41),
                  color: Colors.green.shade50,
                ),
                child: Center(
                  child: Text(
                    'Accepted',
                    style: TextStyle(
                        color: Colors.green[900],
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: [
                  Container(
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                        color: Color(0xFFEBF0FF), shape: BoxShape.circle),
                    child: Image.asset(AppImages.important),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  CustomText(
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    text: 'NOTE',
                    weight: FontWeight.w700,
                    size: 14,
                    fontFamily: AppStrings.interSans,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0),
              child: CustomText(
                textAlign: TextAlign.justify,
                maxLines: 4,
                text:
                    'Your dog walking session purchase has been accepted by the service provider, a notification would be sent to you an hour before the  drop off time',
                weight: FontWeight.w500,
                size: 16,
                fontFamily: AppStrings.interSans,
                color: Colors.black,
              ),
            ),
          ],
        )),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [AppColors.scaffoldColor, Colors.red.shade50],
                begin: Alignment.topRight,
                end: Alignment.topLeft)),
        height: 200,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          GestureDetector(
            onTap: () {
                AppNavigator.pushAndStackPage(context, page: SessionDetailsScreen());
              
            },
            child: CustomText(
              textAlign: TextAlign.center,
              maxLines: 4,
              text: 'Go to session',
              weight: FontWeight.w700,
              size: 20,
              fontFamily: AppStrings.interSans,
              color: AppColors.lightSecondary,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: ButtonView(
              onPressed: () {
                AppNavigator.pushAndStackPage(context, page: ChatPage(userImage: '', username: '', uid: '',));
              },
              expanded: true,
              borderRadius: 41,
              child: Text(
                'Send a message',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 18),
              ),
              color: AppColors.lightSecondary,
            ),
          ),
          SizedBox(
            height: 30,
          ),
        ]),
      ),
    );
  }
}

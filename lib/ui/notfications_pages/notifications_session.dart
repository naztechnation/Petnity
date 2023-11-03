import 'dart:io';

import 'package:flutter/material.dart';
import 'package:petnity/ui/notfications_pages/session_status.dart';
import 'package:petnity/utils/navigator/page_navigator.dart';

import '../../res/app_colors.dart';
import '../../res/app_constants.dart';
import '../../res/app_strings.dart';
import '../../res/enum.dart';
import '../widgets/back_button.dart';
import '../widgets/custom_text.dart';
import 'chat_pages/chat_page.dart';
import 'widgets/requests_content.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  FilterStatus status = FilterStatus.request;

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
                  text: 'Notifications',
                  weight: FontWeight.w700,
                  size: 22,
                  fontFamily: AppStrings.interSans,
                  color: Colors.black,
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () => AppNavigator.pushAndStackPage(context,
                              page: SessionStatusScreen()),
                          child: RequestsContent(
                            isChat: false,
                            isRequestAccepted: true,
                          ));
                    },
                  ),
            ),
            // Container(
            //   alignment: Alignment.center,
            //   width: screenSize(context).width * 0.9,
            //   height: 50,
            //   decoration: BoxDecoration(
            //     color: AppColors.lightPrimary,
            //     borderRadius: BorderRadius.circular(20),
            //   ),
            //   child: 
              
            //   Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Expanded(
            //         child: GestureDetector(
            //           onTap: () {
            //             setState(() {
            //               status = FilterStatus.request;
            //             });
            //           },
            //           child: Padding(
            //             padding: EdgeInsets.only(
            //                 left: status == FilterStatus.request ? 10 : 0,
            //                 right: status == FilterStatus.chats ? 10 : 0),
            //             child: tabHeader(FilterStatus.request,
            //                 status == FilterStatus.request, false),
            //           ),
            //         ),
            //       ),
            //       Flexible(
            //         child: GestureDetector(
            //           onTap: () {
            //             setState(() {
            //               status = FilterStatus.chats;
            //             });
            //           },
            //           child: Padding(
            //             padding: EdgeInsets.only(
            //                 left: status == FilterStatus.request ? 10 : 0,
            //                 right: status == FilterStatus.chats ? 10 : 0),
            //             child: tabHeader(
            //                 FilterStatus.chats,
            //                 status == FilterStatus.chats,
            //                 status == FilterStatus.chats),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // SizedBox(
            //   height: 20,
            // ),
            // if (status == FilterStatus.request) ...[
            //   Expanded(
            //     child: ListView.builder(
            //       shrinkWrap: true,
            //       itemCount: 6,
            //       itemBuilder: (context, index) {
            //         return GestureDetector(
            //             onTap: () => AppNavigator.pushAndStackPage(context,
            //                 page: SessionStatusScreen()),
            //             child: RequestsContent(
            //               isChat: false,
            //               isRequestAccepted: true,
            //             ));
            //       },
            //     ),
            //   )
            // ] else ...[
            //   Expanded(
            //     // height: screenSize(context).height * 0.6,
            //     child: ListView.builder(
            //       shrinkWrap: true,
            //       itemCount: 6,
            //       itemBuilder: (context, index) {
            //         return GestureDetector(
            //           onTap: () => AppNavigator.pushAndStackPage(context,
            //               page: ChatPage(userImage: '', username: '', uid: '',)),
            //           child: RequestsContent(
            //             isChat: true,
            //             isRequestAccepted: false,
            //           ),
            //         );
            //       },
            //     ),
            //   )
            // ]
          ],
        ),
      ),
    );
  }
}

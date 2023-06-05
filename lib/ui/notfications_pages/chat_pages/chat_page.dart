import 'dart:io';

import 'package:flutter/material.dart';
import 'package:petnity/ui/widgets/image_view.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_constants.dart';
import '../../../res/app_images.dart';
import '../../../res/app_strings.dart';
import '../../../res/app_theme.dart';
import '../../widgets/back_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/profile_image.dart';
import 'widget/message_tile.dart';

class ChatPage extends StatefulWidget {
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController messageController = TextEditingController();
  final _scrollController = ScrollController();
  String admin = "";

  @override
  void initState() {
    Future.delayed(
        const Duration(
          seconds: 1,
        ), () {
      _scrollDown();
    });
    super.initState();
  }

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
          children: <Widget>[
            SafeArea(child: SizedBox(height: (Platform.isAndroid) ? 34 : 0)),
            Container(
              width: screenSize(context).width,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  backButton(context),
                  const SizedBox(
                    width: 19,
                  ),
                  ProfileImage(
                    placeHolder: AppImages.person,
                    '',
                    height: 80,
                    width: 80,
                    radius: 23,
                  ),
                  const SizedBox(
                    width: 19,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        text: 'Sarah jhay',
                        weight: FontWeight.w700,
                        size: 14,
                        fontFamily: AppStrings.interSans,
                        color: Colors.black,
                      ),
                      CustomText(
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        text: 'online',
                        weight: FontWeight.w500,
                        size: 14,
                        fontFamily: AppStrings.interSans,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 30.0),
                    child: ImageView.svg(AppImages.phoneIcon),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: chatMessages(),
            ),
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [AppColors.scaffoldColor, Colors.red.shade50],
                      begin: Alignment.topRight,
                      end: Alignment.topLeft)),
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: Row(
                  children: <Widget>[
                    Expanded(
                        flex: 1,
                        child: Icon(
                          Icons.attach_file,
                          color: AppColors.lightSecondary,
                        )),
                    Expanded(
                      flex: 8,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30)),
                        child: TextField(
                          controller: messageController,
                          decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 22),
                              hintText: "Type a message...",
                              hintStyle: TextStyle(
                                  color: AppTheme.lightTheme.dividerColor),
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: FloatingActionButton(
                        mini: true,
                        isExtended: false,
                        onPressed: () {
                          sendMessage();
                        },
                        backgroundColor: AppColors.lightSecondary,
                        elevation: 0,
                        child: const Icon(
                          Icons.send,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            )
          ],
        ),
      ),
    );
  }

  void _scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(microseconds: 200),
      curve: Curves.easeOut,
    );
  }

  chatMessages() {
    // return ListView.builder(
    //         controller: _scrollController,
    //         shrinkWrap: true,
    //         itemCount: 4,
    //         itemBuilder: (context, index) {
    //           return MessageTile(
    //               message: 'I am coming right now',
    //               sender: 'Steve',
    //               timeStamp: 12,
    //               sentByMe: false);
    //         },
    //       )
    //    ;

    return ListView(
      children: [
        MessageTile(
            message: 'Heyyy whats good',
            sender: 'Steve',
            timeStamp: 12,
            sentByMe: false),
        MessageTile(
            message: 'Im chill',
            sender: 'Steve',
            timeStamp: 12,
            sentByMe: true),
        MessageTile(
            message: 'Hows your day rolling out',
            sender: 'Steve',
            timeStamp: 12,
            sentByMe: true),
        MessageTile(
            message:
                'Yeah my days going quite amazing had the best news for this year today',
            sender: 'Steve',
            timeStamp: 12,
            sentByMe: false),
        MessageTile(
            message: 'Yeess', sender: 'true', timeStamp: 12, sentByMe: true)
      ],
    );
  }

  sendMessage() {
    Future.delayed(const Duration(milliseconds: 50)).then((_) => _scrollDown());

    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "message": messageController.text,
        "sender": '',
        "uid": '',
        "time": DateTime.now().millisecondsSinceEpoch,
      };

      messageController.clear();
    }
  }
}

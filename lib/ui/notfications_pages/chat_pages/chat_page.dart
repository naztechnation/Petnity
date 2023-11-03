import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petnity/extentions/custom_string_extension.dart';
import 'package:petnity/ui/widgets/image_view.dart';
import 'package:petnity/utils/navigator/page_navigator.dart';
import 'package:provider/provider.dart';
import '../../../model/chat_model/chat.dart';
import '../../../model/view_models/account_view_model.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_constants.dart';
import '../../../res/app_images.dart';
import '../../../res/app_strings.dart';
import '../../../res/app_theme.dart';
import '../../constants/encryption.dart';
import '../../constants/firebase_constants.dart';
import '../../video.dart';
import '../../widgets/back_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/profile_image.dart';
import 'widget/message_tile.dart';

class ChatPage extends StatefulWidget {
  final String username;
  final String userImage;
  final String uid;

  const ChatPage(
      {super.key,
      required this.username,
      required this.userImage,
      required this.uid});
  @override
  State<ChatPage> createState() => _ChatPageState(username, userImage, uid);
}

class _ChatPageState extends State<ChatPage> {
  final String username;
  final String userImage;
  final String uid;

  TextEditingController messageController = TextEditingController();
  final _scrollController = ScrollController();
  String admin = "";

  String groupChatId = "";
  String currentUserId = "";
  String peerId = "";

  _ChatPageState(this.username, this.userImage, this.uid);

  @override
  void initState() {
    updateOnlineStatus(true);

    generateGroupId();
    Future.delayed(
        const Duration(
          seconds: 1,
        ), () {
      _scrollDown();
    });
    super.initState();
  }

  @override
  void dispose() {
    messageController.dispose();
    updateOnlineStatus(false);
    super.dispose();
  }

  generateGroupId() {
    currentUserId = FirebaseAuth.instance.currentUser!.uid;
    peerId = widget.uid;

    if (currentUserId.compareTo(peerId) > 0) {
      groupChatId = '$currentUserId-$peerId';
    } else {
      groupChatId = '$peerId-$currentUserId';
    }

    updateDataFirestore(
      FirestoreConstants.pathUserCollection,
      currentUserId,
      {FirestoreConstants.chattingWith: peerId},
    );
  }

  Future<void> updateDataFirestore(String collectionPath, String docPath,
      Map<String, dynamic> dataNeedUpdate) {
    return FirebaseFirestore.instance
        .collection(collectionPath)
        .doc(docPath)
        .update(dataNeedUpdate);
  }

  sendChat({required String messaage}) async {
    final String encmess =
        Encryption().encryption(messaage, "1234567891234567");
    MessageChat chat = MessageChat(
        content: messaage,
        idFrom: currentUserId,
        idTo: peerId,
        timestamp: FieldValue.serverTimestamp());

    await FirebaseFirestore.instance
        .collection("groupMessages")
        .doc(groupChatId)
        .collection("messages")
        .add(chat.toJson());

    messageController.text = "";
    //
  }

  Future<bool> onBackPress() {
    updateOnlineStatus(false);

    updateDataFirestore(
      FirestoreConstants.pathUserCollection,
      currentUserId,
      {FirestoreConstants.chattingWith: null},
    );
    Navigator.pop(context);

    return Future.value(false);
  }

  Future<void> updateOnlineStatus(bool isOnline) async {
    try {
      final _firebaseAuth = FirebaseAuth.instance;
      final _firebaseStorage = FirebaseFirestore.instance;
      final currentUserUid = _firebaseAuth.currentUser!.uid;

      await _firebaseStorage.collection('users').doc(currentUserUid).set(
        {
          'online': isOnline,
        },
        SetOptions(merge: true),
      );
    } catch (e) {
      print("Error updating online status: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AccountViewModel>(context, listen: true);

    return WillPopScope(
      onWillPop: onBackPress,
      child: Scaffold(
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
              SafeArea(child: SizedBox(height: (Platform.isAndroid) ? 20 : 0)),
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
                      '$userImage',
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
                          text: '$username'.capitalizeFirstOfEach,
                          weight: FontWeight.w700,
                          size: 14,
                          fontFamily: AppStrings.interSans,
                          color: Colors.black,
                        ),
                        StreamBuilder<bool>(
                          stream: listenToOnlineStatus(
                               uid),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Text('Loading...');
                            }
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            }
                            final isOnline = snapshot.data ?? false;
                            final statusText = isOnline ? 'Online' : 'Offline';
                            return CustomText(
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              text: '$statusText',
                              weight: FontWeight.w500,
                              size: 14,
                              fontFamily: AppStrings.interSans,
                              color: Colors.grey,
                            );
                          },
                        ),
                      ],
                    ),
                    Spacer(),
                    Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 15),
                      margin: const EdgeInsets.only(right: 20.0),
                      decoration: BoxDecoration(
                          color: AppColors.lightPrimary,
                          borderRadius: BorderRadius.circular(30)),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 14.0),
                            child: ImageView.svg(AppImages.phoneIcon),
                          ),
                          GestureDetector(
                              onTap: (() {
                                AppNavigator.pushAndStackPage(context,
                                    page: VideoCall(user1: username, user2: user.username,));
                              }),
                              child: ImageView.svg(AppImages.videoIcon)),
                        ],
                      ),
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
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("groupMessages")
            .doc(groupChatId)
            .collection("messages")
            .orderBy(FirestoreConstants.timestamp, descending: false)
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            reverse: false,
            shrinkWrap: true,
            controller: _scrollController,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              MessageChat chat =
                  MessageChat.fromDocument(snapshot.data!.docs[index]);

              return MessageTile(
                  message: chat.content,
                  sender: username,
                  timeStamp: 0,
                  sentByMe: chat.idFrom == currentUserId ? true : false);
            },
          );
        });
  }

  sendMessage() {
    Future.delayed(const Duration(milliseconds: 50)).then((_) => _scrollDown());

    if (messageController.text.isNotEmpty) {
      sendChat(messaage: messageController.text);
      messageController.text = "";
      _scrollDown();
      FocusManager.instance.primaryFocus?.unfocus();

      messageController.clear();
    }
  }

  Stream<bool> listenToOnlineStatus(String uid) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists) {
        return snapshot.data()?['online'] ?? false;
      } else {
        return false;
      }
    });
  }
}

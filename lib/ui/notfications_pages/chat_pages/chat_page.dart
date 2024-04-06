import 'dart:math';

import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petnity/extentions/custom_string_extension.dart';
import 'package:petnity/handlers/secure_handler.dart';
import 'package:provider/provider.dart';
import '../../../blocs/chats/chat.dart';
import '../../../model/view_models/chat_controller.dart';
import '../../../requests/repositories/account_repo/account_repository_impl.dart';
import '../../../res/app_colors.dart';  
import '../../../res/app_constants.dart';

import '../../../res/app_images.dart';
import '../../../res/app_strings.dart';
import '../../widgets/back_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/profile_image.dart';
 

class ChatPage extends StatelessWidget {
  final String customerName;
  final String agentName;

  final String userImage;
  final String orderId;
  final String agentId;

  const ChatPage(
      {super.key,
      required this.customerName,
      required this.agentName,
      required this.userImage,
      required this.agentId,
      required this.orderId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChatCubit>(
      create: (BuildContext context) => ChatCubit(
          accountRepository: AccountRepositoryImpl(),
          viewModel: Provider.of<MessageController>(context, listen: false)),
      child: Chat(
        agentName: agentName,
        agentId: agentId,
        orderId: orderId,
        customerName: customerName,
        userImage: userImage,
      ),
    );
  }
}

class Chat extends StatefulWidget {
  final String customerName;
  final String agentName;

  final String userImage;
  final String orderId;
  final String agentId;

  const Chat(
      {super.key,
      required this.customerName,
      required this.agentName,
      required this.userImage,
      required this.agentId,
      required this.orderId});
  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  TextEditingController messageController = TextEditingController();
  late ChatCubit _chatCubit;

  final _scrollController = ScrollController();
  String admin = "";
  String userType = "";

  String groupChatId = "";
  String currentUserId = "";
  String peerId = "";

  bool isSender = false;
  String userId = "";

  getUserType() async {
    userType = await StorageHandler.getUserType();
    if (userType == 'user') {
      isSender = true;
      userId = await StorageHandler.getUserId();
    } else {
      isSender = false;
      userId = await StorageHandler.getAgentId();

       
    }
    _chatCubit = context.read<ChatCubit>();

    setState(() {
      _chatCubit.viewModel.updateRecieverDetails(
          receiverId: isSender ? widget.orderId : widget.agentId,
          receiverImage: isSender ? '' : '',
          receiverName: isSender ? widget.customerName : widget.agentName);

      // _chatCubit.viewModel.selectedKey = '';
    });
  }

  @override
  void initState() {
    getUserType();

    super.initState();
  }

  @override
  void dispose() {
    messageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final msgCntrl = Provider.of<MessageController>(context, listen: true);

    
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 55,
        leading: backButton(context),
        title: Row(
          children: [
            ProfileImage(
              placeHolder: AppImages.person,
              '${widget.userImage}',
              height: 80,
              width: 80,
              radius: 23,
            ),
            const SizedBox(
              width: 10,
            ),
            CustomText(
              textAlign: TextAlign.center,
              maxLines: 2,
              text: (userType == 'user')
                  ? '${widget.agentName.toString().capitalizeFirstOfEach}'
                  : '${widget.customerName.capitalizeFirstOfEach}',
              weight: FontWeight.w700,
              size: 14,
              fontFamily: AppStrings.interSans,
              color: Colors.black,
            ),
          ],
        ),
      ),
      body: Container(
        height: screenSize(context).height,
        width: screenSize(context).width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [AppColors.scaffoldColor, Colors.red.shade50],
                begin: Alignment.topRight,
                end: Alignment.topLeft)),
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 70, top: 5),
              child: FirebaseAnimatedList(
                  reverse: true,
                  sort: (DataSnapshot a, DataSnapshot b) =>
                      b.key!.compareTo(a.key!),
                  query: msgCntrl.dbChatMessage.child(msgCntrl.selectedKey),
                  controller: _scrollController,
                  itemBuilder: (context, snapshot, counter, index) {
                    bool isUser =
                        snapshot.child('senderId').value.toString() == userId ;

                    
                    bool isImage =
                        snapshot.child('isImage').value.toString() == "true";

                    return isImage
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              BubbleNormalImage(
                                id: DateTime.now()
                                    .millisecondsSinceEpoch
                                    .toString(),
                                image: Image.network(
                                    snapshot.child('message').value.toString()),
                                // color: Color(0xFF1B97F3),
                                color: isUser
                                    ? Colors.yellow
                                    : Colors.purple[200]!,
                                isSender: isUser,
                                sent: true,
                                seen: true,
                                tail: false,
                              ),
                              // Container(
                              //   alignment: isUser
                              //       ? Alignment.centerRight
                              //       : Alignment.centerLeft,
                              //   margin: const EdgeInsets.only(
                              //       right: 20, bottom: 2, top: 0),
                              //   child: Text(
                              //       '${int.parse(snapshot.child('time').value.toString()).abs()}',

                              //   ),
                              // ),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                             BubbleSpecialThree(
                                text:
                                    snapshot.child('message').value.toString(),
                                color: isUser
                                    ? AppColors.lightSecondary
                                    : Colors.white,
                                isSender: isUser,
                                textStyle: TextStyle(
                                    color:
                                        isUser ? Colors.white : Colors.black54,
                                    fontSize: 16),
                                tail: false,
                              )
                            ],
                          );
                  }),
            ),
            MessageBar(
              replyIconColor: AppColors.lightSecondary,
              sendButtonColor: AppColors.lightSecondary,
              onSend: (val) {
                Future.delayed(const Duration(milliseconds: 50))
                    .then((_) => _scrollDown());

                msgCntrl.sendChatMessages(
                    orderId: widget.orderId,
                    receiverId: widget.agentId,
                    message: msgCntrl.messageText.trim(),
                    senderName: userType == 'user'
                        ? widget.customerName
                        : widget.agentName);
              },
              onTextChanged: (txt) {
                msgCntrl.messageText = txt;
              },
              actions: [
                InkWell(
                  child: Transform.rotate(
                    angle: pi / 2,
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: const Icon(
                        Icons.attach_file,
                        color: Colors.black,
                        size: 30,
                      ),
                    ),
                  ),
                  onTap: () {
                    msgCntrl.uploadImage(recieverId: widget.agentId, orderId: widget.orderId);
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8, right: 8),
                  child: InkWell(
                    child: Icon(
                      Icons.camera_alt,
                      color: AppColors.lightSecondary,
                      size: 24,
                    ),
                    onTap: () {
                      msgCntrl.uploadImage(recieverId: widget.agentId, orderId: widget.orderId, source: ImageSource.camera);
                    },
                  ),
                ),
              ],
            ),
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
}

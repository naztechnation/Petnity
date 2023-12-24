import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petnity/ui/notfications_pages/session_status.dart';
import 'package:petnity/utils/navigator/page_navigator.dart';
import 'package:provider/provider.dart';

import '../../blocs/user/user.dart';
import '../../handlers/secure_handler.dart';
import '../../model/user_models/notifications.dart';
import '../../model/view_models/user_view_model.dart';
import '../../requests/repositories/user_repo/user_repository_impl.dart';
import '../../res/app_colors.dart';
import '../../res/app_constants.dart';
import '../../res/app_strings.dart';
import '../../res/enum.dart';
import '../widgets/back_button.dart';
import '../widgets/custom_text.dart';
import '../widgets/loading_page.dart';
import '../widgets/modals.dart';
import 'chat_pages/chat_page.dart';
import 'tabs_header.dart';
import 'widgets/requests_content.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (BuildContext context) => UserCubit(
          userRepository: UserRepositoryImpl(),
          viewModel: Provider.of<UserViewModel>(context, listen: false)),
      child: Notifications(),
    );
  }
}

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  FilterStatus status = FilterStatus.request;

  late UserCubit _userCubit;

  List<NotificationsList> notifications = [];

  String username = "";

  getUserDetails() async {
    username = await StorageHandler.getUserName();
    _userCubit = context.read<UserCubit>();
    await _userCubit.getNotification(username: username);

    setState(() {});
  }

  Future<List<Message>> getChatMessages(
      String currentUserUid, String otherUserUid) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('messages')
        .where('senderId', whereIn: [currentUserUid, otherUserUid])
        .where('receiverId', whereIn: [currentUserUid, otherUserUid])
        .orderBy('timestamp', descending: false)
        .get();

    List<Message> messages = querySnapshot.docs
        .map((doc) => Message.fromMap(doc.data() as Map<String, dynamic>))
        .toList();

    return messages;
  }

  @override
  void initState() {
    getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<UserCubit, UserStates>(
        listener: (context, state) {
          if (state is NotificatonsLoaded) {
            if (state.notifications.status!) {
              Modals.showToast(state.notifications.message ?? '');

              setState(() {});
            } else {}
          } else if (state is UserNetworkErrApiErr) {
            Modals.showToast(state.message ?? '');
          } else if (state is UserNetworkErr) {
            Modals.showToast(state.message ?? '');
          }
        },
        builder: (context, state) => Container(
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
              // Container(
              //     alignment: Alignment.center,
              //     width: screenSize(context).width * 0.9,
              //     height: 50,
              //     decoration: BoxDecoration(
              //       color: AppColors.lightPrimary,
              //       borderRadius: BorderRadius.circular(20),
              //     ),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Expanded(
              //           child: GestureDetector(
              //             onTap: () {
              //               setState(() {
              //                 status = FilterStatus.request;
              //               });
              //             },
              //             child: Padding(
              //               padding: EdgeInsets.only(
              //                   left: status == FilterStatus.request ? 10 : 0,
              //                   right: status == FilterStatus.chats ? 10 : 0),
              //               child: tabHeader(FilterStatus.request,
              //                   status == FilterStatus.request, false),
              //             ),
              //           ),
              //         ),
              //         Flexible(
              //           child: GestureDetector(
              //             onTap: () {
              //               setState(() {
              //                 status = FilterStatus.chats;
              //               });
              //             },
              //             child: Padding(
              //               padding: EdgeInsets.only(
              //                   left: status == FilterStatus.request ? 10 : 0,
              //                   right: status == FilterStatus.chats ? 10 : 0),
              //               child: tabHeader(
              //                   FilterStatus.chats,
              //                   status == FilterStatus.chats,
              //                   status == FilterStatus.chats),
              //             ),
              //           ),
              //         ),
              //       ],
              //     )),

                  Expanded(
                    child: (state is NotificatonsLoading)
                        ? LoadingPage()
                        : (notifications.isEmpty)
                            ? Container(
                                height: 120,
                                margin: const EdgeInsets.all(12),
                                child: Align(
                                    child: Card(
                                  elevation: 0.5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Container(
                                    height: 90,
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Nothing to show in your notifications',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )))
                            : ListView.builder(
                                shrinkWrap: true,
                                itemCount: notifications.length,
                                itemBuilder: (context, index) {
                                  return

                                      // RequestsContent(
                                      //       isChat: false,
                                      //       isRequestAccepted: false, title: notifications[index].title ?? '', description: notifications[index].body ?? '',
                                      //     );

                                      GestureDetector(
                                          onTap: () =>
                                              AppNavigator.pushAndStackPage(
                                                  context,
                                                  page: SessionStatusScreen()),
                                          child: RequestsContent(
                                            isChat: false,
                                            isRequestAccepted: false,
                                            title: notifications[index].title ??
                                                '',
                                            description:
                                                notifications[index].body ?? '',
                                          ));
                                },
                              )),
              // if (status == FilterStatus.request) ...[
              //   Expanded(
              //       child: (state is NotificatonsLoading)
              //           ? LoadingPage()
              //           : (notifications.isEmpty)
              //               ? Container(
              //                   height: 200,
              //                   margin: const EdgeInsets.all(12),
              //                   child: Align(
              //                       child: Card(
              //                     elevation: 0.5,
              //                     shape: RoundedRectangleBorder(
              //                         borderRadius: BorderRadius.circular(20)),
              //                     child: Container(
              //                       height: 120,
              //                       child: Center(
              //                         child: Padding(
              //                           padding: const EdgeInsets.all(12.0),
              //                           child: Column(
              //                             mainAxisAlignment:
              //                                 MainAxisAlignment.center,
              //                             children: [
              //                               Text(
              //                                 'Nothing to show in your notifications',
              //                                 textAlign: TextAlign.center,
              //                                 style: TextStyle(
              //                                     color: Colors.black,
              //                                     fontSize: 15,
              //                                     fontWeight: FontWeight.w300),
              //                               ),
              //                               const SizedBox(
              //                                 height: 10,
              //                               ),
              //                             ],
              //                           ),
              //                         ),
              //                       ),
              //                     ),
              //                   )))
              //               : ListView.builder(
              //                   shrinkWrap: true,
              //                   itemCount: notifications.length,
              //                   itemBuilder: (context, index) {
              //                     return

              //                         // RequestsContent(
              //                         //       isChat: false,
              //                         //       isRequestAccepted: false, title: notifications[index].title ?? '', description: notifications[index].body ?? '',
              //                         //     );

              //                         GestureDetector(
              //                             onTap: () =>
              //                                 AppNavigator.pushAndStackPage(
              //                                     context,
              //                                     page: SessionStatusScreen()),
              //                             child: RequestsContent(
              //                               isChat: false,
              //                               isRequestAccepted: false,
              //                               title: notifications[index].title ??
              //                                   '',
              //                               description:
              //                                   notifications[index].body ?? '',
              //                             ));
              //                   },
              //                 )),
              // ] else ...[
              //   Expanded(
              //     child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              //       stream: FirebaseFirestore.instance
              //           .collection('messages')
              //           .where('receiverId',
              //               isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              //           .snapshots(),
              //       builder: (context, snapshot) {
              //         if (snapshot.connectionState == ConnectionState.waiting) {
              //           return Center(child: CircularProgressIndicator());
              //         }

              //         List<Message> messages = snapshot.data!.docs
              //             .map((doc) => Message.fromMap(
              //                 doc.data() as Map<String, dynamic>))
              //             .toList();

              //         return ListView.builder(
              //           shrinkWrap: true,
              //           itemCount: messages.length,
              //           itemBuilder: (context, index) {
              //             Message message = messages[index];

              //             return GestureDetector(
              //               onTap: () => AppNavigator.pushAndStackPage(
              //                 context,
              //                 page: ChatPage(
              //                   userImage: '',
              //                   username: '',
              //                   uid: '',
              //                 ),
              //               ),
              //               child: RequestsContent(
              //                 isChat: true,
              //                 isRequestAccepted: false,
              //                 title: 'Name',
              //                 description: message.content,
              //               ),
              //             );
              //           },
              //         );
              //       },
              //     ),
              //   )
              // ]
            ],
          ),
        ),
      ),
    );
  }
}

class Message {
  final String senderId;
  final String receiverId;
  final String content;
  final Timestamp timestamp;

  Message({
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.timestamp,
  });

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      senderId: map['senderId'],
      receiverId: map['receiverId'],
      content: map['content'],
      timestamp: map['timestamp'],
    );
  }
}

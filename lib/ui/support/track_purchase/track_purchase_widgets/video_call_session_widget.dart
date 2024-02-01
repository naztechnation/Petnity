import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:petnity/handlers/secure_handler.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_images.dart';
import 'package:petnity/res/app_strings.dart';

import 'package:petnity/ui/widgets/button_view.dart';
import 'package:petnity/ui/widgets/custom_text.dart';
import 'package:petnity/ui/widgets/image_view.dart';
import 'package:petnity/utils/app_utils.dart';
import 'package:provider/provider.dart';

import '../../../../model/session_types/session_types.dart';
import '../../../../model/user_models/order_list.dart';
import '../../../../model/user_models/vet_orders.dart';
import '../../../../model/user_models/vet_service.dart';
import '../../../../model/view_models/user_view_model.dart';
import '../../../../utils/navigator/page_navigator.dart';
import '../../../landing_page/services/track_services/track_vet_services.dart';
import '../../../notfications_pages/chat_pages/chat_page.dart';
import '../../../video.dart';
import '../../../widgets/modals.dart';

class VideoCallSessionWidget extends StatefulWidget {
  final String buttonText;
  final VetOrders vetOrders;
  const VideoCallSessionWidget(
      {super.key, this.buttonText = 'Details', required this.vetOrders});

  @override
  State<VideoCallSessionWidget> createState() => _VideoCallSessionWidgetState();
}

class _VideoCallSessionWidgetState extends State<VideoCallSessionWidget> {
  String username = '';

  List<SessionTypes> contacts = [];
  List<SessionTypes> sessions = [];

  getUserName() async {
    username = await StorageHandler.getUserName();

    contacts = widget.vetOrders.vetService?.contactMediums ?? [];
    sessions = widget.vetOrders.vetService?.sessionTypes ?? [];
  }

  @override
  void initState() {
    getUserName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final services = Provider.of<UserViewModel>(context, listen: false);

    return Card(
        child: Container(
            width: screenSize(context).width * .9,
            margin: EdgeInsets.symmetric(
                horizontal: screenSize(context).width * .04),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                    child: ImageView.network(
                      widget.vetOrders.agent?.picture,
                      height: 60,
                      width: 60,
                    ),
                    borderRadius: BorderRadius.circular(80),
                  ),
                  Container(
                    width: screenSize(context).width * .2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: widget.vetOrders.agent?.user?.username ?? '',
                          size: 14,
                          weight: FontWeight.bold,
                        ),
                        CustomText(
                          text: 'Vet',
                          size: 13,
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomText(
                            text: 'Session time',
                            size: 10,
                            weight: FontWeight.w600),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Column(
                              children: [
                                ImageView.svg(
                                  AppImages.time,
                                  height: 16,
                                ),
                                SizedBox(width: 4),
                                Text(
                                    services.formatDateTimeToAMPM(
                                        widget.vetOrders.sessionTime ?? ''),
                                    style: TextStyle(fontSize: 10)),
                              ],
                            ),
                            SizedBox(width: 8),
                            Column(
                              children: [
                                ImageView.svg(
                                  AppImages.calender,
                                  height: 16,
                                ),
                                SizedBox(width: 4),
                                Text(
                                    AppUtils.formatComplexDateOnly(
                                        dateTime:
                                            widget.vetOrders.sessionTime ?? ''),
                                    style: TextStyle(fontSize: 10)),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        'Session fee: ${AppUtils.convertPrice(widget.vetOrders.fee)}',
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: AppStrings.interSans,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text('Session type',
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: AppStrings.interSans,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      for (var sessionType
                          in widget.vetOrders.vetService?.contactMediums ?? [])
                        ImageWidget(
                          sessionTypeName: sessionType.name,
                          picture: widget.vetOrders.agent?.picture ?? '',
                          agentName:
                              widget.vetOrders.agent?.user?.username ??
                                  '',
                          firebaseId:
                              widget.vetOrders.agent?.user?.firebaseId ?? '',
                          phone: widget.vetOrders.agent?.user?.phoneNumber ??
                              '',
                          customerName: widget.vetOrders.user?.username ?? '',
                        ),
                    ],
                  ),
                  ButtonView(
                    expanded: false,
                    borderRadius: 30,
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    child: CustomText(
                      text: widget.buttonText,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      AppNavigator.pushAndStackPage(context,
                          page: TrackVetServicesScreen(
                            agentName: widget.vetOrders.agent?.user?.username ?? '',
                            phone:
                                widget.vetOrders.agent?.user?.phoneNumber ??
                                    '',
                            agentId:
                                widget.vetOrders.agent?.user?.firebaseId ??
                                    '',
                            sellerId:
                                widget.vetOrders.agent?.sId.toString() ?? '',
                            startDate1: widget.vetOrders.sessionTime ?? '',
                            amount: widget.vetOrders.fee.toString() ?? '',
                            paymentId: widget.vetOrders.sId ?? '',
                            sellerImage: widget.vetOrders.agent?.picture ?? '',
                            isAcceptedService:
                                widget.vetOrders.isAccepted ?? false,
                            isOngoingService:
                                widget.vetOrders.isOngoing ?? false,
                            isCompletedService:
                                widget.vetOrders.isCompleted ?? false,
                            orderId: widget.vetOrders.sId.toString(),
                            customerName:
                                widget.vetOrders.user?.username ?? '',
                            customerPhone:
                                widget.vetOrders.user?.phoneNumber ?? '',
                            customerImage:
                                widget.vetOrders.user?.profileImage ?? '',
                            customerFireBaseId:
                                widget.vetOrders.user?.firebaseId ?? '',
                            isRejected: widget.vetOrders.isRejected ?? false,
                            isUserMarkedService:
                                widget.vetOrders.userMarkedDelivered ?? false,
                            isAgentMarkedService:
                                widget.vetOrders.agentMarkedDelivered ?? false,
                            contactMediums: contacts,
                            sessionMediums: sessions,
                          ));
                    },
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ])));
  }
}

class ImageWidget extends StatelessWidget {
  final String sessionTypeName;
  final String phone;
  final String customerName;
  final String agentName;
  final String picture;
  final String firebaseId;

  ImageWidget(
      {required this.sessionTypeName,
      required this.phone,
      required this.customerName,
      required this.picture,
      required this.firebaseId,
      required this.agentName});

  @override
  Widget build(BuildContext context) {
    Widget image;
    switch (sessionTypeName) {
      case 'Voice Call':
        image = GestureDetector(
            onTap: () {
              _callNumber(phone);
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: ImageView.svg(AppImages.callBorder),
            ));
        break;
      case 'Chat':
        image = GestureDetector(
            onTap: () {
              if (firebaseId == '' || firebaseId == null) {
                Modals.showToast(
                    'Can\'t communicate with this agent at the moment. Please');
              } else {
                AppNavigator.pushAndStackPage(context,
                    page: ChatPage(
                      customerName: customerName,
                      userImage: picture,
                      uid: firebaseId,
                      agentName: agentName,
                    ));
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: ImageView.svg(AppImages.messageBorder),
            ));
        break;
      case 'Video':
        image = GestureDetector(
            onTap: () {
              AppNavigator.pushAndStackPage(context,
                  page: VideoCall(
                    customerName: customerName,
                    agentName: agentName,
                  ));
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: ImageView.svg(AppImages.videoBorder),
            ));
        break;
      default:
        image = SizedBox.shrink();
    }

    return image;
  }

  _callNumber(String number) async {
    bool res = await FlutterPhoneDirectCaller.callNumber(number) ?? false;
  }
}

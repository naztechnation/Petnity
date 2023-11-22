import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_images.dart';

import 'package:petnity/ui/widgets/button_view.dart';
import 'package:petnity/utils/navigator/page_navigator.dart';
import 'package:provider/provider.dart';

import '../../../../handlers/secure_handler.dart';
import '../../../../model/user_models/agent_services_lists.dart';
import '../../../../model/view_models/user_view_model.dart';
import '../../../landing_page/services/track_services/track_services.dart';
import '../../../notfications_pages/chat_pages/chat_page.dart';
import '../../../video.dart';
import '../../../widgets/image_view.dart';
import '../../../widgets/modals.dart';
import '../widget/progressbar.dart';

class OngoingDeliveryWidget extends StatefulWidget {
  final String label;
  final AgentServicesListOrders services;
  OngoingDeliveryWidget({this.label = 'Details', required this.services});

  @override
  State<OngoingDeliveryWidget> createState() => _OngoingDeliveryWidgetState();
}

class _OngoingDeliveryWidgetState extends State<OngoingDeliveryWidget> {
  String username = '';

  getUsername() async {
    username = await StorageHandler.getUserName();
  }

  @override
  void initState() {
    getUsername();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<UserViewModel>(context, listen: true);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          width: screenSize(context).width * .9,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(AppImages.dogsPic),
                    radius: 40,
                  ),
                  Container(
                    width: screenSize(context).width * .3,
                    child: Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sandra Lee',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                              '${widget.services.package?.service?.serviceType?.name}'),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    // width: screenSize(context).width * .3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Drop off time',
                          style: TextStyle(fontSize: 10),
                        ),
                        Text(userModel.formatDateTimeToAMPM(
                            widget.services.dropoffTime ?? ''))
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total time: ${userModel.calculateTimeDifferenceInHours(widget.services.pickupTime ?? '0', widget.services.dropoffTime ?? '0')} Hrs',
                    style: TextStyle(fontSize: 10),
                  ),
                  Text(
                      'Time remaining:  ${userModel.calculateRemainingTimeInHours(widget.services.dropoffTime ?? '0')} Hrs',
                      style: TextStyle(fontSize: 10)),
                  SizedBox(width: 8),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              ProgressBar(
                remainingTime: double.parse(
                    (userModel.calculateRemainingTimeInHours(
                                widget.services.dropoffTime ?? '') ==
                            'Elapsed'
                        ? '0.0'
                        : userModel.calculateRemainingTimeInHours(
                            widget.services.dropoffTime ?? ''))),
                totalTime: double.parse(
                    userModel.calculateTimeDifferenceInHours(
                        widget.services.pickupTime ?? '0',
                        widget.services.dropoffTime ?? '0')),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Contact ${widget.services.package?.service?.serviceType?.name ?? ''}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                          onTap: () {
                            _callNumber(
                                widget.services.agent?.profile?.phoneNumber ??
                                    '');
                          },
                          child: ImageView.svg(AppImages.callBorder)),
                      const SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                          onTap: () {
                            if (widget.services.agent?.profile?.firebaseId ==
                                    '' ||
                                widget.services.agent?.profile?.firebaseId ==
                                    null) {
                              Modals.showToast(
                                  'Can\'t communicate with this agent at the moment. Please');
                            } else {
                              AppNavigator.pushAndStackPage(context,
                                  page: ChatPage(
                                      username:
                                          widget.services.agent?.name ?? '',
                                      userImage:
                                          widget.services.agent?.picture ?? '',
                                      uid: widget.services.agent?.profile
                                              ?.firebaseId ??
                                          ''));
                            }
                          },
                          child: ImageView.svg(AppImages.messageBorder)),
                      const SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                          onTap: () {
                            /// Todo get the user name and replace here
                            AppNavigator.pushAndStackPage(context,
                                page: VideoCall(
                                  user1: widget.services.agent?.name ?? '',
                                  user2: username,
                                ));
                          },
                          child: ImageView.svg(AppImages.videoBorder)),
                    ],
                  ),
                  Container(
                    width: screenSize(context).width * .23,
                    child: ButtonView(
                      color: Colors.blue,
                      onPressed: () {
                        //  if(widget.services.isPaid ?? false) {
                        AppNavigator.pushAndStackPage(context,
                            page: TrackServicesScreen(
                              sellerName: widget.services.agent?.name ?? '',
                              phone:
                                  widget.services.agent?.profile?.phoneNumber ??
                                      '',
                              serviceOffered: widget.services.package?.service
                                      ?.serviceType?.name ??
                                  '',
                              agentId:
                                  widget.services.agent?.profile?.firebaseId ??
                                      '',
                              sellerId:
                                  widget.services.agent?.id.toString() ?? '',
                              startDate1: widget.services.pickupTime ?? '0',
                              startDate2: widget.services.dropoffTime ?? '0',
                              amount: widget.services.fee ?? '',
                              paymentId: widget.services.purchaseId ?? '',
                              sellerImage: widget.services.agent?.picture ?? '',
                              isAcceptedService:
                                  widget.services.isAccepted ?? false,
                              isOngoingService:
                                  widget.services.isOngoing ?? false,
                              isCompletedService:
                                  widget.services.isCompleted ?? false, orderId: widget.services.id.toString(),
                            ));
                        // }else{
                        Modals.showToast('This Service has not been paid for.');
                        //  }
                      },
                      child: Text(widget.label),
                      borderRadius: 30,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _callNumber(String number) async {
    bool res = await FlutterPhoneDirectCaller.callNumber(number) ?? false;
  }
}

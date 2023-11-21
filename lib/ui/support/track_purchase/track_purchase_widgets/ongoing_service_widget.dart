import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_images.dart';

import 'package:petnity/ui/widgets/button_view.dart';
import 'package:petnity/ui/widgets/image_view.dart';
import 'package:provider/provider.dart';

import '../../../../handlers/secure_handler.dart';
import '../../../../model/user_models/order_list.dart';
import '../../../../model/view_models/user_view_model.dart';
import '../../../../utils/navigator/page_navigator.dart';
import '../../../landing_page/services/track_services/track_services.dart';
import '../../../notfications_pages/chat_pages/chat_page.dart';
import '../../../video.dart';
import '../../../widgets/modals.dart';
import '../widget/progressbar.dart';

class OngoingServiceWidget extends StatefulWidget {
  final UserOrders allOrders;

  final String label;
  OngoingServiceWidget({this.label = 'Details', required this.allOrders});

  @override
  State<OngoingServiceWidget> createState() =>
      _OngoingServiceWidgetState(allOrders);
}

class _OngoingServiceWidgetState extends State<OngoingServiceWidget> {
  final UserOrders allOrders;

  _OngoingServiceWidgetState(this.allOrders);

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
    final services = Provider.of<UserViewModel>(context, listen: false);

    return Card(
      elevation: 1,
      child: Container(
        width: screenSize(context).width * .9,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: ImageView.network(
                      allOrders.agent?.picture,
                      height: 50,
                    )),
                Container(
                  width: screenSize(context).width * .3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        allOrders.agent?.name ?? '',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        allOrders.package?.service?.serviceType?.name ?? '',
                      )
                    ],
                  ),
                ),
                Container(
                  width: screenSize(context).width * .3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Drop off time',
                        style: TextStyle(fontSize: 10),
                      ),
                      Text(services
                          .formatDateTimeToAMPM(allOrders.dropoffTime ?? ''))
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
                  'Total time: ${services.calculateTimeDifferenceInHours(allOrders.pickupTime ?? '0', allOrders.dropoffTime ?? '0')} Hrs',
                  style: TextStyle(fontSize: 10),
                ),
                Text(
                    'Time remaining : ${services.calculateRemainingTimeInHours(allOrders.dropoffTime ?? '0')} Hrs',
                    style: TextStyle(fontSize: 10)),
                SizedBox(width: 8),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            ProgressBar(
              remainingTime: double.parse(
                  (services.calculateRemainingTimeInHours(
                              allOrders.dropoffTime ?? '') ==
                          'Elapsed'
                      ? '0.0'
                      : services.calculateRemainingTimeInHours(
                          allOrders.dropoffTime ?? ''))),
              totalTime: double.parse(services.calculateTimeDifferenceInHours(
                  allOrders.pickupTime ?? '0', allOrders.dropoffTime ?? '0')),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Contact ${allOrders.package?.service?.serviceType?.name ?? ''}',
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
                                allOrders.agent?.profile?.phoneNumber ??
                                    '');
                          },
                          child: ImageView.svg(AppImages.callBorder)),
                          const SizedBox(width: 20,),
                      GestureDetector(
                          onTap: () {
                            if (allOrders.agent?.profile?.firebaseId ==
                                    '' ||
                               allOrders.agent?.profile?.firebaseId ==
                                    null) {
                              Modals.showToast(
                                  'Can\'t communicate with this agent at the moment. Please');
                            } else {
                              AppNavigator.pushAndStackPage(context,
                                  page: ChatPage(
                                      username:
                                          allOrders.agent?.name ?? '',
                                      userImage:
                                          allOrders.agent?.picture ?? '',
                                      uid: allOrders.agent?.profile
                                              ?.firebaseId ??
                                          ''));
                            }
                          },
                          child: ImageView.svg(AppImages.messageBorder)),
                          const SizedBox(width: 20,),

                      GestureDetector(
                          onTap: () {
                            AppNavigator.pushAndStackPage(context,
                                page: VideoCall(
                                  user1: allOrders.agent?.name ?? '',
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
                        AppNavigator.pushAndStackPage(context,
                            page: TrackServicesScreen(
                              sellerName: allOrders.agent?.name ?? '',
                              phone:
                                  allOrders.agent?.profile?.phoneNumber ??
                                      '',
                              serviceOffered: allOrders.package?.service
                                      ?.serviceType?.name ??
                                  '',
                              agentId:
                                  allOrders.agent?.profile?.firebaseId ??
                                      '',
                              sellerId:
                                  allOrders.agent?.id.toString() ?? '',
                              startDate1: allOrders.pickupTime ?? '0',
                              startDate2: allOrders.dropoffTime ?? '0',
                              amount: allOrders.fee ?? '',
                              paymentId:allOrders.purchaseId ?? '',
                              sellerImage: allOrders.agent?.picture ?? '',
                            ));
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
    );
  }

  _callNumber(String number) async{
  bool res = await FlutterPhoneDirectCaller.callNumber(number) ?? false;
}
}

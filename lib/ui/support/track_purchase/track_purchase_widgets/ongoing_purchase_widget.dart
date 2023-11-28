import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_images.dart';

import 'package:petnity/ui/widgets/button_view.dart';
import 'package:petnity/ui/widgets/image_view.dart';
import 'package:provider/provider.dart';

import '../../../../handlers/secure_handler.dart';
import '../../../../model/user_models/order_list.dart';
import '../../../../model/user_models/user_shopping_data.dart';
import '../../../../model/view_models/user_view_model.dart';
import '../../../../utils/navigator/page_navigator.dart';
import '../../../landing_page/services/track_services/track_services.dart';
import '../../../notfications_pages/chat_pages/chat_page.dart';
import '../../../video.dart';
import '../../../widgets/modals.dart';
import '../widget/progressbar.dart';
import '../widget/sellers_progress_bar.dart';

class OngoingPurchaseWidget extends StatefulWidget {
  final UserShopList allOrders;

  final String label;
  OngoingPurchaseWidget({this.label = 'Details', required this.allOrders});

  @override
  State<OngoingPurchaseWidget> createState() =>
      _OngoingServiceWidgetState(allOrders);
}

class _OngoingServiceWidgetState extends State<OngoingPurchaseWidget> {
  final UserShopList allOrders;

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

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                      '${allOrders.product?.agent?.picture}',
                      height: 50,
                    )),
                Container(
                  width: screenSize(context).width * .3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        allOrders.product?.agent?.name ?? '',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Seller',
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
                        'Product',
                        style: TextStyle(fontSize: 10),
                      ),
                      Text(allOrders.product?.name ?? '')
                    ],
                  ),
                ),
              ],
            ),
             SizedBox(
              height: 20,
            ),

            OngoingOrderWidget(
          isOrderReceived: true,
          isOrderDelivered: false,
        ),
            
            SizedBox(
              height: 20,
            ),
            
            
            Text(
              'Contact Seller',
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
                              allOrders.product?.agent?.profile?.phoneNumber ?? '');
                        },
                        child: ImageView.svg(AppImages.callBorder)),
                    const SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                        onTap: () {
                          if (allOrders.product?.agent?.profile?.firebaseId == '' ||
                              allOrders.product?.agent?.profile?.firebaseId == null) {
                            Modals.showToast(
                                'Can\'t communicate with this agent at the moment. Please');
                          } else {
                            AppNavigator.pushAndStackPage(context,
                                page: ChatPage(
                                    username: allOrders.product?.agent?.name ?? '',
                                    userImage: allOrders.product?.agent?.picture ?? '',
                                    uid: allOrders.product?.agent?.profile?.firebaseId ??
                                        ''));
                          }
                        },
                        child: ImageView.svg(AppImages.messageBorder)),
                    const SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                        onTap: () {
                          AppNavigator.pushAndStackPage(context,
                              page: VideoCall(
                                user1: allOrders.product?.agent?.name ?? '',
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
                      // AppNavigator.pushAndStackPage(context,
                      //     page: TrackServicesScreen(
                      //       sellerName: allOrders.agent?.name ?? '',
                      //       phone: allOrders.agent?.profile?.phoneNumber ?? '',
                      //       serviceOffered:
                      //           allOrders.package?.service?.serviceType?.name ??
                      //               '',
                      //       agentId: allOrders.agent?.profile?.firebaseId ?? '',
                      //       sellerId: allOrders.agent?.id.toString() ?? '',
                      //       startDate1: allOrders.pickupTime ?? '0',
                      //       startDate2: allOrders.dropoffTime ?? '0',
                      //       amount: allOrders.fee ?? '',
                      //       paymentId: allOrders.purchaseId ?? '',
                      //       sellerImage: allOrders.agent?.picture ?? '',
                      //       isAcceptedService: allOrders.isAccepted ?? false,
                      //       isOngoingService: allOrders.isOngoing ?? false,
                      //       isCompletedService: allOrders.isCompleted ?? false,
                      //       orderId: allOrders.id.toString(), customerName: '', 
                      //       customerPhone: '', customerImage: '', customerFireBaseId: '',
                      //       isRejected: allOrders.isRejected ?? false, isUserMarkedService: allOrders.userMarkedDelivered ?? false, isAgentMarkedService: allOrders.agentMarkedDelivered ?? false,
                      //     ));
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

  _callNumber(String number) async {
    bool res = await FlutterPhoneDirectCaller.callNumber(number) ?? false;
  }
}

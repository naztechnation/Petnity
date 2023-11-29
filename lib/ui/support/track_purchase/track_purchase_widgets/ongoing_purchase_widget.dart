import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:intl/intl.dart';

import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_images.dart';

import 'package:petnity/ui/widgets/button_view.dart';
import 'package:petnity/ui/widgets/image_view.dart'; 

import '../../../../handlers/secure_handler.dart'; 
import '../../../../model/user_models/user_shopping_data.dart'; 
import '../../../../utils/navigator/page_navigator.dart'; 
import '../../../notfications_pages/chat_pages/chat_page.dart';
import '../../../service_povider_section/service_provider_home/all_requests_section/product_shopping_details.dart';
import '../../../video.dart';
import '../../../widgets/modals.dart'; 
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


  String today = DateFormat('yyyy-MM-dd').format(DateTime.now());

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
              isOrderDelivered: allOrders.userMarkedDelivered ?? true,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order Received',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 10),
                ),
                Text(
                  'Order Delivered',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 10),
                ),
              ],
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
                              allOrders.product?.agent?.profile?.phoneNumber ??
                                  '');
                        },
                        child: ImageView.svg(AppImages.callBorder)),
                    const SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                        onTap: () {
                          if (allOrders.product?.agent?.profile?.firebaseId ==
                                  '' ||
                              allOrders.product?.agent?.profile?.firebaseId ==
                                  null) {
                            Modals.showToast(
                                'Can\'t communicate with this agent at the moment. Please');
                          } else {
                            AppNavigator.pushAndStackPage(context,
                                page: ChatPage(
                                    username:
                                        allOrders.product?.agent?.name ?? '',
                                    userImage:
                                        allOrders.product?.agent?.picture ?? '',
                                    uid: allOrders.product?.agent?.profile
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
                     // if (order.isPaid ?? false) {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return PurchaseRequest(
                    ownerName: '${allOrders.product?.agent?.name}',
                    buyerName: '${allOrders.profile?.user?.username}',
                     
                    productName: '${allOrders.product?.name}',
                    productImage: '${allOrders.product?.image}',
                    quantity: '${allOrders.quantity}',
                    price: '${allOrders.product?.price}',
                    purchaseId: '${allOrders.paymentId}',
                    deliveryDate: today,
                    deliveryLocation: ' ', 
                    ownerImage: '${allOrders.product?.agent?.picture}',
                     ownerNumber: '${allOrders.product?.agent?.profile?.phoneNumber}',
                      ownerFirebaseId: '${allOrders.product?.agent?.profile?.firebaseId}', 
                      isUserMarkedOrder: allOrders.userMarkedDelivered ?? false, 
                      isAgentMarkedOrder: allOrders.agentMarkedDelivered ?? false,
                       orderId: allOrders.product?.id.toString() ?? '',
                       ownerNormalId: allOrders.product?.agent?.id.toString() ?? '',
                  );
                }));
              // } else {
                Modals.showToast('This product  has not been paid for.');
              // }
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

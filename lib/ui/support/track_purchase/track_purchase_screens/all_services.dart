import 'package:flutter/material.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/ui/support/track_purchase/track_purchase_widgets/ongoing_service_widget.dart';
import 'package:petnity/ui/support/track_purchase/track_purchase_widgets/video_call_session_widget.dart';

import '../../../../model/user_models/order.dart';
import '../../../../model/user_models/shop_order.dart';
import '../../../../model/user_models/vet_orders.dart';
import '../../../../res/enum.dart';
import '../track_purchase_widgets/ongoing_purchase_widget.dart';

class AllServices extends StatefulWidget {
  final List<Orders> allOrders;
  final List<ShopOrders> userShopOrder;
  final List<VetOrders> vetOrders;

  final String emptyListTitle;
  final OrderType orderType;

  AllServices.services(
      {super.key,
      required this.allOrders,
      this.emptyListTitle = 'No available service',
      required this.userShopOrder,
      this.orderType = OrderType.services,
      required this.vetOrders});
  AllServices.shop(
      {super.key,
      required this.userShopOrder,
      this.emptyListTitle = 'No available purchases',
      required this.allOrders,
      this.orderType = OrderType.shop,
      required this.vetOrders});

  AllServices.vet(
      {super.key,
      required this.userShopOrder,
      this.emptyListTitle = 'No vet service available',
      required this.allOrders,
      this.orderType = OrderType.vet,
      required this.vetOrders});

  @override
  State<AllServices> createState() => _AllServicesState();
}

class _AllServicesState extends State<AllServices> {
  // Orders? orderList;
  @override
  Widget build(BuildContext context) {
    if (widget.orderType == OrderType.services) {
      return (widget.allOrders.isEmpty)
          ? Center(child: Text(widget.emptyListTitle))
          : Container(
              padding: EdgeInsets.all(10),
              height: screenSize(context).height * .8,
              child: SingleChildScrollView(
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: widget.allOrders.length,
                      itemBuilder: (BuildContext context, index) {
                        // orderList = allOrders?[index];
                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              servicesTypes(index),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal:
                                        screenSize(context).width * 0.03),
                                child: OngoingServiceWidget(
                                  allOrders: widget.allOrders[index],
                                ),
                              ),
                            ]);
                      })),
            );
    } else if (widget.orderType == OrderType.shop) {
      if (widget.userShopOrder.isEmpty) {
        return Center(
          child: Text('You are yet to make a purchase.'),
        );
      } else {
        return Container(
          padding: EdgeInsets.all(10),
          height: screenSize(context).height * .7,
          child: SingleChildScrollView(
            child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.userShopOrder.length,
                itemBuilder: ((context, index) {
                  return OngoingPurchaseWidget(
                    allOrders: widget.userShopOrder[index],
                    label: 'Track',
                  );
                })),
          ),
        );
      }
    } else if (widget.orderType == OrderType.vet) {
      if (widget.vetOrders.isEmpty) {
        return Center(
          child: Text('No vet order in session.'),
        );
      } else {
        return Container(
          padding: EdgeInsets.all(10),
          height: screenSize(context).height * .7,
          child: SingleChildScrollView(
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: widget.vetOrders.length,
                  itemBuilder: (BuildContext context, index) {
                    var vetOrder = widget.vetOrders[index];

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        
                        if (vetOrder.isRejected ?? false) ...[
                          Text(
                            'Service is Rejected',
                            style: TextStyle(color: Colors.red),
                          )
                        ] else if (vetOrder.isPaid! && !vetOrder.isAccepted! && !vetOrder.userMarkedDelivered! && !vetOrder.agentMarkedDelivered!) ...[
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0),
                            child: Text(
                              'You have paid for this service. wait for acceptance.',
                              style: TextStyle(color: Colors.orange),
                            ),
                          )
                        ] else if (vetOrder.isAccepted! && !vetOrder.isOngoing! && !vetOrder.userMarkedDelivered! && !vetOrder.agentMarkedDelivered!) ...[
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0),
                            child: Text(
                              'Service is Accepted',
                              style: TextStyle(color: Colors.blueGrey),
                            ),
                          )
                        ] else if (vetOrder.isOngoing! && !vetOrder.isCompleted! && !vetOrder.userMarkedDelivered! && !vetOrder.agentMarkedDelivered!) ...[
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0),
                            child: Text(
                              'Service is ongoing',
                              style: TextStyle(color: Colors.blue),
                            ),
                          )
                        ] else if (vetOrder.isOngoing!  && vetOrder.userMarkedDelivered! && !vetOrder.agentMarkedDelivered!) ...[
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0),
                            child: Text(
                              'You marked order as completed',
                              style: TextStyle(color: Colors.greenAccent ),
                            ),
                          )
                        ] else if (vetOrder.isCompleted! && vetOrder.userMarkedDelivered! && vetOrder.agentMarkedDelivered! && !vetOrder.paymentReleased!) ...[
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0),
                            child: Text(
                              'Service is completed',
                              style: TextStyle(color: Colors.green[900]),
                            ),
                          )
                        ]else if (vetOrder.isCompleted! && vetOrder.userMarkedDelivered! && vetOrder.agentMarkedDelivered! && vetOrder.paymentReleased!) ...[
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0),
                            child: Text(
                              'Payment Released to service provider',
                              style: TextStyle(color: Colors.green[900]),
                            ),
                          )
                        ],
                        Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: screenSize(context).width * 0.03),
                            child: VideoCallSessionWidget(
                              vetOrders: vetOrder,
                            )),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    );
                  })),
        );
      }
    }

    return const SizedBox.shrink();
  }

  servicesTypes(int index) {
    if (widget.allOrders[index].isOngoing! &&
        !widget.allOrders[index].isCompleted!) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 18),
        child: Text(
          'Ongoing Service',
          style: TextStyle(
              color: AppColors.lightSecondary, fontWeight: FontWeight.w700),
        ),
      );
    } else if (widget.allOrders[index].isCompleted!) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 18),
        child: Text(
          'Completed Service',
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.w700),
        ),
      );
    } else if (widget.allOrders[index].isRejected!) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 18),
        child: Text(
          'Rejected Service',
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.w700),
        ),
      );
    } else if (widget.allOrders[index].isPaid == true &&
        widget.allOrders[index].isAccepted == false) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 18),
        child: Text(
          'Awaiting Service',
          style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w700),
        ),
      );
    } else if (widget.allOrders[index].isPaid == true &&
        widget.allOrders[index].isAccepted == true) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 18),
        child: Text(
          'Awaiting Service',
          style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w700),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 18),
        child: Text(
          'Not Accepted',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      );
    }
  }
}

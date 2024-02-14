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

class AllServices extends StatelessWidget {
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

  // Orders? orderList;

  @override
  Widget build(BuildContext context) {
    if (orderType == OrderType.services) {
      return (allOrders.isEmpty)
          ? Center(child: Text(emptyListTitle))
          : Container(
              padding: EdgeInsets.all(10),
              height: screenSize(context).height * .8,
              child: SingleChildScrollView(
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: allOrders.length,
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
                                  allOrders: allOrders[index],
                                ),
                              ),
                            ]);
                      })),
            );
    } else if (orderType == OrderType.shop) {
      if (userShopOrder.isEmpty) {
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
                itemCount: userShopOrder?.length ?? 0,
                itemBuilder: ((context, index) {
                  return OngoingPurchaseWidget(
                    allOrders: userShopOrder![index],
                    label: 'Track',
                  );
                })),
          ),
        );
      }
    } else if (orderType == OrderType.vet) {
      if (vetOrders.isEmpty) {
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
                  itemCount: vetOrders.length,
                  itemBuilder: (BuildContext context, index) {
                     var vetOrder = vetOrders[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        servicesTypes(index),
                        Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: screenSize(context).width * 0.03),
                            child: VideoCallSessionWidget(vetOrders: vetOrder,)),
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
    if (allOrders[index].isOngoing! && !allOrders[index].isCompleted!) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 18),
        child: Text(
          'Ongoing Services',
          style: TextStyle(
              color: AppColors.lightSecondary, fontWeight: FontWeight.w700),
        ),
      );
    } else if (allOrders[index].isCompleted!)  {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 18),
        child: Text(
          'Completed Services',
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.w700),
        ),
      );
    } else if (allOrders[index].isRejected!) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 18),
        child: Text(
          'Rejected Services',
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.w700),
        ),
      );
    } else if (allOrders[index].isPaid == true && allOrders[index].isAccepted == false) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 18),
        child: Text(
          'Awaiting Services',
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

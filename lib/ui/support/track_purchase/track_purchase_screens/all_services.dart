import 'package:flutter/material.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/ui/support/track_purchase/track_purchase_widgets/ongoing_service_widget.dart';
import 'package:petnity/ui/support/track_purchase/track_purchase_widgets/video_call_session_widget.dart';
import '../../../../model/user_models/order_list.dart';  
import '../track_purchase_widgets/ongoing_purchase_widget.dart';

class AllServices extends StatefulWidget {
  final List<UserOrders> allOrders;
  const AllServices({super.key, required this.allOrders});

  @override
  State<AllServices> createState() => _AllServicesState(allOrders);
}

class _AllServicesState extends State<AllServices> {
  final List<UserOrders> allOrders;
  UserOrders? orderList;
  _AllServicesState(this.allOrders);

  @override
  Widget build(BuildContext context) {
    return (allOrders.isEmpty) ? Center(child: Text('No available Service')) : Container(
      padding: EdgeInsets.all(10),
      height: screenSize(context).height * .7,
      child: SingleChildScrollView(
          child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget.allOrders.length,
              itemBuilder: (BuildContext context, index) {
                orderList = widget.allOrders[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (orderList!.package?.service?.serviceType?.name ==
                        'Vets') ...[
                      servicesTypes(),
                      Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: screenSize(context).width * 0.03),
                          child: VideoCallSessionWidget()),
                      SizedBox(
                        height: 15,
                      ),
                    ] else ...[
                      servicesTypes(),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: screenSize(context).width * 0.03),
                        child: OngoingServiceWidget(
                          allOrders: allOrders[index],
                        ),
                      ),
                    ],
                    if (orderList!.package?.service?.serviceType?.name ==
                        'Shopping') ...[OngoingPurchaseWidget()]
                  ],
                );
              })),
    );
  }

  servicesTypes() {
    if (orderList!.isOngoing!) {
      return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 18),

        child: Text('Ongoing Services', style: TextStyle(color: AppColors.lightSecondary, fontWeight: FontWeight.w700),),
      );
    } else if (orderList!.isCompleted!) {
      return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 18),

        child: Text('Completed Services', style: TextStyle(color: Colors.green, fontWeight: FontWeight.w700),),
      );
    } else if (orderList!.isRejected!) {
      return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 18),

        child: Text('Rejected Services', style: TextStyle(color: Colors.red, fontWeight: FontWeight.w700),),
      );
    } else if (orderList!.isPaid == true && orderList!.isAccepted == false) {
      return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 18),

        child: Text('Awaiting Services', style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w700),),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 18),
        child: Text('Not Accepted',  style: TextStyle(fontWeight: FontWeight.w700),),
      );
    }
  }
}

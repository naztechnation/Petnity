import 'package:flutter/material.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/ui/landing_page/track_purchase/track_purchase_widgets/ongoing_service_widget.dart';
import 'package:petnity/ui/landing_page/track_purchase/track_purchase_widgets/video_call_session_widget.dart';
import 'package:provider/provider.dart';
import '../../../../model/user_models/order_list.dart';
import '../../../../model/view_models/user_view_model.dart';
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
      return Text('Ongoing Services');
    } else if (orderList!.isCompleted!) {
      return Text('Completed Services');
    } else if (orderList!.isRejected!) {
      return Text('Rejected Services');
    } else if (orderList!.isPaid == true && orderList!.isAccepted == false) {
      return Text('Awaiting Services');
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 18),
        child: Text('Not Accepted'),
      );
    }
  }
}

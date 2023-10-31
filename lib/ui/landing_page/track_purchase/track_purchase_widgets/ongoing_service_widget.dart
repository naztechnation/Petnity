import 'package:flutter/material.dart';

import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_images.dart';

import 'package:petnity/ui/widgets/button_view.dart';
import 'package:petnity/ui/widgets/image_view.dart';
import 'package:provider/provider.dart';

import '../../../../model/user_models/order_list.dart';
import '../../../../model/view_models/user_view_model.dart';
import '../../../widgets/modals.dart';

class OngoingServiceWidget extends StatefulWidget {
 final  UserOrders allOrders;

  final String label;
  OngoingServiceWidget({this.label = 'Details', required this.allOrders});

  @override
  State<OngoingServiceWidget> createState() => _OngoingServiceWidgetState(allOrders);
}

class _OngoingServiceWidgetState extends State<OngoingServiceWidget> {

 final  UserOrders allOrders;

  _OngoingServiceWidgetState(this.allOrders);

  @override
  Widget build(BuildContext context) {
    final services = Provider.of<UserViewModel>(context, listen: false);

    return Card(
      elevation: 0,
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
                  child: ImageView.network(allOrders.agent?.picture, height: 50,)),
                Container(
                  width: screenSize(context).width * .3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        allOrders.agent?.name  ?? '',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(allOrders.package?.service?.serviceType?.name ?? '',)
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
                      Text( services.formatDateTimeToAMPM(allOrders.dropoffTime ?? '')   )
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
                  'Total time: ${services.calculateTimeDifferenceInHours(allOrders.pickupTime ?? '',allOrders.dropoffTime ?? '')}',
                  style: TextStyle(fontSize: 10),
                ),
                Text('Time remaining : ${services.calculateRemainingTimeInHours(allOrders.dropoffTime ?? '')} ',
                    style: TextStyle(fontSize: 10)),
                SizedBox(width: 8),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            LinearProgressIndicator(
              value: 1.0 - services.getProgressTime(allOrders.dropoffTime ?? ''),  
              minHeight: 8,  
              borderRadius: BorderRadius.circular(8),
              backgroundColor: Colors.grey[300],  
              valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.blue), // Color of the progress line
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
                Container(
                  width: screenSize(context).width * .13,
                  child: ButtonView(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    borderColor: Colors.red,
                    borderWidth: 2,
                    color: Colors.white,
                    onPressed: () {},
                    child: Icon(
                      Icons.call_outlined,
                      color: Colors.red,
                      size: 20,
                    ),
                    borderRadius: 100,
                  ),
                ),
                Container(
                  width: screenSize(context).width * .13,
                  child: ButtonView(
                    borderColor: Colors.green,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    borderWidth: 2,
                    color: Colors.white,
                    onPressed: () {},
                    child: Icon(
                      Icons.chat,
                      color: Colors.green,
                      size: 20,
                    ),
                    borderRadius: 100,
                  ),
                ),
                Container(
                  width: screenSize(context).width * .13,
                  child: ButtonView(
                    borderColor: Colors.purple,
                    borderWidth: 2,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    color: Colors.white,
                    onPressed: () {},
                    child: Icon(
                      Icons.video_call,
                      color: Colors.purple,
                      size: 20,
                    ),
                    borderRadius: 100,
                  ),
                ),
                Container(
                  width: screenSize(context).width * .23,
                  child: ButtonView(
                    color: Colors.blue,
                    onPressed: () {
                      Modals.showToast('${1.0 - services.getProgressTime(allOrders.dropoffTime ?? '')}');
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
}

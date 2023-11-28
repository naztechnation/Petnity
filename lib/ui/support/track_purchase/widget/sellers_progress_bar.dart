
import 'package:flutter/material.dart';
import 'package:petnity/res/app_images.dart';

import '../../../widgets/image_view.dart';

class OngoingOrderWidget extends StatelessWidget {
  final bool isOrderReceived;
  final bool isOrderDelivered;

  OngoingOrderWidget({
    required this.isOrderReceived,
    required this.isOrderDelivered,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildOrderContainer("Order Received", isOrderReceived, AppImages.giftCard),
        _buildConnectorContainer(isOrderReceived, isOrderDelivered),
        _buildOrderContainer("Order Delivered", isOrderDelivered, AppImages.checkedDelivered),
      ],
    );
  }

  Widget _buildOrderContainer(String title, bool isActive,String icon) {
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(30.0),
            decoration: BoxDecoration(
              color: isActive ? Colors.blue : Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.blue),
            ),
            child: ImageView.svg(icon, color: isActive ? Colors.white : Colors.blue),
          ),
           SizedBox(height: 8.0),
            Text(
              title,
              style: TextStyle(
                color: isActive ? Colors.white : Colors.blue,
                fontWeight: FontWeight.w300,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildConnectorContainer(bool isOrderReceived, bool isOrderDelivered) {
    return Container(
      width: 20.0,
      height: 2.0,
      color: isOrderReceived
          ? Colors.blue
          : (isOrderDelivered ? Colors.white : Colors.grey),
    );
  }
}

  
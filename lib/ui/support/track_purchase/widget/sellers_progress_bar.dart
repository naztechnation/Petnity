import 'package:flutter/material.dart';
import 'package:petnity/res/app_images.dart';

import '../../../../res/app_colors.dart';
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
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildOrderContainer("Order Received", isOrderReceived, AppImages.giftCard),
        _buildConnectorContainer(isOrderReceived, ),
        _buildConnectorContainer(isOrderDelivered, ),
        _buildOrderContainer("Order Delivered", isOrderDelivered, AppImages.checkedDelivered),
      ],
    );
  }

  Widget _buildOrderContainer(String title, bool isActive, String icon) {
    return Expanded(
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              color: isActive ? AppColors.lightSecondary : Colors.white,
              borderRadius: BorderRadius.circular(40.0),
              border: Border.all(color: isActive ? AppColors.lightSecondary : Colors.grey),
            ),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: ImageView.svg(icon, color: isActive ? Colors.white : Colors.grey, height: 12),
            ),
          ),
         
        ],
      ),
    );
  }

  Widget _buildConnectorContainer(bool isOrderReceived,) {
    return Expanded(
      flex: 4,
      child: Container(
        height: 2.0,
        color: (isOrderReceived ? AppColors.lightSecondary : Colors.grey),
      ),
    );
  }
}

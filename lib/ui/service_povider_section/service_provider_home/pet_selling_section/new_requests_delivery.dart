import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/ui/service_povider_section/service_provider_home/service_request.dart';
import 'package:petnity/ui/support/track_purchase/track_purchase_widgets/ongoing_delivery_widget.dart';
import 'package:petnity/ui/widgets/button_view.dart';
import 'package:petnity/ui/widgets/custom_text.dart';
import 'package:petnity/ui/widgets/image_view.dart';
import 'package:provider/provider.dart';

import '../../../../model/service_provider_models/all_agent_orders.dart';
import '../../../../model/view_models/service_provider_inapp.dart';
import 'product_shopping_details.dart';

class ServiceProviderPetDeliveryHomeBody extends StatefulWidget {
  final Function onTap;
  ServiceProviderPetDeliveryHomeBody({super.key, required this.onTap});

  @override
  State<ServiceProviderPetDeliveryHomeBody> createState() =>
      _ServiceProviderPetDeliveryHomeBodyState();
}

class _ServiceProviderPetDeliveryHomeBodyState
    extends State<ServiceProviderPetDeliveryHomeBody> {

       
       String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    final serviceProvider =
        Provider.of<ServiceProviderInAppViewModel>(context, listen: true);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: 'Ongoing Pet Delivery',
          weight: FontWeight.bold,
        ),
        SizedBox(
          height: 10,
        ),
        OngoingDeliveryWidget(
          label: 'Track',
        ),
        SizedBox(
          height: 25,
        ),
        Row(
          children: [
            CustomText(
              text: 'All new requests ',
              weight: FontWeight.bold,
              size: 13,
            ),
            CustomText(
              text: '(${serviceProvider.order.length})',
              size: 13,
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        if (serviceProvider.order.isEmpty) ...[
          Center(
            child: CustomText(
              text: 'no  available order here',
              size: 16,
              weight: FontWeight.bold,
            ),
          ),
        ] else ...[
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: serviceProvider.order.length,
              itemBuilder: ((context, index) {
                return _shoppingOrder(context, serviceProvider.order[index]);
              })),
        ],
       
      ],
    );
  }

  Widget _newRequestWidget(BuildContext context, ShopOrders order) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: ListTile(
        leading: Container(
          width: 80,
          height: screenSize(context).height * .07,
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(20)),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: ImageView.network(order.product!.image)),
        ),
        title: CustomText(
          text: '${order.product?.name}',
          weight: FontWeight.bold,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: 'Pick up time',
              size: 12,
            ),
            Row(
              children: [
                Icon(Icons.timer),
                CustomText(
                  text: '06 PM',
                  size: 10,
                ),
                Icon(Icons.calendar_month),
                CustomText(
                  text: '06 PM',
                  size: 10,
                ),
              ],
            )
          ],
        ),
        trailing: Container(
          width: screenSize(context).width * .2,
          child: ButtonView(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return ServiceRequest();
              }));
            },
            child: Text(
              'view',
              style: TextStyle(color: Colors.blue),
            ),
            borderRadius: 100,
            color: AppColors.scaffoldColor,
            expanded: false,
            borderColor: Colors.transparent,
          ),
        ),
      ),
    );
  }

  Widget _shoppingOrder(BuildContext context, ShopOrders order) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: ListTile(
        leading: Container(
          width: 80,
          height: 150,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: ImageView.network(
                order.product!.image,
                fit: BoxFit.cover,
                height: 150,
              )),
        ),
        title: CustomText(
          text: '${order.product?.name}',
          size: 16,
          weight: FontWeight.bold,
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: CustomText(
            text: 'NGN ${order.product?.price}',
            size: 14,
            weight: FontWeight.w600,
          ),
        ),
        trailing: Container(
          width: screenSize(context).width * .2,
          child: ButtonView(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return PurchaseRequest(ownerName: 'Sandra Lee', phoneNumber: '0908765432', productName: '${order.product?.name}',
                 productImage: '${order.product?.image}', quantity: '${order.quantity}', price: '${order.product?.price}', purchaseId: '${order.paymentId}', deliveryDate: today, deliveryLocation: 'ontisha anambra state',);
              }));
            },
            child: Text(
              'view',
              style: TextStyle(color: Colors.blue),
            ),
            borderRadius: 100,
            color: AppColors.scaffoldColor,
            expanded: false,
            borderColor: Colors.transparent,
          ),
        ),
      ),
    );
  }
}

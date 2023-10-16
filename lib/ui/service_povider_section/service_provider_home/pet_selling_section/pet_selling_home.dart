import 'package:flutter/material.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_images.dart';
import 'package:petnity/ui/service_povider_section/service_provider_home/service_request.dart';
import 'package:petnity/ui/landing_page/track_purchase/track_purchase_widgets/ongoing_delivery_widget.dart';
import 'package:petnity/ui/landing_page/track_purchase/track_purchase_widgets/ongoing_service_widget.dart';
import 'package:petnity/ui/widgets/button_view.dart';
import 'package:petnity/ui/widgets/custom_text.dart';

class ServiceProviderPetDeliveryHomeBody extends StatelessWidget {
  ServiceProviderPetDeliveryHomeBody({super.key});

  @override
  Widget build(BuildContext context) {
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
        Row(
          children: [
            CustomText(
              text: 'All new Pet buying requests ',
              weight: FontWeight.bold,
              size: 13,
            ),
            CustomText(
              text: '(23)',
              size: 13,
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        _newRequestWidget(context),
        _newRequestWidget(context),
        _newRequestWidget(context),
      ],
    );
  }

  Widget _newRequestWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: ListTile(
        // contentPadding: EdgeInsets.symmetric(vertical: 10),
        // tileColor: Colors.white,
        leading: Container(
          width: screenSize(context).width * .14,
          height: screenSize(context).height * .07,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              image: DecorationImage(
                  image: AssetImage(AppImages.person), fit: BoxFit.fill)),
        ),
        title: CustomText(
          text: 'Sandra Lee',
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
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../model/view_models/service_provider_inapp.dart';
import '../../../../../res/app_colors.dart';
import '../../../../../res/app_constants.dart';
import '../../../../../res/app_strings.dart';
import '../../../../support/track_purchase/track_purchase_widgets/ongoing_delivery_widget.dart';
import '../../../../widgets/back_button.dart';
import '../../../../widgets/custom_text.dart';

class AllOngoingDeliveryScreen extends StatelessWidget {
  const AllOngoingDeliveryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final serviceProvider =
        Provider.of<ServiceProviderInAppViewModel>(context, listen: true);

    return Scaffold(
        body: Container(
      height: screenSize(context).height,
      width: screenSize(context).width,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [AppColors.scaffoldColor, Colors.red.shade50],
              begin: Alignment.topRight,
              end: Alignment.topLeft)),
      child: Column(
        children: [
          SafeArea(
              child: Container(
                  color: AppColors.cardColor,
                  height: (Platform.isAndroid) ? 0 : 0)),
          Container(
            color: AppColors.cardColor,
            padding: const EdgeInsets.only(bottom: 20, top: 10),
            child: Row(
              children: [
                backButton(context),
                const SizedBox(
                  width: 40,
                ),
                CustomText(
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  text: 'Ongoing Services',
                  weight: FontWeight.w700,
                  size: 20,
                  fontFamily: AppStrings.interSans,
                  color: Colors.black,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                padding:
                    const EdgeInsets.symmetric(horizontal: 13.0, vertical: 15),
                itemCount: serviceProvider.onGoingOrdersList.length,
                itemBuilder: (context, index) {
                  return OngoingDeliveryWidget(
                    label: 'Track',
                    services: serviceProvider.onGoingOrdersList[index],
                  );
                }),
          ),
        ],
      ),
    ));
  }
}

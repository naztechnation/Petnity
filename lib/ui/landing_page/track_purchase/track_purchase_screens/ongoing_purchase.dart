import 'package:flutter/material.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/ui/landing_page/track_purchase/track_purchase_widgets/ongoing_purchase_widget.dart';
import 'package:petnity/ui/landing_page/track_purchase/track_purchase_widgets/ongoing_service_widget.dart';
import '../track_purchase_widgets/pet_Walking_session_widget.dart';
import '../track_purchase_widgets/video_call_session_widget.dart';

class OngoingPurchases extends StatelessWidget {
  const OngoingPurchases({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: screenSize(context).height * .7,
        child: SingleChildScrollView(
          child: Column(
            children: [for (var i = 0; i < 10; i++) OngoingPurchaseWidget()],
          ),
        ));
  }
}

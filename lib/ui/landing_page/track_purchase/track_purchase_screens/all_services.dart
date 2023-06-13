import 'package:flutter/material.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/ui/landing_page/track_purchase/track_purchase_widgets/ongoing_service_widget.dart';
import 'package:petnity/ui/landing_page/track_purchase/track_purchase_widgets/video_call_session_widget.dart';
import '../track_purchase_widgets/ongoing_purchase_widget.dart';

class AllServices extends StatelessWidget {
  const AllServices({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: screenSize(context).height * .7,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Ongoing Services'),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: screenSize(context).width * 0.03),
              child: OngoinServiceWidget(),
            ),
            SizedBox(
              height: 15,
            ),
            Text('Awaiting Sessions'),
            Container(
                margin: EdgeInsets.symmetric(
                    horizontal: screenSize(context).width * 0.03),
                child: VideoCallSessionWidget()),
            SizedBox(
              height: 15,
            ),
            Text('Ongoing Purchases'),
            Container(
                margin: EdgeInsets.symmetric(
                    horizontal: screenSize(context).width * 0.03),
                child: OngoingPurchaseWidget()),
            // ProgressTracker()
          ],
        ),
      ),
    );
  }
}

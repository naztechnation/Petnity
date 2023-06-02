import 'package:flutter/material.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/ui/landing_page/track_purchase/track_purchase_widgets/ongoing_service_widget.dart';

class OngoinServices extends StatelessWidget {
  const OngoinServices({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenSize(context).height * .7,
      child: SingleChildScrollView(
        child: Column(
          children: [
            for (var i = 0; i < 10; i++) OngoinServiceWidget(),
          ],
        ),
      ),
    );
  }
}

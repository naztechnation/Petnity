import 'package:flutter/material.dart';
import 'package:petnity/res/app_constants.dart';

class OngoingServices extends StatelessWidget {
  const OngoingServices({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenSize(context).height * .7,
      child: SingleChildScrollView(
        child: Column(
          children: [
           // for (var i = 0; i < 10; i++) OngoingServiceWidget(),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/ui/landing_page/track_purchase/track_purchase_widgets/ongoing_service_widget.dart';
import '../track_purchase_widgets/pet_Walking_session_widget.dart';
import '../track_purchase_widgets/video_call_session_widget.dart';

class AwaitingSession extends StatelessWidget {
  const AwaitingSession({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: screenSize(context).height * .7,
        child: SingleChildScrollView(
          child: Column(
            children: [
              PetWalkingSessionWidget(),
              VideoCallSessionWidget(),
              PetWalkingSessionWidget(),
              VideoCallSessionWidget(),
              PetWalkingSessionWidget(),
              VideoCallSessionWidget(),
            ],
          ),
        ));
  }
}

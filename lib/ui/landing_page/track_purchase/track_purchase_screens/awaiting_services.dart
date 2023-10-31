import 'package:flutter/material.dart';
import 'package:petnity/res/app_constants.dart';
import '../track_purchase_widgets/pet_Walking_session_widget.dart';
import '../track_purchase_widgets/video_call_session_widget.dart';

class AwaitingServices extends StatelessWidget {
  const AwaitingServices({super.key});

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

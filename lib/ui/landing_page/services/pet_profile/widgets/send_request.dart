import 'package:flutter/material.dart';
import 'package:petnity/res/app_images.dart';
import 'package:petnity/ui/landing_page/services/pet_profile/widgets/request_success.dart';
import 'package:petnity/ui/widgets/image_view.dart';

import '../../../../widgets/back_button.dart';
import 'dart:async';

class SendRequest extends StatefulWidget {
  const SendRequest({Key? key}) : super(key: key);

  @override
  _SendRequestState createState() => _SendRequestState();
}

class _SendRequestState extends State<SendRequest> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    // Set the desired duration for the "Sending request" screen
    const Duration duration = Duration(seconds: 5);

    Timer(duration, () {
      // Redirect to the next screen after the duration has passed
      // Replace `NextScreen()` with the screen you want to navigate to
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => RequestSuccess()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 25),
          SafeArea(
            child: backButton(context),
          ),
          const SizedBox(height: 250),
          // Loading gif
          ImageView.asset(
            AppImages.loading,
            height: 100,
          ),
          const SizedBox(height: 52),
          Text(
            'Sending request',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
          ),
        ],
      ),
    );
  }
}

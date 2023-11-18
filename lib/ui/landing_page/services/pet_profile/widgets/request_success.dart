import 'package:flutter/material.dart';

import '../../../../../res/app_colors.dart';
import '../../../../../utils/navigator/page_navigator.dart';
import '../../../../widgets/back_button.dart';
import '../../../../widgets/button_view.dart';
import '../../pet_sellers.dart/track_services.dart';

class RequestSuccess extends StatelessWidget {
  const RequestSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 25),
              SafeArea(
                child: Row(
                  children: [
                    backButton(context),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacer(),
                Container(
                  width: MediaQuery.sizeOf(context).width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Color(0xFFFFFFFF),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 18, right: 17, top: 15, bottom: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Successful',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 24),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Your session request has been sent to dera ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 254,
                ),
                ButtonView(
                  borderRadius: 30,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  color: AppColors.lightSecondary,
                  onPressed: () {
                   AppNavigator.pushAndStackPage(context,
                                        page: TrackServices());
                  },
                  child: Text(
                    'Track',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

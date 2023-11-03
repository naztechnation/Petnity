import 'dart:async';

import 'package:flutter/material.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_images.dart';
import 'package:petnity/ui/landing_page/services/service_provider_profile.dart';
import 'package:petnity/ui/settings/update_successful_page.dart';
import 'package:petnity/ui/widgets/back_button.dart';
import 'package:petnity/ui/widgets/button_view.dart';
import 'package:petnity/ui/widgets/custom_text.dart';
import 'package:petnity/utils/navigator/page_navigator.dart';

class TrackConsultingService extends StatefulWidget {
  @override
  _TrackConsultingServiceState createState() => _TrackConsultingServiceState();
}

class _TrackConsultingServiceState extends State<TrackConsultingService> {
  bool _isShowingNotification = false;

  @override
  void initState() {
    super.initState();
    _showNotification();
    startCountdown();
  }

  int _countdown = 10;
  Timer? _timer;
  bool begin = false;
  void startCountdown() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_countdown > 0) {
        setState(() {
          _countdown--;
        });
      } else {
        setState(() {
          begin = true;
        });
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  bool releasePayment = false;

  bool sessionEnded = false;
  void _showNotification() {
    Timer(Duration(seconds: 4), () {
      setState(() {
        _isShowingNotification = true;
      });
    });

    Timer(Duration(seconds: 8), () {
      setState(() {
        _isShowingNotification = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: PreferredSize(
        preferredSize: screenSize(context) * .1,
        child: Container(
          padding: EdgeInsets.only(top: 20),
          child: AppBar(
            centerTitle: true,
            title: Text(
              'Track Service',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: backButton(context),
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: screenSize(context).height * .2,
        // color: Colors.red,
        child: Center(
          child: begin
              ? Container(
                  margin: EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  child: Column(
                    children: [
                      sessionEnded
                          ? Container(
                              padding: EdgeInsets.all(20),
                              width: screenSize(context).width * .9,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Center(
                                child: CustomText(
                                  text: 'Session Ended',
                                  size: 13,
                                  weight: FontWeight.bold,
                                ),
                              ),
                            )
                          : ButtonView(
                              onPressed: () {
                                if (releasePayment) {
                                  AppNavigator.pushAndStackPage(
                                    context,
                                    page: UpdateSuccessfulScreen(
                                      successMessage:
                                          'Funds has been released succesfully',
                                      buttonText: 'Rate & Review service',
                                      onPressed: () {},
                                    ),
                                  );
                                  return;
                                }
                                setState(() {
                                  sessionEnded = true;
                                });
                                Future.delayed(Duration(seconds: 2), () {
                                  setState(() {
                                    sessionEnded = false;
                                    releasePayment = true;
                                  });
                                });
                              },
                              child: CustomText(
                                text: releasePayment
                                    ? 'Release payment'
                                    : 'Begin session',
                                color: Colors.white,
                                size: 13,
                                weight: FontWeight.bold,
                              ),
                            ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: 'Session ID',
                              color: Colors.black,
                              size: 13,
                              weight: FontWeight.bold,
                            ),
                            CustomText(
                              text: '3243J46L46L',
                              color: Colors.black,
                              size: 13,
                              weight: FontWeight.bold,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              : Container(
                  margin: EdgeInsets.only(
                      bottom: begin
                          ? screenSize(context).height * .02
                          : screenSize(context).height * .12),
                  padding: EdgeInsets.all(20),
                  width: screenSize(context).width * .9,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)),
                  child: Center(
                    child: CustomText(
                      text: 'Session begins in $_countdown',
                    ),
                  ),
                ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: 'Service provider details',
                  weight: FontWeight.bold,
                  size: 14,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: screenSize(context).width,
                  child: Row(
                    children: [
                      Container(
                        width: screenSize(context).width * .15,
                        height: screenSize(context).height * .075,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            image: DecorationImage(
                                image: AssetImage(AppImages.person),
                                fit: BoxFit.fill)),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: screenSize(context).width * .7,
                        padding: EdgeInsets.only(right: 20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: 'Name',
                                  size: 13,
                                ),
                                CustomText(
                                  text: 'Service',
                                  size: 13,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: 'Sandra Adams',
                                  size: 13,
                                  weight: FontWeight.bold,
                                ),
                                CustomText(
                                  text: 'Vet',
                                  size: 13,
                                  weight: FontWeight.bold,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: screenSize(context).height * .07,
                  width: screenSize(context).width,
                  child: ButtonView(
                    expanded: false,
                    onPressed: () {
                      // AppNavigator.pushAndStackPage(context,
                      //     page: ServiceProviderProfile());
                    },
                    borderRadius: 50,
                    child: CustomText(
                      text: 'View profile',
                      color: Colors.blue,
                      size: 13,
                      weight: FontWeight.bold,
                    ),
                    color: Colors.white,
                    borderColor: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                CustomText(
                  text: 'Call Starts',
                  size: 13,
                  weight: FontWeight.bold,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  width: screenSize(context).width * .9,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)),
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Icon(Icons.timer_sharp),
                            CustomText(
                              text: '05 pm',
                              size: 13,
                              weight: FontWeight.bold,
                            )
                          ],
                        ),
                      ),
                      Expanded(
                          child: Row(
                        children: [
                          Icon(
                            Icons.calendar_month,
                            color: Colors.black.withOpacity(0.3),
                          ),
                          CustomText(
                            text: '20th October, 2023',
                            size: 13,
                            weight: FontWeight.bold,
                            color: Colors.black.withOpacity(0.3),
                          )
                        ],
                      ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomText(
                  text: 'Call Ends',
                  size: 13,
                  weight: FontWeight.bold,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  width: screenSize(context).width * .9,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)),
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Icon(Icons.timer_sharp),
                            CustomText(
                              text: '06 pm',
                              size: 13,
                              weight: FontWeight.bold,
                            )
                          ],
                        ),
                      ),
                      Expanded(
                          child: Row(
                        children: [
                          Icon(
                            Icons.calendar_month,
                            color: Colors.black.withOpacity(0.3),
                          ),
                          CustomText(
                            text: '20th October, 2023',
                            size: 13,
                            weight: FontWeight.bold,
                            color: Colors.black.withOpacity(0.3),
                          )
                        ],
                      ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  width: screenSize(context).width * .9,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            CustomText(
                              text: 'Amount paid - ',
                              size: 13,
                              weight: FontWeight.bold,
                            ),
                            CustomText(
                              text: '100\$',
                              size: 13,
                              weight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.green.withOpacity(0.3),
                        ),
                        child: CustomText(
                          text: 'PAID',
                          color: Colors.green,
                          size: 13,
                          weight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                if (releasePayment)
                  Center(
                    child: CustomText(
                      text: 'Session ended',
                      size: 13,
                      weight: FontWeight.bold,
                    ),
                  )
              ],
            ),
            if (_isShowingNotification)
              Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                height: screenSize(context).height * .1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: CustomText(
                      maxLines: 4,
                      text:
                          'Your consultation video call is in $_countdown Seconds, get ready',
                    )),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.notifications,
                        color: Colors.blue,
                      ),
                    )
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

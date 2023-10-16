import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; 
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_images.dart'; 
import 'package:petnity/ui/service_povider_section/service_provider_home/feedback.dart'; 
import 'package:petnity/ui/location/widgets/map_view.dart';
import 'package:petnity/ui/settings/update_successful_page.dart';
import 'package:petnity/ui/widgets/back_button.dart';
import 'package:petnity/ui/widgets/button_view.dart';
import 'package:petnity/ui/widgets/custom_text.dart'; 
import 'package:provider/provider.dart';

import '../../../blocs/location/location_cubit.dart';
import '../../../model/view_models/account_view_model.dart';
import '../../../requests/repositories/location_repo/location_repository_impl.dart';
import '../../landing_page/services/pet_profile/pet_profile.dart';

class TrackService extends StatefulWidget {
  @override
  _TrackServiceState createState() => _TrackServiceState();
}

class _TrackServiceState extends State<TrackService> {
  bool _isShowingNotification = false;

  @override
  void initState() {
    super.initState();
    _showNotification();
    startCountdown();
    Future.delayed(Duration(seconds: 15), () {
      setState(() {
        begin = false;
        ended = true;
      });
    });
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

  var ended = false;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LocationCubit>(
          lazy: false,
          create: (_) => LocationCubit(
              locationRepository: LocationRepositoryImpl(),
              userViewModel:
                  Provider.of<AccountViewModel>(context, listen: false)),
        )
      ],
      child: Scaffold(
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
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: screenSize(context).height * .9,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: 'Pet owner details',
                        weight: FontWeight.bold,
                      ),
                      Container(
                        width: screenSize(context).width,
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: screenSize(context).width * .16,
                              height: screenSize(context).height * .08,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  image: DecorationImage(
                                      image: AssetImage(AppImages.person),
                                      fit: BoxFit.fill)),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    text: 'Owner name',
                                    size: 12,
                                  ),
                                  CustomText(
                                    text: 'Sandra Lee',
                                    weight: FontWeight.bold,
                                    size: 12,
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: screenSize(context).width * .12,
                                  margin: EdgeInsets.symmetric(horizontal: 3),
                                  child: ButtonView(
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                    borderColor: Colors.red,
                                    borderWidth: 2,
                                    color: Colors.white,
                                    onPressed: () {},
                                    child: Icon(
                                      Icons.call_outlined,
                                      color: Colors.red,
                                      size: 20,
                                    ),
                                    borderRadius: 100,
                                  ),
                                ),
                                Container(
                                  width: screenSize(context).width * .12,
                                  margin: EdgeInsets.symmetric(horizontal: 3),
                                  child: ButtonView(
                                    borderColor: Colors.green,
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                    borderWidth: 2,
                                    color: Colors.white,
                                    onPressed: () {},
                                    child: Icon(
                                      Icons.chat,
                                      color: Colors.green,
                                      size: 20,
                                    ),
                                    borderRadius: 100,
                                  ),
                                ),
                                Container(
                                  width: screenSize(context).width * .12,
                                  margin: EdgeInsets.symmetric(horizontal: 3),
                                  child: ButtonView(
                                    borderColor: Colors.purple,
                                    borderWidth: 2,
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                    color: Colors.white,
                                    onPressed: () {},
                                    child: Icon(
                                      Icons.video_call,
                                      color: Colors.purple,
                                      size: 20,
                                    ),
                                    borderRadius: 100,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          CustomText(
                            text: 'Pet name - ',
                          ),
                          CustomText(
                            text: 'Thanos',
                            weight: FontWeight.bold,
                          )
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: screenSize(context).width * .05,
                            vertical: 10),
                        width: screenSize(context).width,
                        height: screenSize(context).height * .08,
                        child: ButtonView(
                            expanded: false,
                            onPressed: () => Navigator.push(context,
                                    MaterialPageRoute(builder: (_) {
                                  return PetProfile();
                                })),
                            color: Colors.white,
                            borderColor: Colors.white,
                            child: CustomText(
                              color: Colors.blue,
                              weight: FontWeight.bold,
                              text: 'View pet Profile',
                            )),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      begin ? durationtracker(context) : Container(),
                      SizedBox(
                        height: 10,
                      ),
                      CustomText(
                        text: 'Pick up date and time',
                        weight: FontWeight.bold,
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        margin: EdgeInsets.symmetric(
                            horizontal: screenSize(context).width * .05,
                            vertical: 10),
                        width: screenSize(context).width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Icon(Icons.calendar_month),
                                  CustomText(
                                    text: '20th October, 2023',
                                    size: 14,
                                  )
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Icon(Icons.timer_outlined),
                                  CustomText(
                                    text: '06 PM',
                                    size: 14,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomText(
                        text: 'Drop off date and time',
                        weight: FontWeight.bold,
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        margin: EdgeInsets.symmetric(
                            horizontal: screenSize(context).width * .05,
                            vertical: 10),
                        width: screenSize(context).width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Icon(Icons.calendar_month),
                                  CustomText(
                                    text: '20th October, 2023',
                                    size: 14,
                                  )
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Icon(Icons.timer_outlined),
                                  CustomText(
                                    text: '06 PM',
                                    size: 14,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      _map(context),
                      if (begin)
                        Container(
                          width: screenSize(context).width * .9,
                          margin: EdgeInsets.symmetric(
                              horizontal: screenSize(context).width * .05,
                              vertical: 5),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        text: 'Amount paid - ',
                                        size: 12,
                                      ),
                                      CustomText(
                                        text: '\$1000',
                                        size: 12,
                                        weight: FontWeight.bold,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        text: 'Amount Service charge - ',
                                        size: 12,
                                      ),
                                      CustomText(
                                        text: '\$100',
                                        size: 12,
                                        weight: FontWeight.bold,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        text: 'Amount withdrawable - ',
                                        size: 12,
                                      ),
                                      CustomText(
                                        text: '\$900',
                                        size: 12,
                                        weight: FontWeight.bold,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                width: screenSize(context).width * .15,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color:
                                        Colors.green.shade100.withOpacity(0.8)),
                                child: CustomText(
                                  text: 'Paid',
                                  color: Colors.green,
                                ),
                              )
                            ],
                          ),
                        ),
                      ended
                          ? Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: screenSize(context).width * .075),
                              width: screenSize(context).width * .75,
                              child: ButtonView(
                                  expanded: false,
                                  onPressed: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (_) {
                                      return UpdateSuccessfulScreen(
                                          successMessage:
                                              'Funds has been received and added to your balance',
                                          onPressed: () {});
                                    }));
                                  },
                                  child: CustomText(
                                    text: 'receive Payment',
                                    color: Colors.white,
                                    weight: FontWeight.bold,
                                  )),
                            )
                          : Container(),
                      ended
                          ? Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: screenSize(context).width * .05),
                              padding: EdgeInsets.all(15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    text: 'Session ID ',
                                    size: 12,
                                  ),
                                  CustomText(
                                    text: 'QWE123456BV',
                                    size: 12,
                                    weight: FontWeight.bold,
                                  ),
                                  InkWell(
                                    child: CustomText(
                                      text: 'Report owner',
                                      color: Colors.red,
                                      size: 12,
                                      weight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            )
                          : Container(),
                      CustomText(
                        text: 'Why service charge?',
                        size: 12,
                        weight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                      ended
                          ? Container()
                          : Container(
                              padding: EdgeInsets.all(15),
                              width: screenSize(context).width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(children: [
                                    Icon(
                                      Icons.warning_amber_outlined,
                                      color: Colors.red,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    CustomText(
                                      text: 'NOTE',
                                      weight: FontWeight.bold,
                                      size: 14,
                                    )
                                  ]),
                                  CustomText(
                                    text:
                                        'Funds would be available for withdrawal after session is completed',
                                    weight: FontWeight.bold,
                                    size: 13,
                                    maxLines: 3,
                                  )
                                ],
                              ),
                            ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: ButtonView(
                          borderRadius: 30,
                          expanded: false,
                          color: Colors.white,
                          borderColor: Colors.white,
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return FeedbackScreen();
                            }));
                          },
                          child: Center(
                            child: CustomText(
                              text: 'Feedbacks?',
                              color: Colors.blue,
                              weight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
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
      ),
    );
  }

  Widget _map(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            20,
          ),
          color: Colors.black12,
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                MapViews(
                  zoom: 15,
                ),
                Positioned(
                  left: 0,
                  bottom: 0,
                  child: Container(
                    width: screenSize(context).width * .8,
                    height: ended
                        ? screenSize(context).height * .08
                        : screenSize(context).height * .12,
                    margin: EdgeInsets.all(0),
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      color: ended
                          ? Colors.transparent
                          : Colors.white.withOpacity(1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ended
                        ? ButtonView(
                            expanded: false,
                            color: Colors.white,
                            borderColor: Colors.white,
                            onPressed: () {},
                            child: CustomText(
                              text: 'Session completed',
                              weight: FontWeight.bold,
                            ),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomText(
                                text: begin
                                    ? 'Session in progress'
                                    : 'Awaiting Session',
                                // size: 12,
                                weight: FontWeight.bold,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    text: 'Session ID ',
                                    size: 12,
                                  ),
                                  CustomText(
                                    text: 'QWE123456BV',
                                    size: 12,
                                    weight: FontWeight.bold,
                                  ),
                                ],
                              ),
                              begin
                                  ? Container()
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          text: 'Amount withdrawable - ',
                                          size: 12,
                                        ),
                                        CustomText(
                                          text: '\$900',
                                          size: 12,
                                          weight: FontWeight.bold,
                                        ),
                                      ],
                                    ),
                            ],
                          ),
                  ),
                )
              ],
            )),
        height: screenSize(context).height * .3,
        width: screenSize(context).width * .8,
      ),
    );
  }

  Widget durationtracker(BuildContext context) {
    return Container(
      width: screenSize(context).width * .9,
      height: screenSize(context).height * .14,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: 'Drop off time',
          ),
          Row(
            children: [
              Icon(Icons.timer),
              CustomText(
                text: '06 PM',
                size: 12,
              ),
              SizedBox(
                width: 10,
              ),
              Icon(Icons.calendar_month),
              CustomText(
                text: '23rd October, 2023',
                size: 12,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: 'Estimated time for walk - ',
                      size: 10,
                    ),
                    CustomText(
                      text: '2hrs',
                      size: 10,
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: 'Remaining time for walk - ',
                      size: 10,
                    ),
                    CustomText(
                      text: '2hrs',
                      size: 10,
                    ),
                  ],
                ),
              )
            ],
          ),
          LinearProgressIndicator(
            value: 0.5, // Represents the progress value (from 0.0 to 1.0)
            minHeight: 8, // Adjust the height of the progress line
            backgroundColor: Colors.grey[300], // Color of the remaining line
            valueColor: AlwaysStoppedAnimation<Color>(
                Colors.blue), // Color of the progress line
          ),
        ],
      ),
    );
  }
}

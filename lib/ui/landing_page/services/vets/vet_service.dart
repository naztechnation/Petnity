import 'dart:async';
import 'package:flutter/material.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/ui/landing_page/services/vets/consultation/consultation.dart';
import 'package:petnity/ui/widgets/back_button.dart';
import 'package:petnity/utils/navigator/page_navigator.dart';
import './treatments/treatments.dart';

class VetService extends StatefulWidget {
  @override
  _VetServiceState createState() => _VetServiceState();
}

class _VetServiceState extends State<VetService> {
  bool _isShowingNotification = false;

  @override
  void initState() {
    super.initState();
    _showNotification();
  }

  void _showNotification() {
    setState(() {
      _isShowingNotification = true;
    });

    Timer(Duration(seconds: 2), () {
      setState(() {
        _isShowingNotification = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(
        leading: backButton(context),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Vets',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: 'InterSans'),
        ),
      ),
      body: Container(
        height: screenSize(context).height * .9,
        padding: EdgeInsets.all(20),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Select session type',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'InterSans'),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () => AppNavigator.pushAndStackPage(context,
                      page: Consultation()),
                  child: Container(
                    height: screenSize(context).height * .1,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.list),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Consultation',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'InterSans'),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () =>
                      AppNavigator.pushAndStackPage(context, page: Treatment()),
                  child: Container(
                    height: screenSize(context).height * .1,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.list),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Treatments',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'InterSans'),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  child: Container(
                    height: screenSize(context).height * .1,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.list),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Prescription',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'InterSans'),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if (_isShowingNotification)
              Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                height: screenSize(context).height * .15,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: Text(
                        'Your pets bio has been sent to Dera',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Icon(
                      Icons.verified,
                      color: Colors.blue,
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

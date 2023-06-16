import 'package:flutter/material.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/ui/landing_page/services/vets/consultation/consultation_review.dart';
import 'package:petnity/ui/widgets/back_button.dart';
import 'package:petnity/ui/widgets/button_view.dart';
import 'package:petnity/ui/widgets/custom_text.dart';
import 'package:petnity/utils/navigator/page_navigator.dart';

class SessionDuration extends StatefulWidget {
  @override
  _SessionDurationState createState() => _SessionDurationState();
}

class _SessionDurationState extends State<SessionDuration> {
  double _selectedValue = 5.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: screenSize(context) * .1,
        child: Container(
          padding: EdgeInsets.only(top: 20),
          child: AppBar(
            centerTitle: true,
            title: Text(
              'Vets',
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
      backgroundColor: AppColors.scaffoldColor,
      bottomNavigationBar: Container(
        height: screenSize(context).height * .13,
        padding: EdgeInsets.symmetric(vertical: 23, horizontal: 20),
        child: ButtonView(
            borderRadius: 50,
            onPressed: () {
              AppNavigator.pushAndStackPage(context,
                  page: ConsultationReview());
            },
            child: Text('Finish up and Review')),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: screenSize(context).width,
                  child: Text(
                    'Session duration',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'InterSans'),
                  ),
                ),
                Slider(
                  value: _selectedValue,
                  min: 5.0,
                  max: 60.0,
                  inactiveColor: Colors.white,
                  divisions: 55,
                  label: '$_selectedValue mins',
                  onChanged: (value) {
                    setState(() {
                      _selectedValue = value;
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: _selectedValue == 5 ? Colors.white : null),
                      child: CustomText(
                        text: '5 mins',
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: _selectedValue > 30 && _selectedValue < 35
                              ? Colors.white
                              : null),
                      child: CustomText(
                        text: '30 mins',
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: _selectedValue == 60 ? Colors.white : null),
                      child: CustomText(
                        text: '60 mins',
                      ),
                    ),
                  ],
                )
              ],
            ),
            Center(
              child: Column(
                children: [
                  Text('Price'),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: screenSize(context).width * .4,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                        child: Text(
                            '\$${(50 * (_selectedValue / 5)).toStringAsFixed(2)}')),
                  )
                ],
              ),
            ),
            Container(
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
                    text: 'Pice per 5 mins is \$50',
                    weight: FontWeight.bold,
                    size: 14,
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

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/ui/settings/update_successful_page.dart';
import 'package:petnity/ui/widgets/back_button.dart';
import 'package:petnity/ui/widgets/button_view.dart';
import 'package:petnity/ui/widgets/custom_text.dart';
import 'package:petnity/utils/navigator/page_navigator.dart';

class Review extends StatefulWidget {
  @override
  _ReviewState createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  // CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDate = DateTime.now();
  // DateTime _selectedDate2 = DateTime.now();

  bool val = false;
  TimeOfDay _selectedTime = TimeOfDay.now();

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
              'Review',
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
        height: screenSize(context).height * .13,
        padding: EdgeInsets.symmetric(vertical: 23, horizontal: 20),
        child: ButtonView(
            borderRadius: 50,
            onPressed: () {
              AppNavigator.pushAndStackPage(context,
                  page: UpdateSuccessfulScreen(
                    onPressed: () {},
                    buttonText: 'Track',
                    successMessage:
                        'Your pet treatment session is successfull, click the button below to track your session',
                  ));
            },
            child: Text('Book session')),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: 'Pick up date',
                  weight: FontWeight.bold,
                  size: 14,
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: screenSize(context).width * .8,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Text(
                    '${DateFormat('dd-MM-yyyy').format(_selectedDate)}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomText(
                  text: 'Pick up time',
                  weight: FontWeight.bold,
                  size: 14,
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: screenSize(context).width * .8,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Text(
                    '${DateFormat('h:mm a').format(DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      DateTime.now().day,
                      _selectedTime.hour,
                      _selectedTime.minute,
                    ))}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                CustomText(
                  text: 'Pick up location',
                  weight: FontWeight.bold,
                  size: 14,
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: screenSize(context).width * .8,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Text(
                    'Emmanuel Lodge',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                width: screenSize(context).width * .9,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: 'Fee',
                    ),
                    CustomText(
                      text: '\$0',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

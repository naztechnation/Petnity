import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_strings.dart';
import 'package:petnity/ui/landing_page/services/vets/treatments/review.dart';
import 'package:petnity/ui/widgets/back_button.dart';
import 'package:petnity/ui/widgets/button_view.dart';
import 'package:petnity/ui/widgets/custom_text.dart';
import 'package:petnity/utils/navigator/page_navigator.dart';

class ScheduleDate extends StatefulWidget {
  @override
  _ScheduleDateState createState() => _ScheduleDateState();
}

class _ScheduleDateState extends State<ScheduleDate> {
  // CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDate = DateTime.now();
  DateTime _selectedDate2 = DateTime.now();

  bool val = false;
  TimeOfDay _selectedTime = TimeOfDay.now();

  Future<void> _showClockPicker() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
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
              'Schedule Date',
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
              AppNavigator.pushAndStackPage(context, page: Review());
            },
            child: Text('Finish up and Review')),
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
                  text: 'Session date',
                  weight: FontWeight.bold,
                  size: 14,
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Icon(Icons.date_range),
                    CustomText(
                      text: 'Date',
                      size: 13,
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    _showCalendar(context, 1);
                  },
                  child: Container(
                    width: screenSize(context).width * .35,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${DateFormat('dd-MM-yyyy').format(_selectedDate)}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        Icon(Icons.arrow_drop_down)
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomText(
                  text: 'Session time',
                  weight: FontWeight.bold,
                  size: 14,
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Icon(Icons.timer_sharp),
                    CustomText(
                      text: 'Time',
                      size: 13,
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    _showClockPicker();
                  },
                  child: Container(
                    width: screenSize(context).width * .35,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
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
                        Icon(Icons.arrow_drop_down)
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
            Container(
              child: Column(
                children: [
                  SwitchListTile(
                    title: Text(
                      'Notify when Dera aceepts Session?',
                      style: TextStyle(
                        fontSize: 13,
                        fontFamily: AppStrings.interSans,
                      ),
                    ),
                    value: val,
                    onChanged: (value) {
                      // Handle switch state change
                      setState(() {
                        val = value;
                      });
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
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
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showCalendar(BuildContext context, int containerIndex) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        containerIndex == 2 ? _selectedDate2 = picked : _selectedDate = picked;
      });
    }
  }
}

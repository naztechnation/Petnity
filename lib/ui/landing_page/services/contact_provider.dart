import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../model/view_models/account_view_model.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_constants.dart';
import '../../../res/app_strings.dart';
import '../../../utils/app_utils.dart';
import '../../../utils/navigator/page_navigator.dart';
import '../../widgets/back_button.dart';
import '../../widgets/button_view.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/modals.dart';
import 'review_screen.dart';
import 'widgets/contact_top.dart';

class ContactProvider extends StatefulWidget {
  const ContactProvider({super.key});

  @override
  State<ContactProvider> createState() => _ContactProviderState();
}

class _ContactProviderState extends State<ContactProvider> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String selectedTimeMain1 = 'Select Time';
  DateTime selectedDate1 = DateTime.now();
  TimeOfDay selectedTime1 = TimeOfDay.now();

  String selectedTimeMain2 = 'Select Time';

  bool _value = true;

  @override
  Widget build(BuildContext context) {
    final agent = Provider.of<AccountViewModel>(context, listen: false);
    agent.getUsername();
    return Scaffold(
      body: Container(
        height: screenSize(context).height,
        width: screenSize(context).width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [AppColors.scaffoldColor, Colors.red.shade50],
                begin: Alignment.topRight,
                end: Alignment.topLeft)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SafeArea(child: SizedBox(height: (Platform.isAndroid) ? 30 : 0)),
              Row(
                children: [
                  backButton(context),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: CustomText(
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      text: 'Select Duration',
                      weight: FontWeight.w400,
                      size: 18,
                      fontFamily: AppStrings.montserrat,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 28,
              ),
              contactTop(
                date1: selectedDate.toString().split(' ').first,
                date2: selectedDate1.toString().split(' ').first,
                time1: selectedTimeMain1,
                time2: selectedTimeMain2,
                onTap1: () {
                  _selectDate(context, true);
                },
                onTap2: () {
                  _selectTime(context, true);
                },
                onTap3: () {
                  _selectDate(context, false);
                },
                onTap4: () {
                  _selectTime(context, false);
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 320,
        color: Colors.grey.shade100,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            //Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomText(
                    textAlign: TextAlign.left,
                    maxLines: 2,
                    text: 'Notify when ${agent.agentName} accepts session?',
                    weight: FontWeight.w500,
                    size: 14,
                    fontFamily: AppStrings.interSans,
                    color: Colors.black,
                  ),
                ),
                Switch.adaptive(
                  activeColor: AppColors.lightSecondary,
                  value: _value,
                  onChanged: (newValue) => setState(() => _value = newValue),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(30)),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      text: 'Fee',
                      weight: FontWeight.w600,
                      size: 14,
                      fontFamily: AppStrings.interSans,
                      color: Colors.black,
                    ),
                    CustomText(
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      text: 'NGN ${AppUtils.convertPrice(agent.servicePrice)}',
                      weight: FontWeight.w600,
                      size: 14,
                      color: Colors.black,
                    ),
                  ]),
            ),
            const SizedBox(
              height: 45,
            ),
            ButtonView(
              color: AppColors.lightSecondary,
              borderColor: Colors.white,
              borderRadius: 40,
              onPressed: () {
                if (selectedTimeMain1 != 'Select Time' ||
                    selectedTimeMain2 != 'Select Time') {
                  checkDatesValidity(selectedDate.toString().split(' ').first,
                      selectedDate1.toString().split(' ').first, agent);
                } else {
                  Modals.showToast('please select time');
                }
              },
              child: CustomText(
                textAlign: TextAlign.left,
                maxLines: 2,
                text: 'Finish up and Review',
                weight: FontWeight.w600,
                size: 16,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, bool isFirst) async {
    DateTime selected = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selected,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selected) {
      setState(() {
        if (isFirst) {
          selectedDate = picked;
        } else {
          selectedDate1 = picked;
        }
      });
    }

  }

  Future<void> _selectTime(BuildContext context, bool isFirst) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null) {
      setState(() {
        if (isFirst) {
          selectedTime = picked;

          selectedTimeMain1 = '${selectedTime.hour}:${selectedTime.minute}';

          String formattedTime = selectedTime.format(context);
          selectedTimeMain1 = formattedTime;
        } else {
          selectedTime1 = picked;

          selectedTimeMain2 = '${selectedTime1.hour}:${selectedTime1.minute}';

          String formattedTime = selectedTime1.format(context);
          selectedTimeMain2 = formattedTime;
        }
      });
    }


   
  }

  void checkDatesValidity(String startDateString, String endDateString, agent) {
    DateTime startDate = DateTime.parse(startDateString);
    DateTime endDate = DateTime.parse(endDateString);

    if (startDate.isBefore(endDate)) {
      DateTime combinedDateTime = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime.hour,
        selectedTime.minute,
      );

      String formattedDateTime =
          DateFormat("yyyy-MM-dd'T'HH:mm:ssZ").format(combinedDateTime);

      DateTime combinedDateTime1 = DateTime(
        selectedDate1.year,
        selectedDate1.month,
        selectedDate1.day,
        selectedTime1.hour,
        selectedTime1.minute,
      );

      String formattedDateTime1 =
          DateFormat("yyyy-MM-dd'T'HH:mm:ssZ").format(combinedDateTime1);
      AppNavigator.pushAndStackPage(context,
          page: ReviewScreen(
            date1: selectedDate.toString().split(' ').first,
            date2: selectedDate1.toString().split(' ').first,
            time1: selectedTimeMain1,
            time2: selectedTimeMain2,
            amount: agent.servicePrice,
            orderId: agent.orderId,
            username: agent.username,
            serverDate: formattedDateTime,
            serverDate1: formattedDateTime1,
          ));
    } else if (startDate.isAfter(endDate)) {
      Modals.showToast(
          'Make sure your Pick up date is before your Drop off date');
    } else {}
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:petnity/ui/landing_page/services/widgets/contact_bottom.dart';
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
  String selectedDate1 = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String selectedDate2 = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String selectedTime1 = 'Select Time';
  String selectedTime2 = 'Select Time';

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
                      text: 'Contact   ${agent.agentName}',
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
                date1: selectedDate1,
                date2: selectedDate2,
                time1: selectedTime1,
                time2: selectedTime2,
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
                    text: '₦${AppUtils.convertPrice(agent.servicePrice)}',
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
              if(selectedTime1 != 'Select Time' || selectedTime2 != 'Select Time') {
              AppNavigator.pushAndStackPage(context, 
              page: ReviewScreen(date1: selectedDate1,date2: selectedDate2,
              time1: selectedTime1,time2: selectedTime2,amount: agent.servicePrice, orderId: agent.orderId,username: agent.username,));
              }else{
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
    DateTime selectedDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
        if (isFirst) {
          selectedDate1 = formattedDate;
        } else {
          selectedDate2 = formattedDate;
        }
        print('Selected date: $formattedDate');
      });
    }
  }

  Future<void> _selectTime(BuildContext context, bool isFirst) async {
    TimeOfDay selectedTime = TimeOfDay.now();
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;

        String formattedTime = selectedTime.format(context);

        if (isFirst) {
          selectedTime1 = formattedTime;
        } else {
          selectedTime2 = formattedTime;
        }
        print('Selected time: $formattedTime');
      });
    }
  }
}

import 'package:flutter/material.dart';
import 'package:petnity/ui/landing_page/services/pet_profile/widgets/send_request.dart';
import 'package:petnity/ui/landing_page/services/pet_profile/widgets/user_select_time.dart';

import '../../../../../res/app_colors.dart';
import '../../../../widgets/back_button.dart';
import '../../../../widgets/button_view.dart';

class TimeSelections extends StatefulWidget {
  const TimeSelections({super.key});

  @override
  State<TimeSelections> createState() => _TimeSelectionsState();
}

class _TimeSelectionsState extends State<TimeSelections> {
  bool _value = true;

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
                    //Time selections
                    SizedBox(width: 70),
                    Text(
                      'Time Selections',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
              ),
            ],
          ),

          //content of the time session
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 49),
                Text(
                  'Date, Time and Day',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                ),
                const SizedBox(height: 15),
                UserSelectTime(),
                SizedBox(
                  height: 300,
                ),
                //Notify
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Notify when Dera accepts session?',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14),
                      ),
                      //switch
                      Switch.adaptive(
                        activeColor: AppColors.lightSecondary,
                        value: _value,
                        onChanged: (newValue) =>
                            setState(() => _value = newValue),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 31,
                ),
                ButtonView(
                  borderRadius: 30,
                  padding: EdgeInsets.symmetric(vertical: 25),
                  color: AppColors.lightSecondary,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SendRequest(),
                      ),
                    );
                  },
                  child: Text(
                    'Send Request',
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

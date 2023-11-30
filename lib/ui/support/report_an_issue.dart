import 'package:flutter/material.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_images.dart';
import 'package:petnity/ui/widgets/button_view.dart';
import 'package:petnity/ui/widgets/image_view.dart';
import 'package:petnity/ui/widgets/text_edit_view.dart';

import '../widgets/back_button.dart';
import '../widgets/custom_multi_toogle.dart';

class ReportIssue extends StatefulWidget {
  @override
  State<ReportIssue> createState() => _ReportIssueState();
}

class _ReportIssueState extends State<ReportIssue> {
  final TextEditingController bug = TextEditingController();


  List<String> complaints = ['Pending transactions', 'Fake vendor', 'Cancelled session', 'Rejected cards',];
  String selectedComplaints = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: ButtonView(
          borderRadius: 40,
          onPressed: () {},
          child: Text('Done'),
        ),
      ),
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.lightBackground,
      appBar: PreferredSize(
        preferredSize: screenSize(context) * .1,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: AppBar(
            elevation: 0,
            backgroundColor: AppColors.lightBackground,
            leading:  backButton(context),
            title: Text(
              'Report an issue',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextEditView(
              controller: bug,
              fillColor: Colors.white,
              isDense: true,
              borderRadius: 20,
              hintText: 'Type issue',
            ),
            SizedBox(
              height: 15,
            ),
            Text('Suggestions'),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: EdgeInsets.all(0),
              child: CustomMultiToggle(
              title: complaints,
              fontSize: 14,
              // selectedColor: AppColors.lightPrimary,
                   color: AppColors.lightPrimary,
                   selectedTextColor: AppColors.lightPrimary,
              //     textColor: Colors.black,
              height: 40,
              contentMargin: const EdgeInsets.all(0),
              onSelected: (index) {
                setState(() {
                  selectedComplaints = complaints[index];
                  bug.text = selectedComplaints;
                });
              },
            ), )
          ],
        ),
      ),
    );
  }
}

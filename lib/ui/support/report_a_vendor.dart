import 'package:flutter/material.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/ui/widgets/button_view.dart';
import 'package:petnity/ui/widgets/text_edit_view.dart';

import '../widgets/back_button.dart';

class ReportVendor extends StatelessWidget {
  final TextEditingController vendorName = TextEditingController();
  final TextEditingController problem = TextEditingController();

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
            leading: backButton(context),
            title: Text(
              'Report a vendor',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextEditView(
              controller: vendorName,
              fillColor: Colors.white,
              isDense: true,
              borderRadius: 20,
              hintText: 'Input vendor\'s username',
            ),
             
            SizedBox(
              height: 0,
            ),
             TextEditView(
              controller: vendorName,
              fillColor: Colors.white,
              isDense: true,
              borderRadius: 20,
              hintText: 'report problem',
            ),
            
          ],
        ),
      ),
    );
  }
}

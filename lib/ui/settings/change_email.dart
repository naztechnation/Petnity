
import 'package:flutter/material.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_images.dart';
import 'package:petnity/ui/settings/update_successful_page.dart';
import 'package:petnity/ui/widgets/button_view.dart';
import 'package:petnity/ui/widgets/image_view.dart';
import './widgets/confirm_OTP.dart';

class ChangeEmail extends StatelessWidget {
  final TextEditingController number = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: screenSize(context).height * .1,
        child: ButtonView(
          borderRadius: 40,
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                return ConfirmOTP(
                  route: UpdateSuccessfulScreen(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      successMessage: 'Your email has been updated'),
                  type: 'email',
                );
              },
            );
          },
          child: Text('Verify'),
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
            leading: InkWell(
              child: ImageView.svg(AppImages.backButton),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              'Change Email',
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
            Text('New Email'),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: TextField(
                controller: number,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/ui/widgets/button_view.dart';

import '../../res/app_colors.dart';

class AccountDeleted extends StatelessWidget {
  const AccountDeleted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: screenSize(context).height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: screenSize(context).height * 0.4,
            ),
            Text(
              'Account deleted successfully',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Container(
              height: screenSize(context).height * 0.3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: screenSize(context).width * .8,
                    child: ButtonView(onPressed: () {}, child: Text('Sign in')),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: screenSize(context).width * .8,
                    child: ButtonView(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                            color: AppColors.lightSecondary, fontWeight: FontWeight.bold),
                      ),
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

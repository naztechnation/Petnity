import 'package:flutter/material.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_images.dart';
import 'package:petnity/ui/settings/settings.dart';
import 'package:petnity/ui/widgets/button_view.dart';
import 'package:petnity/ui/widgets/image_view.dart';

class UpdateSuccessfulScreen extends StatelessWidget {
  final String successMessage;
  VoidCallback onPressed;
  final String buttonText;

  UpdateSuccessfulScreen({
    required this.successMessage,
    required this.onPressed,
    this.buttonText = 'back',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(10),
        margin:
            EdgeInsets.symmetric(horizontal: screenSize(context).width * .15),
        child: ButtonView(
          onPressed: onPressed,
          child: Text(buttonText),
        ),
      ),
      appBar: PreferredSize(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: AppBar(
              leading: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: ImageView.svg(AppImages.backButton)),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
          ),
          preferredSize: screenSize(context) * .1),
      body: Container(
        height: screenSize(context).height,
        child: Column(
          children: [
            Container(
              height: screenSize(context).height * .4,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              color: Colors.transparent,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Card(
                    elevation: 0,
                    child: Container(
                      height: screenSize(context).height * .15,
                      width: screenSize(context).width * .9,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Successful',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(successMessage),
                        ],
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

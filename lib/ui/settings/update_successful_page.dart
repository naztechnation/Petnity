import 'package:flutter/material.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_strings.dart';
import 'package:petnity/ui/widgets/back_button.dart';
import 'package:petnity/ui/widgets/button_view.dart';
import 'package:petnity/ui/widgets/custom_text.dart';

class UpdateSuccessfulScreen extends StatelessWidget {
  final String successMessage;
  final VoidCallback onPressed;
  final String buttonText;
  final bool purchaseID;
  final String id;
  final String notetext;

  UpdateSuccessfulScreen(
      {required this.successMessage,
      required this.onPressed,
      this.buttonText = 'back',
      this.purchaseID = false,
      this.notetext = '',
      this.id = ''});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      bottomNavigationBar: Container(
        height: purchaseID
            ? screenSize(context).height * .3
            : screenSize(context).height * .12,
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (purchaseID)
              Container(
                padding: EdgeInsets.all(20),
                height: screenSize(context).height * .15,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Icon(
                        Icons.warning_amber_outlined,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      CustomText(
                        text: 'NOTE',
                        weight: FontWeight.bold,
                        size: 14,
                      )
                    ]),
                    Flexible(
                      child: CustomText(
                        maxLines: 3,
                        text: notetext,
                        weight: FontWeight.bold,
                        size: 14,
                      ),
                    )
                  ],
                ),
              ),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: screenSize(context).width * .15),
              child: ButtonView(
                onPressed: onPressed,
                child: Text(buttonText),
              ),
            ),
          ],
        ),
      ),
      appBar: PreferredSize(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: AppBar(
              leading: backButton(context),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
          ),
          preferredSize: screenSize(context) * .1),
      body: Container(
        height: screenSize(context).height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                          Text(
                            successMessage,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            if (purchaseID)
              Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                width: screenSize(context).width * .9,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: 'Purchase ID',
                      weight: FontWeight.bold,
                      fontFamily: AppStrings.interSans,
                    ),
                    CustomText(
                      text: id,
                      weight: FontWeight.bold,
                      fontFamily: AppStrings.montserrat,
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

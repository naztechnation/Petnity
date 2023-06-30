import 'package:flutter/material.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_images.dart';
import 'package:petnity/ui/settings/update_successful_page.dart';
import 'package:petnity/ui/widgets/button_view.dart';
import 'package:petnity/ui/widgets/image_view.dart';

class SavedCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: screenSize(context).height * .1,
        child: ButtonView(
          borderRadius: 40,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return UpdateSuccessfulScreen(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  successMessage: 'Your card has been added successfully');
            }));
          },
          child: Text('Add Card'),
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
              'Saved Cards',
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
            ATMCard(context, [
              Colors.blue,
              Colors.green,
            ]),
            ATMCard(context, [
              Colors.pink,
              Colors.orange,
            ]),
          ],
        ),
      ),
    );
  }

  Widget ATMCard(BuildContext context, List<Color> colors) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, 'cardDetails'),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        height: screenSize(context).height * .3,
        width: screenSize(context).width * .95,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
            colors: colors,
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Mastercard',
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
            Container(
              height: screenSize(context).height * .2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Divider(),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: screenSize(context).width * .15,
                    height: screenSize(context).height * .06,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    '2134 **** **** 9823',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        wordSpacing: 10,
                        letterSpacing: 3),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

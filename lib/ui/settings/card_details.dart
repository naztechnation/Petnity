import 'package:flutter/material.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_images.dart';
import 'package:petnity/ui/widgets/image_view.dart';

class CardDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: screenSize(context).height * .1,
        child: Center(
          child: InkWell(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(20),
              child: Text(
                'Delete Card',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ),
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
              'Card details',
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
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListTile(
                title: Text(
                  'Card Name',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('Sandra Adams'),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListTile(
                title: Text(
                  'Card Name',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('Sandra Adams'),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListTile(
                title: Text(
                  'Card Name',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('Sandra Adams'),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListTile(
                title: Text(
                  'Card Name',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('Sandra Adams'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

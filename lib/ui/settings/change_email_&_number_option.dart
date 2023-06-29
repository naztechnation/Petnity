import 'package:flutter/material.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_images.dart';
import 'package:petnity/ui/widgets/image_view.dart';

class ChangeEmailAndNumber extends StatelessWidget {
  final TextEditingController number = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              'Change Email/ Number',
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
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: ListTile(
                title: Text(
                  "09150515270",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('Change Number'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.pushNamed(context, 'changeNumber');
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: ListTile(
                title: Text(
                  "JohnWick@gmail.com",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('Change Email'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.pushNamed(context, 'changeEmail');
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

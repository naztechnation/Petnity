import 'package:flutter/material.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_images.dart';
import 'package:petnity/ui/widgets/button_view.dart';
import 'package:petnity/ui/widgets/image_view.dart';
import 'package:petnity/ui/widgets/text_edit_view.dart';

class ReportBug extends StatelessWidget {
  final TextEditingController bug = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: screenSize(context).height * .1,
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
            leading: InkWell(
              child: ImageView.svg(AppImages.backButton),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              'Report a bug',
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
              controller: bug,
              fillColor: Colors.white,
              borderRadius: 20,
              hintText: 'Type bug',
            ),
          ],
        ),
      ),
    );
  }
}

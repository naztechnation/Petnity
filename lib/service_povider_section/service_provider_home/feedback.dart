import 'package:flutter/material.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/ui/settings/update_successful_page.dart';
import 'package:petnity/ui/widgets/back_button.dart';
import 'package:petnity/ui/widgets/button_view.dart';
import 'package:petnity/ui/widgets/custom_text.dart';
import 'package:petnity/ui/widgets/text_edit_view.dart';

class FeedbackScreen extends StatelessWidget {
  FeedbackScreen({super.key});

  TextEditingController _feedback = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.scaffoldColor,
        appBar: PreferredSize(
          preferredSize: screenSize(context) * .1,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: backButton(context),
              title: CustomText(
                text: 'Feedback',
                size: 17,
                weight: FontWeight.bold,
              ),
              centerTitle: true,
            ),
          ),
        ),
        bottomNavigationBar: Container(
          width: screenSize(context).width * .8,
          height: screenSize(context).height * .1,
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ButtonView(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return UpdateSuccessfulScreen(
                      successMessage: 'Feedback sent',
                      onPressed: () {},
                    );
                  }));
                },
                child: Text('Send'),
              ),
            ],
          ),
        ),
        body: Container(
          height: screenSize(context).height * .8,
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextEditView(
                controller: _feedback,
                hintText: 'Type feedback to Pet Owner',
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}

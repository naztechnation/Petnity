import 'package:flutter/material.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/ui/widgets/back_button.dart';
import 'package:petnity/ui/widgets/button_view.dart';

import '../../res/app_strings.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool switchValue1 = false;
  bool switchValue2 = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.lightBackground,
        bottomNavigationBar: Container(
          height: 40,
          child: Center(
            child: InkWell(
              onTap: () => _showBottom(),
              child: Text(
                'Delete Account',
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        appBar: PreferredSize(
          preferredSize: screenSize(context) * .1,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: AppBar(
              centerTitle: true,
              title: Text(
                'Settings',
                style: TextStyle(
                    fontSize: 19.0,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                    fontFamily: AppStrings.interSans),
              ),
              leading: backButton(context),
              elevation: 0,
              backgroundColor: Colors.transparent,
              iconTheme: IconThemeData(color: Colors.black),
            ),
          ),
        ),
        body: ListView.builder(
          itemCount: 7,
          itemBuilder: (context, index) {
            if (index == 0) {
              return TileWidget(
                  title: 'Change Password',
                  icon: Icon(Icons.lock),
                  onpressed: () {
                    Navigator.pushNamed(context, 'changePassword');
                  });
            } else if (index == 1) {
              return TileWidgetWithSwitch(
                  title: 'Hide pet from Scan',
                  icon: Icon(Icons.remove_red_eye),
                  switchh: Switch(
                    value: switchValue1,
                    onChanged: (value) {
                      setState(() {
                        switchValue1 = value;
                      });
                    },
                  ),
                  onpressed: () {});
            } else if (index == 2) {
              return TileWidgetWithSwitch(
                  title: 'Turn on Location',
                  icon: Icon(Icons.location_on),
                  switchh: Switch(
                    value: switchValue2,
                    onChanged: (value) {
                      setState(() {
                        switchValue2 = value;
                      });
                    },
                  ),
                  onpressed: () {});
            } else if (index == 3) {
              return TileWidget(
                  title: 'Cards and Payment',
                  icon: Icon(Icons.payment),
                  onpressed: () {
                    Navigator.pushNamed(context, 'paymentAndCard');
                  });
            } else if (index == 4) {
              return TileWidget(
                  title: 'Change number and Email',
                  icon: Icon(Icons.change_circle),
                  onpressed: () {
                    Navigator.pushNamed(context, 'changeEmailandNumber');
                  });
            } else if (index == 5) {
              return TileWidget(
                  title: 'FAQ',
                  icon: Icon(Icons.question_mark),
                  onpressed: () {
                    Navigator.pushNamed(context, 'faqs');
                  });
            } else {
              return TileWidget(
                  title: 'Privacy Policy',
                  icon: Icon(Icons.privacy_tip),
                  onpressed: () {
                    Navigator.pushNamed(context, 'privacyPolicy');
                  });
            }
          },
        ),
      ),
    );
  }

  Widget TileWidget(
      {required String title,
      required Widget icon,
      required VoidCallback onpressed}) {
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontFamily: AppStrings.interSans),
        ),
        leading: icon,
        onTap: onpressed,
      ),
    );
  }

  Widget TileWidgetWithSwitch(
      {required String title,
      required Widget icon,
      required Widget switchh,
      required Function onpressed}) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: ListTile(
          title: Text(
            title,
            style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontFamily: AppStrings.interSans),
          ),
          leading: icon,
          onTap: () => onpressed,
          trailing: switchh),
    );
  }

  _showBottom() {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(20),
          height: screenSize(context).height * .3,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Are you sure you want to delete?',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Container(
                  width: screenSize(context).width * .4,
                  child: Center(
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, 'accountDeleted');
                      },
                      child: Text(
                        'Yes, proceed',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                ),
                Container(
                    width: screenSize(context).width * .8,
                    child: ButtonView(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('No, go back')))
              ]),
        );
      },
    );
  }
}

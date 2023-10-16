import 'package:flutter/material.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_images.dart';
import 'package:petnity/res/app_strings.dart';
import 'package:petnity/ui/landing_page/widgets/listofservices_widget.dart';
import 'package:petnity/ui/notfications_pages/notifications_session.dart';
import 'package:petnity/ui/profile/profile.dart';
import 'package:petnity/ui/settings/settings.dart';
import 'package:petnity/ui/support/support.dart';
import 'package:petnity/ui/widgets/custom_text.dart';
import 'package:petnity/ui/widgets/image_view.dart';

import '../../../../utils/navigator/page_navigator.dart';

class SPCustomDrawer extends StatelessWidget {
  const SPCustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close)),
                ),
              ),
            ),
            SizedBox(
              height: screenSize(context).height * .08,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  ListTile(
                    minLeadingWidth: 0,
                    onTap: () =>
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return Profile();
                    })),
                    leading: ImageView.svg(
                      AppImages.personIcon,
                      width: 25,
                      height: 25,
                    ),
                    title: Align(
                      alignment: Alignment(-1.15, 0),
                      child: Text(
                        'Profile',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            fontFamily: AppStrings.interSans),
                      ),
                    ),
                  ),
                  ListTile(
                    minLeadingWidth: 0,
                    onTap: () {
                      AppNavigator.pushAndStackPage(context,
                          page: NotificationsScreen());
                    },
                    leading: ImageView.svg(
                      AppImages.messageIcon,
                      width: 25,
                      height: 25,
                    ),
                    title: Align(
                      alignment: Alignment(-2.0, 0),
                      child: Text(
                        'Notifications & chats',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    minLeadingWidth: 0,
                    leading: ImageView.svg(
                      AppImages.awaitingIcon,
                      width: 25,
                      height: 25,
                    ),
                    title: Align(
                      alignment: Alignment(-1.4, 0),
                      child: Text(
                        'Awaiting Sessions',
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontFamily: AppStrings.interSans),
                      ),
                    ),
                  ),
                  ListTile(
                    minLeadingWidth: 0,
                    onTap: () =>
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return Support();
                    })),
                    leading: ImageView.svg(
                      AppImages.supportIcon,
                      width: 25,
                      height: 25,
                    ),
                    title: Align(
                      alignment: Alignment(-1.19, 0),
                      child: Text(
                        'Support',
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontFamily: AppStrings.interSans),
                      ),
                    ),
                  ),
                  ListTile(
                    minLeadingWidth: 0,
                    leading: ImageView.asset(
                      AppImages.walletIcon,
                      width: 25,
                      height: 25,
                    ),
                    title: Align(
                      alignment: Alignment(-2.1, 0),
                      child: Text(
                        'Balance and Withdrawal',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            fontFamily: AppStrings.interSans),
                      ),
                    ),
                  ),
                  ListTile(
                    minLeadingWidth: 0,
                    leading: ImageView.svg(
                      AppImages.settingsIcon,
                      width: 25,
                      height: 25,
                    ),
                    onTap: () =>
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return SettingsScreen();
                    })),
                    title: Align(
                      alignment: Alignment(-1.13, 0),
                      child: Text(
                        'Settings',
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontFamily: AppStrings.interSans),
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                            ),
                          ),
                          isDismissible: true,
                          context: context,
                          builder: (context) {
                            return Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 20),
                              height: screenSize(context).height * .5,
                              child: SingleChildScrollView(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: CustomText(
                                      text: 'Services',
                                      weight: FontWeight.bold,
                                      size: 17,
                                    ),
                                  ),
                                  CustomText(
                                    text: 'All Services',
                                    weight: FontWeight.bold,
                                    size: 14,
                                  ),
                                  CustomText(
                                    size: 14,
                                    text: 'Select Service',
                                  ),
                                  ListOfServices(),
                                ],
                              )),
                            );
                          });
                    },
                    minLeadingWidth: 0,
                    leading: Container(
                      width: screenSize(context).width * .1,
                      child: Stack(
                        children: [
                          CircleAvatar(
                            backgroundColor: Color(0xFFD9D9D9),
                            radius: 14,
                          ),
                          Positioned(
                              left: 8,
                              child: Container(
                                width: screenSize(context).width * .069,
                                height: screenSize(context).height * .035,
                                decoration: BoxDecoration(
                                    color: Color(0xFFD9D9D9),
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(color: Colors.white)),
                              ))
                        ],
                      ),
                    ),
                    title: Align(
                      alignment: Alignment(-2, 0),
                      child: Text(
                        'Add other Services',
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontFamily: AppStrings.interSans),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: screenSize(context).height * .1,
            ),
            SizedBox(
              height: screenSize(context).height * .1,
            ),
            ListTile(
              onTap: () {
                AppNavigator.pushNamedAndRemoveUntil(context,
                    name: 'signInScreen');
              },
              minLeadingWidth: 0,
              leading: ImageView.svg(
                AppImages.logoutIcon,
                width: 25,
                height: 25,
              ),
              title: Align(
                alignment: Alignment(-1.1, 0),
                child: Text(
                  'Log out',
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontFamily: AppStrings.interSans),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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

import '../../../utils/navigator/page_navigator.dart';

class SPcustomDrawer extends StatelessWidget {
  const SPcustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close)),
            ),
            SizedBox(
              height: screenSize(context).height * .08,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  ListTile(
                    onTap: () =>
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return Profile();
                    })),
                    leading: ImageView.svg(
                      AppImages.personIcon,
                      width: 25,
                      height: 25,
                    ),
                    title: Text(
                      'Profile',
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontFamily: AppStrings.interSans),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      AppNavigator.pushAndStackPage(context,
                          page: NotificationsScreen());
                    },
                    leading: ImageView.svg(
                      AppImages.messageIcon,
                      width: 25,
                      height: 25,
                    ),
                    title: Text(
                      'Notifications and chats',
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontFamily: AppStrings.interSans),
                    ),
                  ),
                  ListTile(
                    leading: ImageView.svg(
                      AppImages.bagIcon,
                      width: 25,
                      height: 25,
                    ),
                    title: Text(
                      'Awaiting Sessions',
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontFamily: AppStrings.interSans),
                    ),
                  ),
                  ListTile(
                    onTap: () =>
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return Support();
                    })),
                    leading: ImageView.svg(
                      AppImages.trackIcon,
                      width: 25,
                      height: 25,
                    ),
                    title: Text(
                      'Support',
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontFamily: AppStrings.interSans),
                    ),
                  ),
                  ListTile(
                    leading: ImageView.svg(
                      AppImages.bagIcon,
                      width: 25,
                      height: 25,
                    ),
                    title: Text(
                      'Balance and Withdrawal',
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontFamily: AppStrings.interSans),
                    ),
                  ),
                  ListTile(
                    leading: ImageView.svg(
                      AppImages.filterIcon,
                      width: 25,
                      height: 25,
                    ),
                    onTap: () =>
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return SettingsScreen();
                    })),
                    title: Text(
                      'Settings',
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontFamily: AppStrings.interSans),
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
                    leading: Container(
                      width: screenSize(context).width * .1,
                      child: Stack(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 15,
                          ),
                          Positioned(
                              left: 8,
                              child: Container(
                                width: screenSize(context).width * .069,
                                height: screenSize(context).height * .035,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade600,
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                        color: Colors.grey.shade600)),
                              ))
                        ],
                      ),
                    ),
                    title: Text(
                      'Add other Services',
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontFamily: AppStrings.interSans),
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
              leading: ImageView.svg(
                AppImages.visibleIcon,
                width: 25,
                height: 25,
              ),
              title: Text(
                'Log out',
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontFamily: AppStrings.interSans),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

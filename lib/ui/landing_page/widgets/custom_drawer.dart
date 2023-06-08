import 'package:flutter/material.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_images.dart';
import 'package:petnity/res/app_strings.dart';
import 'package:petnity/ui/Profile/profile.dart';
import 'package:petnity/ui/settings/settings.dart';
import 'package:petnity/ui/support/support.dart';
import 'package:petnity/ui/widgets/button_view.dart';
import 'package:petnity/ui/widgets/image_view.dart';

class customDrawer extends StatelessWidget {
  const customDrawer({super.key});

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
                      'Cart',
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
                ],
              ),
            ),
            SizedBox(
              height: screenSize(context).height * .1,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: ButtonView(
                onPressed: () {},
                child: Text('Beign Registration'),
              ),
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

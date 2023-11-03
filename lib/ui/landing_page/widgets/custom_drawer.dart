import 'package:flutter/material.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_images.dart';
import 'package:petnity/res/app_strings.dart';
import 'package:petnity/ui/profile/profile.dart';
import 'package:petnity/ui/settings/settings.dart';
import 'package:petnity/ui/support/support.dart';
import 'package:petnity/ui/widgets/button_view.dart';
import 'package:petnity/ui/widgets/image_view.dart';
import 'package:provider/provider.dart';

import '../../../handlers/secure_handler.dart';
import '../../../model/view_models/account_view_model.dart';
import '../../../res/app_routes.dart';
import '../../../res/enum.dart';
import '../../../utils/navigator/page_navigator.dart';
import '../../notfications_pages/notifications_session.dart';

class customDrawer extends StatefulWidget {
  final VoidCallback onLogOutPressesd;
  const customDrawer({super.key, required this.onLogOutPressesd});

  @override
  State<customDrawer> createState() => _customDrawerState();
}

class _customDrawerState extends State<customDrawer> {
  String registeredPet = '';
  bool isPetRegistered = false;

  getUsername() async {
    registeredPet = await StorageHandler.getUserPetState();

    if (registeredPet != '') {
      setState(() {
        isPetRegistered = true;
      });
    }
  }

  @override
  void initState() {
    getUsername();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AccountViewModel>(context, listen: true);

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
                     onTap: () {
                      AppNavigator.pushAndStackPage(context,
                          page: Profile());
                    },
                   
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
                      'Notifications ',
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontFamily: AppStrings.interSans),
                    ),
                  ),
                  // ListTile(
                  //   leading: ImageView.svg(
                  //     AppImages.cartIcon,
                  //     width: 25,
                  //     height: 25,
                  //   ),
                  //   title: Text(
                  //     'Cart',
                  //     style: TextStyle(
                  //         fontWeight: FontWeight.w800,
                  //         fontFamily: AppStrings.interSans),
                  //   ),
                  // ),
                  ListTile(
                     onTap: () {
                      AppNavigator.pushAndStackPage(context,
                          page: Support());
                    },
                   
                    leading: ImageView.svg(
                      AppImages.supportIcon,
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
                      AppImages.settingsIcon,
                      width: 25,
                      height: 25,
                    ),
                    onTap: () {
                      AppNavigator.pushAndStackPage(context,
                          page: SettingsScreen());
                    },
                    
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
            (isPetRegistered)
                ? SizedBox.shrink()
                : Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.center,
                    child: ButtonView(
                      borderRadius: 30,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            expanded: false,
                      onPressed: () {
                        user.setUserType(UserType.user);

                        AppNavigator.pushAndStackNamed(context,
                            name: AppRoutes.kycScreenOne);
                      },
                      child: Text('Begin Registration', style: TextStyle(fontSize: 14),),
                    ),
                  ),
            SizedBox(
              height: screenSize(context).height * .1,
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                widget.onLogOutPressesd();
              },
              leading: ImageView.svg(
                AppImages.logoutIcon,
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

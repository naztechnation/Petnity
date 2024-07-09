import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_images.dart';
import 'package:petnity/res/app_strings.dart';
import 'package:petnity/ui/profile/profile.dart';
import 'package:petnity/ui/settings/settings.dart';
import 'package:petnity/ui/support/support.dart';
import 'package:petnity/ui/widgets/button_view.dart';
import 'package:petnity/ui/widgets/image_view.dart';
import 'package:petnity/ui/widgets/modals.dart';
import 'package:provider/provider.dart';

import '../../../handlers/secure_handler.dart';
import '../../../model/view_models/account_view_model.dart';
import '../../../res/app_routes.dart';
import '../../../res/enum.dart';
import '../../../utils/navigator/page_navigator.dart';
import '../../notfications_pages/notifications_session.dart';
import '../../user/wallet/user_wallet.dart';

class customDrawer extends StatefulWidget {
  final VoidCallback onLogOutPressesd;
  const customDrawer({super.key, required this.onLogOutPressesd});

  @override
  State<customDrawer> createState() => _customDrawerState();
}

class _customDrawerState extends State<customDrawer> {
  String registeredPet = '';
  String picture = '';
  bool isPetRegistered = false;

  getUsername() async {
    registeredPet = await StorageHandler.getUserPetState();

    setState(() {
      if (registeredPet != '') {
        isPetRegistered = true;
      }
    });
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signOut(BuildContext context) async {
    try {
      await _auth.signOut();

      await StorageHandler.clearCache();
      AppNavigator.pushAndReplaceName(context, name: AppRoutes.signInScreen);
    } catch (e) {
      print("Error signing out: $e");
    }
  }

  @override
  void initState() {
    getUsername();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AccountViewModel>(context, listen: false);

    user.getUserImage();
    return Drawer(
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close)),
              ),
              SizedBox(
                height: screenSize(context).height * .01,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Center(
                        child: Card(
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80),
                          ),
                          child: Container(
                            width: 120,
                            height: 120,
                            margin: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            80),
                                                    child: Image.network(
                                                      user.picture,
                                                      fit: BoxFit.cover,
                                                      width: 120,
                                                                                height: 120,
                                                      errorBuilder: (context,
                                                          error, stackTrace) {
                                                        return   ImageView
                                                            .asset(
                                                            AppImages
                                                                .avatarIcon,
                                                            fit:
                                                                BoxFit.cover);
                                                      },
                                                      loadingBuilder: (context,
                                                          child,
                                                          loadingProgress) {
                                                        if (loadingProgress ==
                                                            null)
                                                          return child;
                                                        return const ImageView
                                                            .asset(
                                                            AppImages
                                                                .avatarIcon,
                                                            fit:
                                                                BoxFit.cover);
                                                      },
                                                    )),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenSize(context).height * .012,
                    ),
                    Divider(),

                    ListTile(
                      onTap: () {
                        AppNavigator.pushAndStackPage(context, page: Profile());
                      },
                      leading: ImageView.svg(
                        AppImages.personIcon,
                        width: 22,
                        height: 22,
                      ),
                      title: Text(
                        'Profile',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            fontFamily: AppStrings.interSans),
                      ),
                    ),
                    Divider(
                      height: 0,
                    ),
                    ListTile(
                      onTap: () {
                        AppNavigator.pushAndStackPage(context,
                            page: UserWalletPage());
                      },
                      leading: ImageView.asset(
                        AppImages.walletIcon,
                        width: 22,
                        height: 22,
                      ),
                      title: Text(
                        'Wallet',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            fontFamily: AppStrings.interSans),
                      ),
                    ),
                    Divider(),

                    ListTile(
                      onTap: () {
                        AppNavigator.pushAndStackPage(context,
                            page: NotificationsScreen());
                      },
                      leading: ImageView.svg(
                        AppImages.messageIcon,
                        width: 22,
                        height: 22,
                      ),
                      title: Text(
                        'Notifications',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            fontFamily: AppStrings.interSans),
                      ),
                    ),
                    Divider(),

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
                        AppNavigator.pushAndStackPage(context, page: Support());
                      },
                      leading: ImageView.svg(
                        AppImages.supportIcon,
                        width: 22,
                        height: 22,
                      ),
                      title: Text(
                        'Support',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            fontFamily: AppStrings.interSans),
                      ),
                    ),
                    Divider(),

                    ListTile(
                      leading: ImageView.svg(
                        AppImages.settingsIcon,
                        width: 22,
                        height: 22,
                      ),
                      onTap: () {
                        AppNavigator.pushAndStackPage(context,
                            page: SettingsScreen());
                      },
                      title: Text(
                        'Settings',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            fontFamily: AppStrings.interSans),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              SizedBox(
                height: 30,
              ),
              (isPetRegistered)
                  ? SizedBox.shrink()
                  : Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      alignment: Alignment.center,
                      child: ButtonView(
                        borderRadius: 30,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        expanded: false,
                        onPressed: () {
                          user.setUserType(UserType.user);

                          AppNavigator.pushAndStackNamed(context,
                              name: AppRoutes.kycScreenOne);
                        },
                        child: Text(
                          'Begin Registration',
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ),
                    ),
              SizedBox(height: 60),
              GestureDetector(
                onTap: () {
                  Modals.showAlertOptionDialog(context,
                      title: "Log Out!!!",
                      buttonNoText: 'Cancel',
                      buttonYesText: 'Continue',
                      message: "Are you sure you want to Logout this account?.",
                      onTap: () {
                    Navigator.pop(context);
                    _signOut(context);

                    widget.onLogOutPressesd();
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ImageView.svg(
                      AppImages.logoutIcon,
                      width: 25,
                      height: 25,
                      color: Colors.red,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Align(
                      alignment: Alignment(-1.1, 0),
                      child: Text(
                        'Log out',
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Colors.red,
                            fontSize: 16,
                            fontFamily: AppStrings.interSans),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

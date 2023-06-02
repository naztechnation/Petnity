import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_strings.dart';
import 'package:petnity/ui/landing_page/servicesScreen.dart';
import 'package:petnity/ui/landing_page/shop_screen/shop_screen.dart';
import 'package:petnity/ui/landing_page/widgets/custom_drawer.dart';
import 'package:petnity/ui/widgets/image_view.dart';

import 'package:petnity/ui/landing_page/widgets/search_widget.dart';
import 'package:petnity/ui/widgets/notification_icon.dart';

import '../../res/app_images.dart';
import 'homepage.dart';
import 'track_purchase/track_purchase.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    ServicesScreen(),
    ShopScreen(),
    TrackPurchase(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: customDrawer(),
        appBar: PreferredSize(
          child: Container(
            color: AppColors.lightBackground,
            // margin: EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: _selectedIndex == 0
                ? HomepageAppbar()
                : _selectedIndex == 1
                    ? simpleAppbar('Services', Container())
                    : _selectedIndex == 2
                        ? simpleAppbar(
                            'Shop Products',
                            NotificationIcon(
                              icon: Icon(Icons.shopping_cart),
                              nun_of_notifications: 6,
                            ),
                          )
                        : _selectedIndex == 3
                            ? simpleAppbar(
                                'Track Purchases',
                                Container(
                                  padding: EdgeInsets.only(top: 20),
                                  child: InkWell(
                                    onTap: () {},
                                    child: Text(
                                      'History',
                                      style: TextStyle(
                                          color: Colors.blue, fontSize: 12),
                                    ),
                                  ),
                                ))
                            : null,
          ),
          preferredSize: MediaQuery.of(context).size * .1,
        ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: SizedBox(
          height: 68,
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: ImageView.svg(
                  AppImages.homeIcon,
                  height: 22,
                  width: 22,
                  color: _selectedIndex == 0
                      ? AppColors.lightSecondary
                      : Colors.black,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: ImageView.svg(
                  AppImages.userIcon,
                  height: 22,
                  width: 22,
                  color: _selectedIndex == 1
                      ? AppColors.lightSecondary
                      : Colors.black,
                ),
                label: 'Services',
              ),
              BottomNavigationBarItem(
                icon: ImageView.svg(
                  AppImages.bagIcon,
                  height: 22,
                  width: 22,
                  color: _selectedIndex == 2
                      ? AppColors.lightSecondary
                      : Colors.black,
                ),
                label: 'Shop',
              ),
              BottomNavigationBarItem(
                icon: ImageView.svg(
                  AppImages.trackIcon,
                  height: 22,
                  width: 22,
                  color: _selectedIndex == 3
                      ? AppColors.lightSecondary
                      : Colors.black,
                ),
                label: 'Track',
              ),
            ],
            currentIndex: _selectedIndex,
            unselectedItemColor: Colors.black,
            unselectedFontSize: 13,
            selectedFontSize: 13,
            iconSize: 16,
            selectedLabelStyle: TextStyle(
                fontWeight: FontWeight.w500, fontFamily: AppStrings.interSans),
            unselectedLabelStyle: TextStyle(
                fontWeight: FontWeight.w500, fontFamily: AppStrings.interSans),
            selectedItemColor: AppColors.lightSecondary,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}

class HomepageAppbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.lightBackground,
      iconTheme: IconThemeData(color: Colors.black),
      actions: [
        NotificationIcon(
            icon: Icon(Icons.notifications_outlined), nun_of_notifications: 5),
        CircleAvatar(
          radius: 50,
          child: ImageView.asset(AppImages.catPic),
        )
      ],
    );
  }
}

class simpleAppbar extends StatelessWidget {
  final Widget action;
  final String title;
  simpleAppbar(this.title, this.action);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.lightBackground,
      iconTheme: IconThemeData(color: Colors.black),
      title: Text(
        title,
        style:
            TextStyle(fontFamily: AppStrings.montserrat, color: Colors.black),
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: action,
        )
      ],
    );
  }
}

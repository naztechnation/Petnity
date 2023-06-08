import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_strings.dart';
import 'package:petnity/ui/landing_page/widgets/custom_drawer.dart';
import 'package:petnity/ui/notfications_pages/notifications_session.dart';
import 'package:petnity/ui/widgets/image_view.dart';
import 'package:petnity/ui/widgets/notification_icon.dart';
import 'services/services_screen.dart';
import 'shop_screen/shop_screen.dart';

import '../../res/app_images.dart';
import '../../utils/navigator/page_navigator.dart';

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
    return Scaffold(
      drawer: customDrawer(),
      backgroundColor: AppColors.lightBackground,
      appBar: PreferredSize(
        preferredSize: _selectedIndex == 0
            ? screenSize(context) * .09
            : screenSize(context) * .09,
        child: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: _selectedIndex == 0
              ? HomepageAppbar()
              : _selectedIndex == 1
                  ? simpleAppbar('Services', Container())
                  : _selectedIndex == 2
                      ? simpleAppbar(
                          'Shop Products',
                          NotificationIcon(
                            icon: ImageView.svg(AppImages.bell,),
                            nun_of_notifications: 5,
                          ))
                      : _selectedIndex == 3
                          ? simpleAppbar(
                              'Track Purchase',
                              InkWell(
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 15.0, top: 25),
                                  child: Text(
                                    'History',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.blue),
                                  ),
                                ),
                              ))
                          : Container(),
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: SizedBox(
        height: 68,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: ImageView.svg(
                AppImages.homeIcon,
                height: 20,
                width: 20,
              ),
              activeIcon: ImageView.svg(
                AppImages.homeIcon,
                height: 20,
                width: 20,
                color: AppColors.lightSecondary,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: ImageView.svg(
                AppImages.userIcon,
                height: 20,
                width: 20,
              ),
              activeIcon: ImageView.svg(
                AppImages.userIcon,
                height: 20,
                width: 20,
                color: AppColors.lightSecondary,
              ),
              label: 'Services',
            ),
            BottomNavigationBarItem(
              icon: ImageView.svg(
                AppImages.bagIcon,
                height: 20,
                width: 20,
              ),
              activeIcon: ImageView.svg(
                AppImages.bagIcon,
                height: 20,
                width: 20,
                color: AppColors.lightSecondary,
              ),
              label: 'Shop',
            ),
            BottomNavigationBarItem(
              icon: ImageView.svg(
                AppImages.trackIcon,
                height: 20,
                width: 20,
              ),
              activeIcon: ImageView.svg(
                AppImages.trackIcon,
                height: 20,
                width: 20,
                color: AppColors.lightSecondary,
              ),
              label: 'Track',
            ),
          ],
          currentIndex: _selectedIndex,
          unselectedItemColor: Colors.black,
          selectedItemColor: AppColors.lightSecondary,
          unselectedFontSize: 15,
          selectedFontSize: 15,
          iconSize: 16,
          selectedLabelStyle: TextStyle(
              fontWeight: FontWeight.w500, fontFamily: AppStrings.interSans),
          unselectedLabelStyle: TextStyle(
              fontWeight: FontWeight.w500, fontFamily: AppStrings.interSans),
          onTap: _onItemTapped,
        ),
      ),
    );
    body:
    Center(
      child: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          AppNavigator.pushAndStackPage(context, page: NotificationsScreen()),
      child: Container(
        child: Center(
          child: Text(
            'Services',
            style: TextStyle(fontSize: 20),
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

import 'package:flutter/material.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_strings.dart';
import 'package:petnity/ui/service_povider_section/service_provider_home/service_provider_home.dart';
import 'package:petnity/ui/notfications_pages/notifications_session.dart';
import 'package:petnity/ui/widgets/image_view.dart';
import 'package:petnity/ui/widgets/notification_icon.dart';

import '../../../res/app_images.dart';
import '../../../utils/navigator/page_navigator.dart';
import 'widget/drawer_custom.dart';

class ServiceProviderLandingPage extends StatefulWidget {
  @override
  _ServiceProviderLandingPageState createState() =>
      _ServiceProviderLandingPageState();
}

class _ServiceProviderLandingPageState
    extends State<ServiceProviderLandingPage> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    ServiceProviderHomePage(),
    Container(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SPCustomDrawer(),
      backgroundColor: AppColors.lightBackground,
      appBar: PreferredSize(
        preferredSize: _selectedIndex == 0
            ? screenSize(context) * .09
            : screenSize(context) * .09,
        child: Padding(
          padding: const EdgeInsets.only(top: 5, right: 20),
          child: _selectedIndex == 0
              ? HomepageAppbar()
              : _selectedIndex == 1
                  ? simpleAppbar('Payment', Container())
                  : Container(),
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        width: screenSize(context).width,
        color: Colors.white,
        height: 88,
        child: Column(
          children: [
            SizedBox(
              width: 300,
              height: 88,
              child: BottomNavigationBar(
                backgroundColor: Colors.white,
                elevation: 0,
                type: BottomNavigationBarType.fixed,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: ImageView.svg(
                      AppImages.activities,
                      height: 20,
                      width: 20,
                      color: Colors.black,
                    ),
                    activeIcon: ImageView.svg(
                      AppImages.activities,
                      height: 20,
                      width: 20,
                      color: AppColors.lightSecondary,
                    ),
                    label: 'Activities',
                  ),
                  BottomNavigationBarItem(
                    icon: ImageView.svg(
                      AppImages.creditcard,
                      height: 20,
                      width: 20,
                    ),
                    activeIcon: ImageView.svg(
                      AppImages.creditcard,
                      height: 20,
                      width: 20,
                      color: AppColors.lightSecondary,
                    ),
                    label: 'Payment',
                  ),
                ],
                currentIndex: _selectedIndex,
                unselectedItemColor: Colors.black,
                selectedItemColor: AppColors.lightSecondary,
                unselectedFontSize: 15,
                selectedFontSize: 15,
                iconSize: 16,
                selectedLabelStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontFamily: AppStrings.interSans),
                unselectedLabelStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontFamily: AppStrings.interSans),
                onTap: _onItemTapped,
              ),
            ),
          ],
        ),
      ),
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
            icon: Icon(
              Icons.notifications_outlined,
              size: 24,
            ),
            nun_of_notifications: 5)
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

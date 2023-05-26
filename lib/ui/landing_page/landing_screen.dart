import 'package:flutter/material.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/res/app_strings.dart';
import 'package:petnity/ui/widgets/image_view.dart';

import '../../res/app_images.dart';



class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  int _selectedIndex = 0;

  

  List<Widget> _widgetOptions = <Widget>[
    Page1(),
    Page2(),
    Page3(),
    Page4(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: SizedBox(
        height: 68,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: ImageView.svg(AppImages.homeIcon, height: 22,width: 22,),
              label: 'Home',
            ),
            BottomNavigationBarItem(
                          icon: ImageView.svg(AppImages.userIcon, height: 22,width: 22,),
      
              label: 'Services',
            ),
            BottomNavigationBarItem(
                          icon: ImageView.svg(AppImages.bagIcon, height: 22,width: 22,),
      
              label: 'Shop',
            ),
            BottomNavigationBarItem(
                          icon: ImageView.svg(AppImages.trackIcon, height: 22,width: 22,),
      
              label: 'Track',
            ),
          ],
          currentIndex: _selectedIndex,
          unselectedItemColor: Colors.black,
          unselectedFontSize: 15,
          selectedFontSize: 15,
          iconSize: 16,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.w500, fontFamily: AppStrings.interSans),
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w500, fontFamily: AppStrings.interSans),
          selectedItemColor: AppColors.lightSecondary,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          'Home Page',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          'Services',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

class Page3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          'Shop',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

class Page4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          'Track',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
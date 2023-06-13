import 'package:flutter/material.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_images.dart';
import 'package:petnity/res/app_strings.dart';
import 'package:petnity/ui/landing_page/widgets/listofservices_widget.dart';
import 'package:petnity/ui/widgets/button_view.dart';
import 'package:petnity/ui/widgets/image_view.dart';
import './widgets/custom_drawer.dart';

import '../widgets/filter_search_section.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          height: screenSize(context).height * .9,
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: screenSize(context).width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Hi Sarah,',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                            fontFamily: AppStrings.montserrat),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: Colors.black.withOpacity(0.7),
                            ),
                            Text(
                              'Ifite, Awka',
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.7),
                                  fontFamily: AppStrings.interSans),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'How is your pet doing?',
                  style: TextStyle(
                      fontFamily: AppStrings.interSans,
                      fontWeight: FontWeight.w800,
                      fontSize: 24),
                ),
                SizedBox(
                  height: 10,
                ),
                FilterSearchView(
                  showFilter: false,
                  controller: search,
                ),
                SizedBox(
                  height: 30,
                ),
                card(context),
                SizedBox(
                  height: 20,
                ),
                ListOfServices(),
                const SizedBox(
                  height: 40,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget search() {}

  Widget card(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.white,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 6.0,
            ),
          ],
          gradient: LinearGradient(
              colors: [AppColors.scaffoldColor, Colors.red.shade50],
              begin: Alignment.topRight,
              end: Alignment.topLeft)),
      child: Row(
        children: [
          Container(
            width: screenSize(context).width * .60,
            height: screenSize(context).height * .22,
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Register pets to get full access to products \nand services.',
                  maxLines: 3,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 17,
                      fontFamily: AppStrings.interSans),
                ),
                SizedBox(
                  height: 10,
                ),
                ButtonView(
                  borderRadius: 30,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  onPressed: () {},
                  child: Text('Begin Now'),
                  expanded: false,
                ),
              ],
            ),
          ),
          SizedBox(width: 130, child: ImageView.asset(AppImages.playingCat))
        ],
      ),
    );
  }
}

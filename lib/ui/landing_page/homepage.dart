import 'package:flutter/material.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_images.dart';
import 'package:petnity/res/app_strings.dart';
import 'package:petnity/ui/landing_page/widgets/listofservices_widget.dart';
import 'package:petnity/ui/landing_page/widgets/search_widget.dart';
import 'package:petnity/ui/widgets/button_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                Search('Search'),
                SizedBox(
                  height: 10,
                ),
                card(context),
                SizedBox(
                  height: 10,
                ),
                Container(
                    height: screenSize(context).height * .5,
                    child: ListOfServices()),
        const SizedBox(height: 40,)

              ],

            ),
          ),
        ),
      ),
    );
  }

  // Widget search() {}

  Widget card(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Card(
        color: Colors.lime[400],
        elevation: 2,
        child: Container(
          child: Row(
            children: [
              Container(
                width: screenSize(context).width * .65,
                height: screenSize(context).height * .22,
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Register pets to get full access to products and services',
                      maxLines: 4,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 17,
                          fontFamily: AppStrings.interSans),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: ButtonView(
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        onPressed: () {},
                        child: Text('Begin Now'),
                        expanded: false,
                      ),
                    ),
                  ],
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(AppImages.catPic),
              )
            ],
          ),
        ),
      ),
    );
  }
}

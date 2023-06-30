import 'package:flutter/material.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_images.dart';
import 'package:petnity/ui/widgets/back_button.dart';
import 'package:petnity/ui/widgets/button_view.dart';
import 'package:petnity/ui/widgets/image_view.dart';

import '../../res/app_strings.dart';
import '../widgets/custom_text.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool reachability = true;

  TextEditingController bug = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.lightBackground,
      appBar: PreferredSize(
        preferredSize: screenSize(context) * .1,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: AppBar(
            iconTheme: IconThemeData(color: Colors.black),
            elevation: 0,
            backgroundColor: AppColors.lightBackground,
            leading: backButton(context),
            title: Text(
              'Your Profile',
              style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontFamily: AppStrings.interSans
                        
                        ),
            ),
            centerTitle: true,
            actions: [
              Icon(
                Icons.add_box_outlined,
                size: 30,
              )
            ],
          ),
        ),
      ),
      body: Container(
        height: screenSize(context).height * .9,
        width: screenSize(context).width,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: screenSize(context).height * .4,
                width: screenSize(context).width * .9,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: AssetImage(AppImages.dogPet),
                      fit: BoxFit.fill,
                    )),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Thanos',
                       style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                        
                        fontFamily: AppStrings.interSans
                        
                        ),
                    ),
                    Text(
                      'Sex: Semale',
                       style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                        
                        fontFamily: AppStrings.interSans
                        
                        ),
                    ),
                  ],
                ),
              ),
              Container(
                width: screenSize(context).width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      child: ImageView.asset(AppImages.catPic),
                    ),
                    Container(
                      width: screenSize(context).width * .4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sandra Jhay',style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        fontFamily: AppStrings.interSans
                        
                        ),
                          ),
                          Text('You',
                          textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 14.0,
                        
                        fontFamily: AppStrings.interSans
                      )
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Text('Reachability',
                        textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 14.0,
                        
                        fontFamily: AppStrings.interSans
                        
                        )),
                        Switch(
                            value: reachability,
                            onChanged: (value) {
                              setState(() {
                                reachability = value;
                              });
                            })
                      ],
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 2.0),
                width: screenSize(context).width,
                padding: EdgeInsets.all(5),
                child: Flexible(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    // margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(),
                    child: Text(
                      'Lorem ipsum dolor sit amet consectetur. At sed accumsan ac vitae semper nunc aliquam semper eget. Vel arcu sollicitudin magna elit pellentesque egestas id. Nisl vulputate tristique amet mollis ut luctus integer ultrices accumsan. In mi aliquet consectetur id phasellus. Eu amet nulla tortor ut elementum enim. In sed tristique',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 14.0,
                        
                        fontFamily: AppStrings.interSans
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                width: screenSize(context).width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dog bio',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue),
                          color: Color(0xff8DADFF).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(30)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Age',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text('47kg',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13))
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Size',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text('0 - 12',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13))
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Breed',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontFamily: AppStrings.interSans,
                                        fontSize: 14),
                                  ),
                                  Text('Bull Dog',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontFamily: AppStrings.interSans,
                                          fontSize: 13))
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Weight',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontFamily: AppStrings.interSans,
                                        fontSize: 14),
                                  ),
                                  Text('The Dogs Age',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontFamily: AppStrings.interSans,
                                          fontSize: 13))
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                width: screenSize(context).width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Health Status',
                        style: TextStyle(
                            fontFamily: AppStrings.interSans,
                            fontWeight: FontWeight.w700,
                            fontSize: 14)),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                          color: Color(0xFF96FF8D).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Dog Illness',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontFamily: AppStrings.interSans,
                                          fontSize: 14)),
                                  Text('6 Months 3 Weeks old',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontFamily: AppStrings.interSans,
                                          fontSize: 13))
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Medication',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontFamily: AppStrings.interSans,
                                        fontSize: 14),
                                  ),
                                  Text('6-10',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontFamily: AppStrings.montserrat,
                                          fontSize: 13))
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Dog Allergies',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                      fontFamily: AppStrings.interSans,
                                    ),
                                  ),
                                  CustomText(
                                    text: 'Milk',
                                    fontFamily: AppStrings.interSans,
                                    size: 13,
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Medication',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  CustomText(
                                    text: 'None',
                                    fontFamily: AppStrings.interSans,
                                    size: 13,
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                width: screenSize(context).width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Gallery',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: screenSize(context).height * .25,
                      width: screenSize(context).width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: screenSize(context).width * .89,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: screenSize(context).width * .295,
                                    height: screenSize(context).height * .125,
                                    child: ImageView.asset(
                                      AppImages.playing,
                                      fit: BoxFit.cover,
                                    ),
                                    color: Colors.pink,
                                  ),
                                  Container(
                                    width: screenSize(context).width * .295,
                                    height: screenSize(context).height * .125,
                                    color: Colors.red,
                                    child: ImageView.asset(
                                      AppImages.playing,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                    width: screenSize(context).width * .295,
                                    height: screenSize(context).height * .125,
                                    color: Colors.blue,
                                    child: ImageView.asset(
                                      AppImages.playing,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: screenSize(context).width * .89,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: screenSize(context).width * .295,
                                    height: screenSize(context).height * .125,
                                    color: Colors.green,
                                    child: ImageView.asset(
                                      AppImages.playing,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                    width: screenSize(context).width * .295,
                                    height: screenSize(context).height * .125,
                                    color: Colors.brown,
                                    child: ImageView.asset(
                                      AppImages.playing,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                    width: screenSize(context).width * .295,
                                    height: screenSize(context).height * .125,
                                    color: Colors.purple,
                                    child: ImageView.asset(
                                      AppImages.playing,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: screenSize(context).height * .08,
                width: screenSize(context).width * .8,
                child:
                    ButtonView(onPressed: () {}, child: Text('Edit profile',  style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                        
                        fontFamily: AppStrings.interSans
                        
                        ),)),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

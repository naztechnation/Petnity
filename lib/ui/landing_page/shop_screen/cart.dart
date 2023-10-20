import 'package:flutter/material.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_images.dart';
import 'package:petnity/ui/landing_page/widgets/rating_widget.dart';
import 'package:petnity/ui/payment/payment_screen.dart';
import 'package:petnity/ui/widgets/image_view.dart';

import '../../../res/app_colors.dart';
import '../../../utils/navigator/page_navigator.dart';
import '../../widgets/button_view.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool selectAll = false;
  List<bool> itemSelected = List.generate(10, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cart',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        centerTitle: true,
        leading: ImageView.svg(AppImages.backButton),
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Select product to check out'),
                    Row(
                      children: [
                        InkWell(
                            onTap: () {
                              setState(() {
                                selectAll = !selectAll;
                                itemSelected =
                                    List.generate(10, (index) => selectAll);
                              });
                            },
                            child: Text(
                              'Select All',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: screenSize(context).height * .85,
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Card(
                          child: Container(
                            width: screenSize(context).width * .8,
                            height: screenSize(context).height * .15,
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 35,
                                  backgroundImage: AssetImage(AppImages.catPic),
                                ),
                                SizedBox(width: 8.0),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Adult Smart Feed',
                                        style:
                                            TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      RatingWidget(coloredStars: 4)
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        '\$45',
                                        style:
                                            TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Qty: 1',
                                        style:
                                            TextStyle(fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                                Radio(
                                  value: index,
                                  groupValue: itemSelected[index] ? index : null,
                                  onChanged: (value) {
                                    setState(() {
                                      itemSelected[index] = !itemSelected[index];
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
             
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: ButtonView(
                onPressed: () {
            //  AppNavigator.pushAndStackPage(context, page: PaymentDetailsScreen());
                },
                expanded: true,
                borderRadius: 41,
                child: Text(
            'Checkout',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 18),
                ),
                color: AppColors.lightSecondary,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ]),
          ),
        ],
        
      ),
      
    );
  }
}

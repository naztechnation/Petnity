import 'package:flutter/material.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_images.dart';
import 'package:petnity/ui/landing_page/shop_screen/cart.dart';
import 'package:petnity/ui/landing_page/shop_screen/widgets/review_widget.dart';
import 'package:petnity/ui/landing_page/widgets/rating_widget.dart';
import 'package:petnity/ui/widgets/button_view.dart';
import 'package:petnity/ui/widgets/image_view.dart';
import 'package:petnity/ui/widgets/notification_icon.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  var count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F6FF),
      bottomNavigationBar: Container(
        color: Colors.white,
        height: screenSize(context).height * .1,
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
              width: screenSize(context).width * .3,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Center(
                child: Text(
                  '\$45',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Container(
              width: screenSize(context).width * .6,
              child: ButtonView(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return CartScreen();
                    }));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text('Add to cart'), Icon(Icons.shopping_cart)],
                  )),
            )
          ],
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
            child: ImageView.svg(AppImages.backButton),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: NotificationIcon(
                icon: ImageView.svg(AppImages.cartIcon, width: 30,), nun_of_notifications: 3),
          ),
          Container(
            width: 20,
          )
        ],
      ),
      body: Container(
        height: screenSize(context).height * .9,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: screenSize(context).height * .15,
                width: screenSize(context).width * .4,
                margin: EdgeInsets.symmetric(
                    horizontal: screenSize(context).width * .3),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppImages.petDoctor),
                  ),
                ),
              ),
              Container(
                width: screenSize(context).width * .2,
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(30)),
                padding: EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          count += 1;
                        });
                      },
                      child: Icon(Icons.add),
                    ),
                    Text('$count'),
                    InkWell(
                      onTap: () {
                        if (count > 0) {
                          count -= 1;
                          setState(() {
                            count;
                          });
                        }
                      },
                      child: Icon(Icons.remove),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: screenSize(context).height * .618,
                color: Colors.yellow.shade50,
                padding: EdgeInsets.all(10),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Smart Adult Feed',
                        style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                      Text(
                        'in stock',
                        style: TextStyle(fontSize: 12),
                      )
                    ],
                  ),
                  RatingWidget(
                    coloredStars: 4,
                    size: 20,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    width: screenSize(context).width,
                    child: Text(
                      'About Product',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    width: screenSize(context).width,
                    child: Text(
                      'Review',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    height: screenSize(context).height * .31,
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return ReviewWidget();
                        }),
                  )
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_strings.dart';
import 'package:petnity/ui/landing_page/shop_screen/product_detail_screen.dart';
import 'package:petnity/ui/landing_page/widgets/custom_drawer.dart';
import 'package:petnity/ui/widgets/image_view.dart';

import 'package:petnity/ui/landing_page/widgets/search_widget.dart';

import 'package:petnity/ui/landing_page/widgets/rating_widget.dart';

import '../../../res/app_images.dart';
import '../homepage.dart';

class ShopScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: Container(
        height: screenSize(context).height * .9,
        width: screenSize(context).width,
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Search('Search Products'),
            ),
            SizedBox(
              height: 10,
            ),
            Text('All Products'),
            Container(
              margin: EdgeInsets.all(12),
              height: screenSize(context).height * .69,
              child: StaggeredGridView.countBuilder(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 1,
                  itemCount: 9,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return ProductDetailScreen();
                        }));
                      },
                      child: Container(
                        height: screenSize(context).height * .23,
                        child: Column(
                          children: [
                            Container(
                              height: screenSize(context).height * .2,
                              width: screenSize(context).width * .4,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                          AssetImage('assets/images/logo2.jpg'),
                                      fit: BoxFit.fill),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                            ),
                            ListTile(
                                title: Text('item name'),
                                trailing: Text('\$55'),
                                subtitle: RatingWidget(
                                  coloredStars: 3,
                                ))
                          ],
                        ),
                      ),
                    );
                  },
                  staggeredTileBuilder: (index) {
                    return StaggeredTile.count(1, index.isEven ? 1.45 : 1.6);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

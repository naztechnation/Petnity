import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:petnity/utils/navigator/page_navigator.dart';

import '../../../../res/app_colors.dart';
import '../../../../res/app_constants.dart';
import '../../../../res/app_images.dart';
import '../../../../res/app_strings.dart';
import '../../../widgets/back_button.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/filter_search_section.dart';
import '../../widgets/rating_widget.dart';
import 'track_services.dart';

class PetsOnSale extends StatelessWidget {
  PetsOnSale({super.key});

  final List<String> pets = [
    'Dog',
    'Cats',
    'Squirrels',
    'Bird',
    'Rabbits',
    'Birds',
    'Monkeys',
    'Rats',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: screenSize(context).height,
        width: screenSize(context).width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [AppColors.scaffoldColor, Colors.red.shade50],
                begin: Alignment.topRight,
                end: Alignment.topLeft)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
                child: Container(
                    color: AppColors.cardColor,
                    height: (Platform.isAndroid) ? 0 : 0)),
            Container(
              padding: const EdgeInsets.only(bottom: 0, top: 30),
              child: Row(
                children: [
                  backButton(context),
                  const SizedBox(
                    width: 40,
                  ),
                  CustomText(
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    text: 'Pets on sale',
                    weight: FontWeight.w700,
                    size: 20,
                    fontFamily: AppStrings.interSans,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 5),
              child: FilterSearchView(
                hintText: 'Search pets',
                showFilter: true,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        textAlign: TextAlign.left,
                        maxLines: 2,
                        text: 'Select pet type  ',
                        weight: FontWeight.w700,
                        size: 15,
                        fontFamily: AppStrings.interSans,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 100,
                        child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: pets.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, index) {
                              return Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        color: Colors.greenAccent,
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image:
                                                AssetImage(AppImages.rabbitPic),
                                            fit: BoxFit.cover)),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  CustomText(
                                    text: pets[index],
                                    size: 14,
                                    weight: FontWeight.w600,
                                    fontFamily: AppStrings.interSans,
                                  ),
                                ],
                              );
                            }),
                      ),
                      Container(
                        margin: EdgeInsets.all(12),
                        child: Expanded(
                          child: StaggeredGridView.countBuilder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 1,
                              itemCount: 9,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    AppNavigator.pushAndStackPage(context,
                                        page: TrackServices());
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        height:
                                            screenSize(context).height * .18,
                                        width: screenSize(context).width * .4,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image:
                                                    AssetImage(AppImages.dogg),
                                                fit: BoxFit.fill),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15))),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
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
                                );
                              },
                              staggeredTileBuilder: (index) {
                                return StaggeredTile.count(
                                    1, index.isEven ? 1.45 : 1.6);
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

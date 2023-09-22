import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:petnity/res/app_images.dart';
import 'package:provider/provider.dart';

import '../../model/view_models/user_view_model.dart';
import '../../res/app_colors.dart';
import '../../res/app_constants.dart';
import '../../res/app_strings.dart';
import '../../res/enum.dart';
import '../../utils/navigator/page_navigator.dart';
import '../widgets/back_button.dart';
import '../widgets/button_view.dart';
import '../widgets/custom_text.dart';
import '../widgets/filter_search_section.dart';

import 'kyc_screen_five.dart';
import 'widgets/pet_type_container.dart';

PetBreedsTypes _petTypes = PetBreedsTypes.none;

class KycScreenFour extends StatefulWidget {
  KycScreenFour({
    super.key,
  });

  @override
  State<KycScreenFour> createState() => _KycScreenFourState();
}

class _KycScreenFourState extends State<KycScreenFour> {
  int _index = -1;
    List<String> pets = [
      'Monkey',
      'Dog',
      'Rabbit',
      'Cat',
      'Squirell',
      'Snake',
    ];

  @override
  Widget build(BuildContext context) {
  

    final petProfile = Provider.of<UserViewModel>(context, listen: false);

    return Scaffold(
      body: Container(
        height: screenSize(context).height,
        width: screenSize(context).width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [AppColors.scaffoldColor, Colors.red.shade50],
                begin: Alignment.topRight,
                end: Alignment.topLeft)),
        child: ListView(
          shrinkWrap: true,
          children: [
            SafeArea(child: SizedBox(height: (Platform.isAndroid) ? 30 : 0)),
            backButton(context),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    textAlign: TextAlign.left,
                    maxLines: 2,
                    text: '${petProfile.petType} breed',
                    weight: FontWeight.w700,
                    size: 24,
                    fontFamily: AppStrings.montserrat,
                    color: Colors.black,
                  ),
                  SizedBox(height: 27),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CustomText(
                      textAlign: TextAlign.left,
                      maxLines: 1,
                      text: 'Select your ${petProfile.petType}breed',
                      weight: FontWeight.w500,
                      size: 16,
                      fontFamily: AppStrings.interSans,
                      color: Colors.black,
                    ),
                  ),
                  FilterSearchView(
                    hintText: 'Select breed',
                    showFilter: false,
                  ),
                  SizedBox(height: 30),
                  Container(
                    margin: EdgeInsets.all(1),
                    child: Expanded(
                      child: StaggeredGridView.countBuilder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          crossAxisSpacing: 14,
                          mainAxisSpacing: 12,
                          itemCount: pets.length,
                          itemBuilder: (context, index) {
                            return PetType(
                              imageUrl: AppImages.squirrelPic,
                              petName: pets[index],
                              isPetType: _index == index,
                              onPressed: () {
                                setState(() {
                                  _index = index;
                                  
                                  petProfile.setPetBreed(pets[index]);
                                });
                              },
                            );
                          },
                          staggeredTileBuilder: (index) {
                            return StaggeredTile.count(1, 0.45);
                          }),
                    ),
                  ),
                  SizedBox(height: 30),

                  if (_index != -1)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0.0, horizontal: 0),
                      child: ButtonView(
                        onPressed: () {
                          AppNavigator.pushAndStackPage(context,
                              page: KycScreenFive());
                        },
                        color: AppColors.lightSecondary,
                        borderRadius: 22,
                        child: CustomText(
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          text: 'Select',
                          weight: FontWeight.w700,
                          size: 20,
                          fontFamily: AppStrings.interSans,
                          color: Colors.white,
                        ),
                      ),
                    ),

                  // PetBreedBody(onPressed: (petType, index) {
                  //     petProfile.setPetBreed(petType);
                  //     AppNavigator.pushAndStackPage(context,
                  //         page: KycScreenFive(selectedPet: petType));

                  // }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:petnity/res/app_images.dart';
import 'package:petnity/ui/widgets/text_edit_view.dart';
import 'package:provider/provider.dart';

import '../../../model/view_models/account_view_model.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_constants.dart';
import '../../../res/app_strings.dart';
import '../../../res/enum.dart';
import '../../../utils/navigator/page_navigator.dart';
import '../../widgets/back_button.dart';
import '../../widgets/button_view.dart';
import '../../widgets/custom_text.dart';

import 'kyc_screen_five.dart';

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

    final petBreedController = TextEditingController();
    @override
  void initState() {
    petBreedController.text = 'None';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
  

    final petProfile = Provider.of<AccountViewModel>(context, listen: false);

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
             Row(
                children: [
                  backButton(context),
                  const SizedBox(
                    width: 40,
                  ),
                  CustomText(
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    text: 'KYC  Registration',
                    weight: FontWeight.w800,
                    size: 16,
                    fontFamily: AppStrings.interSans,
                    color: Colors.black,
                  ),
                ],
              ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 
                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.15),
                   CustomText(
                    textAlign: TextAlign.left,
                    maxLines: 2,
                    text: '${petProfile.petType} breed',
                    weight: FontWeight.w700,
                    size: 24,
                    fontFamily: AppStrings.montserrat,
                    color: Colors.black,
                  ),
            SizedBox(height: 40),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: CustomText(
                      textAlign: TextAlign.left,
                      maxLines: 1,
                      text: 'Input your ${petProfile.petType} breed',
                      weight: FontWeight.w500,
                      size: 16,
                      fontFamily: AppStrings.interSans,
                      color: Colors.black,
                    ),
                  ),
                
                  TextEditView(
                    controller: petBreedController,
                    hintText: 'Select breed',
                    isDense: true,
                  ),
                  SizedBox(height: 30),
                  // Container(
                  //   margin: EdgeInsets.all(1),
                  //   child: Expanded(
                  //     child: StaggeredGridView.countBuilder(
                  //         physics: const NeverScrollableScrollPhysics(),
                  //         shrinkWrap: true,
                  //         crossAxisCount: 2,
                  //         crossAxisSpacing: 14,
                  //         mainAxisSpacing: 12,
                  //         itemCount: pets.length,
                  //         itemBuilder: (context, index) {
                  //           return PetType(
                  //             imageUrl: AppImages.squirrelPic,
                  //             petName: pets[index],
                  //             isPetType: _index == index,
                  //             onPressed: () {
                  //               setState(() {
                  //                 _index = index;
                                  
                  //                 petProfile.setPetBreed(pets[index]);
                  //               });
                  //             },
                  //           );
                  //         },
                  //         staggeredTileBuilder: (index) {
                  //           return StaggeredTile.count(1, 0.45);
                  //         }),
                  //   ),
                  // ),
                  SizedBox(height: 30),

                  if (petBreedController.text.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0.0, horizontal: 0),
                      child: ButtonView(
                        onPressed: () {
                          petProfile.setPetBreed(petBreedController.text);
                          AppNavigator.pushAndStackPage(context,
                              page: KycScreenFive());
                        },
                        color: AppColors.lightSecondary,
                        borderRadius: 16,
                        child: CustomText(
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          text: 'Select',
                          weight: FontWeight.w500,
                          size: 16,
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

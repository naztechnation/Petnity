
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../../../model/view_models/account_view_model.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_constants.dart';
import '../../../res/app_images.dart';
import '../../../res/app_strings.dart';
import '../../../utils/navigator/page_navigator.dart';
import '../../user/user_kyc/widgets/pet_type_container.dart';
import '../../widgets/button_view.dart';
import '../../widgets/custom_text.dart';

class ServiceKycScreenOne extends StatefulWidget {
  ServiceKycScreenOne({super.key});

  @override
  State<ServiceKycScreenOne> createState() => _ServiceKycScreenOneState();
}

class _ServiceKycScreenOneState extends State<ServiceKycScreenOne> {


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

    final petProfile = Provider.of<AccountViewModel>(context, listen: false);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: screenSize(context).height,
          width: screenSize(context).width,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [AppColors.scaffoldColor, Colors.red.shade50],
                  begin: Alignment.topRight,
                  end: Alignment.topLeft)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 58,
                ),
                CustomText(
                  textAlign: TextAlign.left,
                  maxLines: 2,
                  text: 'Pet type',
                  weight: FontWeight.w700,
                  size: 24,
                  fontFamily: AppStrings.montserrat,
                  color: Colors.black,
                ),
                SizedBox(
                  height: 30,
                ),
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
                                  
                                  petProfile.setPetType(pets[index]);
                                  petProfile.setPetTypeIndex('${index + 1}');
                                });
                              },
                            );
                          },
                          staggeredTileBuilder: (index) {
                            return StaggeredTile.count(1, 0.45);
                          }),
                    ),
                  ),
                  SizedBox(height: 40,),
                   if (_index != -1)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0.0, horizontal: 0),
                      child: ButtonView(
                        onPressed: () {
                          // AppNavigator.pushAndStackPage(context,
                          //     page: KycScreenTwo());
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
                // PetTypeBody(
                //   onPressed: (petType, index) {
                //     {
                //       petProfile.setPetType(petType.capitalizeFirstOfEach);
                //       petProfile.setPetTypeIndex(index.toString());
                //       AppNavigator.pushAndStackPage(context,
                //           page: KycScreenTwo());
                //     }
                //   },
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

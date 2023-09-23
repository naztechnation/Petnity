import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../../model/view_models/service_provider_view_model.dart';
import '../../model/view_models/user_view_model.dart';
import '../../res/app_colors.dart';
import '../../res/app_constants.dart';
import '../../res/app_images.dart';
import '../../res/app_strings.dart';
import '../../utils/navigator/page_navigator.dart';
import '../user_kyc/widgets/service_provider_choice_container.dart';
import '../widgets/button_view.dart';
import '../widgets/custom_text.dart';
import 'service_kyc_nine.dart';

class KycServiceScreenEight extends StatefulWidget {
  KycServiceScreenEight({super.key});

  @override
  State<KycServiceScreenEight> createState() => _KycServiceScreenEightState();
}

class _KycServiceScreenEightState extends State<KycServiceScreenEight> {
  int _index = -1;
  List<String> services = [
    'Pet walkers',
    'Pet date',
    'Pet sitters',
    'Trainer',
    'Vets',
    'Grooming',
    'Boarding',
    'Pet care givers',
    'Pet sellers',
    'Sell products'
  ];
  List<String> servicesPics = [
    AppImages.dogWalk,
    AppImages.petDate,
    AppImages.dogSitter,
    AppImages.dogTrainer,
    AppImages.dogVets,
    AppImages.dogGrooming,
    AppImages.dogBoarding,
    AppImages.petCarers,
    AppImages.dogSellers,
    AppImages.proPet
  ];
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<ServiceProviderViewModel>(context, listen: true);

    return Scaffold(
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
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
                                SafeArea(child: SizedBox(height: (Platform.isAndroid) ? 30 : 0)),

                  CustomText(
                    textAlign: TextAlign.left,
                    maxLines: 2,
                    text: 'Select service',
                    weight: FontWeight.w700,
                    size: 24,
                    fontFamily: AppStrings.montserrat,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomText(
                    textAlign: TextAlign.left,
                    maxLines: 2,
                    text: 'What service would you like to provide',
                    weight: FontWeight.w500,
                    size: 16,
                    color: Colors.black,
                  ),
                   SizedBox(
                    height: 30,
                  ),
                  Container(
                    margin: EdgeInsets.all(1),
                    child: StaggeredGridView.countBuilder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 12,
                        itemCount: services.length,
                       
                        itemBuilder: (context, index) {
                           String serviceName = services[index];
                          return ServiceProviderChoice(
                            imageUrl: servicesPics[index],
                            serviceName: serviceName,
                            isSelected:user.selectedServiceItems.contains(serviceName),
                            onPressed: () {
                              setState(() {
                                _index = index;
      
                               user.addService(serviceName);
                               // petProfile.setPetTypeIndex('${index + 1}');
                              });
                            },
                          );
                        },
                        staggeredTileBuilder: (index) {
                          return StaggeredTile.count(1, 0.45);
                        }),
                  ),
                  Spacer(
                  ),
                  if (user.selectedServiceItems.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0.0, horizontal: 0),
                      child: ButtonView(
                        onPressed: () {
                          AppNavigator.pushAndStackPage(context,
                              page: KycServiceScreenNine());
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
                  SizedBox(
                    height: 40,

                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

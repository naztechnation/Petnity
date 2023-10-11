import 'dart:io';

import 'package:flutter/material.dart';
import 'package:petnity/ui/widgets/button_view.dart';
import 'package:petnity/utils/navigator/page_navigator.dart';
import 'package:provider/provider.dart';

import '../../../model/user_models/service_provider_lists.dart';
import '../../../model/view_models/account_view_model.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_constants.dart';
import '../../../res/app_images.dart';
import '../../../res/app_routes.dart';
import '../../../res/app_strings.dart';
import '../../../res/enum.dart';
import '../../chat_screen.dart';
import '../../location/set_location_screen.dart';
import '../../notfications_pages/chat_pages/chat_page.dart';
import '../../widgets/back_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/image_view.dart';
import '../../widgets/profile_image.dart';
import 'pet_sellers.dart/pet_on_sale.dart';
import 'pet_trainers/training_packages.dart';
import 'widgets/gallary_rating_section.dart';
import 'widgets/providers_profile_body.dart';
import './vets/vet_service.dart';

class ServiceProviderProfile extends StatelessWidget {
  final Agents? agents;
  ServiceProviderProfile({super.key, this.agents});

  final AccountViewModel userViewModel = AccountViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: screenSize(context).height,
            width: screenSize(context).width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [AppColors.scaffoldColor, Colors.red.shade50],
                    begin: Alignment.topRight,
                    end: Alignment.topLeft)),
            child: Column(
              children: [
                SafeArea(
                    child: Container(
                        color: AppColors.cardColor,
                        height: (Platform.isAndroid) ? 0 : 0)),
                Container(
                  color: AppColors.cardColor,
                  padding: const EdgeInsets.only(bottom: 20, top: 10),
                  child: Row(
                    children: [
                      backButton(context),
                      const SizedBox(
                        width: 40,
                      ),
                      CustomText(
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        text: 'Service profile',
                        weight: FontWeight.w700,
                        size: 20,
                        fontFamily: AppStrings.interSans,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 12,
                      ),
                      SizedBox(
                        width: 130,
                        child: Row(
                          children: [
                            ImageView.svg(AppImages.location),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: CustomText(
                                textAlign: TextAlign.start,
                                maxLines: 2,
                                text: '${agents!.city}, ${agents!.country}',
                                weight: FontWeight.w300,
                                size: 14,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      ProfileImage(
                        '${agents!.picture}',
                        placeHolder: AppImages.person,
                        radius: 55,
                        height: 120,
                        width: 120,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            textAlign: TextAlign.start,
                            maxLines: 2,
                            text: '${agents!.name}',
                            weight: FontWeight.w700,
                            size: 14,
                            fontFamily: AppStrings.interSans,
                            color: Colors.black,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          agents!.isVerified!
                              ? ImageView.svg(AppImages.verified)
                              : SizedBox.shrink(),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      CustomText(
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        text: agents!.isVerified! ? 'Verified' : 'Not Verified',
                        weight: FontWeight.w300,
                        size: 11,
                        fontFamily: AppStrings.interSans,
                        color: agents!.isVerified! ? Colors.green : Colors.red,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      // CustomText(
                      //   textAlign: TextAlign.start,
                      //   maxLines: 2,
                      //   text: '322 Completed walks',
                      //   weight: FontWeight.w400,
                      //   size: 12,
                      //   fontFamily: AppStrings.interSans,
                      //   color: Colors.black,
                      // ),
                      const SizedBox(
                        height: 12,
                      ),
                      ProviderProfileBody(
                        agents: agents,
                      ),
                      GallaryRatingSection(userId: agents!.id.toString()),
                      const SizedBox(
                        height: 150,
                      ),
                    ],
                  )),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: ButtonView(
                      onPressed: () {
                        // openServices(
                        //     Provider.of<AccountViewModel>(context, listen: false)
                        //         .selectedService,
                        //     context);
                      },
                      child: CustomText(
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        text: 'Book session',
                        weight: FontWeight.w400,
                        size: 12,
                        fontFamily: AppStrings.interSans,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 14,
                  ),
                  Expanded(
                      flex: 2,
                      child: ButtonView(
                        color: Color(0xFFEAF0FF),
                        onPressed: () {
                           AppNavigator.pushAndReplacePage(context,
                  page: ChatPage(username: agents!.name ?? '', userImage: agents!.picture ?? '',));
                        },
                        child: ImageView.svg(
                          AppImages.messageArrow,
                        ),
                        expanded: false,
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  openServices(Services services, BuildContext context) {
    switch (services) {
      case Services.none:
        break;
      case Services.dogwalkers:
        AppNavigator.pushAndStackPage(context, page: SetLocationScreen());

        break;
      case Services.petdate:
        break;
      case Services.dogsitters:
        AppNavigator.pushAndStackPage(context, page: SetLocationScreen());
        break;
      case Services.trainer:
        AppNavigator.pushAndStackPage(context, page: TrainingScreen());
        break;
      case Services.vets:
        AppNavigator.pushAndStackPage(context, page: VetService());
        break;
      case Services.grooming:
        break;
      case Services.breeders:
        break;
      case Services.petsellers:
        AppNavigator.pushAndStackPage(context, page: PetsOnSale());

        break;
      case Services.boarding:
        break;
      case Services.petcaregivers:
        break;

      default:
        AppNavigator.pushAndStackPage(context, page: SetLocationScreen());
    }
  }
}

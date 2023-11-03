import 'dart:io';

import 'package:flutter/material.dart';
import 'package:petnity/extentions/custom_string_extension.dart';
import 'package:petnity/ui/widgets/button_view.dart';
import 'package:petnity/utils/navigator/page_navigator.dart';
import 'package:provider/provider.dart';

import '../../../model/user_models/service_provider_lists.dart';
import '../../../model/view_models/account_view_model.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_constants.dart';
import '../../../res/app_images.dart';
import '../../../res/app_strings.dart';
import '../../notfications_pages/chat_pages/chat_page.dart';
import '../../widgets/back_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/image_view.dart';
import '../../widgets/profile_image.dart';
import 'agent_packages.dart';
import 'pet_sellers.dart/pet_on_sale.dart';
import 'pet_trainers/training_packages.dart';
import 'widgets/gallery_rating_section.dart';
import 'widgets/providers_profile_body.dart';
import './vets/vet_service.dart';

class ServiceProviderProfile extends StatefulWidget {
  final Agents? agents;
  ServiceProviderProfile({super.key, this.agents});

  @override
  State<ServiceProviderProfile> createState() => _ServiceProviderProfileState();
}

class _ServiceProviderProfileState extends State<ServiceProviderProfile> {
  final AccountViewModel userViewModel = AccountViewModel();

    Future<bool> onBackPress() {
     
    Navigator.pop(context);

    return Future.value(false);
  }

  


  @override
  Widget build(BuildContext context) {
      
    return WillPopScope(
      onWillPop: onBackPress,

      child: Scaffold(
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ImageView.svg(AppImages.location),
                            SizedBox(
                              width: 5,
                            ),
                            Align(
                              child: CustomText(
                                textAlign: TextAlign.start,
                                maxLines: 2,
                                text: '${widget.agents!.city}, ${widget.agents!.country}',
                                weight: FontWeight.w300,
                                size: 14,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        ProfileImage(
                          '${widget.agents?.picture}',
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
                              text: '${widget.agents?.name}',
                              weight: FontWeight.w700,
                              size: 14,
                              fontFamily: AppStrings.interSans,
                              color: Colors.black,
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            widget.agents!.isVerified!
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
                          text: widget.agents!.isVerified! ? 'Verified' : 'Not Verified',
                          weight: FontWeight.w300,
                          size: 11,
                          fontFamily: AppStrings.interSans,
                          color: widget.agents!.isVerified! ? Colors.green : Colors.red,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                           
                        const SizedBox(
                          height: 12,
                        ),
                        ProviderProfileBody(
                          agents: widget.agents,
                          
                        ),

                        GalleryRatingSection(userId: widget.agents!.id.toString()),
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
                          Provider.of<AccountViewModel>(context, listen: false)
                                  .setAgentName(widget.agents!.name ?? '');

                                  Provider.of<AccountViewModel>(context, listen: false)
                                  .setAgentId(widget.agents!.id.toString());
                                 
                          openServices(
                              Provider.of<AccountViewModel>(context, listen: false)
                                  .selectedService.toLowerCase(),
                              context);
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
                            AppNavigator.pushAndStackPage(context,
                                page: ChatPage(
                                  username: widget.agents!.name ?? '',
                                  userImage: widget.agents!.picture ?? '',
                                  uid: widget.agents!.profile!.firebaseId!,
                                ));
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
      ),
    );
  }

  openServices(String services, BuildContext context) {
    switch (services) {
      case '':
        break;
      case 'dog walkers':
        AppNavigator.pushAndStackPage(context, page: PackagesScreen(serviceId: Provider.of<AccountViewModel>(context, listen: false).serviceId, agentId: Provider.of<AccountViewModel>(context, listen: false).agentId2,));

        break;
      case 'pet date':
        break;
      case 'dog sitters':
               AppNavigator.pushAndStackPage(context, page: PackagesScreen(serviceId: Provider.of<AccountViewModel>(context, listen: false).serviceId, agentId: Provider.of<AccountViewModel>(context, listen: false).agentId2,));
 
        break;
      case 'trainer':
        AppNavigator.pushAndStackPage(context, page: TrainingScreen());
        break;
      case 'vets':
        AppNavigator.pushAndStackPage(context, page: VetService());
        break;
      case 'grooming':
        break;
      case 'breeders':
        break;
      case 'pet sellers':
        AppNavigator.pushAndStackPage(context, page: PetsOnSale());

        break;
      case 'boarding':
        break;
      case 'pet care givers':
        break;

      default:
        //AppNavigator.pushAndStackPage(context, page: SetLocationScreen());
    }
  }


}

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
import 'vets/book_pet/booking_page.dart';
import 'widgets/gallery_rating_section.dart';
import 'widgets/providers_profile_body.dart';
 

class ServiceProviderProfile extends StatefulWidget {
  final Agents? agents;
  ServiceProviderProfile({super.key, this.agents,
    });

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
                            ImageView.svg(AppImages.location, height: 20),
                            SizedBox(
                              width: 10,
                            ),
                            Align(
                              child: CustomText(
                                textAlign: TextAlign.start,
                                maxLines: 2,
                                text:
                                    '${widget.agents!.city}, ${widget.agents!.country}'.replaceAll('?', ''),
     
                                weight: FontWeight.w600,
                                size: 16,
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
                              text: '${widget.agents?.profile?.user?.username}'.capitalizeFirstOfEach,
                              weight: FontWeight.w700,
                              size: 16,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: ImageView.svg(
                                AppImages.verified,
                                color: widget.agents?.isVerified ?? false
                          ? Colors.green : Colors.red,
                              )),
                              const SizedBox(width: 10,),
                            CustomText(
                              textAlign: TextAlign.start,
                              maxLines: 2,
                              text: widget.agents?.isVerified ?? false
                                  ? 'Verified'
                                  : 'Not Verified',
                              weight: FontWeight.w300,
                              size: 11,
                              fontFamily: AppStrings.interSans,
                              color: widget.agents!.isVerified!
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ],
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
                        GalleryRatingSection(
                            userId: widget.agents!.id.toString()),
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
                        color: AppColors.lightSecondary,
                        onPressed: () {
                          Provider.of<AccountViewModel>(context, listen: false)
                              .setAgentName(widget.agents!.name ?? '');

                          Provider.of<AccountViewModel>(context, listen: false)
                              .setAgentId(widget.agents!.id.toString());

                          openServices(
                              Provider.of<AccountViewModel>(context,
                                      listen: false)
                                  .selectedService
                                  .toLowerCase(),
                              context);
                        },
                        child: CustomText(
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          text: 'Book Session',
                          weight: FontWeight.w400,
                          size: 15,
                          fontFamily: AppStrings.interSans,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    // const SizedBox(
                    //   width: 14,
                    // ),
                    // Expanded(
                    //     flex: 2,
                    //     child: ButtonView(
                    //       color: Color(0xFFEAF0FF),
                    //       onPressed: () {
                    //         if (widget.agents?.profile?.firebaseId != null ||
                    //             widget.agents?.profile?.firebaseId.toString() !=
                    //                 "null") {
                    //           AppNavigator.pushAndStackPage(context,
                    //               page: ChatPage(
                    //                 agentName: widget.agents?.profile?.user?.username ?? '',
                    //                 userImage: widget.agents?.picture ?? '',
                    //                 uid: widget.agents?.profile?.firebaseId ??
                    //                     '', customerName: widget.,
                    //               ));
                    //         } else {
                    //           Modals.showToast(
                    //               'This agent is not accessible at the moment');
                    //         }
                    //       },
                    //       child: ImageView.svg(
                    //         AppImages.messageArrow,
                    //       ),
                    //       expanded: false,
                    //     ))
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
        AppNavigator.pushAndStackPage(context,
            page: PackagesScreen(
              serviceId: Provider.of<AccountViewModel>(context, listen: false)
                  .serviceId,
              agentId: Provider.of<AccountViewModel>(context, listen: false)
                  .agentId2,
            ));

        break;
      case 'pet date':
        AppNavigator.pushAndStackPage(context,
            page: PackagesScreen(
              serviceId: Provider.of<AccountViewModel>(context, listen: false)
                  .serviceId,
              agentId: Provider.of<AccountViewModel>(context, listen: false)
                  .agentId2,
            ));
        break;
      case 'dog sitters':
        AppNavigator.pushAndStackPage(context,
            page: PackagesScreen(
              serviceId: Provider.of<AccountViewModel>(context, listen: false)
                  .serviceId,
              agentId: Provider.of<AccountViewModel>(context, listen: false)
                  .agentId2,
            ));

        break;
      case 'pet trainer':
        AppNavigator.pushAndStackPage(context,
            page: PackagesScreen(
              serviceId: Provider.of<AccountViewModel>(context, listen: false)
                  .serviceId,
              agentId: Provider.of<AccountViewModel>(context, listen: false)
                  .agentId2,
            ));
        break;
      case 'vets':
        AppNavigator.pushAndStackPage(context,
            page: VetBookingPage(name: widget.agents?.profile?.user?.username ?? '', image: '${widget.agents?.picture}', gender: widget.agents?.gender ?? '', location: '${widget.agents?.city}, ${widget.agents?.country}'.replaceAll('?', ''), about: widget.agents?.about ?? '',
               
            ));
        break;
      case 'grooming':
        AppNavigator.pushAndStackPage(context,
            page: PackagesScreen(
              serviceId: Provider.of<AccountViewModel>(context, listen: false)
                  .serviceId,
              agentId: Provider.of<AccountViewModel>(context, listen: false)
                  .agentId2,
            ));
        break;
      case 'pet breeders':
        AppNavigator.pushAndStackPage(context,
            page: PackagesScreen(
              serviceId: Provider.of<AccountViewModel>(context, listen: false)
                  .serviceId,
              agentId: Provider.of<AccountViewModel>(context, listen: false)
                  .agentId2,
            ));
        break;
      case 'pet sellers':
        AppNavigator.pushAndStackPage(context, page: PetsOnSale());

        break;
      case 'boarding':
        AppNavigator.pushAndStackPage(context,
            page: PackagesScreen(
              serviceId: Provider.of<AccountViewModel>(context, listen: false)
                  .serviceId,
              agentId: Provider.of<AccountViewModel>(context, listen: false)
                  .agentId2,
            ));
        break;
      case 'pet care givers':
        AppNavigator.pushAndStackPage(context,
            page: PackagesScreen(
              serviceId: Provider.of<AccountViewModel>(context, listen: false)
                  .serviceId,
              agentId: Provider.of<AccountViewModel>(context, listen: false)
                  .agentId2,
            ));
        break;

      default:
      //AppNavigator.pushAndStackPage(context, page: SetLocationScreen());
    }
  }
}

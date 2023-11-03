import 'package:flutter/material.dart';
import 'package:petnity/ui/widgets/image_view.dart';
import 'package:provider/provider.dart';

import '../../../../model/view_models/user_view_model.dart';
import '../../../../res/app_colors.dart';
import '../../../../res/app_constants.dart';
import '../../../../res/app_images.dart';
import '../../../../res/app_strings.dart';
import '../../../../utils/navigator/page_navigator.dart';
import '../../../widgets/button_view.dart';
import '../../../widgets/custom_multi_toogle.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/profile_image.dart';
import '../../../widgets/ratings_views.dart';
import '../service_provider_profile.dart';

class ProvidersCard extends StatefulWidget {
  final int index;
  ProvidersCard({super.key, required this.index});

  @override
  State<ProvidersCard> createState() => _ProvidersCardState();
}

class _ProvidersCardState extends State<ProvidersCard> {
  List<String> services = [
   
  ];
  String selectedService = '';

  List<String> animal = [];
  String selectedAnimal = '';

  int ratings = 5;
 

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserViewModel>(context, listen: true);
    
       services = user.agents[widget.index].services != null
    ? user.agents[widget.index].services!
        .map((service) => service.name ?? '')
        .toList()
    : <String>[];

    animal = user.agents[widget.index].petTypes != null
    ? user.agents[widget.index].petTypes!
        .map((petTypes) => petTypes.name ?? '')
        .toList()
    : <String>[];

     
    if (user.agents.isNotEmpty) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        margin: const EdgeInsets.only(bottom: 40),
        width: screenSize(context).width,
        child: Card(
          color: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: ProfileImage(
                    
                    user.agents[widget.index].picture!,
                    placeHolder: AppImages.person,
                    radius: 25,
                    height: 100,
                    width: 80,
                  ),
                  title: SizedBox(
                    width: 120,
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomText(
                            textAlign: TextAlign.start,
                            maxLines: 2,
                            text: user.agents[widget.index].name,
                            weight: FontWeight.w700,
                            size: 14,
                            fontFamily: AppStrings.interSans,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  subtitle: user.agents[widget.index].isVerified!
                      ? Align(
                          alignment: Alignment.topLeft,
                          child: ImageView.svg(
                            AppImages.verified,
                            color: Colors.green,
                          ))
                      : SizedBox.shrink(),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        text: user.agents[widget.index].isVerified!
                            ? 'Verified'
                            : 'Not Verified',
                        weight: FontWeight.w300,
                        size: 11,
                        fontFamily: AppStrings.interSans,
                        color: user.agents[widget.index].isVerified!
                            ? Colors.green
                            : Colors.red,
                      ),
                      SizedBox(
                        height: 5,
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
                                text: '${user.agents[widget.index].city}, ${user.agents[widget.index].country}.',
                                weight: FontWeight.w300,
                                size: 11,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomText(
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  text: 'Services',
                  weight: FontWeight.w600,
                  size: 14,
                  fontFamily: AppStrings.interSans,
                  color: Colors.black,
                ),
                CustomMultiToggle(
                  title: services,
                  fontSize: 11,
                  color: AppColors.lightPrimary,
                  selectedTextColor: AppColors.lightPrimary,
                  height: 35,
                  contentMargin: const EdgeInsets.all(5),
                  onSelected: (index) {
                    setState(() {
                      selectedService = services[index];
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomText(
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  text: 'Animals',
                  weight: FontWeight.w600,
                  size: 14,
                  fontFamily: AppStrings.interSans,
                  color: Colors.black,
                ),
                CustomMultiToggle(
                  title: animal,
                  fontSize: 11,
                  color: AppColors.lightPrimary,
                  selectedTextColor: AppColors.lightPrimary,
                  height: 35,
                  contentMargin: const EdgeInsets.all(5),
                  onSelected: (index) {
                    setState(() {
                      selectedAnimal = animal[index] ;

                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      text: 'About',
                      weight: FontWeight.w600,
                      size: 14,
                      fontFamily: AppStrings.interSans,
                      color: Colors.black,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomText(
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          text: 'Ratings',
                          weight: FontWeight.w600,
                          size: 14,
                          fontFamily: AppStrings.interSans,
                          color: Colors.black,
                        ),
                        RatingView(
                          rating: ratings,
                          onSelected: (rating) {
                            setState(() {
                              ratings = rating;
                            });
                          },
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomText(
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  text: '${user.agents[widget.index].gender}',
                  weight: FontWeight.w500,
                  size: 14,
                  fontFamily: AppStrings.interSans,
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomText(
                  textAlign: TextAlign.start,
                  maxLines: 4,
                  text:
                      '${user.agents[widget.index].about}',
                  weight: FontWeight.w500,
                  size: 14,
                  fontFamily: AppStrings.interSans,
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: ButtonView(
                    onPressed: () {
                      AppNavigator.pushAndStackPage(context,
                          page: ServiceProviderProfile(agents: user.agents[widget.index], ));
                    },
                    expanded: true,
                    borderRadius: 41,
                    child: Text(
                      'View Profile',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                    ),
                    color: AppColors.lightSecondary,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      );
    } else if (user.agents == []) {
      return Center(
        child: CustomText(
          textAlign: TextAlign.start,
          maxLines: 2,
          text: 'No Service Provider Available',
          weight: FontWeight.w300,
          size: 11,
          fontFamily: AppStrings.interSans,
          color: Colors.black,
        ),
      );
    }

    return SizedBox.shrink();
  }
}

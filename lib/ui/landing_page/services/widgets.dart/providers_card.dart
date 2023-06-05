import 'package:flutter/material.dart';
import 'package:petnity/ui/widgets/image_view.dart';

import '../../../../res/app_colors.dart';
import '../../../../res/app_constants.dart';
import '../../../../res/app_images.dart';
import '../../../../res/app_strings.dart';
import '../../../widgets/button_view.dart';
import '../../../widgets/custom_multi_toogle.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/profile_image.dart';
import '../../../widgets/ratings_views.dart';

class ProvidersCard extends StatefulWidget {
  ProvidersCard({super.key});

  @override
  State<ProvidersCard> createState() => _ProvidersCardState();
}

class _ProvidersCardState extends State<ProvidersCard> {
  List<String> services = [
    'Sitting',
    'Pet walking',
    'Grooming',
  ];
  String selectedService = '';

  List<String> animal = ['Dogs', 'Cat', 'Squirrels', 'monkeys'];
  String selectedAnimal = '';

  int ratings = 5;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      margin: const EdgeInsets.only(bottom: 40),
      width: screenSize(context).width,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: ProfileImage(
                  AppImages.person,
                  placeHolder: AppImages.person,
                  radius: 25,
                ),
                title: SizedBox(
                  width: 120,
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomText(
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          text: 'Dera Jessica',
                          weight: FontWeight.w700,
                          size: 14,
                          fontFamily: AppStrings.interSans,
                          color: Colors.black,
                        ),
                      ),
                      Expanded(child: ImageView.svg(AppImages.verified))
                    ],
                  ),
                ),
                subtitle: CustomText(
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  text: '321 Completed walks',
                  weight: FontWeight.w300,
                  size: 11,
                  fontFamily: AppStrings.interSans,
                  color: Colors.black,
                ),
                trailing: Column(
                  children: [
                    CustomText(
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      text: 'Verified',
                      weight: FontWeight.w300,
                      size: 11,
                      fontFamily: AppStrings.interSans,
                      color: Colors.black,
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
                          CustomText(
                            textAlign: TextAlign.start,
                            maxLines: 2,
                            text: 'Ikeja, Lagos',
                            weight: FontWeight.w300,
                            size: 11,
                            fontFamily: AppStrings.interSans,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
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
                height: 10,
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
                    selectedAnimal = animal[index];
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
                text: '32 Years',
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
                    'Lorem ipsum dolor sit amet consectetur. Sit nisi eget sit urna tortor vel convallis pretium est. Volutpat duis curabitur fames faucibus euismod imperdiet semper eget faucibus. ',
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
                    //  AppNavigator.pushAndStackPage(context, page: PaymentDetailsScreen());
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
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

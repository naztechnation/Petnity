import 'package:flutter/material.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_images.dart';
import 'package:petnity/res/app_strings.dart';
import 'package:provider/provider.dart';

import '../../../model/view_models/user_view_model.dart';
import '../../../res/enum.dart';
import '../../../utils/navigator/page_navigator.dart';
import '../services/services_providers_details.dart';

class ListOfServices extends StatelessWidget {
  ListOfServices({super.key});

  UserViewModel userViewModel = UserViewModel();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Item(context, Colors.lightBlueAccent, 'Pet \nwalkers',
                    AppImages.dogWalk, () {
                  Provider.of<UserViewModel>(context, listen: false)
                      .setSelectedService(Services.dogwalkers);
                  AppNavigator.pushAndStackPage(context,
                      page: ServiceProvidersDetails(
                        petProvider: 'Pet Walkers',
                      ));
                }),
                Item(context, Colors.brown, 'Pet \ndate', AppImages.petDate,
                    () {
                  Provider.of<UserViewModel>(context, listen: false)
                      .setSelectedService(Services.petdate);
                  AppNavigator.pushAndStackPage(context,
                      page: ServiceProvidersDetails(
                        petProvider: 'Pet Date',
                      ));
                }),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Item(context, Color.fromARGB(255, 179, 120, 10),
                    'Pet \nsitters', AppImages.dogSitter, () {
                  Provider.of<UserViewModel>(context, listen: false)
                      .setSelectedService(Services.dogsitters);
                  AppNavigator.pushAndStackPage(context,
                      page: ServiceProvidersDetails(
                        petProvider: 'Pet Sitters',
                      ));
                }),
                Item(context, Color.fromARGB(255, 52, 139, 170), 'Trainer',
                    AppImages.dogTrainer, () {
                  Provider.of<UserViewModel>(context, listen: false)
                      .setSelectedService(Services.trainer);
                  AppNavigator.pushAndStackPage(context,
                      page: ServiceProvidersDetails(
                        petProvider: 'Trainers',
                      ));
                }),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Item(context, Colors.purpleAccent, 'Vets', AppImages.dogVets,
                    () {
                  Provider.of<UserViewModel>(context, listen: false)
                      .setSelectedService(Services.vets);
                  AppNavigator.pushAndStackPage(context,
                      page: ServiceProvidersDetails(
                        petProvider: 'Vets',
                      ));
                }),
                Item(context, Color.fromARGB(255, 185, 15, 72), 'Grooming',
                    AppImages.dogGrooming, () {
                  Provider.of<UserViewModel>(context, listen: false)
                      .setSelectedService(Services.grooming);
                  AppNavigator.pushAndStackPage(context,
                      page: ServiceProvidersDetails(
                        petProvider: 'Grooming',
                      ));
                }),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Item(context, Colors.orangeAccent, 'Boarding',
                    AppImages.dogBoarding, () {
                  Provider.of<UserViewModel>(context, listen: false)
                      .setSelectedService(Services.boarding);
                  AppNavigator.pushAndStackPage(context,
                      page: ServiceProvidersDetails(
                        petProvider: 'Pet boarder',
                      ));
                }),
                Item(context, Colors.lightGreen, 'Breeders',
                    AppImages.dogBreeders, () {
                  Provider.of<UserViewModel>(context, listen: false)
                      .setSelectedService(Services.breeders);
                  AppNavigator.pushAndStackPage(context,
                      page: ServiceProvidersDetails(
                        petProvider: 'Breeders',
                      ));
                }),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Item(
                    context, Colors.blue, 'Pet \nsellers', AppImages.dogSellers,
                    () {
                  Provider.of<UserViewModel>(context, listen: false)
                      .setSelectedService(Services.petsellers);
                  AppNavigator.pushAndStackPage(context,
                      page: ServiceProvidersDetails(
                        petProvider: 'Pet Sellers',
                      ));
                }),
                Item(context, Colors.pink, 'Pet care \ngivers',
                    AppImages.petCarers, () {
                  Provider.of<UserViewModel>(context, listen: false)
                      .setSelectedService(Services.petcaregivers);
                  AppNavigator.pushAndStackPage(context,
                      page: ServiceProvidersDetails(
                        petProvider: 'Pet care giving',
                      ));
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget Item(BuildContext context, Color color, String title, String image,
    VoidCallback onPressed) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      width: screenSize(context).width * .43,
      height: screenSize(context).height * .08,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(image),
            radius: 25,
          ),
          const SizedBox(width: 15),
          Text(
            title,
            maxLines: 2,
            style: TextStyle(fontSize: 14, fontFamily: AppStrings.interSans),
          )
        ],
      ),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_images.dart';
import 'package:petnity/res/app_strings.dart';

import '../../../utils/navigator/page_navigator.dart';
import '../services/services_providers_details.dart';

class ListOfServices extends StatelessWidget {
  const ListOfServices({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        // shrinkWrap: true,
        // padding: const EdgeInsets.symmetric(horizontal: 20),
        // physics: const NeverScrollableScrollPhysics(),
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 10,),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Item(context, Colors.lightBlueAccent, 'Dog \nwalkers', AppImages.dogWalk, (){
                  AppNavigator.pushAndStackPage(context, page: ServiceProvidersDetails(petProvider: 'Dog Walkers',));
                }),
                Item(context, Colors.brown, 'Pet \ndate', AppImages.petDate, (){
                  AppNavigator.pushAndStackPage(context, page: ServiceProvidersDetails(petProvider: 'Pet Date',));
    
                }),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Item(context, Color.fromARGB(255, 179, 120, 10), 'Dog \nsitters',AppImages.dogSitter, (){
                  AppNavigator.pushAndStackPage(context, page: ServiceProvidersDetails(petProvider: 'Dog Sitters',));
    
                }),
                Item(context, Color.fromARGB(255, 52, 139, 170), 'Trainer', AppImages.dogTrainer, (){
                  AppNavigator.pushAndStackPage(context, page: ServiceProvidersDetails(petProvider: 'Trainers',));
    
                }),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Item(context, Colors.purpleAccent, 'Vets', AppImages.dogVets, (){
                  AppNavigator.pushAndStackPage(context, page: ServiceProvidersDetails(petProvider: 'Vets',));
    
                }),
                Item(context, Color.fromARGB(255, 185, 15, 72), 'Grooming', AppImages.dogGrooming, (){
                  AppNavigator.pushAndStackPage(context, page: ServiceProvidersDetails(petProvider: 'Grooming',));
    
                }),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Item(context, Colors.orangeAccent, 'Boarding',AppImages.dogBoarding, (){
                  AppNavigator.pushAndStackPage(context, page: ServiceProvidersDetails(petProvider: 'Boarding',));
    
                }),
                Item(context, Colors.lightGreen, 'Breeders', AppImages.dogBreeders, (){
                  AppNavigator.pushAndStackPage(context, page: ServiceProvidersDetails(petProvider: 'Breeders',));
    
                }),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Item(context, Colors.blue, 'Dog \nsellers', AppImages.dogSellers, (){
                  AppNavigator.pushAndStackPage(context, page: ServiceProvidersDetails(petProvider: 'Dog Sellers',));
    
                }),
                Item(context, Colors.pink, 'Pet care \ngivers', AppImages.petCarers, (){
                  AppNavigator.pushAndStackPage(context, page: ServiceProvidersDetails(petProvider: 'Pet Care GIvers',));
    
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget Item(BuildContext context, Color color, String title, String image, VoidCallback onPressed) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      width: screenSize(context).width * .43,
      height: screenSize(context).height * .08,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: color.withOpacity(0.2), borderRadius: BorderRadius.circular(20)),
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




import '../../res/app_images.dart';

class OnboardPageItem {
  String gifAsset;
  String description;
  String title;

  OnboardPageItem(
      {required this.gifAsset,
      required this.title,
      required this.description});


      static List<OnboardPageItem> onboardPageItems = [
    OnboardPageItem(
      gifAsset: AppImages.walkingDog,
      title: 'Connect with our pet \ncare givers',
      description: 'Find and meet and book world class \npet sitters and walkers',

    ),
    OnboardPageItem(
      gifAsset: AppImages.dogCar,
       title: 'Go on close by pet \ndates',
      description: 'Connect with pets and pet owners \naround you',

    ),
    OnboardPageItem(
      gifAsset: AppImages.cardShopping,
       title: 'Shop for your pets \nfeed and product',
      description: ' Buy pet feeds and product from \nthe comfort of your sofa',

    ),
    OnboardPageItem(
      gifAsset: AppImages.lovePet,
       title: 'Lets handle your pet \nwith love',
      description: 'Connect with pet boardes, day carers \nand home sitters',

    ),
    OnboardPageItem(
      gifAsset: AppImages.petDoctor,
       title: 'Connect with verified \ntop class vets',
      description: 'Get access to top class vets to always \nstay ahead of your pets health \nand welfare',

    ),
  ];
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petnity/blocs/location/location.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_images.dart';
import 'package:petnity/ui/service_povider_section/service_provider_home/track_session.dart';
import 'package:petnity/ui/location/widgets/map_view.dart';
import 'package:petnity/ui/settings/update_successful_page.dart';
import 'package:petnity/ui/widgets/back_button.dart';
import 'package:petnity/ui/widgets/button_view.dart';
import 'package:petnity/ui/widgets/custom_text.dart';
import 'package:provider/provider.dart';

import '../../../../model/view_models/account_view_model.dart';
import '../../../../requests/repositories/location_repo/location_repository_impl.dart';
import '../../../landing_page/services/pet_profile/pet_profile.dart';
import '../../../widgets/image_view.dart';

class PurchaseRequest extends StatelessWidget {
  const PurchaseRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LocationCubit>(
          lazy: false,
          create: (_) => LocationCubit(
              locationRepository: LocationRepositoryImpl(),
              userViewModel:
                  Provider.of<AccountViewModel>(context, listen: false)),
        )
      ],
      child: Scaffold(
        backgroundColor: AppColors.scaffoldColor,
        appBar: PreferredSize(
          preferredSize: screenSize(context) * .1,
          child: Container(
            padding: EdgeInsets.only(top: 20),
            child: AppBar(
              centerTitle: true,
              title: Text(
                'Purchase Request',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: backButton(context),
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          height: screenSize(context).height * .9,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: 'Product buyer details',
                  weight: FontWeight.bold,
                ),
                Container(
                  width: screenSize(context).width,
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: screenSize(context).width * .16,
                        height: screenSize(context).height * .08,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            image: DecorationImage(
                                image: AssetImage(AppImages.person),
                                fit: BoxFit.fill)),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: 'Owner name',
                              size: 12,
                            ),
                            CustomText(
                              text: 'Sandra Lee',
                              weight: FontWeight.bold,
                              size: 12,
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: screenSize(context).width * .12,
                            margin: EdgeInsets.symmetric(horizontal: 3),
                            child: ButtonView(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              borderColor: Colors.red,
                              borderWidth: 2,
                              color: Colors.white,
                              onPressed: () {},
                              child: Icon(
                                Icons.call_outlined,
                                color: Colors.red,
                                size: 20,
                              ),
                              borderRadius: 100,
                            ),
                          ),
                          Container(
                            width: screenSize(context).width * .12,
                            margin: EdgeInsets.symmetric(horizontal: 3),
                            child: ButtonView(
                              borderColor: Colors.green,
                              padding: EdgeInsets.symmetric(vertical: 15),
                              borderWidth: 2,
                              color: Colors.white,
                              onPressed: () {},
                              child: Icon(
                                Icons.chat,
                                color: Colors.green,
                                size: 20,
                              ),
                              borderRadius: 100,
                            ),
                          ),
                          Container(
                            width: screenSize(context).width * .12,
                            margin: EdgeInsets.symmetric(horizontal: 3),
                            child: ButtonView(
                              borderColor: Colors.purple,
                              borderWidth: 2,
                              padding: EdgeInsets.symmetric(vertical: 15),
                              color: Colors.white,
                              onPressed: () {},
                              child: Icon(
                                Icons.video_call,
                                color: Colors.purple,
                                size: 20,
                              ),
                              borderRadius: 100,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Align(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomText(
                        text: 'Product name',
                      ),
                      CustomText(
                        text: 'Smart Adult feed',
                        weight: FontWeight.bold,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                Align(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      height: 160,
                      width: 160,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(color: Colors.white),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: ImageView.network(
                          'https://www.poochandmutt.co.uk/cdn/shop/products/GLOBAL_PRODUCT_IMAGES_HD-2_672x.jpg?v=1623489378',
                          height: 150,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  width: screenSize(context).width,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      CustomText(
                        text: 'Purchase Review',
                        weight: FontWeight.bold,
                        size: 15,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: CustomText(
                              text: 'Product name',
                              weight: FontWeight.bold,
                              maxLines: 2,
                              size: 13,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: CustomText(
                              text: 'Smart Adult  feed',
                              weight: FontWeight.bold,
                              maxLines: 2,
                              size: 13,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: 'QTY',
                            weight: FontWeight.bold,
                            size: 13,
                          ),
                          CustomText(
                            text: '2',
                            weight: FontWeight.bold,
                            size: 13,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: 'Price',
                            weight: FontWeight.bold,
                            size: 13,
                          ),
                          CustomText(
                            text: 'NGN400',
                            weight: FontWeight.bold,
                            size: 13,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  width: screenSize(context).width,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    
                  ),
                  child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: 'Purchase',
                            weight: FontWeight.bold,
                            size: 13,
                          ),
                          CustomText(
                            text: 'ID 200000dn9r',
                            weight: FontWeight.bold,
                            size: 13,
                          ),
                        ],
                      ),
                  ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: CustomText(
                    text: 'Delivery due date',
                    size: 13,
                    weight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.symmetric(
                      horizontal: screenSize(context).width * .05,
                      vertical: 10),
                  width: screenSize(context).width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Icon(Icons.calendar_month),
                            CustomText(
                              text: '20th October, 2023',
                              size: 14,
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Icon(Icons.timer_outlined),
                            CustomText(
                              text: '06 PM',
                              size: 14,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                
                _map(context),
               
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar:  Container(
          height: 150,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      ButtonView(
                        expanded: false,
                        color: Colors.transparent,
                        borderColor: Colors.transparent,
                        onPressed: () {},
                        child: Center(
                          child: CustomText(
                            text: 'Reject',
                            color: Colors.red,
                            weight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ButtonView(
                        borderRadius: 30,
                        expanded: false,
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return UpdateSuccessfulScreen(
                                buttonText: 'Track',
                                successMessage:
                                    'You\'ve successfully accepted  a dog walking session',
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (_) {
                                    return TrackService();
                                  }));
                                });
                          }));
                        },
                        child: Center(
                          child: CustomText(
                            text: 'Accept Session',
                            color: Colors.white,
                            weight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
      ),
    );
  }

  Widget _map(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            20,
          ),
          color: Colors.black12,
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                MapViews(
                  zoom: 15,
                ),
                Positioned(
                  left: 0,
                  bottom: 0,
                  child: Container(
                    width: screenSize(context).width * .74,
                    height: screenSize(context).height * .08,
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                       
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ImageView.svg(AppImages.location),
                            const SizedBox(width: 10,),
                            CustomText(
                              text: 'delivery location',
                              size: 12,
                              weight: FontWeight.bold,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            )),
        height: screenSize(context).height * .3,
        width: screenSize(context).width * .8,
      ),
    );
  }
}

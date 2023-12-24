import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:petnity/model/view_models/user_view_model.dart';
import 'package:petnity/res/app_strings.dart';
import 'package:petnity/ui/widgets/image_view.dart';
import 'package:provider/provider.dart';

import '../../../model/user_models/service_provider_lists.dart';
import '../../../model/user_models/service_type.dart';
import '../../../model/view_models/account_view_model.dart';
import '../../../utils/navigator/page_navigator.dart';
import '../../service_povider_section/create_package/select_level_amount.dart';
import '../../widgets/modals.dart';
import 'vets/vet_service.dart';

class ServicesList extends StatelessWidget {
  final List<ServicesDetails> services;
  ServicesList({super.key, required this.services});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserViewModel>(context, listen: true);
    final agent = Provider.of<AccountViewModel>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(1),
            child: StaggeredGridView.countBuilder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 12,
                itemCount: user.services.length,
                itemBuilder: (context, index) {
                  Color randomColor = getRandomColor();

                  ServiceTypes masterItem = user.services[index];

                  bool isActive =
                      services.any((subItem) => subItem.id == masterItem.id);

                  if (isActive) {
                    return Item(context, randomColor, '${masterItem.name}',
                        '${masterItem.image}', () {
                      agent.setServiceId('${user.services[index].id}');

                      if(masterItem.name == 'Vets'){

                        AppNavigator.pushAndReplacePage(context,
                          page: VetService(
                              ));

                      }else{
                         AppNavigator.pushAndReplacePage(context,
                          page: SelectPackageLevelAmount(
                              serviceType: '${user.services[index].name}',
                              serviceId: '${user.services[index].id}'));
                      }
                      
                     
                    }, true);
                  } else {
                    return Item(context, Colors.grey.shade50,
                        '${masterItem.name}', '${masterItem.image}', () {
                      Modals.showToast(
                          'You do not offer this service at the moment. please add to your services if you want to');
                    }, false);
                  }
                },
                staggeredTileBuilder: (index) {
                  return StaggeredTile.count(1, 0.35);
                }),
          ),
        ],
      ),
    );
  }
}

Color getRandomColor() {
  Random random = Random();

  Color color;
  do {
    int red = 200 + random.nextInt(56);
    int green = 200 + random.nextInt(56);
    int blue = 200 + random.nextInt(56);

    color = Color.fromARGB(255, red, green, blue);
  } while (color.computeLuminance() < 0.1);

  return color;
}

Widget Item(BuildContext context, Color color, String title, String image,
    VoidCallback onPressed, bool isActive) {
  return GestureDetector(
      onTap: onPressed,
      child: (isActive)
          ? Container(
              // width: screenSize(context).width * .43,
              // height: screenSize(context).height * .06,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(60)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: ImageView.network(
                      image,
                      height: 35,
                      width: 35,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      title,
                      maxLines: 2,
                      style: TextStyle(
                          fontSize: 14, fontFamily: AppStrings.interSans),
                    ),
                  )
                ],
              ),
            )
          : Stack(
              children: [
                Container(
                  // width: screenSize(context).width * .43,
                  // height: screenSize(context).height * .06,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.7), borderRadius: BorderRadius.circular(60)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: ImageView.network(
                          image,
                          height: 35,
                          width: 35,
                          fit: BoxFit.cover,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Text(
                          title,
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: 14, fontFamily: AppStrings.interSans),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(60)),
                ),
              ],
            ));
}

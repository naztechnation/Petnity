import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:petnity/model/view_models/user_view_model.dart';
import 'package:petnity/res/app_strings.dart';
import 'package:petnity/ui/widgets/image_view.dart';
import 'package:provider/provider.dart';

import '../../../model/services/services.dart';
import '../../../model/user_models/service_type.dart';
import '../../../model/view_models/account_view_model.dart';
import '../../../utils/navigator/page_navigator.dart';
import '../../service_povider_section/create_package/select_level_amount.dart';
import '../../service_povider_section/service_profile/agents_packages.dart';
import '../../service_povider_section/service_profile/vet_packages.dart';
import '../../widgets/modals.dart';
import 'vets/vet_service.dart';

class ServicesList extends StatelessWidget {
  final List<ServiceType> services;

  final bool isAgent;
  final String agentId;
  ServicesList({super.key, required this.services, this.isAgent = false,  this.agentId = '0'});

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

                  ServiceType masterItem = user.services[index];

                  bool isActive =
                      services.any((subItem) => subItem.sId == masterItem.sId);

                 
                    return Item(context, randomColor, '${masterItem.name}',
                        '${masterItem.image}', () {
                      agent.setServiceId('${user.services[index].sId}');

                      if (masterItem.name == 'Vets'&& !isAgent) {
                        AppNavigator.pushAndStackPage(context,
                            page: VetService());
                      }else if(masterItem.name == 'Vets'&& isAgent){
                        AppNavigator.pushAndStackPage(context,
                            page: VetPackages(agentId: agentId,));
                      } else {
                        if (isAgent) {
                          AppNavigator.pushAndReplacePage(context,
                              page: AgentPackagesScreen(
                                  agentId: agentId,
                                  serviceId: '${user.services[index].sId}',
                                  serviceType: masterItem.name ?? '',));
                        } else {
                          AppNavigator.pushAndReplacePage(context,
                              page: SelectPackageLevelAmount(
                                  serviceType: '${user.services[index].name}',
                                  serviceId: '${user.services[index].sId}'));
                        }
                      }
                    }, true);
                   
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
                  color: color, borderRadius: BorderRadius.circular(60)),
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
                      color: Colors.grey.withOpacity(0.7),
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

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:petnity/model/view_models/user_view_model.dart';
import 'package:petnity/res/app_strings.dart';
import 'package:petnity/ui/widgets/image_view.dart';
import 'package:provider/provider.dart';

import '../../../model/view_models/account_view_model.dart';
import '../../../res/app_images.dart';
import '../../../utils/navigator/page_navigator.dart';
import '../services/services_providers_details.dart';

class ListOfServices extends StatelessWidget {
  ListOfServices({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserViewModel>(context, listen: true);

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
                itemCount: user.servicesType.length,
                itemBuilder: (context, index) {
                  Color randomColor = getRandomColor();

                  return Item(context, randomColor,
                      '${user.servicesType[index].name}',  '${user.servicesType[index].image}', () {
                    Provider.of<AccountViewModel>(context, listen: false)
                        .setSelectedService(user.servicesType[index].name ?? '');
                         Provider.of<AccountViewModel>(context, listen: false)
                                  .setServiceId(user.servicesType[index].sId.toString());
                    AppNavigator.pushAndStackPage(context,
                        page: ServiceProvidersDetails(
                          petProvider: '${user.servicesType[index].name}',
                          serviceId: '${user.servicesType[index].sId}',
                        ));
                  });
                },
                staggeredTileBuilder: (index) {
                 return StaggeredTile.count(
                                    1, index.isEven ? 0.4 : 0.4);
                }),
          ),
        ],
      ),
    );
  }
}

Color getRandomColor() {
  Random random = Random();
  return Color.fromARGB(
    255,
    random.nextInt(256),
    random.nextInt(256),
    random.nextInt(256),
  );
}

Widget Item(BuildContext context, Color color, String title, String image,
    VoidCallback onPressed) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      // width: screenSize(context).width * .43,
      // height: screenSize(context).height * .06,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(60)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Hero(
                  tag: 'profilePicture',
                  child: Image.network(
                    image,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return ImageView.asset(AppImages.appLogo,
                          fit: BoxFit.cover);
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const ImageView.asset(AppImages.appLogo,
                          fit: BoxFit.cover);
                    },
                  ),
                )),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              title,
              maxLines: 2,
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, fontFamily: AppStrings.satoshi),
            ),
          )
        ],
      ),
    ),
  );
}

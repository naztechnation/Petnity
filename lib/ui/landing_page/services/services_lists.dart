import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:petnity/model/view_models/user_view_model.dart';
import 'package:petnity/res/app_images.dart';
import 'package:petnity/res/app_strings.dart';
import 'package:provider/provider.dart';

import '../../../utils/navigator/page_navigator.dart';
import '../../service_povider_section/create_package/select_level_amount.dart';
 

class ServicesList extends StatelessWidget {
  ServicesList({super.key});

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
                itemCount: user.services.length,
                itemBuilder: (context, index) {
                  Color randomColor = getRandomColor();

                  return Item(context, randomColor,
                      '${user.services[index].name}', AppImages.catPic, () {
                        AppNavigator.pushAndReplacePage(context, page: SelectPackageLevelAmount(serviceType: '${user.services[index].name}',));
                  });
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
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(60)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(image),
            radius: 18,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              title,
              maxLines: 2,
              style: TextStyle(fontSize: 14, fontFamily: AppStrings.interSans),
            ),
          )
        ],
      ),
    ),
  );
}

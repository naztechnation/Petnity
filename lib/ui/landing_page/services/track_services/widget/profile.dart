import 'package:flutter/material.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_images.dart';
import 'package:petnity/ui/notfications_pages/chat_pages/chat_page.dart';
import 'package:petnity/ui/widgets/image_view.dart';

import '../../../../../res/app_strings.dart';
import '../../../../../utils/navigator/page_navigator.dart';
import '../../../../video.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/modals.dart';

Widget serviceProfile(
  BuildContext context, {
  bool hideImage = false,
  required String sellerName,
  required String sellerImage,
  required String sellerId,
  required String userName,
}) {
  return Row(
    children: [
      Expanded(
        flex: 1,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: ImageView.network(
            sellerImage,
            height: 80,
            placeholder: AppImages.person,
          ),
        ),
      ),
      Expanded(
        flex: 6,
        child: ListTile(
          title: CustomText(
            textAlign: TextAlign.left,
            maxLines: 2,
            text: 'Seller',
            weight: FontWeight.w700,
            size: 12,
            fontFamily: AppStrings.interSans,
            color: Colors.black,
          ),
          subtitle: CustomText(
            textAlign: TextAlign.left,
            maxLines: 2,
            text: sellerName,
            weight: FontWeight.w700,
            size: 12,
            fontFamily: AppStrings.interSans,
            color: Colors.black,
          ),
          trailing: (hideImage)
              ? ImageView.svg(AppImages.messageBorder)
              : SizedBox(
                  width: screenSize(context).width * 0.45,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ImageView.svg(AppImages.callBorder),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                          onTap: () {
                            if (sellerId == '') {
                              Modals.showToast(
                                  'Can\'t communicate with this agent at the moment. Please');
                            } else {
                              AppNavigator.pushAndStackPage(context,
                                  page: ChatPage(
                                      username: sellerName,
                                      userImage: sellerImage,
                                      uid: sellerId));
                            }
                          },
                          child: ImageView.svg(AppImages.messageBorder)),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                          onTap: () {
                            AppNavigator.pushAndStackPage(context,
                                page: VideoCall(
                                  user1: sellerName,
                                  user2: userName,
                                ));
                          },
                          child: ImageView.svg(AppImages.videoBorder)),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                ),
        ),
      ),
    ],
  );
}

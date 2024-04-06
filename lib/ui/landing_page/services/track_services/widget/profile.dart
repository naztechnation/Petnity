import 'package:flutter/material.dart';
import 'package:petnity/extentions/custom_string_extension.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_images.dart';
import 'package:petnity/ui/notfications_pages/chat_pages/chat_page.dart';
import 'package:petnity/ui/widgets/image_view.dart';
import 'package:provider/provider.dart';

import '../../../../../model/view_models/chat_controller.dart';
import '../../../../../res/app_strings.dart';
import '../../../../../utils/navigator/page_navigator.dart';
 
import '../../../../video.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/modals.dart';

import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

Widget serviceProfile(
  BuildContext context, {
  bool hideImage = false,
  required String agentName,
  required String sellerImage,
  required String agentId,
  required String userName,
  required String phone,
  required String userType,
  required String customerName,
  required String customerImage,
  required String customerPhone,
  required String orderId,
  required String customerFireBaseId,
}) {
    
       final msgCntrl = Provider.of<MessageController>(context, listen: true);


  return    (userType == 'user') ? Row(
    children: [
      Expanded(
        flex: 1,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(60),
          child: ImageView.network(
            sellerImage,
             height: 50,
                      width: 50,
                      fit: BoxFit.cover,
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
          //goof
          subtitle: CustomText(
            textAlign: TextAlign.left,
            maxLines: 2,
            text: agentName,
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
                      GestureDetector(
                        onTap: (){
                          _callNumber(phone);
                        },
                        child: ImageView.svg(AppImages.callBorder)),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                          onTap: () {
                            if (agentId == '') {
                              Modals.showToast(
                                  'Can\'t communicate with this agent at the moment.');
                            } else {
                              
                              msgCntrl.updateSelectedKey(orderId, agentId);
                              AppNavigator.pushAndStackPage(context,
                                  page: ChatPage(
                                      customerName: customerName,
                                      userImage: sellerImage,
                                      orderId: orderId, agentId: agentId, agentName: agentName,));
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
                                  customerName: customerName,
                                  agentName: agentName,
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
  ) : Row(
    children: [
      Expanded(
        flex: 1,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(60),
          child: ImageView.network(
            customerImage,
            height: 50,
                      width: 50,
                      fit: BoxFit.cover,
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
            text: 'Username',
            weight: FontWeight.w700,
            size: 12,
            fontFamily: AppStrings.interSans,
            color: Colors.black,
          ),
          subtitle: CustomText(
            textAlign: TextAlign.left,
            maxLines: 2,
            text: customerName.capitalizeFirstOfEach,
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
                      GestureDetector(
                        onTap: (){
                          _callNumber(customerPhone);
                        },
                        child: ImageView.svg(AppImages.callBorder)),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                          onTap: () {
                            msgCntrl.updateSelectedKey(orderId, agentId);
                       
                              AppNavigator.pushAndStackPage(context,
                                  page: ChatPage(
                                      customerName: customerName,
                                      userImage: customerImage,
                                      orderId: orderId, agentId: agentId, agentName: agentName,));
                          },
                          child: ImageView.svg(AppImages.messageBorder)),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                          onTap: () {
                            AppNavigator.pushAndStackPage(context,
                                page: VideoCall(
                                  customerName: customerName,
                                  agentName: agentName,
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

_callNumber(String number) async{
  bool res = await FlutterPhoneDirectCaller.callNumber(number) ?? false;
}
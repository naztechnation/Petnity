import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_images.dart';
import 'package:petnity/ui/location/widgets/map_view.dart';
import 'package:petnity/ui/widgets/button_view.dart';
import 'package:petnity/ui/widgets/image_view.dart';
import 'package:provider/provider.dart';

import '../../../../blocs/location/location.dart';
import '../../../../model/view_models/account_view_model.dart';
import '../../../../model/view_models/user_view_model.dart';
import '../../../../requests/repositories/location_repo/location_repository_impl.dart';
import '../../../../res/app_colors.dart';
import '../../../../res/app_strings.dart';
import '../../../../res/enum.dart';
import '../../../../utils/app_utils.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/text_edit_view.dart';
import 'widget/profile.dart';

class TrackServicesBody extends StatelessWidget {
  final String sellerName;
  final String sellerPhoto;
  final String phone;
  final String agentId;
  final String startDate1;
  final String startDate2;
  final String paymentId;
  final String amount;
  const TrackServicesBody(
      {super.key,
      required this.sellerName,
      required this.phone,
      required this.agentId,
      required this.startDate1,
      required this.startDate2,
      required this.paymentId,
      required this.amount,
      required this.sellerPhoto});

  @override
  Widget build(BuildContext context) {
    final services = Provider.of<UserViewModel>(context, listen: false);

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
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              serviceProfile(context, sellerName: sellerName, sellerImage: sellerPhoto, sellerId: agentId),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Container(
                  height: 60,
                  width: screenSize(context).width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)),
                  child: Center(
                    child: CustomText(
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      text: 'View profile',
                      weight: FontWeight.w700,
                      size: 12,
                      fontFamily: AppStrings.interSans,
                      color: AppColors.lightSecondary,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Provider.of<AccountViewModel>(context, listen: false)
                          .selectedService ==
                      Services.trainer
                  ? Column(
                      children: [
                        TextEditView(
                          controller: TextEditingController(
                            text: '1 month',
                          ),
                          borderRadius: 30,
                          readOnly: true,
                          borderColor: Colors.white,
                          filled: true,
                          fillColor: Colors.white,
                          isDense: true,
                          textViewTitle: 'Boarding Duration',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextEditView(
                          controller: TextEditingController(
                            text: 'Basic',
                          ),
                          borderRadius: 30,
                          readOnly: true,
                          borderColor: Colors.white,
                          filled: true,
                          fillColor: Colors.white,
                          isDense: true,
                          textViewTitle: 'Boarding Package',
                        ),
                      ],
                    )
                  : SizedBox.shrink(),
              const SizedBox(
                height: 20,
              ),
              CustomText(
                textAlign: TextAlign.left,
                maxLines: 2,
                text: 'Pick up date  and time',
                weight: FontWeight.w700,
                size: 12,
                fontFamily: AppStrings.interSans,
                color: Colors.black,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                height: 70,
                width: screenSize(context).width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Color(
                    0xFFF8FAFF,
                  ),
                ),
                child: Row(
                  children: [
                    ImageView.svg(AppImages.calender),
                    const SizedBox(
                      width: 10,
                    ),
                    CustomText(
                      textAlign: TextAlign.left,
                      maxLines: 2,
                      text: AppUtils.formatComplexDate(dateTime: startDate1),
                      weight: FontWeight.w600,
                      size: 12,
                      fontFamily: AppStrings.interSans,
                      color: Colors.black,
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ImageView.svg(AppImages.time),
                        const SizedBox(
                          width: 10,
                        ),
                        CustomText(
                          textAlign: TextAlign.left,
                          maxLines: 2,
                          text: services.formatDateTimeToAMPM(startDate1 ?? ''),
                          weight: FontWeight.w600,
                          size: 12,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomText(
                textAlign: TextAlign.left,
                maxLines: 2,
                text: 'Drop off date and time',
                weight: FontWeight.w600,
                size: 12,
                fontFamily: AppStrings.interSans,
                color: Colors.black,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                height: 70,
                width: screenSize(context).width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Color(
                    0xFFF8FAFF,
                  ),
                ),
                child: Row(
                  children: [
                    ImageView.svg(AppImages.calender),
                    const SizedBox(
                      width: 10,
                    ),
                    CustomText(
                      textAlign: TextAlign.left,
                      maxLines: 2,
                      text: AppUtils.formatComplexDate(dateTime: startDate2),
                      weight: FontWeight.w600,
                      size: 12,
                      fontFamily: AppStrings.interSans,
                      color: Colors.black,
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ImageView.svg(AppImages.time),
                        const SizedBox(
                          width: 10,
                        ),
                        CustomText(
                          textAlign: TextAlign.left,
                          maxLines: 2,
                          text: services.formatDateTimeToAMPM(startDate2 ?? ''),
                          weight: FontWeight.w600,
                          size: 12,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      height: 224,
                      width: screenSize(context).width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: MapViews(
                        zoom: 11,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: ButtonView(
                      onPressed: () {},
                      borderRadius: 30,
                      color: Colors.white,
                      borderColor: Colors.white,
                      child: CustomText(
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        text: 'Awaiting session',
                        weight: FontWeight.w700,
                        size: 12,
                        fontFamily: AppStrings.interSans,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 60,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        text: 'Session Paid - NGN $amount',
                        weight: FontWeight.w500,
                        size: 12,
                        color: Colors.black,
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.green.shade100),
                        child: CustomText(
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          text: paymentId,
                          weight: FontWeight.w600,
                          size: 14,
                          color: Colors.black,
                        ),
                      ),
                    ]),
              ),
              const SizedBox(
                height: 180,
              ),
            ],
          ),
        ));
  }
}

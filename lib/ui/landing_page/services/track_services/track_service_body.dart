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
import '../../../../requests/repositories/location_repo/location_repository_impl.dart';
import '../../../../res/app_colors.dart';
import '../../../../res/app_strings.dart';
import '../../../../res/enum.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/text_edit_view.dart';
import 'widget/profile.dart';

class TrackServicesBody extends StatelessWidget {
  const TrackServicesBody({super.key});

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
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              serviceProfile(context),
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
                      text: '20th October 2023',
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
                          text: '04pm',
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
                      text: '20th October 2023',
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
                          text: '04pm',
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
                        text: 'Session Paid - 1000\$',
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
                          text: '3243J46L',
                          weight: FontWeight.w600,
                          size: 14,
                          color: Colors.black,
                        ),
                      ),
                    ]),
              ),
              const SizedBox(
                height: 80,
              ),
            ],
          ),
        ));
  }
}

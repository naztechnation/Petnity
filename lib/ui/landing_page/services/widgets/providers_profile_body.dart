import 'package:flutter/material.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/ui/widgets/button_view.dart';
import 'package:petnity/ui/widgets/modals.dart';
import 'package:provider/provider.dart';

import '../../../../model/user_models/service_provider_lists.dart';
import '../../../../model/view_models/user_view_model.dart';
import '../../../../res/app_strings.dart';
import '../../../widgets/custom_multi_toogle.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/ratings_views.dart';
import 'contact_info.dart';

class ProviderProfileBody extends StatefulWidget {
  final Agents? agents;

  ProviderProfileBody({super.key, this.agents});

  @override
  State<ProviderProfileBody> createState() => _ProviderProfileBodyState();
}

class _ProviderProfileBodyState extends State<ProviderProfileBody> {
  List<String> services = [];

  List<String> animals = [];

  String servicesInfo = '';
  String animalsInfo = '';
  int ratings = 4;

  @override
  Widget build(BuildContext context) {
    services = widget.agents!.services != null
        ? widget.agents!.services!.map((service) => service.name ?? '').toList()
        : <String>[];

    animals = widget.agents!.petTypes != null
        ? widget.agents!.petTypes!
            .map((petTypes) => petTypes.name ?? '')
            .toList()
        : <String>[];

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Align(
            alignment: Alignment.centerLeft,
            child: CustomText(
              textAlign: TextAlign.start,
              maxLines: 2,
              text: 'Service',
              weight: FontWeight.w700,
              size: 16,
              fontFamily: AppStrings.interSans,
              color: Colors.black,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: ButtonView(
              onPressed: () {},
              borderRadius: 30,
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Text(
                '${services[0]}',
                style: TextStyle(color: AppColors.lightSecondary),
              ),
              expanded: false,
              color: AppColors.lightSecondary.withOpacity(0.3),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: CustomText(
              textAlign: TextAlign.start,
              maxLines: 2,
              text: 'Other services',
              weight: FontWeight.w700,
              size: 16,
              fontFamily: AppStrings.interSans,
              color: Colors.black,
            ),
          ),
          CustomMultiToggle(
            title: services,
            fontSize: 11,
            color: AppColors.lightPrimary,
            selectedTextColor: AppColors.lightPrimary,
            height: 35,
            contentMargin: const EdgeInsets.all(5),
            onSelected: (index) {
              setState(() {
                servicesInfo = services[index];
              });
            },
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: CustomText(
              textAlign: TextAlign.start,
              maxLines: 2,
              text: 'Animals',
              weight: FontWeight.w700,
              size: 16,
              fontFamily: AppStrings.interSans,
              color: Colors.black,
            ),
          ),
          CustomMultiToggle(
            title: animals,
            fontSize: 11,
            color: AppColors.lightPrimary,
            selectedTextColor: AppColors.lightPrimary,
            height: 35,
            contentMargin: const EdgeInsets.all(5),
            onSelected: (index) {
              setState(() {
                animalsInfo = animals[index];
              });
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                textAlign: TextAlign.start,
                maxLines: 2,
                text: 'About',
                weight: FontWeight.w600,
                size: 14,
                fontFamily: AppStrings.interSans,
                color: Colors.black,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomText(
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    text: 'Ratings',
                    weight: FontWeight.w600,
                    size: 14,
                    fontFamily: AppStrings.interSans,
                    color: Colors.black,
                  ),
                  RatingView(
                    rating: ratings,
                    onSelected: (rating) {
                      setState(() {
                        ratings = rating;
                      });
                    },
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          CustomText(
            textAlign: TextAlign.start,
            maxLines: 2,
            text: '${widget.agents!.gender}',
            weight: FontWeight.w500,
            size: 14,
            color: Colors.black,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomText(
            textAlign: TextAlign.start,
            maxLines: 4,
            text: '${widget.agents!.about}',
            weight: FontWeight.w500,
            size: 14,
            fontFamily: AppStrings.interSans,
            color: Colors.black,
          ),
          contactInfo(phone: widget.agents!.profile!.phoneNumber, email: widget.agents!.profile!.user!.email),
          const SizedBox(
            height: 30,
          ),
        ]));
  }
}

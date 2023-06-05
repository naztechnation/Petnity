import 'dart:io';

import 'package:flutter/material.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/ui/widgets/modals.dart';

import '../../../res/app_strings.dart';
import '../../widgets/back_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/filter_search_section.dart';
import 'widgets.dart/bottomsheet_content.dart';
import 'widgets.dart/providers_card.dart';

class ServiceProvidersDetails extends StatelessWidget {
  const ServiceProvidersDetails({super.key, required this.petProvider});

  final String petProvider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        SafeArea(child: SizedBox(height: (Platform.isAndroid) ? 30 : 0)),
        Row(
          children: [
            backButton(context),
            const SizedBox(
              width: 40,
            ),
            CustomText(
              textAlign: TextAlign.center,
              maxLines: 2,
              text: petProvider,
              weight: FontWeight.w600,
              size: 22,
              fontFamily: AppStrings.interSans,
              color: Colors.black,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: FilterSearchView(
            hintText: 'Search $petProvider',
            onFilterTap: () {
              Modals.showBottomSheetModal(
                context,
                
                page: bottomSheetContent(context),
                borderRadius: 30,
                heightFactor: 1,
              );
            },
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Expanded(
          child: ListView.builder(
              itemCount: 2,
              shrinkWrap: true,
              itemBuilder: (_, __) {
                return ProvidersCard();
              }),
        )
      ])),
    );
  }
}

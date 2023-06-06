import 'dart:io';

import 'package:flutter/material.dart';
import 'package:petnity/ui/widgets/modals.dart';

import '../../../res/app_strings.dart';
import '../../widgets/back_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/filter_search_section.dart';
import 'widgets.dart/bottomsheet_content.dart';
import 'widgets.dart/providers_card.dart';

class ServiceProvidersDetails extends StatelessWidget {
    ServiceProvidersDetails({super.key, required this.petProvider});

  final String petProvider;
  List<String> addressSpinnerItems = ['State', 'Enugu', 'Ebonyi', 'Lagos', 'Kano', 'Kastina', 'Anambra'];
  List<String> age = ['18-25', '27-35', '36-45', '46-100'];
  List<String> gender = ['Male', 'Female'];
  List<String> animals = ['Dogs', 'Cat', 'Monkeys', 'Rabbits', 'Squirrels', 'Parrots','Birds'];

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
                
                page: BottomSheetContent(addressSpinnerItems: addressSpinnerItems,age: age,gender: gender,animals: animals),
                borderRadius: 30,
                heightFactor: 1.5,
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

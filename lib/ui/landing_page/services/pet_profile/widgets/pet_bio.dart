import 'package:flutter/material.dart';
import 'package:petnity/extentions/custom_string_extension.dart';
import 'package:petnity/res/app_colors.dart';

import '../../../../../model/user_models/pets.dart';
import '../../../../../res/app_strings.dart';
import '../../../../widgets/custom_text.dart';

class PetBio extends StatelessWidget {
  final Pets pets;

  const PetBio({Key? key, required this.pets}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Dog Bio',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          pets.about ?? '',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(
          height: 20,
        ),

        Text(
          'Health Status',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: AppColors.lightGreen,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ListTile(
                title: CustomText(
                  text: '${pets.type?.name ?? 'None'} Illness',
                  fontFamily: AppStrings.interSans,
                  weight: FontWeight.w700,
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: (pets.healthIssues ?? [])
                      .map((health) => Text(
                            '${health.name ?? 'None'}'.capitalizeFirstOfEach,
                          ))
                      .toList(),
                ),
                trailing: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.38,
                  child: ListTile(
                    title: CustomText(
                      text: 'Medication',
                      fontFamily: AppStrings.interSans,
                      weight: FontWeight.w700,
                    ),
                    subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: (pets.healthIssues ?? [])
                      .map((health) => Text(
                            '${health.drug ?? 'None'}'.capitalizeFirstOfEach,
                          ))
                      .toList(),
                ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    text: 'Prescription',
                    fontFamily: AppStrings.interSans,
                    weight: FontWeight.w700,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: (pets.healthIssues ?? [])
                      .map((health) => Text(
                            '${health.prescription ?? 'None'}'.capitalizeFirstOfEach,
                          ))
                      .toList(),
                ),),
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                title: CustomText(
                  text: '${pets.type?.name ?? 'None'} Allergies',
                  fontFamily: AppStrings.interSans,
                  weight: FontWeight.w700,
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: (pets.allergies ?? [])
                      .map((allergy) => Text(
                            '${allergy.name ?? 'None'}'.capitalizeFirstOfEach,
                          ))
                      .toList(),
                ),
                trailing: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.38,
                  child: ListTile(
                    title: CustomText(
                      text: 'Medication',
                      fontFamily: AppStrings.interSans,
                      weight: FontWeight.w700,
                    ),
                    subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: (pets.allergies ?? [])
                      .map((allergy) => Text(
                            '${allergy.drug ?? 'None'}'.capitalizeFirstOfEach,
                          ))
                      .toList(),
                ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    text: 'Prescription',
                    fontFamily: AppStrings.interSans,
                    weight: FontWeight.w700,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: (pets.allergies ?? [])
                      .map((allergy) => Align(
                  alignment: Alignment.centerLeft,

                        child: Text(
                              '${allergy.prescription ?? 'None'}'.capitalizeFirstOfEach,
                            ),
                      ))
                      .toList(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        // Text(
        //   'Gallery',
        //   style: TextStyle(fontWeight: FontWeight.w700),
        // ),
        SizedBox(
          height: 20,
        ),
        // GalleryRatingBody(isGallery: true),
      ],
    );
  }
}

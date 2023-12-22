import 'package:flutter/material.dart';
import 'package:petnity/extentions/custom_string_extension.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:provider/provider.dart';

import '../../../../../model/view_models/user_view_model.dart';
import '../../../../../res/app_strings.dart';
import '../../../../widgets/custom_text.dart';

class PetBio extends StatelessWidget {
  const PetBio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var petDetails = Provider.of<UserViewModel>(context, listen: true);

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
          petDetails.petDetails?.pet?.about ?? '',
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
                  text: '${petDetails.petDetails?.pet?.type?.name ?? 'None'} Illness',
                  fontFamily: AppStrings.interSans,
                  weight: FontWeight.w700,
                ),
                subtitle: Text('${petDetails.petDetails?.petHealthIssue?.name ?? 'None'}'
                    .capitalizeFirstOfEach),
                trailing: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.38,
                  child: ListTile(
                    title: CustomText(
                      text: 'Medication',
                      fontFamily: AppStrings.interSans,
                      weight: FontWeight.w700,
                    ),
                    subtitle: Text(
                        '${petDetails.petDetails?.petHealthIssue?.drug ?? 'None'}'
                            .capitalizeFirstOfEach),
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
                    child: Text(
                        '${petDetails.petDetails?.petHealthIssue?.prescription ?? 'None'}'
                            .capitalizeFirstOfEach)),
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                title: CustomText(
                  text: '${petDetails.petDetails?.pet?.type?.name ?? 'None'} Illness',
                  fontFamily: AppStrings.interSans,
                  weight: FontWeight.w700,
                ),
                subtitle: Text('${petDetails.petDetails?.petAllergy?.name ?? 'None'}'
                    .capitalizeFirstOfEach),
                trailing: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.38,
                  child: ListTile(
                    title: CustomText(
                      text: 'Medication',
                      fontFamily: AppStrings.interSans,
                      weight: FontWeight.w700,
                    ),
                    subtitle: Text('${petDetails.petDetails?.petAllergy?.drug ?? 'None'}'
                        .capitalizeFirstOfEach),
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
                    child: Text(
                        '${petDetails.petDetails?.petAllergy?.prescription ?? 'None'}'
                            .capitalizeFirstOfEach)),
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

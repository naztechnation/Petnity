import 'package:flutter/material.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/ui/landing_page/services/widgets/gallery_rating_body.dart';

import '../../../../../res/app_strings.dart';
import '../../../../widgets/custom_text.dart';

class PetBio extends StatelessWidget {
  const PetBio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Lorem ipsum dolor sit amet consectetur. Vitae magna blandit nisl pulvinar ac nunc. Turpis pulvinar amet at erat fames venenatis. Est mi egestas eget feugiat nunc. Mattis sapien diam.',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          'Dog Bio',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          'Health Status',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 156,
          width: 379,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: AppColors.lightGreen,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListTile(
                title: CustomText(
                  text: 'Dog Illness',
                  fontFamily: AppStrings.interSans,
                  weight: FontWeight.w700,
                ),
                subtitle: Text('6 Months 3 Weeks Old'),
                trailing: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.38,
                  child: ListTile(
                    title: CustomText(
                      text: 'Medication',
                      fontFamily: AppStrings.interSans,
                      weight: FontWeight.w700,
                    ),
                    subtitle: Text('6-10'),
                  ),
                ),
              ),
              ListTile(
                title: CustomText(
                  text: 'Dog Allergies',
                  fontFamily: AppStrings.interSans,
                  weight: FontWeight.w700,
                ),
                subtitle: Text('Bulldog'),
                trailing: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.38,
                  child: ListTile(
                    title: CustomText(
                      text: 'Medication',
                      fontFamily: AppStrings.interSans,
                      weight: FontWeight.w700,
                    ),
                    subtitle: Text('46Kg'),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          'Gallery',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: 10,
        ),
        GalleryRatingBody(isGallery: true),
      ],
    );
  }
}

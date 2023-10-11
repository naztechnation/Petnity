import 'package:flutter/material.dart';
import 'package:petnity/extentions/custom_string_extension.dart';

import '../../../../res/app_colors.dart';
import '../../../../res/app_images.dart';
import '../../../../res/app_strings.dart';
import '../../../../res/enum.dart';
import '../../../widgets/button_view.dart';
import '../../../widgets/custom_text.dart';
import 'pet_type_container.dart';

class PetBreedBody extends StatefulWidget {
  final Function(String petType, int index) onPressed;
  PetBreedBody({
    super.key, required this.onPressed,
  });

  @override
  State<PetBreedBody> createState() => _PetBreedBodyState();
}

class _PetBreedBodyState extends State<PetBreedBody> {
  PetBreedsTypes _petTypes = PetBreedsTypes.none;

  @override
  Widget build(BuildContext context) {
    return Column(
      
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: PetType(
                imageUrl: AppImages.dogsPic,
                petName: 'German shepherd',
                spacing: 10,
                isPetType: _petTypes == PetBreedsTypes.german,
                onPressed: () {
                  setState(() {
                    _petTypes = PetBreedsTypes.german;
                  });
                },
              ),
            ),
           
            Flexible(
              child: PetType(
                imageUrl: AppImages.squirrelPic,
                petName: 'Bulldog',
                spacing: 5,
                isPetType: _petTypes == PetBreedsTypes.bulldog,
                onPressed: () {
                  setState(() {
                    _petTypes = PetBreedsTypes.bulldog;
                  });
                },
              ),
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              child: PetType(
                imageUrl: AppImages.catPic,
                petName: 'Chihuahua',
                spacing: 15,
                isPetType: _petTypes == PetBreedsTypes.chihuahua,
                onPressed: () {
                  setState(() {
                    _petTypes = PetBreedsTypes.chihuahua;
                  });
                },
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Flexible(
              child: PetType(
                imageUrl: AppImages.monkeyPic,
                petName: 'Poodle',
                spacing: 5,
                isPetType: _petTypes == PetBreedsTypes.poodle,
                onPressed: () {
                  setState(() {
                    _petTypes = PetBreedsTypes.poodle;
                  });
                },
              ),
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            PetType(
              imageUrl: AppImages.parrotPic,
              petName: 'Maltipoo',
              spacing: 10,
              isPetType: _petTypes == PetBreedsTypes.maltipoo,
              onPressed: () {
                setState(() {
                  _petTypes = PetBreedsTypes.maltipoo;
                });
              },
            ),
            SizedBox(
              width: 10,
            ),
            PetType(
              imageUrl: AppImages.birdsPic,
              petName: 'Bullmastiff',
              spacing: 20,
              isPetType: _petTypes == PetBreedsTypes.bullmastiff,
              onPressed: () {
                setState(() {
                  _petTypes = PetBreedsTypes.bullmastiff;
                });
              },
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            PetType(
              imageUrl: AppImages.rabbitPic,
              petName: 'Alstasian',
              spacing: 10,
              isPetType: _petTypes == PetBreedsTypes.alstatians,
              onPressed: () {
                setState(() {
                  _petTypes = PetBreedsTypes.alstatians;
                });
              },
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
        SizedBox(
          height: 80,
        ),
        if (_petTypes != PetTypes.none)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20),
            child: ButtonView(
              onPressed: () => widget.onPressed((_petTypes.index == 0) ? 'German shepherd' :_petTypes.name.capitalizeFirstOfEach, _petTypes.index + 1),
              color: AppColors.lightSecondary,
              borderRadius: 22,
              child: CustomText(
                textAlign: TextAlign.center,
                maxLines: 1,
                text: 'Select',
                weight: FontWeight.w700,
                size: 20,
                fontFamily: AppStrings.interSans,
                color: Colors.white,
              ),
            ),
          ),
        SizedBox(
          height: 50,
        ),
      ],
    );
  }
}

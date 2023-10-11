import 'package:flutter/material.dart';
import 'package:petnity/extentions/custom_string_extension.dart';

import '../../../../res/app_colors.dart';
import '../../../../res/app_images.dart';
import '../../../../res/app_strings.dart';
import '../../../../res/enum.dart';
import '../../../widgets/button_view.dart';
import '../../../widgets/custom_text.dart';
import 'pet_type_container.dart';

class PetTypeBody extends StatefulWidget {
  final Function(String petType, int index) onPressed;
  PetTypeBody({
    super.key, required this.onPressed,
  });

  @override
  State<PetTypeBody> createState() => _PetTypeBodyState();
}

class _PetTypeBodyState extends State<PetTypeBody> {
  PetTypes _petTypes = PetTypes.none;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            PetType(
              imageUrl: AppImages.dogsPic,
              petName: 'Dog',
              spacing: 10,
              isPetType: _petTypes == PetTypes.dog,
              onPressed: () {
                setState(() {
                  _petTypes = PetTypes.dog;
                });
              },
            ),
            SizedBox(
              width: 10,
            ),
            PetType(
              imageUrl: AppImages.squirrelPic,
              petName: 'Squirrels',
              spacing: 5,
              isPetType: _petTypes == PetTypes.squirrels,
              onPressed: () {
                setState(() {
                  _petTypes = PetTypes.squirrels;
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
            Flexible(
              child: PetType(
                imageUrl: AppImages.catPic,
                petName: 'Cats',
                spacing: 15,
                isPetType: _petTypes == PetTypes.cats,
                onPressed: () {
                  setState(() {
                    _petTypes = PetTypes.cats;
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
                petName: 'Monkeys',
                spacing: 5,
                isPetType: _petTypes == PetTypes.monkeys,
                onPressed: () {
                  setState(() {
                    _petTypes = PetTypes.monkeys;
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
              petName: 'Parrot',
              spacing: 10,
              isPetType: _petTypes == PetTypes.parrot,
              onPressed: () {
                setState(() {
                  _petTypes = PetTypes.parrot;
                });
              },
            ),
            SizedBox(
              width: 10,
            ),
            PetType(
              imageUrl: AppImages.birdsPic,
              petName: 'Birds',
              spacing: 20,
              isPetType: _petTypes == PetTypes.birds,
              onPressed: () {
                setState(() {
                  _petTypes = PetTypes.birds;
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
              petName: 'Rabbit',
              spacing: 10,
              isPetType: _petTypes == PetTypes.rabbits,
              onPressed: () {
                setState(() {
                  _petTypes = PetTypes.rabbits;
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
       
        SizedBox(
          height: 50,
        ),
      ],
    );
  }
}

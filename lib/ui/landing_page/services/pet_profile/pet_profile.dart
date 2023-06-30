import 'package:flutter/material.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/ui/landing_page/services/pet_profile/widgets/pet_bio.dart';
import 'package:petnity/ui/landing_page/services/pet_profile/widgets/pet_image_status.dart';
import 'package:petnity/ui/landing_page/services/pet_profile/widgets/pet_owner.dart';
import 'package:petnity/ui/landing_page/services/pet_profile/widgets/time_select.dart';
import 'package:petnity/ui/widgets/button_view.dart';

import '../../../widgets/back_button.dart';

class PetProfile extends StatefulWidget {
  const PetProfile({super.key});

  @override
  State<PetProfile> createState() => _PetProfileState();
}

class _PetProfileState extends State<PetProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 25),
              SafeArea(
                child: Row(
                  children: [
                    backButton(context),
                    //pet profile
                    SizedBox(width: 70),
                    Text(
                      'Pet Profile',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 40),
                    child: Column(
                      children: [
                        const SizedBox(height: 15),
                        //pet image and status
                        PetStatus(),
                        const SizedBox(height: 15),
                        //Pet owner
                        PetOwner(),
                        const SizedBox(
                          height: 15,
                        ),
                        //Thanos brief history and Bio
                        PetBio(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 30,
            left: 25,
            right: 25,
            child: ButtonView(
              borderRadius: 30,
              padding: EdgeInsets.symmetric(vertical: 25),
              color: AppColors.lightSecondary,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TimeSelections(),
                    ));
              },
              child: Text(
                'Book Session',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

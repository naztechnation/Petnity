import 'package:flutter/material.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/res/app_images.dart';
import 'package:petnity/ui/landing_page/services/pet_profile/widgets/pet_bio.dart';
import 'package:petnity/ui/landing_page/services/pet_profile/widgets/pet_image_status.dart';
import 'package:petnity/ui/landing_page/services/pet_profile/widgets/pet_owner.dart';
import 'package:petnity/ui/landing_page/services/pet_profile/widgets/time_select.dart';
import 'package:petnity/ui/widgets/button_view.dart';

import '../../../../utils/navigator/page_navigator.dart';
import '../../../widgets/back_button.dart';
import '../../../widgets/image_view.dart';
import '../single_image_view.dart';

class PetProfile extends StatefulWidget {
  final bool isUser;
  const PetProfile({super.key,  this.isUser = false});

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
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 40),
                    child: Column(
                      children: [
                        const SizedBox(height: 15),
                        PetStatus(),
                        const SizedBox(height: 15),
                      if(widget.isUser)   PetOwner(),
                        const SizedBox(
                          height: 15,
                        ),
                        PetBio(),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: Colors.white),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(40),
                              child: GridView.builder(
                                padding: const EdgeInsets.all(.0),
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 0,
                                  mainAxisSpacing: 0,
                                ),
                                itemCount: 6,
                                itemBuilder: (ctx, i) {
                                  return Container(
                                      decoration:
                                          BoxDecoration(color: Colors.white),
                                      child: GestureDetector(
                                          onTap: () {
                                            AppNavigator.pushAndStackPage(
                                                context,
                                                page: SingleImageView(
                                                  image: AppImages.dogPet,
                                                ));
                                          },
                                          child: ImageView.asset(
                                            AppImages.dogPet,
                                             
                                            fit: BoxFit.cover,
                                          )));
                                },
                              ),
                            ),
                          ),
                        ),
                     if(widget.isUser)    const SizedBox(
                          height: 120,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        if(widget.isUser)  Positioned(
            bottom: 30,
            left: 25,
            right: 25,
            child: ButtonView(
              borderRadius: 30,
              padding: EdgeInsets.symmetric(vertical: 15),
              color: AppColors.lightSecondary,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TimeSelections(),
                    ));
              },
              child: Text(
                'Request video call inspection',
                style: TextStyle(fontSize: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

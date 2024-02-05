import 'package:flutter/material.dart';
import 'package:petnity/extentions/custom_string_extension.dart';
import 'package:petnity/model/user_models/pets_profile.dart';

import '../../../../../res/app_constants.dart';
import '../../../../widgets/image_view.dart';

class PetStatus extends StatelessWidget {
  final Pets pets;
  const PetStatus({super.key, required this.pets});

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Container(
                        height: screenSize(context).height * .3,
                        width: screenSize(context).width * .9,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: ImageView.network(
                              pets.picture,
                              
                              fit: BoxFit.cover,
                            )),
                      ),
        const SizedBox(height: 15),

        
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              pets.name.toString().capitalizeFirstOfEach ?? "",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            Text(
              'Sex: ${pets.gender ?? ""}'.capitalizeFirstOfEach,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ],
    );
  }
}

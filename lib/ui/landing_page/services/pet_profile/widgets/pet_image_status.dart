import 'package:flutter/material.dart';
import 'package:petnity/extentions/custom_string_extension.dart';
import 'package:provider/provider.dart';

import '../../../../../model/view_models/user_view_model.dart';
import '../../../../../res/app_constants.dart';
import '../../../../widgets/image_view.dart';

class PetStatus extends StatelessWidget {
  const PetStatus({super.key});

  @override
  Widget build(BuildContext context) {
    var petDetails = Provider.of<UserViewModel>(context, listen: true);

    return Column(
      children: [
        Container(
                        height: screenSize(context).height * .3,
                        width: screenSize(context).width * .9,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: ImageView.network(
                              petDetails.petDetails?.pet?.picture,
                              
                              fit: BoxFit.cover,
                            )),
                      ),
        const SizedBox(height: 15),

        
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              petDetails.petDetails?.pet?.name.toString().capitalizeFirstOfEach ?? "",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            Text(
              'Sex: ${petDetails.petDetails?.pet?.gender ?? ""}'.capitalizeFirstOfEach,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ],
    );
  }
}

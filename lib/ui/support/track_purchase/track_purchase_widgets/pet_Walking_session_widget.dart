import 'package:flutter/material.dart';

import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_images.dart';

import 'package:petnity/ui/widgets/button_view.dart';

class PetWalkingSessionWidget extends StatelessWidget {
  const PetWalkingSessionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Card(
        child: Container(
          height: screenSize(context).height * .22,
          width: screenSize(context).width * .9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(AppImages.catPic),
                  radius: 40,
                ),
                title: Text('John Doe'),
                subtitle: Text('Dog Walking'),
                trailing: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  padding: EdgeInsets.all(5.0),
                  child:
                      Text('Awaiting session', style: TextStyle(fontSize: 10)),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Drop-off time',
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                        Text(
                          '4pm',
                          style: TextStyle(fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pick-up time',
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                        Text(
                          '5pm',
                          style: TextStyle(fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: screenSize(context).width * .3,
                    child: ButtonView(
                      // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      onPressed: () {},
                      child: Text('Details'),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

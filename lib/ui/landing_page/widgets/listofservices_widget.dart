import 'package:flutter/material.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_images.dart';

class ListOfServices extends StatelessWidget {
  const ListOfServices({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Item(context, Colors.lightBlueAccent),
                Item(context, Colors.brown),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Item(context, Color.fromARGB(255, 179, 120, 10)),
                Item(context, Color.fromARGB(255, 52, 139, 170)),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Item(context, Colors.purpleAccent),
                Item(context, Color.fromARGB(255, 185, 15, 72)),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Item(context, Colors.orangeAccent),
                Item(context, Colors.lightGreen),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Item(context, Colors.blue),
                Item(context, Colors.pink),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget Item(BuildContext context, Color color) {
  return Container(
    width: screenSize(context).width * .43,
    height: screenSize(context).height * .08,
    padding: EdgeInsets.symmetric(horizontal: 10),
    decoration: BoxDecoration(
        color: color.withOpacity(0.2), borderRadius: BorderRadius.circular(20)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(AppImages.catPic),
          radius: 30,
        ),
        Text(
          'Dog Sitter',
          maxLines: 2,
        )
      ],
    ),
  );
}

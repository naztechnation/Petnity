
import 'package:flutter/material.dart';

import '../../../../res/app_colors.dart';

class DurationContent extends StatefulWidget {

  final Function(String value) onTap;

  const DurationContent({super.key, required this.onTap});
  @override
  _MyListState createState() => _MyListState();
}

class _MyListState extends State<DurationContent> {
  int selectedValue = -1;

  @override
  Widget build(BuildContext context) {
    return   Wrap(
        spacing: 16,
        children: List.generate(8, (index) {
          List<String> durations = [
            '1 week',
            '2 weeks',
            '1 month',
            '1 month & 2 weeks',
           
            '2 months & 2 weeks',
            '3 months & 2 weeks',
             '2 months',
            '6 months',
            '3 months',
          ];

          String duration = durations[index];

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedValue = index;

                widget.onTap(duration);
              });
            },
            child: Container(
              width: 105,
                
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 0),

              decoration: BoxDecoration(
                color: selectedValue == index ?  AppColors.lightSecondary : Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    duration,
                    style: TextStyle(
                      color: selectedValue == index ?  Colors.white : Colors.black,
                       fontSize: 14,
                        fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
       
    );
  }
}
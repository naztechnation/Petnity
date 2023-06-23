import 'package:flutter/material.dart';

class PetStatus extends StatelessWidget {
  const PetStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 380,
          height: 396,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(29),
            image: DecorationImage(
              image: AssetImage('assets/images/pet1.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 15),

        //Pet status
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Thanos',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            Text(
              'Sex: Female',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ],
    );
  }
}

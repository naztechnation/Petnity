import 'package:flutter/material.dart';
import 'package:petnity/ui/location/widgets/map_view.dart';

class LocatePet extends StatelessWidget {
  const LocatePet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MapViews(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/utils/navigator/page_navigator.dart';

import '../../../../res/app_strings.dart';
import '../../../widgets/button_view.dart';
import '../../../widgets/custom_text.dart';
import '../review_screen.dart';

class ContactBottom extends StatefulWidget {
  final String buttonText;

  const ContactBottom({super.key, required this.buttonText});

  @override
  State<ContactBottom> createState() => _ContactBottomState();
}

class _ContactBottomState extends State<ContactBottom> {
  bool _value = true;
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

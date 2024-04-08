import 'package:flutter/material.dart'; 

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

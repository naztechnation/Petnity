import 'package:flutter/material.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/res/app_constants.dart'; 

import '../../handlers/secure_handler.dart';
import '../widgets/back_button.dart';

class ChangeEmailAndNumber extends StatefulWidget {
  @override
  State<ChangeEmailAndNumber> createState() => _ChangeEmailAndNumberState();
}

class _ChangeEmailAndNumberState extends State<ChangeEmailAndNumber> {
  final TextEditingController number = TextEditingController();

  String email = "";

  String phone = "";

  getUserDetails() async {
    email = await StorageHandler.getUserEmail();
    phone = await StorageHandler.getUserPhone();
    setState(() {
      
    });
  }

  @override
  void initState() {
   
    getUserDetails();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.lightBackground,
      appBar: PreferredSize(
        preferredSize: screenSize(context) * .1,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: AppBar(
            elevation: 0,
            backgroundColor: AppColors.lightBackground,
            leading:backButton(context),
            title: Text(
              'Change Number',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: ListTile(
                title: Text(
                  phone,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('Change Number'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.pushNamed(context, 'changeNumber');
                },
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}

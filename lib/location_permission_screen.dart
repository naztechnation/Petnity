import 'dart:io';


import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'res/app_routes.dart';
import 'ui/widgets/button_view.dart';
import 'utils/navigator/page_navigator.dart';



class LocationPermissionScreen extends StatefulWidget {
  const LocationPermissionScreen({super.key});

  @override
  State<LocationPermissionScreen> createState() =>
      _LocationPermissionScreenState();
}

class _LocationPermissionScreenState extends State<LocationPermissionScreen> {
  final Uri _url = Uri.parse('');

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  _getPerm() async {
            AppNavigator.pushAndReplaceName(context, name: AppRoutes.welcomeScreen);
    
    // PermissionStatus _permission = await Permission.location.request();
    // if (_permission.isGranted) {
    //         AppNavigator.pushAndReplaceName(context, name: AppRoutes.welcomeScreen);

    // } else {
    //   Modals.showToast('Permision Not Granted');

    //  exit(0);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SafeArea(
                  child: const SizedBox(
                height: 20,
              )),
              Align(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.location_on,
                    size: 65,
                    color: Colors.red,
                  )),
              const SizedBox(
                height: 20,
              ),
              Center(
                  child: Text(
                'Use your Location',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              )),
              const SizedBox(
                height: 30,
              ),
              Text(
                """At Lucacify, we prioritize your privacy and aim to offer exceptional service while upholding the confidentiality of your personal information. Here's how we utilize your location data:

        
Direct Service Delivery: Your location information enables us to ensure that pet care professionals can efficiently deliver their services directly to your location. This means they can come directly to you to provide the care your pets need, ensuring convenience and efficiency in managing their well-being.

We are dedicated to protecting your privacy. For further insights into how we handle your information, please review our detailed privacy policy linked below.
        """,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () async {
                  _launchUrl();
                },
                child: Align(
                  child: Text(
                    'https://lucacify.com/privacy',
                    textAlign: TextAlign.center,
                    
                    style: TextStyle(
                      decorationColor: Colors.blue,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.blue,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Image.asset('assets/images/google-maps.jpeg')
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 80,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ButtonView(
                onPressed: () async {
                  exit(0);
                },
                child: Text('No Thanks', style: TextStyle(color: Colors.white),),
                expanded: false,
                color: Colors.red,
                borderColor: Colors.red,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              ),
              ButtonView(
                onPressed: () {
                  _getPerm();
                },
                child: Text('I Agree', style: TextStyle(color: Colors.white),),
                expanded: false,
                color: Colors.green,
                borderColor: Colors.green,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

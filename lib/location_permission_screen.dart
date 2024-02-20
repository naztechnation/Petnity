import 'dart:io';


import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import 'ui/widgets/button_view.dart';



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
    
    PermissionStatus _permission = await Permission.location.request();
    if (_permission.isGranted) {
      // Navigator.pushAndRemoveUntil(context,
      //               MaterialPageRoute(builder: (_) {
      //             return const ContactPermissionScreen();
      //           }), (route) => false);
    } else {
      exit(0);
      //Modals.showToast('Permision Not Granted');
    }
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
                """This app collects your location information to enable a seamless pickup rider experience. We value your privacy and want to provide you with the best service possible. Here's how we use your location:
        
1. Pickup Coordination: By accessing your location, we can match you with the nearest available riders for quick and efficient pickups. This ensures that you receive timely service and reduces waiting times.
        
Please note that we respect your privacy and are committed to handling your location information responsibly.

You can learn more about choices regarding the collection and use of information in our privacy policy below
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
                child: Text(
                  'https://blopz.com/privacy',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.blue,
                      decoration: TextDecoration.underline),
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
                child: Text('No Thanks'),
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
                child: Text('I Agree'),
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

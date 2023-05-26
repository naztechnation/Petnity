import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../res/app_colors.dart';
import '../../res/app_constants.dart';
import '../../res/app_images.dart';
import '../../res/app_strings.dart';
import '../../utils/navigator/page_navigator.dart';
import '../widgets/back_button.dart';
import '../widgets/button_view.dart';
import '../widgets/custom_text.dart';
import '../widgets/image_view.dart';
import 'kyc_screen_eight.dart';

class KycScreenSeven extends StatefulWidget {
  final String selectedPet;

  KycScreenSeven({super.key, this.selectedPet = ''});

  @override
  State<KycScreenSeven> createState() => _KycScreenSevenState();
}

class _KycScreenSevenState extends State<KycScreenSeven> {
  var image;

  ImagePicker picker = ImagePicker();

  var imageSource;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: screenSize(context).height,
        width: screenSize(context).width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [AppColors.scaffoldColor, Colors.red.shade50],
                begin: Alignment.topRight,
                end: Alignment.topLeft)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SafeArea(child: SizedBox(height: (Platform.isAndroid) ? 44 : 0)),
              backButton(context),
              SizedBox(
                height: screenSize(context).height * 0.11,
              ),
              CustomText(
                textAlign: TextAlign.center,
                maxLines: 2,
                text: 'Upload your ${widget.selectedPet} \npicture ',
                weight: FontWeight.w700,
                size: 28,
                fontFamily: AppStrings.montserrat,
                color: Colors.black,
              ),
              SizedBox(
                height: 50,
              ),
           if(image == null) ... [ClipOval(
                  child: Container(
                      padding: EdgeInsets.all(30),
                      color: AppColors.cardColor,
                      height: 160,
                      width: 160,
                      child: ImageView.asset(
                        AppImages.defaultImage,
                        fit: BoxFit.contain,
                        height: 80,
                        width: 80,
                      ))),] ,
                      if(image != null)...[

                        ClipOval(
                  child: Container(
                      padding: EdgeInsets.all(0),
                      color: AppColors.cardColor,
                      height: 160,
                      width: 160,
                      child: ImageView.file(File(image!.path, ),fit: BoxFit.cover) )),
                          
                      ],
              SizedBox(
                height: 40,
              ),
              TextButton(
                onPressed: () async {
            imageSource  =     await showModalBottomSheet<dynamic>(
        context: context,
        shape: const RoundedRectangleBorder(borderRadius:
        BorderRadius.vertical(top: Radius.circular(16.0))),
        builder: (BuildContext bc) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(
                    left: 30.0, right: 8.0, top: 8.0, bottom: 8.0),
                child: Text('Select the images source',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.bold)),
              ),
              ListTile(
                leading: Icon(
                  Icons.photo_camera,
                  size: 35.0,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                title: const Text('Camera'),
                onTap: () async{
                  Navigator.pop(context);

     image = await ImagePicker().pickImage(source: ImageSource.camera,
          imageQuality: 80, maxHeight: 1000, maxWidth: 1000); 

          setState(() {
            
          });
                },
                
              
              ),
              ListTile(
                leading: Icon(
                  Icons.photo,
                  size: 35.0,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                title: const Text('Gallery'),
                onTap: () async{
                  Navigator.pop(context);
                image = await ImagePicker().pickImage(source: ImageSource.gallery,
          imageQuality: 80, maxHeight: 1000, maxWidth: 1000); 
           setState(() {
            
          });
                } ,
              ),
            ],
          );
        });
                                    
                      
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text('Choose from gallery'),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Color(0xFFEBF0FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              const SizedBox(
                height: 70,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20),
                child: ButtonView(
                  onPressed: () {
                    AppNavigator.pushAndStackPage(context,
                        page: KycScreenEight(
                          selectedPet: widget.selectedPet,
                        ));
                  },
                  color: AppColors.lightSecondary,
                  borderRadius: 32,
                  borderColor: Colors.white,
                  child: CustomText(
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    text: 'Select',
                    weight: FontWeight.w700,
                    size: 20,
                    fontFamily: AppStrings.interSans,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

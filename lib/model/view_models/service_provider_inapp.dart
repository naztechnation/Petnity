
 
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../../res/enum.dart';
import 'base_viewmodel.dart';

class ServiceProviderInAppViewModel extends BaseViewModel {
   
  int _selectedIndex = -1 ;
  File? _imageURl;


  setPackageLevelSelectedIndex({required int selectedIndex}){

    _selectedIndex = selectedIndex;
    setViewState(ViewState.success);

  }

  loadImage(BuildContext context, ) async {
    await showModalBottomSheet<dynamic>(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.0))),
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
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.w700)),
              ),
              ListTile(
                leading: Icon(
                  Icons.photo_camera,
                  size: 35.0,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                title: const Text('Camera'),
                onTap: () async {
                  Navigator.pop(context);

                  final image = await ImagePicker().pickImage(
                      source: ImageSource.camera,
                      imageQuality: 80,
                      maxHeight: 1000,
                      maxWidth: 1000);

                       _imageURl = File(image!.path);
                  
                  setViewState(ViewState.success);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.photo,
                  size: 35.0,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                title: const Text('Gallery'),
                onTap: () async {
                  Navigator.pop(context);
                  final image = await ImagePicker().pickImage(
                      source: ImageSource.gallery,
                      imageQuality: 80,
                      maxHeight: 1000,
                      maxWidth: 1000);
                      _imageURl = File(image!.path);

                  setViewState(ViewState.success);
                },
              ),
            ],
          );
        });
  }

   Future<String> uploadImage(String imageUrl, String uploadPreset) async{
    final url = Uri.parse('https://api.cloudinary.com/v1_1/do2z93mmw/upload');

    String image = '';

    try {
      final request = http.MultipartRequest('POST', url)
        ..fields['upload_preset'] = uploadPreset
        ..files.add(await http.MultipartFile.fromPath('file', imageUrl));

        final response = await request.send();

        if(response.statusCode == 200){
          final responseData = await response.stream.toBytes();
          final resPonseString = String.fromCharCodes(responseData);
          final jsonMap = jsonDecode(resPonseString);

            image = jsonMap['url'];

           
           return image;
        }
    } catch (e) {
      
    }
     
     return image;
  }



  int get selectedIndex => _selectedIndex;
  File? get imageURl => _imageURl;


}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../handlers/location_handler.dart';
import '../../res/enum.dart';
import 'base_viewmodel.dart';

class UserViewModel extends BaseViewModel {
  UserViewModel() {
    _intData();
  }

  String _address = '';
  String _username = '';
  String _petType = '';
  String _petTypeIndex = '';
  String _petName = '';
  String _petGender = '';
  String _petBreed = '';
  String _petSize = '';
  String _aboutPet = '';
  File? _imageURl;
  UserType _userType = UserType.none;

  ImagePicker picker = ImagePicker();

  bool _showPassword = false;

  double _latitude = 6.424676142638944;

  double _longitude = 7.496529864154287;

  Services _selectedService = Services.none;

  showPassword() {
    _showPassword = !_showPassword;
    setViewState(ViewState.success);
  }

  Future<void> _intData() async {
    /// Get current location
    final position = await LocationHandler.determinePosition();
    await setLongLat(
        latitude: position.latitude, longitude: position.longitude);
  }

  setPetType(String petType) {
    _petType = petType;
    setViewState(ViewState.success);
  }

   setPetTypeIndex(String petTypeIndex) {
    _petTypeIndex = petTypeIndex;
    setViewState(ViewState.success);
  }

  setPetName(String petName) {
    _petName = petName;
    setViewState(ViewState.success);
  }

  setPetGender(String petGender) {
    _petGender = petGender;
    setViewState(ViewState.success);
  }

  setPetSize(String petSize) {
    _petSize = petSize;
    setViewState(ViewState.success);
  }

  setAboutPet(String aboutPet) {
    _aboutPet = aboutPet;
    setViewState(ViewState.success);
  }

  setPetBreed(String petBreed) {
    _petBreed = petBreed;
    setViewState(ViewState.success);
  }

  setUserType(UserType userType) {
    _userType = userType;
    setViewState(ViewState.success);
  }

  Future<void> setUserData({required String username}) async {
    _username = username;
    setViewState(ViewState.success);
  }

  loadImage(BuildContext context) async {
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

  Future<void> setAddress(String address) async {
    _address = address;
    setViewState(ViewState.success);
  }

  Future<void> setSelectedService(Services selectedService) async {
    _selectedService = selectedService;
    setViewState(ViewState.success);
  }

  String get address => _address;
  Services get selectedService => _selectedService;

  Future<void> setLongLat(
      {required double latitude, required double longitude}) async {
    _longitude = longitude;
    _latitude = latitude;
    debugPrint('Longitude: $longitude  Latitude: $latitude');
    setViewState(ViewState.success);
  }

  double get longitude => _longitude;

  double get latitude => _latitude;
  bool get showPasswordStatus => _showPassword;
  String get username => _username;
  String get petType => _petType;
  String get petTypeIndex=> _petTypeIndex;
  String get petName => _petName;
  String get petGender => _petGender;
  String get petBreed => _petBreed;
  String get petSize => _petSize;
  String get aboutPet => _aboutPet;
  File? get imageURl => _imageURl;
  UserType get userType => _userType;
}

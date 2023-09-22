

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../res/app_colors.dart';
import '../../res/enum.dart';
import 'base_viewmodel.dart';

class ServiceProviderViewModel extends BaseViewModel {
 

  String _address = '';
  String _username = '';
  String _petType = '';
  String _petTypeIndex = '';
  String _serviceProviderName = '';
  String _serviceProviderGender = '';
  String _serviceProviderAge = '';
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

  

  

  setPetType(String petType) {
    _petType = petType;
    setViewState(ViewState.success);
  }

  setServiceProviderAge(String age) {
    
    _serviceProviderAge = age;
    setViewState(ViewState.success);
  }

   Future<String> showDatePickerDialog(BuildContext context) async {
    String age = '';
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1970),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.lightSecondary, // header background color
              onPrimary: AppColors.lightPrimary, // header text color
              onSurface: AppColors.lightSecondary, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.lightSecondary, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      String formattedDate = "${selectedDate.toLocal()}".split(' ')[0];

        setServiceProviderAge(formattedDate);

        age = serviceProviderAge;
     
    }

    return age;
  }



  setServiceProviderName(String name) {
    _serviceProviderName = name;
    setViewState(ViewState.success);
  }

  setServiceProviderGender(String serviceGender) {
    _serviceProviderGender = serviceGender;
    setViewState(ViewState.success);
  }

     setPetTypeIndex(String petTypeIndex) {
    _petTypeIndex = petTypeIndex;
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

  

  double get longitude => _longitude;

  double get latitude => _latitude;
  bool get showPasswordStatus => _showPassword;
  String get username => _username;
  String get petType => _petType;
  String get petTypeIndex=> _petTypeIndex;
  String get serviceProviderName => _serviceProviderName;
  String get servicesProviderGender => _serviceProviderGender;
  String get serviceProviderAge => _serviceProviderAge;
  String get petBreed => _petBreed;
  String get petSize => _petSize;
  String get aboutPet => _aboutPet;
  File? get imageURl => _imageURl;
  UserType get userType => _userType;
}

import 'package:flutter/material.dart';

import '../../handlers/location_handler.dart';
import '../../res/enum.dart';
import 'base_viewmodel.dart';

class UserViewModel extends BaseViewModel {
  UserViewModel() {
    _intData();
  }

  late String _address = '';

  late double _latitude = 6.424676142638944;

  late double _longitude = 7.496529864154287;

  double _walletBalance = 0;

  Services _selectedService = Services.none;

  Future<void> _intData() async {
    /// Get current location
    final position = await LocationHandler.determinePosition();
    await setLongLat(
        latitude: position.latitude, longitude: position.longitude);
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
}

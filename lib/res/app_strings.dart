
import 'dart:io';

import '../handlers/app_handlers.dart';

class AppStrings {
  static const String appName = 'Petnity';
  static const String interSans = 'InterSans';
  static const String montserrat = 'Montserrat';


  static const String _androidKey = 'AIzaSyCkRg-SOtAqWIK1AYKUz0FpRFcoB8gT1B4';
  static const String _iosKey = 'Google Maps API key';
  static final locationApiKey = Platform.isAndroid ? _androidKey : _iosKey;

  static const String networkErrorMessage = "Network error, try again later";

  static String googlePlaceUrl(String query) =>
      'https://maps.googleapis.com/maps/api/place/autocomplete/json'
      '?input=$query&language=en&components=country:ng'
      '&key=$locationApiKey&sessiontoken=${AppHandler.generateUniqueId()}';

 
}




import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationHandler{

  static Future<Placemark> getUserAddress() async{
    Position position=await determinePosition();
    List<Placemark> placeMarks = await placemarkFromCoordinates(position.latitude, position.longitude);

    return placeMarks.first;
  }

  static Future<String> getUserAddressFromLocation(double latitude, double longitude) async{
    List<Placemark> placeMarks = await placemarkFromCoordinates(latitude, longitude);
     
    var first = placeMarks.first;
    final address=first.locality;
    final city=first.administrativeArea;
    

    /*print(first.locality);
    print(first.isoCountryCode);
    print(first.postalCode);
    print(first.street);
    print(first.subAdministrativeArea);
    print(first.subLocality);
    print(first.subThoroughfare);
    print(first.thoroughfare);
    print(first.administrativeArea);
    print(first.name);
    print(first.country);*/

    return '$address, $city,';
  }

  static Future<Location> getUserLocationFromAddress(String address) async{
    List<Location> locations = await locationFromAddress(address);
    return locations.first;
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  static Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
  }


}
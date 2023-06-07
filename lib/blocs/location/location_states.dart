
import 'package:equatable/equatable.dart';
import 'package:geocoding/geocoding.dart';

import '../../model/data_models/location/location_prediction.dart';

abstract class LocationStates extends Equatable {
  const LocationStates();
}

class InitialState extends LocationStates {
  const InitialState();
  @override
  List<Object> get props => [];
}

class LoadingLocation extends LocationStates {
  @override
  List<Object> get props => [];
}

class LocationsLoaded extends LocationStates {
  final List<LocationPrediction> locations;
  const LocationsLoaded(this.locations);
  @override
  List<Object> get props => [locations];
}

class SearchLocationSelected extends LocationStates {
  final Location location;
  const SearchLocationSelected(this.location);
  @override
  List<Object> get props => [location];
}

class LocationDetected extends LocationStates {
  final String address;
  const LocationDetected(this.address);
  @override
  List<Object> get props => [address];
}

class LocationNetworkErr extends LocationStates {
  final String? message;
  const LocationNetworkErr(this.message);
  @override
  List<Object> get props => [message!];
}

class LocationApiErr extends LocationStates {
  final String? message;
  const LocationApiErr(this.message);
  @override
  List<Object> get props => [message!];
}
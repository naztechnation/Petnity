

import '../../../../model/data_models/location/location_prediction.dart';

abstract class LocationRepository {
  Future<List<LocationPrediction>> fetchSuggestions(String query);
}
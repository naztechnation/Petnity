
import '../../../model/data_models/location/location_prediction.dart';
import '../../../res/app_strings.dart';
import '../setup/requests.dart';
import 'location_repository.dart';

class LocationRepositoryImpl implements LocationRepository{

  @override
  Future<List<LocationPrediction>> fetchSuggestions(String query) async{
    // TODO: implement fetchSuggestions
    final map=await Requests().get(AppStrings.googlePlaceUrl(query));
    return List<LocationPrediction>.from(map["predictions"].map((x) => LocationPrediction.fromMap(x)));
  }

}
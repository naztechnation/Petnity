
import '../../../model/user_models/service_provider_lists.dart';
import '../../../res/app_strings.dart';
import '../../setup/requests.dart';
import 'user_repository.dart';

class UserRepositoryImpl implements UserRepository {
 
  
  @override
  Future<ServiceProvidersList> getServiceProviderList({required String serviceId}) async {
    final map = await Requests().get(AppStrings.getServiseProvidersList(serviceId), headers: {
      'Authorization': AppStrings.token,
     });
    return ServiceProvidersList.fromJson(map);
  }

  
}

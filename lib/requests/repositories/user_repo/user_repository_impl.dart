
import '../../../model/account_models/auth_data.dart';
import '../../../model/user_models/service_provider_lists.dart';
import '../../../model/user_models/service_type.dart';
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

@override
  Future<GetServiceTypes> getServiceTypes() async {
    final map = await Requests().get(AppStrings.getServiceTypes, headers: {
      'Authorization': AppStrings.token,
     });
    return GetServiceTypes.fromJson(map);
  }

  @override
  Future<ServiceProvidersList> serviceProvided(
      {required List<String> services,
      required String username,
      required String agentId}) async {
    final map = await Requests().patch(AppStrings.selectServiceTypeUrl(agentId),
        body: {
          "service_types": services
        },
        headers: {
          'Authorization': AppStrings.token,
          "Content-type": "application/json"
        });
    return ServiceProvidersList.fromJson(map);
  }
  
}

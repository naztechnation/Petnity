 

import '../../../model/user_models/service_provider_lists.dart';


abstract class UserRepository {
  Future<ServiceProvidersList> getServiceProviderList({
    required String serviceId,
    
    });   

    Future<ServiceProvidersList> getServiceTypes(); 
}
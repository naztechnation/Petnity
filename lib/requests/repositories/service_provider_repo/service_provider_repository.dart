 
import 'package:petnity/model/account_models/auth_data.dart';

import '../../../model/service_provider_models/create_services_amount.dart';
import '../../../model/user_models/create_order.dart';


abstract class ServiceProviderRepository {
   

  
    Future<CreateOrder> createService({required String packageId,required String username,required String pickupTime, required String dropOffTime, required String pickUpLocation});
    Future<ServiceAmount> createServiceAmount({required String agentId,required String servicesId,required String levelAmount});
    Future<AuthData> publishPackage({required String agentId,required String servicesId,});
    Future<AuthData> createServicePackage({required String agentId,required String servicesId,required String levelAmount,required String name,required String description, required String duration,required String pricing});

}
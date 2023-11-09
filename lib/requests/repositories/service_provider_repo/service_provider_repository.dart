 

import '../../../model/service_provider_models/create_services_amount.dart';
import '../../../model/user_models/create_order.dart';


abstract class ServiceProviderRepository {
   

  
    Future<CreateOrder> createService({required String packageId,required String username,required String pickupTime, required String dropOffTime, required String pickUpLocation});
    Future<ServiceAmount> createServiceAmount({required String agentId,required String servicesId,required String levelAmount});

}
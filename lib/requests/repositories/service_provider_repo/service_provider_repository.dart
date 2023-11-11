 
import 'package:petnity/model/account_models/auth_data.dart';

import '../../../model/service_provider_models/account_details.dart';
import '../../../model/service_provider_models/all_agent_orders.dart';
import '../../../model/service_provider_models/create_services_amount.dart';
import '../../../model/service_provider_models/create_shop_products_model.dart';
import '../../../model/user_models/create_order.dart';


abstract class ServiceProviderRepository {
   

  
    Future<CreateOrder> createService({required String packageId,required String username,required String pickupTime, required String dropOffTime, required String pickUpLocation});
    Future<ServiceAmount> createServiceAmount({required String agentId,required String servicesId,required String levelAmount});
    Future<AuthData> publishPackage({required String agentId,required String servicesId,});
    Future<AgentsOrderRequests> agentOrders({required String agentId,required String page,});
    Future<AccountDetailsList> accountDetails({required String agentId,});
    Future<AuthData> updateAccountDetails({required String agentId,required String accountName,required String accountNumber,required String bankName,});
    Future<AuthData> createServicePackage({required String agentId,required String servicesId,required String levelAmount,required String name,required String description, required String duration,required String pricing});
    Future<CreateShopProduct> createShopProduct({required String agentId,required String name,required String pricing,required String image,required String description,});

}
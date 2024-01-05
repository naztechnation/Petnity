 
import 'package:petnity/model/account_models/auth_data.dart';

import '../../../model/service_provider_models/account_details.dart';
import '../../../model/service_provider_models/all_agent_orders.dart';
import '../../../model/service_provider_models/create_services_amount.dart';
import '../../../model/service_provider_models/create_shop_products_model.dart';
import '../../../model/service_provider_models/create_vet_services.dart';
import '../../../model/service_provider_models/get_vet_services.dart';
import '../../../model/service_provider_models/get_agent_balance.dart';
import '../../../model/user_models/agent_services_lists.dart';
import '../../../model/user_models/vet_services.dart';
import '../../../model/user_models/withdrawal_history.dart';
import '../../../model/withdrawal/withdrawal.dart';


abstract class ServiceProviderRepository {
   

  
    Future<ServiceAmount> createServiceAmount({required String agentId,required String servicesId,required String levelAmount});
    Future<AuthData> publishPackage({required String agentId,required String servicesId,});
    Future<AgentsOrderRequests> agentOrders({required String agentId,required String page,});
    Future<AccountDetailsList> accountDetails({required String agentId,});
    Future<AuthData> updateAccountDetails({required String agentId,required String accountName,required String accountNumber,required String bankName,});
    Future<AuthData> createServicePackage({required String agentId,required String servicesId,required String levelAmount,required String name,required String description, required String duration,required String pricing});
    Future<CreateShopProduct> createShopProduct({required String agentId,required String name,required String pricing,required String image,required String description,});
    Future<AgentServicesList> getAgentServicesList({required String agentId}); 
    Future<AuthData> acceptAgentOrder({required String agentId, required String orderId,}); 
    Future<AuthData> acceptOngoingOrder({required String agentId, required String orderId,}); 
    Future<AuthData> acceptCompleteOrder({required String agentId, required String orderId,}); 
    Future<AuthData> userAcceptDeliveredShopOrder({required String username, required String orderId,}); 
    Future<AuthData> agentAcceptDeliveredShopOrder({required String agentId, required String orderId,}); 
    Future<AuthData> agentAcceptDeliveredServiceOrder({required String agentId, required String orderId,}); 
    Future<AuthData> agentRejectServiceOrder({required String agentId, required String orderId,}); 
    Future<AuthData> userAcceptOrderDelivered({required String username, required String orderId,}); 
    Future<AgentBalance> agentBalance({ required String agentId,}); 
    Future<CreateVetServices> createVetServices({ required String agentId,required String serviceId, 
    required List<int> sessionType, required List<int> contactMedium ,required int amount, }); 
    Future<AuthData> publishVetServices({ required String agentId,required String serviceId,}); 
    Future<VetsServices> vetServices({ required String agentId,}); 
    Future<CreateVetOrder> createVetOrder({ required String agentId,required String  username, required String  vetService,required String  sessionTime}); 
    Future<CreateVetOrder> confirmVetPaymentOrder({ required String orderId,required String  username, required String  vetServiceId,required String  purchaseId}); 
     Future<AuthData> acceptAgentVetOrder({required String agentId, required String orderId,}); 
    Future<AuthData> acceptOngoingVetOrder({required String agentId, required String orderId,}); 
    Future<AuthData> acceptCompleteVetOrder({required String agentId, required String orderId,}); 
    Future<AuthData> agentRejectServiceVetOrder({required String agentId, required String orderId,}); 
    Future<AuthData> userAcceptVetOrderDelivered({required String username, required String orderId,}); 
    Future<CreateWithrawal> agentCreateWithdrawal({required String agentId, required String amount,}); 
    Future<WithrawalHistory> agentWithdrawalHistory({required String agentId,}); 
    Future<AuthData> editPackagePricing({required String agentId,required String packageId,required String price,}); 

}
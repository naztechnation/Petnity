 
import 'package:petnity/model/account_models/auth_data.dart';
import 'package:petnity/model/user_models/credit_wallet.dart';

import '../../../model/account_models/add_bank.dart';
import '../../../model/service_provider_models/account_details.dart';
import '../../../model/service_provider_models/all_agent_orders.dart';
import '../../../model/service_provider_models/create_services_amount.dart';
import '../../../model/service_provider_models/create_shop_products_model.dart';
import '../../../model/service_provider_models/create_vet_services.dart';
import '../../../model/service_provider_models/get_vet_services.dart';
import '../../../model/service_provider_models/get_agent_balance.dart';
import '../../../model/service_provider_models/vetservices_model.dart';
import '../../../model/user/transactions/transactions_list.dart';
import '../../../model/user_models/agent_services_lists.dart';
import '../../../model/user_models/medium_types.dart';
import '../../../model/user_models/session_types.dart';
import '../../../model/user_models/withdrawal_history.dart';
import '../../../model/withdrawal/withdrawal.dart';


abstract class ServiceProviderRepository {
   

  
    Future<ServiceAmount> createServiceAmount({required String agentId,required String servicesId,required String levelAmount});
    Future<AuthData> publishPackage({required String agentId,required String servicesId,});
    Future<AgentsOrderRequests> agentOrders({required String agentId,required String page,});
    Future<AccountDetailsList> accountDetails({required String agentId,});
    Future<AddBank> updateAccountDetails({required String bankCode,required String accountName,required String accountNumber,required String bankName,});
    Future<AuthData> createServicePackage({required String agentId,required String servicesId,required String levelAmount,required String name,required String description, required String duration,required String pricing});
    Future<CreateShopProduct> createShopProduct({required String quantity,required String name,required String pricing,required List<String> image,required String description,});
    Future<AgentServicesList> getAgentServicesList({required String agentId}); 
    Future<AuthData> acceptAgentOrder({required String agentId, required String orderId,}); 
    Future<AuthData> acceptOngoingOrder({required String agentId, required String orderId,}); 
    Future<AuthData> acceptCompleteOrder({required String agentId, required String orderId,}); 
    Future<AuthData> userAcceptDeliveredShopOrder({required String username, required String orderId,}); 
    Future<AuthData> agentAcceptDeliveredShopOrder({required String agentId, required String orderId,}); 
    Future<AuthData> agentAcceptDeliveredServiceOrder({required String agentId, required String orderId,}); 
    Future<AuthData> agentRejectServiceOrder({required String agentId, required String orderId,}); 
    Future<AuthData> userAcceptOrderDelivered({required String username, required String orderId,}); 
    Future<AgentBalance> agentBalance({ required String url,}); 
    Future<CreateVetServices> createVetServices({ required String agentId,required String serviceId, 
    required List<String> sessionType, required List<String> contactMedium ,required int amount, }); 
    Future<AuthData> publishVetServices({ required String agentId,required String serviceId,}); 
    Future<VetServices> vetServices({ required String agentId,}); 
    Future<CreateVetOrder> createVetOrder({ required String agentId,required String  fee, required String  vetService,required String  sessionTime}); 
    Future<CreateVetOrder> confirmVetPaymentOrder({ required String orderId,required String  username, required String  vetServiceId,required String  purchaseId}); 
     Future<AuthData> acceptAgentVetOrder({required String agentId, required String orderId,}); 
    Future<AuthData> acceptOngoingVetOrder({required String agentId, required String orderId,}); 
    Future<AuthData> acceptCompleteVetOrder({required String agentId, required String orderId,}); 
    Future<AuthData> agentRejectServiceVetOrder({required String agentId, required String orderId,}); 
    Future<AuthData> userAcceptVetOrderDelivered({required String username, required String orderId,}); 
    Future<CreateWithrawal> agentCreateWithdrawal({required String amount,}); 
    Future<WithrawalHistory> agentWithdrawalHistory({required String agentId,}); 
    Future<UserTransactionList> userWithdrawalHistory(); 
    Future<AuthData> editPackagePricing({required String agentId,
    required String packageId,required String price,
    required String name,
      required String description,
      required String duration,
    }); 
    Future<AuthData> editVetPackagePricing({required String agentId,required String serviceId,required String price,}); 
    Future<CreditedWallet> creditWallet({required String txId,}); 
    Future<VetMediumTypes> getMediumTypes(); 
    Future<VetsSessionTypes> getSessionTypes(); 

}
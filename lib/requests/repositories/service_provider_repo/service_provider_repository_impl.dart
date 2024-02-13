import 'dart:convert';

import 'package:petnity/model/account_models/auth_data.dart';
import 'package:petnity/model/service_provider_models/account_details.dart';
import 'package:petnity/model/service_provider_models/all_agent_orders.dart';
import 'package:petnity/model/service_provider_models/create_services_amount.dart';
import 'package:petnity/model/service_provider_models/create_shop_products_model.dart';
import 'package:petnity/model/service_provider_models/create_vet_services.dart';
import 'package:petnity/model/user_models/credit_wallet.dart';

import '../../../model/account_models/add_bank.dart';
import '../../../model/service_provider_models/get_vet_services.dart';
import '../../../model/service_provider_models/get_agent_balance.dart';
import '../../../model/service_provider_models/vetservices_model.dart';
import '../../../model/user_models/agent_services_lists.dart';
import '../../../model/user_models/withdrawal_history.dart';
import '../../../model/withdrawal/withdrawal.dart';
import '../../../res/app_strings.dart';
import '../../setup/requests.dart';
import 'service_provider_repository.dart';

class ServiceProviderRepositoryImpl implements ServiceProviderRepository {
  @override
  Future<ServiceAmount> createServiceAmount(
      {required String agentId,
      required String servicesId,
      required String levelAmount}) async {
    var payload = {"serviceTypeId": servicesId, 'levelsAmount': levelAmount};
    final map = await Requests()
        .post(AppStrings.setServiceAmountUrl, body: json.encode(payload));
    return ServiceAmount.fromJson(map);
  }

  @override
  Future<AuthData> createServicePackage(
      {required String agentId,
      required String servicesId,
      required String levelAmount,
      required String name,
      required String description,
      required String duration,
      required String pricing}) async {
    var payload = {
      'level': levelAmount,
      'name': name,
      'description': description,
      'duration': duration,
      'price': pricing,
    };
    final map = await Requests().post(AppStrings.createPackageUrl(servicesId),
        body: json.encode(payload));

    return AuthData.fromJson(map);
  }

  @override
  Future<AuthData> publishPackage(
      {required String agentId, required String servicesId}) async {
    final map = await Requests().patch(
      AppStrings.publishPackageUrl(servicesId),
      useApp: false
    );
    return AuthData.fromJson(map);
  }

  @override
  Future<CreateShopProduct> createShopProduct(
      {required String quantity,
      required String name,
      required String pricing,
      required List<String> image,
      required String description}) async {
    var payload = {
      "name": name,
      "price": pricing,
      "images": image,
      "description": description,
      "quantity": quantity
    };
    final map = await Requests()
        .post(AppStrings.publishShopProductUrl, body: json.encode(payload));

    return CreateShopProduct.fromJson(map);
  }

  @override
  Future<AgentsOrderRequests> agentOrders(
      {required String agentId, required String page}) async {
    final map = await Requests().get(
      AppStrings.agentOrderUrl,
    );
    return AgentsOrderRequests.fromJson(map);
  }

  @override
  Future<AddBank> updateAccountDetails(
      {required String bankCode,
      required String accountName,
      required String accountNumber,
      required String bankName}) async {
    var payload = {
      "bank": bankName,
      "bankCode": bankCode,
      "accountName": accountName,
      "accountNumber": accountNumber
    };
    final map = await Requests()
        .post(AppStrings.updateAccountDetailsUrl, body: payload, useApp: false);

    return AddBank.fromJson(map);
  }

  @override
  Future<AccountDetailsList> accountDetails({
    required String agentId,
  }) async {
    final map = await Requests().get(
      AppStrings.getAccountDetailsUrl,
    );
    return AccountDetailsList.fromJson(map);
  }

  @override
  Future<AgentServicesList> getAgentServicesList(
      {required String agentId}) async {
    final map = await Requests().get(
      AppStrings.getAgentServicesLists,
    );

    return AgentServicesList.fromJson(map);
  }

  @override
  Future<AuthData> acceptAgentOrder(
      {required String agentId, required String orderId}) async {
    final map = await Requests().patch(
      
      AppStrings.agentAcceptOrder(orderId: orderId),
      useApp: false
    );

    return AuthData.fromJson(map);
  }

  @override
  Future<AuthData> acceptCompleteOrder(
      {required String agentId, required String orderId}) async {
    final map = await Requests().patch(
      AppStrings.agentMarkCompletedOrder(orderId: orderId),
      useApp: false

    );

    return AuthData.fromJson(map);
  }

  @override
  Future<AuthData> acceptOngoingOrder(
      {required String agentId, required String orderId}) async {
    final map = await Requests().patch(
      AppStrings.agentMarkOngoingOrder(orderId: orderId),
      useApp: false
    );

    return AuthData.fromJson(map);
  }

  @override
  Future<AuthData> agentAcceptDeliveredShopOrder(
      {required String agentId, required String orderId}) async {
    final map = await Requests().patch(
      AppStrings.agentMarkDeliveredShopOrder(orderId: orderId),
    );

    return AuthData.fromJson(map);
  }

  @override
  Future<AuthData> userAcceptDeliveredShopOrder(
      {required String username, required String orderId}) async {
    final map = await Requests().patch(
      AppStrings.userMarkDeliveredShopOrder(orderId: orderId),
    );

    return AuthData.fromJson(map);
  }

  @override
  Future<AuthData> agentRejectServiceOrder(
      {required String agentId, required String orderId}) async {
    final map = await Requests().patch(
      AppStrings.agentRejectServiceOrder(orderId: orderId),
    );

    return AuthData.fromJson(map);
  }

  @override
  Future<AuthData> userAcceptOrderDelivered(
      {required String username, required String orderId}) async {
    final map = await Requests()
        .patch(AppStrings.userMarkOrderDelivered(orderId: orderId),
        useApp: false
        );

    return AuthData.fromJson(map);
  }

  @override
  Future<AuthData> agentAcceptDeliveredServiceOrder(
      {required String agentId, required String orderId}) async {
    final map = await Requests().patch(
      AppStrings.userMarkOrderDelivered(orderId: orderId),
    );

    return AuthData.fromJson(map);
  }

  @override
  Future<AgentBalance> agentBalance({required String url}) async {
    final map = await Requests().get(url);

    return AgentBalance.fromJson(map);
  }

  @override
  Future<CreateVetServices> createVetServices({
    required String agentId,
    required String serviceId,
    required List<String> sessionType,
    required List<String> contactMedium,
    required int amount,
  }) async {
    var payload = {
      "serviceId": serviceId,
      "vetSessionTypes": sessionType,
      "vetContactMediums": contactMedium,
      "price": amount
    };
    final map = await Requests().post(
      AppStrings.createVetService,
      body: json.encode(payload),
    );

    return CreateVetServices.fromJson(map);
  }

  @override
  Future<AuthData> publishVetServices({
    required String agentId,
    required String serviceId,
  }) async {
    final map = await Requests().patch(
      AppStrings.publishVetService(serviceId),
    );

    return AuthData.fromJson(map);
  }

  @override
  Future<VetServices> vetServices({required String agentId}) async {
    final map = await Requests().get(
      AppStrings.getVetService(
        agentId,
      ),
    );

    return VetServices.fromJson(map);
  }

  @override
  Future<CreateVetOrder> createVetOrder(
      {required String agentId,
      required String fee,
      required String vetService,
      required String sessionTime}) async {
    var payload = {
      'fee': fee,
      'sessionTime': sessionTime,
    };
    final map = await Requests().post(
      AppStrings.createVetOrder(
        agentId,
      ),
      body: json.encode(payload),
    );

    return CreateVetOrder.fromJson(map);
  }

  @override
  Future<CreateVetOrder> confirmVetPaymentOrder(
      {required String orderId,
      required String username,
      required String vetServiceId,
      required String purchaseId}) async {
    final map = await Requests()
        .post(AppStrings.confirmVetPaymentOrder(orderId, username), body: {
      'purchase_id': purchaseId,
      'vet_service': vetServiceId,
    }, );

    return CreateVetOrder.fromJson(map);
  }

  @override
  Future<AuthData> acceptAgentVetOrder(
      {required String agentId, required String orderId}) async {
    final map = await Requests().patch(
      AppStrings.agentAcceptVetOrder(orderId: orderId),
      useApp: false

    );

    return AuthData.fromJson(map);
  }

  @override
  Future<AuthData> acceptCompleteVetOrder(
      {required String agentId, required String orderId}) async {
    final map = await Requests().patch(
      AppStrings.agentMarkCompletedVetOrder(orderId: orderId),
      useApp: false
    );

    return AuthData.fromJson(map);
  }

  @override
  Future<AuthData> acceptOngoingVetOrder(
      {required String agentId, required String orderId}) async {
    final map = await Requests().patch(
      AppStrings.agentMarkOngoingVetOrder(orderId: orderId),
      useApp: false

    );

    return AuthData.fromJson(map);
  }

  @override
  Future<AuthData> agentRejectServiceVetOrder(
      {required String agentId, required String orderId}) async {
    final map = await Requests().patch(
      AppStrings.agentRejectServiceVetOrder(orderId: orderId),
      useApp: false

    );

    return AuthData.fromJson(map);
  }

  @override
  Future<AuthData> userAcceptVetOrderDelivered(
      {required String username, required String orderId}) async {
    final map = await Requests().patch(
      AppStrings.userMarkVetOrderDelivered(orderId: orderId),
      useApp: false

    );

    return AuthData.fromJson(map);
  }

  @override
  Future<CreateWithrawal> agentCreateWithdrawal({
    required var amount,
  }) async {

    var payload = {
          "amount": amount
        };
    final map = await Requests().post(
        AppStrings.agentCreateWithdrawal,
        useApp: false,
        body: payload,
        );

    return CreateWithrawal.fromJson(map);
  }

  

  @override
  Future<WithrawalHistory> agentWithdrawalHistory(
      {required String agentId}) async {
    final map = await Requests().get(
      AppStrings.agentWithdrawalHistory
    );

    return WithrawalHistory.fromJson(map);
  }

  @override
  Future<AuthData> editPackagePricing(
      {required String agentId,
      required String packageId,
      required String price}) async {
    var payload = {'price': price};
    final map = await Requests().patch(
      AppStrings.updatePackagePricing(
        packageId: packageId,
      ),
      body: payload,
    );

    return AuthData.fromJson(map);
  }

  @override
  Future<AuthData> editVetPackagePricing(
      {required String agentId,
      required String serviceId,
      required String price}) async {
    var payload = {'price': price};
    final map = await Requests().patch(
      AppStrings.updateVetPackagePricing(
        serviceId: serviceId,
      ),
      body: payload,
    );

    return AuthData.fromJson(map);
  }

  @override
  Future<CreditedWallet> creditWallet({required String txId}) async {
    var payload = {'transactionId': txId};
    final map = await Requests().post(
      AppStrings.creditWalletUrl,
      body: json.encode(payload),
    );

    return CreditedWallet.fromJson(map);
  }
}

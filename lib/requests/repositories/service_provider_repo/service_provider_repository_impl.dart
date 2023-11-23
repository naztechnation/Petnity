import 'package:petnity/model/account_models/auth_data.dart';
import 'package:petnity/model/service_provider_models/account_details.dart';
import 'package:petnity/model/service_provider_models/all_agent_orders.dart';
import 'package:petnity/model/service_provider_models/create_services_amount.dart';
import 'package:petnity/model/service_provider_models/create_shop_products_model.dart';
import 'package:petnity/model/user_models/create_order.dart';

import '../../../model/user_models/agent_services_lists.dart';
import '../../../res/app_strings.dart';
import '../../setup/requests.dart';
import 'service_provider_repository.dart';

class ServiceProviderRepositoryImpl implements ServiceProviderRepository {
  @override
  Future<ServiceAmount> createServiceAmount(
      {required String agentId,
      required String servicesId,
      required String levelAmount}) async {
    final map = await Requests()
        .post(AppStrings.setServiceAmountUrl(agentId, servicesId), headers: {
      'Authorization': AppStrings.token,
    }, body: {
      'levels_amount': levelAmount
    });
    return ServiceAmount.fromJson(map);
  }

  @override
  Future<CreateOrder> createService(
      {required String packageId,
      required String username,
      required String pickupTime,
      required String dropOffTime,
      required String pickUpLocation}) {
    // TODO: implement createService
    throw UnimplementedError();
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
    final map = await Requests()
        .post(AppStrings.createPackageUrl(agentId, servicesId), headers: {
      'Authorization': AppStrings.token,
    }, body: {
      'level': levelAmount,
      'name': name,
      'description': description,
      'duration': duration,
      'price': pricing,
    });

    return AuthData.fromJson(map);
  }

  @override
  Future<AuthData> publishPackage(
      {required String agentId, required String servicesId}) async {
    final map = await Requests().patch(
      AppStrings.publishPackageUrl(agentId, servicesId),
      headers: {
        'Authorization': AppStrings.token,
      },
    );
    return AuthData.fromJson(map);
  }

  @override
  Future<CreateShopProduct> createShopProduct(
      {required String agentId,
      required String name,
      required String pricing,
      required String image,
      required String description}) async {
    final map =
        await Requests().post(AppStrings.publishShopProductUrl, headers: {
      'Authorization': AppStrings.token,
    }, body: {
      'agent_id': agentId,
      'name': name,
      'image': image,
      'description': description,
      'price': pricing,
    });

    return CreateShopProduct.fromJson(map);
  }

  @override
  Future<AgentsOrderRequests> agentOrders(
      {required String agentId, required String page}) async {
    final map = await Requests().get(
      AppStrings.agentOrderUrl(agentId, page),
      headers: {
        'Authorization': AppStrings.token,
      },
    );
    return AgentsOrderRequests.fromJson(map);
  }

  @override
  Future<AuthData> updateAccountDetails(
      {required String agentId,
      required String accountName,
      required String accountNumber,
      required String bankName}) async {
    final map = await Requests()
        .post(AppStrings.updateAccountDetailsUrl(agentId: agentId), headers: {
      'Authorization': AppStrings.token,
    }, body: {
      'bank': bankName,
      'account_name': accountName,
      'account_number': accountNumber,
    });

    return AuthData.fromJson(map);
  }

  @override
  Future<AccountDetailsList> accountDetails({
    required String agentId,
  }) async {
    final map = await Requests().get(
      AppStrings.getAccountDetailsUrl(
        agentId: agentId,
      ),
      headers: {
        'Authorization': AppStrings.token,
      },
    );
    return AccountDetailsList.fromJson(map);
  }

  @override
  Future<AgentServicesList> getAgentServicesList(
      {required String agentId}) async {
    final map = await Requests()
        .get(AppStrings.getAgentServicesLists(agentId: agentId), headers: {
      'Authorization': AppStrings.token,
    });

    return AgentServicesList.fromJson(map);
  }

  @override
  Future<AuthData> acceptAgentOrder(
      {required String agentId, required String orderId}) async {
    final map = await Requests().patch(
        AppStrings.agentAcceptOrder(agentId: agentId, orderId: orderId),
        headers: {
          'Authorization': AppStrings.token,
        });

    return AuthData.fromJson(map);
  }

  @override
  Future<AuthData> acceptCompleteOrder(
      {required String agentId, required String orderId}) async {
    final map = await Requests().patch(
        AppStrings.agentMarkCompletedOrder(agentId: agentId, orderId: orderId),
        headers: {
          'Authorization': AppStrings.token,
        });

    return AuthData.fromJson(map);
  }

  @override
  Future<AuthData> acceptOngoingOrder(
      {required String agentId, required String orderId}) async {
    final map = await Requests().patch(
        AppStrings.agentMarkOngoingOrder(agentId: agentId, orderId: orderId),
        headers: {
          'Authorization': AppStrings.token,
        });

    return AuthData.fromJson(map);
  }
  
  @override
  Future<AuthData> agentAcceptDeliveredShopOrder({required String agentId, required String orderId}) async {
    final map = await Requests().patch(
        AppStrings.agentMarkDeliveredShopOrder(agentId: agentId, orderId: orderId),
        headers: {
          'Authorization': AppStrings.token,
        });

    return AuthData.fromJson(map);
  }
  
  @override
  Future<AuthData> userAcceptDeliveredShopOrder({required String username, required String orderId}) async {
    final map = await Requests().patch(
        AppStrings.userMarkDeliveredShopOrder(username: username, orderId: orderId),
        headers: {
          'Authorization': AppStrings.token,
        });

    return AuthData.fromJson(map);
  }
}

 
import 'package:petnity/model/account_models/auth_data.dart';
import 'package:petnity/model/service_provider_models/create_services_amount.dart';
import 'package:petnity/model/service_provider_models/create_shop_products_model.dart';
import 'package:petnity/model/user_models/create_order.dart';

import '../../../res/app_strings.dart';
import '../../../ui/widgets/modals.dart';
import '../../setup/requests.dart';
import 'service_provider_repository.dart';

class ServiceProviderRepositoryImpl implements ServiceProviderRepository {
  
  
  @override
   Future<ServiceAmount> createServiceAmount({required String agentId,required String servicesId,
   required String levelAmount}) async {
    final map = await Requests()
        .post(AppStrings.setServiceAmountUrl(agentId, servicesId), headers: {
      'Authorization': AppStrings.token,
    },
    body: {
      'levels_amount': levelAmount
    }
    );
    return ServiceAmount.fromJson(map);
  }

  @override
  Future<CreateOrder> createService({required String packageId, required String username, required String pickupTime, required String dropOffTime, required String pickUpLocation}) {
    // TODO: implement createService
    throw UnimplementedError();
  }

  @override
  Future<AuthData> createServicePackage({required String agentId, required String servicesId, 
  required String levelAmount, required String name, 
  required String description, required String duration, required String pricing}) async {
    final map = await Requests()
        .post(AppStrings.createPackageUrl(agentId, servicesId), headers: {
      'Authorization': AppStrings.token,
    },
    body: {
      'level': levelAmount,
      'name': name,
      'description': description,
      'duration': duration,
      'price': pricing,
    }
    );
    Modals.showToast(pricing);

    return AuthData.fromJson(map);
  }
  
  @override
  Future<AuthData> publishPackage({required String agentId, required String servicesId}) async {
    final map = await Requests()
        .patch(AppStrings.publishPackageUrl(agentId, servicesId), headers: {
      'Authorization': AppStrings.token,
    },
   
    );
    return AuthData.fromJson(map);
  }

  @override
  Future<CreateShopProduct> createShopProduct({required String agentId, 
  required String name, required String pricing, required String image, required String description}) async {
    final map = await Requests()
        .post(AppStrings.publishShopProductUrl, headers: {
      'Authorization': AppStrings.token,
    },
    body: {
      'agent_id': agentId,
      'name': name,
      'image': image,
      'description': description,
      'price': pricing,
    }
    );
    Modals.showToast(pricing);

    return CreateShopProduct.fromJson(map);
  }

 

}

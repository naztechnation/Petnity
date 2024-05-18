import 'dart:convert';

import 'package:petnity/model/account_models/agents_packages.dart';
import 'package:petnity/model/account_models/confirm_payment.dart';
import 'package:petnity/model/user_models/confirm_shop_payment.dart';
import 'package:petnity/model/user_models/create_payment_order.dart';
import 'package:petnity/model/user_models/faq.dart';
import 'package:petnity/model/user_models/get_product_reviews.dart';
import 'package:petnity/model/user_models/notifications.dart';
import 'package:petnity/model/user_models/privacy_policy.dart';
import 'package:petnity/model/user_models/products_detail.dart';
import 'package:petnity/model/user_models/user_shopping_data.dart';

import '../../../model/account_models/auth_data.dart';
import '../../../model/user_models/agent_profile.dart';
import '../../../model/user_models/create_order.dart';
import '../../../model/user_models/gallery_data.dart';
import '../../../model/user_models/get_services.dart';
import '../../../model/user_models/get_services_type.dart';
import '../../../model/user_models/order_lists.dart';
import '../../../model/user_models/pet_profile_details.dart';
import '../../../model/user_models/pets_profile.dart';
import '../../../model/user_models/reviews_data.dart';
import '../../../model/user_models/service_provider_lists.dart';
import '../../../model/user_models/shopping_lists.dart';
import '../../../model/user_models/user_profile.dart';
import '../../../res/app_strings.dart';
import '../../setup/requests.dart';
import 'user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  @override
  Future<ServiceProvidersList> getServiceProviderList(
      {required String serviceId}) async {
    final map = await Requests()
        .get(AppStrings.getServiceProvidersList(serviceId),);
    return ServiceProvidersList.fromJson(map);
  }

  @override
  Future<GetServiceTypes> getServiceTypes() async {
    final map = await Requests().get(
         
             AppStrings.getServiceTypes
            
        );
    return GetServiceTypes.fromJson(map);
  }

   @override
  Future<GetServices> getIndividualAgentService(String agentId) async {
    final map = await Requests().get(
         
              AppStrings.getIndividualAgentService(agentId),
        );
    return GetServices.fromJson(map);
  }

  @override
  Future<ServiceProvidersList> serviceProvided(
      {required List<String> services,
      required String username,
      required String agentId}) async {
    final map = await Requests().patch(
      AppStrings.selectServiceTypeUrl,
      body: {"serviceTypes": services},
    );
    return ServiceProvidersList.fromJson(map);
  }

  @override
  Future<GetReviews> getReviews({required String userId}) async {
    final map = await Requests().get(AppStrings.getReviewUrl(userId), );
    return GetReviews.fromJson(map);
  }

  @override
  Future<GalleryAgents> getGallery({required String agentId}) async {
    final map = await Requests().get(
      AppStrings.getGalleryUrl(agentId),
    );
    return GalleryAgents.fromJson(map);
  }

  @override
  Future<GetAgentsPackages> getAgentPackages(
      {required String agentId, required String serviceId}) async {
    final map = await Requests()
        .get(AppStrings.getAgentPackagesUrl(serviceId), );
    return GetAgentsPackages.fromJson(map);
  }

  @override
  Future<PaymentResponse> confirmPayment({
    required String username,
    required String purchaseId,
    required String orderId,
  }) async {
    final map = await Requests()
        .post(AppStrings.confirmPaymentUrl(username, orderId), body: {
      "purchase_id": purchaseId
    }, headers: {
      'Authorization': AppStrings.token,
    });
    return PaymentResponse.fromJson(map);
  }

  @override
  Future<CreateOrder> createOrder(
      {required String packageId,
      required String pickupTime,
      required String dropOffTime,
      required String fee,
      required String pickUpLocation}) async {

        var payload = {
      "pickupTime": pickupTime,
      "dropoffTime": dropOffTime,
      "pickupLocation": pickUpLocation,
      "fee": fee,
    };
    final map = await Requests()
        .post(AppStrings.createOrder(packageId,), body: json.encode(payload), );
    return CreateOrder.fromJson(map);
  }

  @override
  Future<UserOrders> orderList({required String username}) async {
    final map = await Requests().get(
      AppStrings.userOrders,
    );
    return UserOrders.fromJson(map);
  }

  @override
  Future<ShoppingList> shoppingList({required String index}) async {
    final map = await Requests().get(AppStrings.shoppingList(index),);
    return ShoppingList.fromJson(map);
  }

  @override
  Future<ShoppingList> agentShoppingList({required String agentId}) async {
    final map = await Requests()
        .get(AppStrings.getAgentsProducts(agentId: agentId), );
    return ShoppingList.fromJson(map);
  }

  @override
  Future<ProductDetails> productDetails({required String productId}) async {
    final map =
        await Requests().get(AppStrings.productDetailsUrl(productId),);
    return ProductDetails.fromJson(map);
  }

  @override
  Future<CreatePaymentOrder> createOrderPayment(
      {required String address,
      required String productId,
      required String quantity}) async {
        var payload = {
      "productId": productId,
      "quantity": quantity,
      "address": address
    };
    final map =
        await Requests().post(AppStrings.createOrderPayment, body: json.encode(payload),);
    return CreatePaymentOrder.fromJson(map);
  }

  @override
  Future<ConfirmShopPayment> confirmShoppingPayment(
      {required String username,
      required String purchaseId,
      required String shopOrderId}) async {
    final map = await Requests().patch(
        AppStrings.confirmShoppingPaymentUrl(
            username: username, shopOrderId: shopOrderId),
        body: {
          "payment_id": purchaseId
        },
        headers: {
          'Authorization': AppStrings.token,
          "Content-type": "application/json"
        });
    return ConfirmShopPayment.fromJson(map);
  }

  @override
  Future<GetProductReviews> getProductReviews(
      {required String productId}) async {
    final map = await Requests()
        .get(AppStrings.getProductReview(productId: productId),);
    return GetProductReviews.fromJson(map);
  }

  @override
  Future<AuthData> sendReviews(
      {required String url,
      required String comment,
      required String rating}) async {
    var payload = {
      "rating": rating,
      "comment": comment,
    };
    final map = await Requests().post(
      AppStrings.publishProductReview(url: url),
      body: json.encode(payload),
    );
    return AuthData.fromJson(map);
  }

  @override
  Future<AgentProfile> getAgentProfile(String agentId) async {
    final map = await Requests().get(
      AppStrings.agentProfile(agentId),
    );
    return AgentProfile.fromJson(map);
  }

  @override
  Future<AuthData> uploadGallery(
      {required String agentId, required String image}) async {
    var payload = {
      "image": image,
    };
    final map = await Requests()
        .post(AppStrings.uploadAgentGallery, body: json.encode(payload));
    return AuthData.fromJson(map);
  }

  @override
  Future<UserShopData> shopOrderData({required String username}) async {
    final map = await Requests()
        .get(AppStrings.getUserOrderedProducts,);
    return UserShopData.fromJson(map);
  }

  @override
  Future<UserProfile> getUserProfile({required String userId}) async {
    final map = await Requests()
        .get(AppStrings.getUserProfile(userId: userId), );
    return UserProfile.fromJson(map);
  }

  @override
  Future<PetProfile> getUserPet({required String username}) async {
    final map = await Requests().get(
      AppStrings.getUserPets,
    );
    return PetProfile.fromJson(map);
  }

  @override
  Future<PetProfileDetails> getUserPetDetails({required String petId}) async {
    final map = await Requests().get(
      AppStrings.getUserPetDetails(petId: petId),
    );
    return PetProfileDetails.fromJson(map);
  }

  @override
  Future<FAQ> getFaq() async {
    final map = await Requests().get(
      AppStrings.getFaq,
    );
    return FAQ.fromJson(map);
  }

  @override
  Future<AuthData> updateNumber({
    required String username,
    required String email,
    required String number,
  }) async {
    final map = await Requests().patch(
      AppStrings.updateNumber(username),
      headers: {
        'Authorization': AppStrings.token,
        "Content-type": "application/json"
      },
      body: {
        "email": email,
        "phone_number": number,
      },
    );
    return AuthData.fromJson(map);
  }

  @override
  Future<PrivacyPolicies> privacy() async {
    final map = await Requests().get(
      AppStrings.privacy,
    );
    return PrivacyPolicies.fromJson(map);
  }

  @override
  Future<AuthData> deleteUser({required String email, required String password}) async {
    final map = await Requests().patch(AppStrings.deleteUser,
    body: {
      'email': email,
      'password': password,
    },
        headers: {
          'Authorization': AppStrings.token,
          "Content-type": "application/json"
        });
    return AuthData.fromJson(map);
  }

  @override
  Future<AuthData> reportAgent(
      {required String username,
      required String description,
      required String title,
      required String agentId}) async {
        var payload = {
      "title": title,
      "description": description,
    };
    final map =
        await Requests().post(AppStrings.reportAgent(username, agentId), body: json.encode(payload), );
    return AuthData.fromJson(map);
  }

  @override
  Future<AuthData> reportBug(
      {required String image,
      required String title,
      required String description}) async {
        var payload = {
      "title": title,
      "description": description,
      "image": image
    };
    final map = await Requests().post(AppStrings.reportBug, body: json.encode(payload),);
    return AuthData.fromJson(map);
  }

  @override
  Future<Notifications> getNotification({required String url}) async {
    final map = await Requests().get(
      url,
    );
    return Notifications.fromJson(map);
  }
}

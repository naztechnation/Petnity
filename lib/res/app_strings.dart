import 'dart:io';

import '../handlers/app_handlers.dart';

class AppStrings {
  static const String appName = 'Lucacify';
  static const String interSans = 'Satoshi-Variable';
  static const String montserrat = 'Satoshi-Variable';
  static const String satoshi = 'Satoshi-Variable';

  ///flutterwave api
  static const String flutterwaveApiKey =
      "FLWPUBK_TEST-e244b020ccc49bcf667b0e3f26dc056b-X";

  ///app tokens

  static const token = 'Token 73adfcf7561bb4f05bd49ef5388761052c7f154a';

  ///base url

  static const String _baseUrl = 'https://api.lucacify.com/';

  static const String _androidKey = 'AIzaSyCGhgIA6avmf0LRLakXaAama2vRnBsyL_Q';
  static const String _iosKey = 'Google Maps API key';
  static final locationApiKey = Platform.isAndroid ? _androidKey : _iosKey;

  static const String networkErrorMessage = "Network error, try again later";
  static const String registerUrl = "auth/register";
  static const String petTypesUrl = "${_baseUrl}get-pet-types";
  static String resendCodeUrl(String username) => "auth/resend-code/$username";

  static String googlePlaceUrl(String query) =>
      'https://maps.googleapis.com/maps/api/place/autocomplete/json'
      '?input=$query&language=en&components=country:ng'
      '&key=$locationApiKey&sessiontoken=${AppHandler.generateUniqueId()}';

  static String otpUrl(String url) => '${_baseUrl}$url';
  static String verifyCodeUr(String username) =>
      '${_baseUrl}auth/resend-code/$username';
  static String getServiceProvidersList(String serviceId) =>
      '${_baseUrl}users/get-service-agents/$serviceId';
  static String verifyUserProfileUrl(String username) =>
      '${_baseUrl}auth/verify-profile/$username';

  static const String loginUrl = '${_baseUrl}auth/login';
  static const String logoutUrl = '${_baseUrl}auth/logout';
  static const String shoppingList = '${_baseUrl}shop/get-products/1';
  static const String getServiceTypes = '${_baseUrl}get-service-types';
  static String getIndividualAgentService(String agentId) =>
      '${_baseUrl}users/get-agent-services/$agentId';
  static const String publishShopProductUrl = '${_baseUrl}shop/create-product';
  static String agentProfile = '${_baseUrl}users/get-agents';

  static String userOrders(String username) =>
      '${_baseUrl}order/get-user-orders/$username';
  static String createOrderPayment(String username) =>
      '${_baseUrl}shop/create-shop-order/$username';
  static String uploadIdUrl(String agentId, String photoId) =>
      '${_baseUrl}auth/upload-id-photo/$agentId';
  static String productDetailsUrl(String productId) =>
      '${_baseUrl}shop/get-product/$productId';
  static String createOrder(String packageId, String username) =>
      '${_baseUrl}order/create-order/$username/$packageId';
  static String getReviewUrl(String userId) =>
      '${_baseUrl}users/get-reviews/$userId';
  static String getGalleryUrl(String userId) =>
      '${_baseUrl}users/get-gallery-elements/$userId';
  static String setServiceAmountUrl(String agentId, String serviceId) =>
      '${_baseUrl}services/create-service/$agentId/$serviceId';
  static String agentOrderUrl(String agentId, String pageIndex) =>
      '${_baseUrl}shop/get-agent-shop-orders/$agentId/$pageIndex';

  static String createPackageUrl(String agentId, String serviceId) =>
      '${_baseUrl}services/create-package/$agentId/$serviceId';

  static String publishPackageUrl(String agentId, String serviceId) =>
      '${_baseUrl}services/publish-service/$agentId/$serviceId';

  static String confirmPaymentUrl(String username, String agentId) =>
      '${_baseUrl}order/order-payment/$username/$agentId';
  static String getAgentPackagesUrl(String agentId, String serviceId) =>
      '${_baseUrl}users/get-agent-service-packages/$agentId/$serviceId';
  static String selectPetTypeUrl(String agentId) =>
      '${_baseUrl}auth/select-pet-types/$agentId';
  static String selectServiceTypeUrl(String agentId) =>
      '${_baseUrl}auth/select-service-types/$agentId';
  static String petHealthStatusUrl({String? petId}) =>
      '${_baseUrl}pets/add-health-issue/$petId';
  static String petAlergeyDataUrl({String? petId = '2'}) =>
      '${_baseUrl}pets/add-allergies/$petId';
  static String petHealthUrl({required url}) => '${_baseUrl + url}';
  static String registerUserPetProfileUrl({required username}) =>
      '${_baseUrl}pets/add-pet/$username';
  static String registerServiceProviderProfileUrl({required username}) =>
      '${_baseUrl}auth/create-agent/$username';

  static String getProductReview({required String productId}) =>
      '${_baseUrl}shop/get-product-reviews/$productId';
  static String updateAccountDetailsUrl({required String agentId}) =>
      '${_baseUrl}users/add-agent-bank-details/$agentId';
  static String getAccountDetailsUrl({required String agentId}) =>
      '${_baseUrl}users/get-agent-bank-details/$agentId';
  static String uploadAgentGallery({required String agentId}) =>
      '${_baseUrl}users/add-gallery-element/$agentId';

  static String publishProductReview({
    required String url,
  }) =>
      '${_baseUrl}$url';

  static String confirmShoppingPaymentUrl(
          {required String username, required String shopOrderId}) =>
      '${_baseUrl}shop/shop-order-payment/$username/$shopOrderId';

  static String getAgentServicesLists({
    required String agentId,
  }) =>
      '${_baseUrl}order/get-agent-orders/$agentId';

  static String agentAcceptOrder(
          {required String agentId, required String orderId}) =>
      '${_baseUrl}order/agent-accept-order/$agentId/$orderId';

  static String agentMarkOngoingOrder(
          {required String agentId, required String orderId}) =>
      '${_baseUrl}order/order-ongoing/$agentId/$orderId';

  static String agentMarkCompletedOrder(
          {required String agentId, required String orderId}) =>
      '${_baseUrl}order/agent-complete-order/$agentId/$orderId';

  static String userMarkDeliveredShopOrder(
          {required String username, required String orderId}) =>
      '${_baseUrl}shop/user-marked-delivered/$username/$orderId';

  static String agentMarkDeliveredShopOrder(
          {required String agentId, required String orderId}) =>
      '${_baseUrl}shop/agent-marked-delivered/$agentId/$orderId';

      static String agentRejectServiceOrder(
          {required String agentId, required String orderId}) =>
      '${_baseUrl}order/agent-reject-order/$agentId/$orderId';

       static String userMarkOrderDelivered(
          {required String username, required String orderId}) =>
      '${_baseUrl}order/user-complete-order/$username/$orderId';
 static String agentMarkOrderDelivered(
          {required String agentId, required String orderId}) =>
      '${_baseUrl}order/user-complete-order/$agentId/$orderId';
  static String getAgentsProducts(
          {required String agentId, }) =>
      '${_baseUrl}shop/get-agent-products/$agentId';

      static String getAgentsBalance(
          {required String agentId, }) =>
      '${_baseUrl}users/get-agent-balance/$agentId';


    

}

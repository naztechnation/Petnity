import 'dart:io';

import '../handlers/app_handlers.dart';

class AppStrings {
  static const String appName = 'Lucacify';
  static const String interSans = 'Satoshi-Variable';
  static const String montserrat = 'Satoshi-Variable';
  static const String satoshi = 'Satoshi-Variable';

  ///flutterwave api
  static const String flutterwaveApiKey =
      "FLWPUBK_TEST-2685ec5e008c45c4eeb28b2401b5b26e-X";

  ///app tokens

  static const token = 'Token 73adfcf7561bb4f05bd49ef5388761052c7f154a';

  ///base url

  static const String _baseUrl = 'https://lucacify.onrender.com/';

  static const String _androidKey = 'AIzaSyCGhgIA6avmf0LRLakXaAama2vRnBsyL_Q';
  static const String _iosKey = 'Google Maps API key';
  static final locationApiKey = Platform.isAndroid ? _androidKey : _iosKey;

  static const String networkErrorMessage = "Network error, try again later";
  static const String registerUrl = "auth/register";
  static const String petTypesUrl = "${_baseUrl}home/get-pet-types";
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
  static String verifyUserProfileUrl =
      '${_baseUrl}auth/verify-user';

  static String resetPasswordUrl(String email) =>
      '${_baseUrl}auth/change-password/$email';

      static String getIdTypeListUrl =
      '${_baseUrl}auth/get-id-types';
  static String forgotPasswordUrl(String email) =>
      '${_baseUrl}auth/request-password-change/$email';

  static const String loginUrl = '${_baseUrl}auth/login';
  static const String logoutUrl = '${_baseUrl}auth/logout';
  static const String shoppingList = '${_baseUrl}shop/get-products/1';
  static const String getServiceTypes = '${_baseUrl}home/get-service-types';
  static String getIndividualAgentService(String agentId) =>
      '${_baseUrl}users/get-agent-services/$agentId';
  static const String publishShopProductUrl = '${_baseUrl}shop/create-product';
  static String agentProfile(String userId) => '${_baseUrl}user/get-user-profile/$userId';

  static String userOrders(String username) =>
      '${_baseUrl}order/get-user-orders/$username';
  static String createOrderPayment(String username) =>
      '${_baseUrl}shop/create-shop-order/$username';
  static String uploadIdUrl =
      '${_baseUrl}auth/upload-id-photo';
  static String productDetailsUrl(String productId) =>
      '${_baseUrl}shop/get-product/$productId';
  static String createOrder(String packageId, String username) =>
      '${_baseUrl}order/create-order/$username/$packageId';
  static String getReviewUrl(String userId) =>
      '${_baseUrl}users/get-reviews/$userId';
  static String getGalleryUrl =
      '${_baseUrl}user/get-gallery-elements';
  static String setServiceAmountUrl = 
      '${_baseUrl}service/create-service';
  static String agentOrderUrl =
      '${_baseUrl}shop/get-agent-shop-orders';

  static String createPackageUrl(String serviceId) =>
      '${_baseUrl}service/create-package/$serviceId';

  static String publishPackageUrl( String serviceId) =>
      '${_baseUrl}service/publish-service/$serviceId';

  static String confirmPaymentUrl(String username, String agentId) =>
      '${_baseUrl}order/order-payment/$username/$agentId';
  static String getAgentPackagesUrl(String agentId, String serviceId) =>
      '${_baseUrl}users/get-agent-service-packages/$agentId/$serviceId';
  static String selectPetTypeUrl  =
      '${_baseUrl}auth/select-pet-types';
  static String selectServiceTypeUrl =
      '${_baseUrl}auth/select-service-types';
  static String petHealthStatusUrl({String? petId}) =>
      '${_baseUrl}pets/add-health-issue/$petId';
  static String petAlergeyDataUrl({String? petId = '2'}) =>
      '${_baseUrl}pets/add-allergies/$petId';
  static String petHealthUrl({required url}) => '${_baseUrl + url}';
  static String registerUserPetProfileUrl =
      '${_baseUrl}pets/add-pet';
  static String registerServiceProviderProfileUrl =
      '${_baseUrl}auth/create-agent';

  static String getProductReview({required String productId}) =>
      '${_baseUrl}shop/get-product-reviews/$productId';
  static String updateAccountDetailsUrl({required String agentId}) =>
      '${_baseUrl}users/add-agent-bank-details/$agentId';
  static String getAccountDetailsUrl({required String agentId}) =>
      '${_baseUrl}users/get-agent-bank-details/$agentId';
  static String uploadAgentGallery =
      '${_baseUrl}user/add-gallery-element';

  static String publishProductReview({
    required String url,
  }) =>
      '${_baseUrl}$url';

  static String confirmShoppingPaymentUrl(
          {required String username, required String shopOrderId}) =>
      '${_baseUrl}shop/shop-order-payment/$username/$shopOrderId';

  static String getAgentServicesLists =
      '${_baseUrl}order/get-agent-orders';

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
  static String getAgentsProducts({
    required String agentId,
  }) =>
      '${_baseUrl}shop/get-agent-products/$agentId';

  static String getAgentsBalance({
    required String agentId,
  }) =>
      '${_baseUrl}user/get-user-wallet-balance';

  static String getUserOrderedProducts({
    required String username,
  }) =>
      '${_baseUrl}shop/get-user-shop-orders/$username';

  static String getUserProfile({
    required String username,
  }) =>
      '${_baseUrl}users/get-profile/$username';

  static String getUserPets({
    required String username,
  }) =>
      '${_baseUrl}pets/get-user-pets/$username';

  static String getUserPetDetails({
    required String petId,
  }) =>
      '${_baseUrl}pets/get-pet-details/$petId';
  static const String getFaq = '${_baseUrl}get-faqs';

  static String updateNumber(String username) =>
      '${_baseUrl}users/change-email-and-phone/$username';

  static String privacy = '${_baseUrl}get-privacy-policy';

  static String deleteUser(String username) =>
      '${_baseUrl}users/delete-user/$username';

  static String reportBug(String username) => '${_baseUrl}report-bug/$username';

  static String reportAgent(String username, String agentId) =>
      '${_baseUrl}report-agent/$username/$agentId';
  static String getUserNotifications =
      '${_baseUrl}user/get-agent-notifications';

  static String createVetService(
    String serviceTypeId,
  ) =>
      '${_baseUrl}service/create-vet-service';

  static String publishVetService( String serviceTypeId) =>
      '${_baseUrl}service/publish-vet-service/$serviceTypeId';

  static String getVetService(
    String agentId,
  ) =>
      '${_baseUrl}users/get-vet-service/$agentId';

  static String createVetOrder(String agentId, String username) =>
      '${_baseUrl}order/create-vet-order/$username/$agentId';
  static String confirmVetPaymentOrder(String orderId, String username) =>
      '${_baseUrl}order/vet-order-payment/$username/$orderId';

  //Agent accept order

  static String agentAcceptVetOrder(
          {required String agentId, required String orderId}) =>
      '${_baseUrl}order/agent-accept-vet-order/$agentId/$orderId';

  static String agentMarkOngoingVetOrder(
          {required String agentId, required String orderId}) =>
      '${_baseUrl}order/vet-order-ongoing/$agentId/$orderId';

  static String agentMarkCompletedVetOrder(
          {required String agentId, required String orderId}) =>
      '${_baseUrl}order/agent-complete-vet-order/$agentId/$orderId';

  static String agentRejectServiceVetOrder(
          {required String agentId, required String orderId}) =>
      '${_baseUrl}order/agent-reject-vet-order/$agentId/$orderId';

  static String userMarkVetOrderDelivered(
          {required String username, required String orderId}) =>
      '${_baseUrl}order/user-complete-vet-order/$username/$orderId';

  static String agentCreateWithdrawal({required String agentId}) =>
      '${_baseUrl}users/create-withdrawal-request/$agentId';

  static String agentWithdrawalHistory({required String agentId}) =>
      '${_baseUrl}users/get-agent-withdrawals';

  static String updatePackagePricing(
          { required String packageId}) =>
      '${_baseUrl}service/update-package-price/$packageId';

      static String updateVetPackagePricing(
          {required String agentId, required String serviceId}) =>
      '${_baseUrl}services/update-vet-service-price/$agentId/$serviceId';
}

import 'dart:io';

import '../handlers/app_handlers.dart';

class AppStrings {
  static const String appName = 'Lucacify';
  static const String interSans = 'Satoshi-Variable';
  static const String montserrat = 'Satoshi-Variable';
  static const String satoshi = 'Satoshi-Variable';

  ///flutterwave api
  static const String flutterwaveApiKey =
      " ";

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
  static String resendCodeUrl = "auth/resend-code";

  static String googlePlaceUrl(String query) =>
      'https://maps.googleapis.com/maps/api/place/autocomplete/json'
      '?input=$query&language=en&components=country:ng'
      '&key=$locationApiKey&sessiontoken=${AppHandler.generateUniqueId()}';

  static String otpUrl(String url) => '${_baseUrl}$url';
  static String verifyCodeUr(String username) =>
      '${_baseUrl}auth/resend-code/$username';
  static String getServiceProvidersList(String serviceId) =>
      '${_baseUrl}user/get-service-agents/$serviceId';
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
  static   String shoppingList(String index) => '${_baseUrl}shop/get-products/$index';
  static const String getServiceTypes = '${_baseUrl}home/get-service-types';
   
      static String getIndividualAgentService(String agentId) =>
      '${_baseUrl}user/get-agent-services/$agentId';
  static const String publishShopProductUrl = '${_baseUrl}shop/create-product';
  static String agentProfile(String userId) => '${_baseUrl}user/get-user-profile/$userId';

  static String userOrders =
      '${_baseUrl}order/get-user-orders';
  static String createOrderPayment =
      '${_baseUrl}shop/create-shop-order';
  static String uploadIdUrl =
      '${_baseUrl}auth/upload-id-photo';
  static String productDetailsUrl(String productId) =>
      '${_baseUrl}shop/get-product/$productId';
  static String createOrder(String packageId,) =>
      '${_baseUrl}order/create-order/$packageId';
  static String getReviewUrl(String agentId) =>
      '${_baseUrl}user/get-reviews/$agentId';
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
  static String getAgentPackagesUrl( String serviceId) =>
      '${_baseUrl}user/get-agent-service-packages/$serviceId';
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
      '${_baseUrl}pet/add-pet';
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
          { required String orderId}) =>
      '${_baseUrl}order/agent-accept-order/$orderId';

  static String agentMarkOngoingOrder(
          { required String orderId}) =>
      '${_baseUrl}order/order-ongoing/$orderId';

  static String agentMarkCompletedOrder(
          { required String orderId}) =>
      '${_baseUrl}order/agent-complete-order/$orderId';

  static String userMarkDeliveredShopOrder(
          { required String orderId}) =>
      '${_baseUrl}shop/user-marked-delivered/$orderId';

  static String agentMarkDeliveredShopOrder(
          { required String orderId}) =>
      '${_baseUrl}shop/agent-marked-delivered/$orderId';

  static String agentRejectServiceOrder(
          { required String orderId}) =>
      '${_baseUrl}order/agent-reject-order/$orderId';
static String productReviewUrl(
          { required String productId}) =>
      '${_baseUrl}shop/review-product/$productId';

static String agentRejectShopOrder(
          { required String orderId}) =>
      '${_baseUrl}order/agent-reject-order/$orderId';

  static String agentAcceptShopOrder(
          { required String orderId}) =>
      '${_baseUrl}shop/agent-accept-shop-order/$orderId';
    

  static String userMarkOrderDelivered(
          {required String orderId}) =>
      '${_baseUrl}order/user-complete-order$orderId';
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

  static String getUserOrderedProducts =
      '${_baseUrl}shop/get-user-shop-orders';

  static String getUserProfile({
    required String userId,
  }) =>
      '${_baseUrl}user/get-user-profile/$userId';

  static String getUserPets =
      '${_baseUrl}pet/get-user-pets';

  static String getUserPetDetails({
    required String petId,
  }) =>
      '${_baseUrl}pet/get-pet-details/$petId';
  static const String getFaq = '${_baseUrl}home/get-faqs';

  static String updateNumber(String username) =>
      '${_baseUrl}users/change-email-and-phone/$username';

  static String privacy = '${_baseUrl}home/get-privacy-policy';

  static String deleteUser(String username) =>
      '${_baseUrl}users/delete-user/$username';

  static String reportBug(String username) => '${_baseUrl}report-bug';

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
      '${_baseUrl}user/get-vet-service/$agentId';

  static String createVetOrder(String agentId,) =>
      '${_baseUrl}order/create-vet-order/$agentId';
  static String confirmVetPaymentOrder(String orderId, String username) =>
      '${_baseUrl}order/vet-order-payment/$username/$orderId';

  //Agent accept order

  static String agentAcceptVetOrder(
          { required String orderId}) =>
      '${_baseUrl}order/agent-accept-vet-order/$orderId';

  static String agentMarkOngoingVetOrder(
          { required String orderId}) =>
      '${_baseUrl}order/vet-order-ongoing/$orderId';

  static String agentMarkCompletedVetOrder(
          { required String orderId}) =>
      '${_baseUrl}order/agent-complete-vet-order/$orderId';

  static String agentRejectServiceVetOrder(
          { required String orderId}) =>
      '${_baseUrl}order/agent-reject-vet-order/$orderId';

  static String userMarkVetOrderDelivered(
          { required String orderId}) =>
      '${_baseUrl}order/user-complete-vet-order/$orderId';

  static String agentCreateWithdrawal({required String agentId}) =>
      '${_baseUrl}users/create-withdrawal-request/$agentId';

  static String agentWithdrawalHistory({required String agentId}) =>
      '${_baseUrl}users/get-agent-withdrawals';

  static String updatePackagePricing(
          { required String packageId}) =>
      '${_baseUrl}service/update-package-price/$packageId';

      static String updateVetPackagePricing(
          { required String serviceId}) =>
      '${_baseUrl}service/update-vet-service-price/$serviceId';

       static String creditWalletUrl =
      '${_baseUrl}user/credit-wallet';
}

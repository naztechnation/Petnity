 
 
import '../../../model/account_models/agents_packages.dart';
import '../../../model/account_models/auth_data.dart';
import '../../../model/account_models/confirm_payment.dart';
import '../../../model/user_models/confirm_shop_payment.dart';
import '../../../model/user_models/create_order.dart';
import '../../../model/user_models/create_payment_order.dart';
import '../../../model/user_models/faq.dart';
import '../../../model/user_models/gallery_data.dart';
import '../../../model/user_models/get_product_reviews.dart';
import '../../../model/user_models/get_services.dart';
import '../../../model/user_models/notifications.dart';
import '../../../model/user_models/order_list.dart'; 
import '../../../model/user_models/pet_profile_details.dart';
import '../../../model/user_models/pets_profile.dart';
import '../../../model/user_models/privacy_policy.dart';
import '../../../model/user_models/products_detail.dart';
import '../../../model/user_models/reviews_data.dart';
import '../../../model/user_models/service_provider_lists.dart';
import '../../../model/user_models/service_type.dart';
import '../../../model/user_models/shopping_lists.dart';
import '../../../model/user_models/user_profile.dart';
import '../../../model/user_models/user_shopping_data.dart';


abstract class UserRepository {
  Future<ServiceProvidersList> getServiceProviderList({
    required String serviceId,
    
    });   


    Future<ServiceProvidersList> getAgentProfile(String userId);   
    Future<GetServiceTypes> getServiceTypes([String? agentId]); 
    Future<ShoppingList> shoppingList({required String index}); 
    Future<ShoppingList> agentShoppingList({required String agentId}); 
    Future<GetReviews> getReviews({required String userId}); 
    Future<GalleryAgents> getGallery({required String userId}); 
    Future<AuthData> uploadGallery({required String agentId, required String image}); 
    Future<UserOrderList> orderList({required String username}); 
    Future<UserShopData> shopOrderData({required String username}); 
    Future<ProductDetails> productDetails({required String productId}); 
    Future<GetProductReviews> getProductReviews({required String productId}); 
    Future<GetAgentsPackages> getAgentPackages({required String agentId, required String serviceId,}); 
    Future<AuthData> sendReviews({required String url,  required String comment, required String rating}); 
    Future<PaymentResponse> confirmPayment({required String username, required String purchaseId, required String orderId}); 
    Future<ConfirmShopPayment> confirmShoppingPayment({required String username, required String purchaseId, required String shopOrderId}); 
    Future<CreatePaymentOrder> createOrderPayment({required String address, required String productId, required String quantity}); 
    Future<ServiceProvidersList> serviceProvided({required List<String> services,required String username,required String agentId});   
    Future<CreateOrder> createOrder({required String packageId,required String fee,required String pickupTime, required String dropOffTime, required String pickUpLocation});
    Future<UserProfile> getUserProfile({required String userId});
    Future<PetProfile> getUserPet({required String username});
    Future<PetProfileDetails> getUserPetDetails({required String petId});
    Future<FAQ> getFaq();
    Future<AuthData> updateNumber({required String username,required String email,required String number,}); 
    Future<PrivacyPolicies> privacy(); 
    Future<AuthData> deleteUser({required String username}); 
    Future<AuthData> reportBug({required String username, required String title, required String description, }); 
    Future<AuthData> reportAgent({required String username, required String description, required String title,required String agentId, }); 
    Future<Notifications> getNotification({required String username, }); 


}
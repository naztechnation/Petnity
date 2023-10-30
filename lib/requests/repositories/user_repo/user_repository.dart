 
 
import '../../../model/account_models/agents_packages.dart';
import '../../../model/account_models/confirm_payment.dart';
import '../../../model/user_models/create_order.dart';
import '../../../model/user_models/create_payment_order.dart';
import '../../../model/user_models/gallery_data.dart';
import '../../../model/user_models/order_list.dart';
import '../../../model/user_models/products_detail.dart';
import '../../../model/user_models/reviews_data.dart';
import '../../../model/user_models/service_provider_lists.dart';
import '../../../model/user_models/service_type.dart';
import '../../../model/user_models/shopping_lists.dart';


abstract class UserRepository {
  Future<ServiceProvidersList> getServiceProviderList({
    required String serviceId,
    
    });   

    Future<GetServiceTypes> getServiceTypes(); 
    Future<ShoppingList> shoppingList(); 
    Future<GetReviews> getReviews({required String userId}); 
    Future<GalleryAgents> getGallery({required String userId}); 
    Future<UserOrderList> orderList({required String username}); 
    Future<ProductDetails> productDetails({required String productId}); 
    Future<GetAgentsPackages> getAgentPackages({required String agentId, required String serviceId,}); 
    Future<PaymentResponse> confirmPayment({required String username, required String purchaseId, required String orderId}); 
    Future<CreatePaymentOrder> createOrderPayment({required String username, required String productId, required String quantity}); 
    Future<ServiceProvidersList> serviceProvided({required List<String> services,required String username,required String agentId});   
    Future<CreateOrder> createOrder({required String packageId,required String username,required String pickupTime, required String dropOffTime, required String pickUpLocation});

}
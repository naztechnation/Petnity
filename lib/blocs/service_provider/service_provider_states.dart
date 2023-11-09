import 'package:equatable/equatable.dart';
import 'package:petnity/model/user_models/shopping_lists.dart';

import '../../model/account_models/agents_packages.dart';
import '../../model/account_models/auth_data.dart';
import '../../model/account_models/confirm_payment.dart';
import '../../model/user_models/confirm_shop_payment.dart';
import '../../model/user_models/create_order.dart';
import '../../model/user_models/create_payment_order.dart';
import '../../model/user_models/gallery_data.dart';
import '../../model/user_models/get_product_reviews.dart';
import '../../model/user_models/order_list.dart';
import '../../model/user_models/products_detail.dart';
import '../../model/user_models/reviews_data.dart';
import '../../model/user_models/service_provider_lists.dart';
import '../../model/user_models/service_type.dart';



abstract class ServiceProviderState extends Equatable {
  const ServiceProviderState();
}

class InitialState extends ServiceProviderState {
  const InitialState();
  @override
  List<Object> get props => [];
}

// class ServiceProviderListLoading extends ServiceProviderState {
//   @override
//   List<Object> get props => [];
// }

// class ServicesLoading extends ServiceProviderState {
//   @override
//   List<Object> get props => [];
// }
 
// class ServicesLoaded extends ServiceProviderState {
//   final GetServiceTypes services;
//   const ServicesLoaded(this.services);
//   @override
//   List<Object> get props => [services];
// }
// class ServiceProviderListLoaded extends ServiceProviderState {
//   final ServiceProvidersList userData;
//   const ServiceProviderListLoaded(this.userData);
//   @override
//   List<Object> get props => [userData];
// }

// class ReviewLoading extends ServiceProviderState {
//   @override
//   List<Object> get props => [];
// }
 
// class ReviewLoaded extends ServiceProviderState {
//   final GetReviews reviews;
//   const ReviewLoaded(this.reviews);
//   @override
//   List<Object> get props => [reviews];
// }
// class GalleryLoading extends ServiceProviderState {
//   @override
//   List<Object> get props => [];
// }
 
// class GalleryLoaded extends ServiceProviderState {
//   final GalleryAgents galleryAgents;
//   const GalleryLoaded(this.galleryAgents);
//   @override
//   List<Object> get props => [galleryAgents];
// }

// class AgentPackagesLoading extends ServiceProviderState {
//   @override
//   List<Object> get props => [];
// }
 
// class AgentPackagesLoaded extends ServiceProviderState {
//   final GetAgentsPackages packages;
//   const AgentPackagesLoaded(this.packages);
//   @override
//   List<Object> get props => [packages];
// }

// class ConfirmPaymentLoading extends ServiceProviderState {
//   @override
//   List<Object> get props => [];
// }
 
// class ConfirmPaymentLoaded extends ServiceProviderState {
//   final PaymentResponse packages;
//   const ConfirmPaymentLoaded(this.packages);
//   @override
//   List<Object> get props => [packages];
// }

class CreateServiceLoading extends ServiceProviderState {
  @override
  List<Object> get props => [];
}
 
class CreateServiceLoaded extends ServiceProviderState {
  final CreateOrder createService;
  const CreateServiceLoaded(this.createService);
  @override
  List<Object> get props => [createService];
}

// class OrderListLoading extends ServiceProviderState {
//   @override
//   List<Object> get props => [];
// }
 
// class OrderListLoaded extends ServiceProviderState {
//   final UserOrderList orderList;
//   const OrderListLoaded(this.orderList);
//   @override
//   List<Object> get props => [orderList];
// }

// class ShoppingListLoading extends ServiceProviderState {
//   @override
//   List<Object> get props => [];
// }
 
// class ShoppingListLoaded extends ServiceProviderState {
//   final ShoppingList shoppingList;
//   const ShoppingListLoaded(this.shoppingList);
//   @override
//   List<Object> get props => [shoppingList];
// }

// class ProductDetailsLoading extends ServiceProviderState {
//   @override
//   List<Object> get props => [];
// }
 
// class ProductDetailsLoaded extends ServiceProviderState {
//   final ProductDetails productDetails;
//   const ProductDetailsLoaded(this.productDetails);
//   @override
//   List<Object> get props => [productDetails];
// }

// class ProductOrderLoading extends ServiceProviderState {
//   @override
//   List<Object> get props => [];
// }
 
// class ProductOrderLoaded extends ServiceProviderState {
//   final CreatePaymentOrder createPaymentOrder;
//   const ProductOrderLoaded(this.createPaymentOrder);
//   @override
//   List<Object> get props => [createPaymentOrder];
// }

// class ConfirmShoppingOrderLoading extends ServiceProviderState {
//   @override
//   List<Object> get props => [];
// }
 
// class ConfirmShoppingOrderLoaded extends ServiceProviderState {
//   final ConfirmShopPayment confirmPaymentOrder;
//   const ConfirmShoppingOrderLoaded(this.confirmPaymentOrder);
//   @override
//   List<Object> get props => [confirmPaymentOrder];
// }

// class GetProductReviewsLoading extends ServiceProviderState {
//   @override
//   List<Object> get props => [];
// }
 
// class GetProductReviewsLoaded extends ServiceProviderState {
//   final GetProductReviews getAgentPayment;
//   const GetProductReviewsLoaded(this.getAgentPayment);
//   @override
//   List<Object> get props => [getAgentPayment];
// }

// class PostProductReviewsLoading extends ServiceProviderState {
//   @override
//   List<Object> get props => [];
// }
 
// class PostProductReviewsLoaded extends ServiceProviderState {
//   final AuthData postReview;
//   const PostProductReviewsLoaded(this.postReview);
//   @override
//   List<Object> get props => [postReview];
// }




// class UserNetworkErr extends ServiceProviderState {
//   final String? message;
//   const UserNetworkErr(this.message);
//   @override
//   List<Object> get props => [message!];
// }

// class UserNetworkErrApiErr extends ServiceProviderState {
//   final String? message;
//   const UserNetworkErrApiErr(this.message);
//   @override
//   List<Object> get props => [message!];
// }

class CreateServiceNetworkErr extends ServiceProviderState {
  final String? message;
  const CreateServiceNetworkErr(this.message);
  @override
  List<Object> get props => [message!];
}

class CreateServiceNetworkErrApiErr extends ServiceProviderState {
  final String? message;
  const CreateServiceNetworkErrApiErr(this.message);
  @override
  List<Object> get props => [message!];
}




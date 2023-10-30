import 'package:equatable/equatable.dart';
import 'package:petnity/model/user_models/shopping_lists.dart';

import '../../model/account_models/agents_packages.dart';
import '../../model/account_models/confirm_payment.dart';
import '../../model/user_models/create_order.dart';
import '../../model/user_models/gallery_data.dart';
import '../../model/user_models/order_list.dart';
import '../../model/user_models/reviews_data.dart';
import '../../model/user_models/service_provider_lists.dart';
import '../../model/user_models/service_type.dart';



abstract class UserStates extends Equatable {
  const UserStates();
}

class InitialState extends UserStates {
  const InitialState();
  @override
  List<Object> get props => [];
}

class ServiceProviderListLoading extends UserStates {
  @override
  List<Object> get props => [];
}

class ServicesLoading extends UserStates {
  @override
  List<Object> get props => [];
}
 
class ServicesLoaded extends UserStates {
  final GetServiceTypes services;
  const ServicesLoaded(this.services);
  @override
  List<Object> get props => [services];
}
class ServiceProviderListLoaded extends UserStates {
  final ServiceProvidersList userData;
  const ServiceProviderListLoaded(this.userData);
  @override
  List<Object> get props => [userData];
}

class ReviewLoading extends UserStates {
  @override
  List<Object> get props => [];
}
 
class ReviewLoaded extends UserStates {
  final GetReviews reviews;
  const ReviewLoaded(this.reviews);
  @override
  List<Object> get props => [reviews];
}
class GalleryLoading extends UserStates {
  @override
  List<Object> get props => [];
}
 
class GalleryLoaded extends UserStates {
  final GalleryAgents galleryAgents;
  const GalleryLoaded(this.galleryAgents);
  @override
  List<Object> get props => [galleryAgents];
}

class AgentPackagesLoading extends UserStates {
  @override
  List<Object> get props => [];
}
 
class AgentPackagesLoaded extends UserStates {
  final GetAgentsPackages packages;
  const AgentPackagesLoaded(this.packages);
  @override
  List<Object> get props => [packages];
}

class ConfirmPaymentLoading extends UserStates {
  @override
  List<Object> get props => [];
}
 
class ConfirmPaymentLoaded extends UserStates {
  final PaymentResponse packages;
  const ConfirmPaymentLoaded(this.packages);
  @override
  List<Object> get props => [packages];
}

class CreateOrderLoading extends UserStates {
  @override
  List<Object> get props => [];
}
 
class CreateOrderLoaded extends UserStates {
  final CreateOrder createOrder;
  const CreateOrderLoaded(this.createOrder);
  @override
  List<Object> get props => [createOrder];
}

class OrderListLoading extends UserStates {
  @override
  List<Object> get props => [];
}
 
class OrderListLoaded extends UserStates {
  final OrderList orderList;
  const OrderListLoaded(this.orderList);
  @override
  List<Object> get props => [orderList];
}

class ShoppingListLoading extends UserStates {
  @override
  List<Object> get props => [];
}
 
class ShoppingListLoaded extends UserStates {
  final ShoppingList shoppingList;
  const ShoppingListLoaded(this.shoppingList);
  @override
  List<Object> get props => [shoppingList];
}


class UserNetworkErr extends UserStates {
  final String? message;
  const UserNetworkErr(this.message);
  @override
  List<Object> get props => [message!];
}

class UserNetworkErrApiErr extends UserStates {
  final String? message;
  const UserNetworkErrApiErr(this.message);
  @override
  List<Object> get props => [message!];
}

class CreateOrderNetworkErr extends UserStates {
  final String? message;
  const CreateOrderNetworkErr(this.message);
  @override
  List<Object> get props => [message!];
}

class CreateOrderNetworkErrApiErr extends UserStates {
  final String? message;
  const CreateOrderNetworkErrApiErr(this.message);
  @override
  List<Object> get props => [message!];
}




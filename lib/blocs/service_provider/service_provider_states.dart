import 'package:equatable/equatable.dart';
import 'package:petnity/model/account_models/auth_data.dart';

import '../../model/service_provider_models/account_details.dart';
import '../../model/service_provider_models/all_agent_orders.dart';
import '../../model/service_provider_models/create_services_amount.dart';
import '../../model/service_provider_models/create_shop_products_model.dart';
import '../../model/user_models/agent_services_lists.dart';
import '../../model/user_models/create_order.dart';

abstract class ServiceProviderState extends Equatable {
  const ServiceProviderState();
}

class InitialState extends ServiceProviderState {
  const InitialState();
  @override
  List<Object> get props => [];
}

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

class CreateServiceAmountLoading extends ServiceProviderState {
  @override
  List<Object> get props => [];
}

class CreateServiceAmountLoaded extends ServiceProviderState {
  final ServiceAmount serviceAmount;
  const CreateServiceAmountLoaded(this.serviceAmount);
  @override
  List<Object> get props => [serviceAmount];
}

class CreateServicePackageLoading extends ServiceProviderState {
  @override
  List<Object> get props => [];
}

class CreateServicePackageLoaded extends ServiceProviderState {
  final AuthData package;
  const CreateServicePackageLoaded(this.package);
  @override
  List<Object> get props => [package];
}

class  PublishPackageLoading extends ServiceProviderState {
  @override
  List<Object> get props => [];
}

class  PublishPackageLoaded extends ServiceProviderState {
  final AuthData package;
  const  PublishPackageLoaded(this.package);
  @override
  List<Object> get props => [package];
}

class  CreateShopProductsLoading extends ServiceProviderState {
  @override
  List<Object> get props => [];
}

class  CreateShopProductsLoaded extends ServiceProviderState {
  final CreateShopProduct createShopProduct;
  const  CreateShopProductsLoaded(this.createShopProduct);
  @override
  List<Object> get props => [createShopProduct];
}

class  AgentOrdersLoading extends ServiceProviderState {
  @override
  List<Object> get props => [];
}

class  AgentOrdersLoaded extends ServiceProviderState {
  final AgentsOrderRequests agentsOrderRequests;
  const  AgentOrdersLoaded(this.agentsOrderRequests);
  @override
  List<Object> get props => [agentsOrderRequests];
}

class  UpdateAccountDetailsLoading extends ServiceProviderState {
  @override
  List<Object> get props => [];
}

class  UpdateAccountDetailsLoaded extends ServiceProviderState {
  final AuthData account;
  const  UpdateAccountDetailsLoaded(this.account);
  @override
  List<Object> get props => [account];
}

class   AccountDetailsLoading extends ServiceProviderState {
  @override
  List<Object> get props => [];
}

class  AccountDetailsLoaded extends ServiceProviderState {
  final AccountDetailsList account;
  const  AccountDetailsLoaded(this.account);
  @override
  List<Object> get props => [account];
}

class   AgentServicesListLoading extends ServiceProviderState {
  @override
  List<Object> get props => [];
}

class  AgentServicesListLoaded extends ServiceProviderState {
  final AgentServicesList services;
  const  AgentServicesListLoaded(this.services);
  @override
  List<Object> get props => [services];
}

class  AcceptOrderLoaded extends ServiceProviderState {
  final AuthData order;
  const  AcceptOrderLoaded(this.order);
  @override
  List<Object> get props => [order];
}

class   AcceptOrderLoading extends ServiceProviderState {
  @override
  List<Object> get props => [];
}

class  AcceptOngoingOrderLoaded extends ServiceProviderState {
  final AuthData order;
  const  AcceptOngoingOrderLoaded(this.order);
  @override
  List<Object> get props => [order];
}

 class   AcceptShopOrderLoading extends ServiceProviderState {
  @override
  List<Object> get props => [];
}

class  DeliveredShopOrderLoaded extends ServiceProviderState {
  final AuthData order;
  const  DeliveredShopOrderLoaded(this.order);
  @override
  List<Object> get props => [order];
}

class  AcceptCompletedOrderLoaded extends ServiceProviderState {
  final AuthData order;
  const  AcceptCompletedOrderLoaded(this.order);
  @override
  List<Object> get props => [order];
}

 

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

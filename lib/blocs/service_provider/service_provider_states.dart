import 'package:equatable/equatable.dart';
import 'package:petnity/model/account_models/auth_data.dart';
import 'package:petnity/model/user_models/credit_wallet.dart';

import '../../model/account_models/add_bank.dart';
import '../../model/service_provider_models/account_details.dart';
import '../../model/service_provider_models/all_agent_orders.dart';
import '../../model/service_provider_models/create_services_amount.dart';
import '../../model/service_provider_models/create_shop_products_model.dart';
import '../../model/service_provider_models/create_vet_services.dart';
import '../../model/service_provider_models/get_vet_services.dart';
import '../../model/service_provider_models/get_agent_balance.dart';
import '../../model/service_provider_models/vetservices_model.dart';
import '../../model/user/transactions/transactions_list.dart';
import '../../model/user_models/agent_services_lists.dart';
import '../../model/user_models/create_order.dart';
import '../../model/user_models/medium_types.dart';
import '../../model/user_models/session_types.dart';
import '../../model/user_models/vet_service.dart';
import '../../model/user_models/withdrawal_history.dart';
import '../../model/withdrawal/withdrawal.dart';

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
  final AddBank account;
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

 class   RejectOrderLoading extends ServiceProviderState {
  @override
  List<Object> get props => [];
}

class  RejectOrderLoaded extends ServiceProviderState {
  final AuthData order;
  const  RejectOrderLoaded(this.order);
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
class  AgentDeliveredShopOrderLoaded extends ServiceProviderState {
  final AuthData order;
  const  AgentDeliveredShopOrderLoaded(this.order);
  @override
  List<Object> get props => [order];
}

class  UserAcceptOrderDeliveredOrderLoaded extends ServiceProviderState {
  final AuthData order;
  const  UserAcceptOrderDeliveredOrderLoaded(this.order);
  @override
  List<Object> get props => [order];
}

class  AcceptCompletedOrderLoaded extends ServiceProviderState {
  final AuthData order;
  const  AcceptCompletedOrderLoaded(this.order);
  @override
  List<Object> get props => [order];
}

  class   AgentBalanceLoading extends ServiceProviderState {
  @override
  List<Object> get props => [];
}

class  AgentBalanceLoaded extends ServiceProviderState {
  final AgentBalance balance;
  const  AgentBalanceLoaded(this.balance);
  @override
  List<Object> get props => [balance];
}

  class   CreateServicesLoading extends ServiceProviderState {
  @override
  List<Object> get props => [];
}

class  CreateServicesLoaded extends ServiceProviderState {
  final CreateVetServices data;
  const  CreateServicesLoaded(this.data);
  @override
  List<Object> get props => [data];
}

  class   PublishServicesLoading extends ServiceProviderState {
  @override
  List<Object> get props => [];
}

class  PublishServicesLoaded extends ServiceProviderState {
  final AuthData data;
  const  PublishServicesLoaded(this.data);
  @override
  List<Object> get props => [data];
}

  class   VetsServicesLoading extends ServiceProviderState {
  @override
  List<Object> get props => [];
}

class  VetsServicesLoaded extends ServiceProviderState {
  final VetServices  vetService;
  const  VetsServicesLoaded(this.vetService);
  @override
  List<Object> get props => [vetService];
}

class   VetsServicesOrderLoading extends ServiceProviderState {
  @override
  List<Object> get props => [];
}

class  VetsServicesOrderLoaded extends ServiceProviderState {
  final CreateVetOrder  vetService;
  const  VetsServicesOrderLoaded(this.vetService);
  @override
  List<Object> get props => [vetService];
}

class   VetsConfirmOrderLoading extends ServiceProviderState {
  @override
  List<Object> get props => [];
}

class  VetsConfirmOrderLoaded extends ServiceProviderState {
  final CreateVetOrder  vetService;
  const  VetsConfirmOrderLoaded(this.vetService);
  @override
  List<Object> get props => [vetService];
}

class   VetsCreateWithdrawalRequestLoading extends ServiceProviderState {
  @override
  List<Object> get props => [];
}

class  VetsCreateWithdrawalRequestLoaded extends ServiceProviderState {
  final CreateWithrawal  requests;
  const  VetsCreateWithdrawalRequestLoaded(this.requests);
  @override
  List<Object> get props => [requests];
}

class   AgentWithdrawalHistoryLoading extends ServiceProviderState {
  @override
  List<Object> get props => [];
}

class  AgentWithdrawalHistoryLoaded extends ServiceProviderState {
  final WithrawalHistory  requests;
  const  AgentWithdrawalHistoryLoaded(this.requests);
  @override
  List<Object> get props => [requests];
}

class  UserWithdrawalHistoryLoaded extends ServiceProviderState {
  final UserTransactionList  requests;
  const  UserWithdrawalHistoryLoaded(this.requests);
  @override
  List<Object> get props => [requests];
}

class  EditPackageLoaded extends ServiceProviderState {
  final AuthData data;
  const  EditPackageLoaded(this.data);
  @override
  List<Object> get props => [data];
}

  class   EditPackageLoading extends ServiceProviderState {
  @override
  List<Object> get props => [];
}

class  CreditWalletLoaded extends ServiceProviderState {
  final CreditedWallet data;
  const  CreditWalletLoaded(this.data);
  @override
  List<Object> get props => [data];
}

  class   CreditWalletLoading extends ServiceProviderState {
  @override
  List<Object> get props => [];
}

class  SessionTypeLoaded extends ServiceProviderState {
  final VetsSessionTypes data;
  const  SessionTypeLoaded(this.data);
  @override
  List<Object> get props => [data];
}

  class   SessionTypeLoading extends ServiceProviderState {
  @override
  List<Object> get props => [];
}

class  MediumTypeLoaded extends ServiceProviderState {
  final VetMediumTypes data;
  const  MediumTypeLoaded(this.data);
  @override
  List<Object> get props => [data];
}

  class   MediumTypeLoading extends ServiceProviderState {
  @override
  List<Object> get props => [];
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

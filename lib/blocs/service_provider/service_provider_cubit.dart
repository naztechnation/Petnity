import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petnity/requests/repositories/service_provider_repo/service_provider_repository.dart';

import '../../model/view_models/service_provider_inapp.dart';
import '../../utils/exceptions.dart';
import 'service_provider_states.dart';

class ServiceProviderCubit extends Cubit<ServiceProviderState> {
  ServiceProviderCubit(
      {required this.serviceProviderRepository, required this.viewModel})
      : super(const InitialState());
  final ServiceProviderRepository serviceProviderRepository;
  final ServiceProviderInAppViewModel viewModel;

  Future<void> setServiceAmount({
    required String serviceId,
    required String agentId,
    required String levelAmount,
  }) async {
    try {
      emit(CreateServiceAmountLoading());

      final services = await serviceProviderRepository.createServiceAmount(
        servicesId: serviceId,
        agentId: agentId,
        levelAmount: levelAmount,
      );

      // await viewModel.setAgentDetails(agents: agents.agents ?? []);

      emit(CreateServiceAmountLoaded(services));
    } on ApiException catch (e) {
      emit(CreateServiceNetworkErrApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(CreateServiceNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

  Future<void> setServicePackage(
      {required String agentId,
      required String servicesId,
      required String levelAmount,
      required String name,
      required String description,
      required String duration,
      required String pricing}) async {
    try {
      emit(CreateServicePackageLoading());

      final services = await serviceProviderRepository.createServicePackage(
        servicesId: servicesId,
        agentId: agentId,
        levelAmount: levelAmount,
        name: name,
        description: description,
        duration: duration,
        pricing: pricing,
      );

      // await viewModel.setAgentDetails(agents: agents.agents ?? []);

      emit(CreateServicePackageLoaded(services));
    } on ApiException catch (e) {
      emit(CreateServiceNetworkErrApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(CreateServiceNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

  Future<void> publishServicePackage({
    required String agentId,
    required String servicesId,
  }) async {
    try {
      emit(PublishPackageLoading());

      final services = await serviceProviderRepository.publishPackage(
        servicesId: servicesId,
        agentId: agentId,
      );

      emit(PublishPackageLoaded(services));
    } on ApiException catch (e) {
      emit(CreateServiceNetworkErrApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(CreateServiceNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

  Future<void> createShoppingProduct({
    required String agentId,
    required String name,
    required String pricing,
    required String image,
    required String description,
  }) async {
    try {
      emit(CreateShopProductsLoading());

      final services = await serviceProviderRepository.createShopProduct(
        agentId: agentId,
        name: name,
        pricing: pricing,
        image: image,
        description: description,
      );

      emit(CreateShopProductsLoaded(services));
    } on ApiException catch (e) {
      emit(CreateServiceNetworkErrApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(CreateServiceNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

  Future<void> getAllAgentOrder({
    required String agentId,
    required String pageIndex,
  }) async {
    try {
      emit(AgentOrdersLoading());

      final services = await serviceProviderRepository.agentOrders(
        agentId: agentId,
        page: pageIndex,
      );

      viewModel.setAgentOrdersList(services);
      emit(AgentOrdersLoaded(services));
    } on ApiException catch (e) {
      emit(CreateServiceNetworkErrApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(CreateServiceNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

  Future<void> updateAccount(
      {required String agentId,
      required String bankName,
      required String accountName,
      required String accountNumber}) async {
    try {
      emit(UpdateAccountDetailsLoading());

      final account = await serviceProviderRepository.updateAccountDetails(
        agentId: agentId,
        accountName: accountName,
        accountNumber: accountNumber,
        bankName: bankName,
      );

      emit(UpdateAccountDetailsLoaded(account));
    } on ApiException catch (e) {
      emit(CreateServiceNetworkErrApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(CreateServiceNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

  Future<void> getAccount({
    required String agentId,
  }) async {
    try {
      emit(AccountDetailsLoading());

      final account = await serviceProviderRepository.accountDetails(
        agentId: agentId,
      );

      emit(AccountDetailsLoaded(account));
    } on ApiException catch (e) {
      emit(CreateServiceNetworkErrApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(CreateServiceNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

  Future<void> getAgentsAvailableServices({
    required String agentId,
  }) async {
    try {
      emit(AgentServicesListLoading());

      final services = await serviceProviderRepository.getAgentServicesList(
        agentId: agentId,
      );

      viewModel.setAgentServicesList(services);

      emit(AgentServicesListLoaded(services));
    } on ApiException catch (e) {
      emit(CreateServiceNetworkErrApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(CreateServiceNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

  Future<void> acceptAgentOrder({
    required String agentId,
    required String orderId,
  }) async {
    try {
      emit(AcceptOrderLoading());

      final services = await serviceProviderRepository.acceptAgentOrder(
        agentId: agentId,
        orderId: orderId,
      );

      emit(AcceptOrderLoaded(services));
    } on ApiException catch (e) {
      emit(CreateServiceNetworkErrApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(CreateServiceNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

  Future<void> markOngoingAgentOrder({
    required String agentId,
    required String orderId,
  }) async {
    try {
      emit(AgentOrdersLoading());

      final services = await serviceProviderRepository.acceptOngoingOrder(
        agentId: agentId,
        orderId: orderId,
      );

      
      emit(AcceptOngoingOrderLoaded(services));
    } on ApiException catch (e) {
      emit(CreateServiceNetworkErrApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(CreateServiceNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

   Future<void> markCompleteAgentOrder({
    required String agentId,
    required String orderId,
  }) async {
    try {
      emit(AgentOrdersLoading());

      final services = await serviceProviderRepository.acceptCompleteOrder(
        agentId: agentId,
        orderId: orderId,
      );

      
      emit(AcceptCompletedOrderLoaded(services));
    } on ApiException catch (e) {
      emit(CreateServiceNetworkErrApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(CreateServiceNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

  
   Future<void> agentDeliveredOrder({
    required String agentId,
    required String orderId,
  }) async {
    try {
      emit(AcceptShopOrderLoading());

      final services = await serviceProviderRepository.agentAcceptDeliveredShopOrder(
        agentId: agentId,
        orderId: orderId,
      );

      
      emit(AgentDeliveredShopOrderLoaded(services));
    } on ApiException catch (e) {
      emit(CreateServiceNetworkErrApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(CreateServiceNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

     Future<void> agentAcceptDeliveredServiceOrder({
    required String agentId,
    required String orderId,
  }) async {
    try {
      emit(AcceptShopOrderLoading());

      final services = await serviceProviderRepository.agentAcceptDeliveredShopOrder(
        agentId: agentId,
        orderId: orderId,
      );

      
      emit(DeliveredShopOrderLoaded(services));
    } on ApiException catch (e) {
      emit(CreateServiceNetworkErrApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(CreateServiceNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

 Future<void> userDeliveredOrder({
    required String username,
    required String orderId,
  }) async {
    try {
      emit(AcceptShopOrderLoading());

      final services = await serviceProviderRepository.userAcceptDeliveredShopOrder(
        username: username,
        orderId: orderId,
      );

      
      emit(DeliveredShopOrderLoaded(services));
    } on ApiException catch (e) {
      emit(CreateServiceNetworkErrApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(CreateServiceNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

  Future<void> rejectUserOrder({
    required String agentId,
    required String orderId,
  }) async {
    try {
      emit(RejectOrderLoading());

      final services = await serviceProviderRepository.agentRejectServiceOrder(
        agentId: agentId,
        orderId: orderId,
      );

      
      emit(RejectOrderLoaded(services));
    } on ApiException catch (e) {
      emit(CreateServiceNetworkErrApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(CreateServiceNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

   Future<void> userAcknowledgeOrderDelivered({
    required String username,
    required String orderId,
  }) async {
    try {
      emit(AcceptShopOrderLoading());

      final services = await serviceProviderRepository.userAcceptOrderDelivered(
        username: username,
        orderId: orderId,
      );

      
      emit(UserAcceptOrderDeliveredOrderLoaded(services));
    } on ApiException catch (e) {
      emit(CreateServiceNetworkErrApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(CreateServiceNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

  Future<void> getAgentBalance({
    required String agentId,
  }) async {
    try {
      emit(AgentBalanceLoading());

      final services = await serviceProviderRepository.agentBalance(
        agentId: agentId,
      );

      
      emit(AgentBalanceLoaded(services));
    } on ApiException catch (e) {
      emit(CreateServiceNetworkErrApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(CreateServiceNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }
}

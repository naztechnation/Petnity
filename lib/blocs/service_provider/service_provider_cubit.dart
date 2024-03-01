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
    required String quantity,
    required String name,
    required String pricing,
    required List<String> image,
    required String description,
  }) async {
    try {
      emit(CreateShopProductsLoading());

      final services = await serviceProviderRepository.createShopProduct(
        quantity: quantity,
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
      {required String bankCode,
      required String bankName,
      required String accountName,
      required String accountNumber}) async {
    try {
      emit(UpdateAccountDetailsLoading());

      final account = await serviceProviderRepository.updateAccountDetails(
        bankCode: bankCode,
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

      final services =
          await serviceProviderRepository.agentAcceptDeliveredShopOrder(
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

      final services =
          await serviceProviderRepository.agentAcceptDeliveredShopOrder(
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

      final services =
          await serviceProviderRepository.userAcceptDeliveredShopOrder(
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
    required String url,
  }) async {
    try {
      emit(AgentBalanceLoading());

      final services = await serviceProviderRepository.agentBalance(
        url: url,
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

  Future<void> createAgentServices({
    required String agentId,
    required String serviceId,
    required int amount,
    required List<String> contactMedium,
    required List<String> sessionType,
  }) async {
    try {
      emit(CreateServicesLoading());

      final services = await serviceProviderRepository.createVetServices(
        agentId: agentId,
        serviceId: serviceId,
        sessionType: sessionType,
        contactMedium: contactMedium,
        amount: amount,
      );

      emit(CreateServicesLoaded(services));
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

  Future<void> publishAgentServices({
    required String agentId,
    required String serviceId,
  }) async {
    try {
      emit(PublishServicesLoading());

      final services = await serviceProviderRepository.publishVetServices(
        agentId: agentId,
        serviceId: serviceId,
      );

      emit(PublishServicesLoaded(services));
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

  Future<void> vetServices({
    required String agentId,
  }) async {
    try {
      emit(VetsServicesLoading());

      final services = await serviceProviderRepository.vetServices(
        agentId: agentId,
      );

      emit(VetsServicesLoaded(services));
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

  Future<void> vetServicesOrder(
      {required String agentId,
      required String fee,
      required String vetService,
      required String sessionTime}) async {
    try {
      emit(VetsServicesOrderLoading());

      final services = await serviceProviderRepository.createVetOrder(
        agentId: agentId,
        fee: fee,
        vetService: vetService,
        sessionTime: sessionTime,
      );

      emit(VetsServicesOrderLoaded(services));
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

  Future<void> verifyVetOrder(
      {required String orderId,
      required String username,
      required String vetServiceId,
      required String purchaseId}) async {
    try {
      emit(VetsConfirmOrderLoading());

      final services = await serviceProviderRepository.confirmVetPaymentOrder(
        username: username,
        orderId: orderId,
        vetServiceId: vetServiceId,
        purchaseId: purchaseId,
      );

      emit(VetsConfirmOrderLoaded(services));
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

  Future<void> rejectUserVetOrder({
    required String agentId,
    required String orderId,
  }) async {
    try {
      emit(RejectOrderLoading());

      final services =
          await serviceProviderRepository.agentRejectServiceVetOrder(
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

  Future<void> userAcknowledgeVetOrderDelivered({
    required String username,
    required String orderId,
  }) async {
    try {
      emit(AcceptShopOrderLoading());

      final services =
          await serviceProviderRepository.userAcceptVetOrderDelivered(
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

  Future<void> acceptAgentVetOrder({
    required String agentId,
    required String orderId,
  }) async {
    try {
      emit(AcceptOrderLoading());

      final services = await serviceProviderRepository.acceptAgentVetOrder(
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

  Future<void> markOngoingAgentVetOrder({
    required String agentId,
    required String orderId,
  }) async {
    try {
      emit(AgentOrdersLoading());

      final services = await serviceProviderRepository.acceptOngoingVetOrder(
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

  Future<void> markCompleteAgentVetOrder({
    required String agentId,
    required String orderId,
  }) async {
    try {
      emit(AgentOrdersLoading());

      final services = await serviceProviderRepository.acceptCompleteVetOrder(
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

  Future<void> vetsCreateWithdrawalRequest({
    required String amount,
  }) async {
    try {
      emit(VetsCreateWithdrawalRequestLoading());

      final requests = await serviceProviderRepository.agentCreateWithdrawal(
        amount: amount,
      );

      emit(VetsCreateWithdrawalRequestLoaded(requests));
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

  Future<void> agentWithdrawalHistory({
    required String agentId,
  }) async {
    try {
      emit(AgentWithdrawalHistoryLoading());

      final requests = await serviceProviderRepository.agentWithdrawalHistory(
        agentId: agentId,
      );

      emit(AgentWithdrawalHistoryLoaded(requests));
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

  Future<void> userWithdrawalHistory() async {
    try {
      emit(AgentWithdrawalHistoryLoading());

      final requests = await serviceProviderRepository.userWithdrawalHistory(
      );

      emit(UserWithdrawalHistoryLoaded(requests));
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

  Future<void> editPackage(
      {required String agentId,
      required String price,
      required String packageId}) async {
    try {
      emit(EditPackageLoading());

      final edit = await serviceProviderRepository.editPackagePricing(
        agentId: agentId,
        packageId: packageId,
        price: price,
      );

      emit(EditPackageLoaded(edit));
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

  Future<void> editVetPackage(
      {required String agentId,
      required String price,
      required String serviceId}) async {
    try {
      emit(EditPackageLoading());

      final edit = await serviceProviderRepository.editVetPackagePricing(
        agentId: agentId,
        serviceId: serviceId,
        price: price,
      );

      emit(EditPackageLoaded(edit));
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

  Future<void> creditWallet({
    required String txId,
  }) async {
    try {
      emit(CreditWalletLoading());

      final txid = await serviceProviderRepository.creditWallet(
        txId: txId,
      );

      emit(CreditWalletLoaded(txid));
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

  Future<void> getSessionType() async {
    try {
      emit(SessionTypeLoading());

      final type = await serviceProviderRepository.getSessionTypes(
         
      );

      emit(SessionTypeLoaded(type));
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

  Future<void> getMediumType() async {
    try {
      emit(MediumTypeLoading());

      final type = await serviceProviderRepository.getMediumTypes(
      );

      emit(MediumTypeLoaded(type));
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

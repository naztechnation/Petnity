import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petnity/requests/repositories/service_provider_repo/service_provider_repository.dart';

import '../../model/view_models/service_provider_inapp.dart';
import '../../utils/exceptions.dart';
import 'service_provider_states.dart';

class ServiceProviderCubit extends Cubit<ServiceProviderState> {
  ServiceProviderCubit({required this.serviceProviderRepository, required this.viewModel})
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
        servicesId: serviceId, agentId:agentId,levelAmount:levelAmount,
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

  Future<void> setServicePackage({
    required String agentId,required String servicesId,
    required String levelAmount,required String name,
    required String description, required String duration,required String pricing
  }) async {
    try {
      emit(CreateServicePackageLoading());

      final services = await serviceProviderRepository.createServicePackage(
        servicesId: servicesId, agentId:agentId,levelAmount:levelAmount, 
        name: name, description: description, duration: duration, pricing: pricing,
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
    required String agentId,required String servicesId,
    
  }) async {
    try {
      emit(PublishPackageLoading());

      final services = await serviceProviderRepository.publishPackage(
        servicesId: servicesId, agentId:agentId,
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
    required String agentId,required String name,
    required String pricing,required String image,required String description,
  }) async {
    try {
      emit(CreateShopProductsLoading());

      final services = await serviceProviderRepository.createShopProduct(
          agentId:agentId, name: name, pricing: pricing, image: image, description: description,
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
    required String agentId,required String pageIndex,
     
  }) async {
    try {
      emit(AgentOrdersLoading());

      final services = await serviceProviderRepository.agentOrders(
          agentId:agentId, page: pageIndex,  
      );

      viewModel.setAgentOrdersList(services.shopOrders ?? []);
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
}
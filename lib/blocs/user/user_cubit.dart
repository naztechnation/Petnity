
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/view_models/user_view_model.dart';
import '../../requests/repositories/user_repo/user_repository.dart';
import '../../utils/exceptions.dart';
import 'user_states.dart';

class UserCubit extends Cubit<UserStates> {


  UserCubit({required this.userRepository, required this.viewModel})
      : super(const InitialState());
  final UserRepository userRepository;
  final UserViewModel viewModel;

  Future<void> getServiceProviderList({
    required String serviceId,
    
  }) async {
    try {
      emit(ServiceProviderListLoading());

      final agents = await userRepository.getServiceProviderList(
        serviceId: serviceId,
       );

       await viewModel.setAgentDetails(agents:agents.agents ?? []);

      emit(ServiceProviderListLoaded(agents));
    } on ApiException catch (e) {
      emit(UserNetworkErrApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(UserNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }
  
  Future<void> getServiceTypes() async {
    try {
      emit(ServiceProviderListLoading());

      final service = await userRepository.getServiceTypes(
       );

       await viewModel.setServicesList(services:service.serviceTypes ?? []);


      emit(ServicesLoaded(service));
    } on ApiException catch (e) {
      emit(UserNetworkErrApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(UserNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

  Future<void> serviceProvided({required List<String> services,required String username, required String agentId}) async {
    try {
      emit(ServiceProviderListLoading());

      final user = await userRepository.serviceProvided(services: services, username: username, agentId: agentId
          );
 
      emit(ServiceProviderListLoaded(user));
    } on ApiException catch (e) {
      emit(UserNetworkErrApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(UserNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

    Future<void> getReviews({ required String userId}) async {
    try {
      emit(ReviewLoading());

      final reviews = await userRepository.getReviews(
         userId: userId
          );
       await viewModel.setReviews(reviews:reviews);
 
      emit(ReviewLoaded(reviews));
    } on ApiException catch (e) {
      emit(UserNetworkErrApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(UserNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

    Future<void> getGallery({ required String userId}) async {
    try {
      emit(GalleryLoading());

      final gallery = await userRepository.getGallery(
         userId: userId
          );
       await viewModel.setGallery(gallery:gallery);
 
      emit(GalleryLoaded(gallery));
    } on ApiException catch (e) {
      emit(UserNetworkErrApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(UserNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

  Future<void> getAgentPackages({ required String agentId, required String serviceId}) async {
    try {
      emit(AgentPackagesLoading());

      final packages = await userRepository.getAgentPackages(agentId: agentId, serviceId: serviceId
          
          );
       await viewModel.setAgentPackages(agentPackage:packages);
 
      emit(AgentPackagesLoaded(packages));
    } on ApiException catch (e) {
      emit(UserNetworkErrApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(UserNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

  Future<void> confirmPayment({ required String purchaseId, required String username,  required String orderId}) async {
    try {
      emit(ConfirmPaymentLoading());

      final payment = await userRepository.confirmPayment(purchaseId: purchaseId, username: username, orderId: orderId
          
          );
      
      emit(ConfirmPaymentLoaded(payment));
    } on ApiException catch (e) {
      emit(UserNetworkErrApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(UserNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

    Future<void> createOrder({ required String packageId,required String username,required String pickupTime, required String dropOffTime, required String pickUpLocation}) async {
    try {
      emit(CreateOrderLoading());

      final order = await userRepository.createOrder(packageId: packageId, username: username, pickupTime: pickupTime, dropOffTime: dropOffTime, pickUpLocation: pickUpLocation
          
          );
      
      emit(CreateOrderLoaded(order));
    } on ApiException catch (e) {
      emit(CreateOrderNetworkErrApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(CreateOrderNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }


 Future<void> orderList(
      {required String username,}) async {
    try {
      emit(OrderListLoading());

      final userData=
          await userRepository.orderList(username: username);

      emit(OrderListLoaded(userData));
    } on ApiException catch (e) {
      emit(UserNetworkErrApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(UserNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

   Future<void> shoppingList(
      ) async {
    try {
      emit(ShoppingListLoading());

      final shoppingList=
          await userRepository.shoppingList();

      emit(ShoppingListLoaded(shoppingList)); 
    } on ApiException catch (e) {
      emit(UserNetworkErrApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(UserNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }
}
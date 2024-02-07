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

     
      await viewModel.setAgentDetails(agents: agents.data?.agents ?? []);

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

  Future<void> getAgentProfile(String userId) async {
    try {
      emit(ServiceProviderListLoading());

      final agents = await userRepository.getAgentProfile(userId);
      ///TODO
     /// await viewModel.setAgentDetails(agents: agents.agents ?? []);

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

  Future<void> getServiceTypes([String? agentId]) async {
    try {
      emit(ServiceProviderListLoading());

      final services = await userRepository.getServiceTypes(agentId);

      await viewModel.setServicesList(services: services.data?.serviceTypes);

      emit(ServicesLoaded(services));
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

  Future<void> serviceProvided(
      {required List<String> services,
      required String username,
      required String agentId}) async {
    try {
      emit(ServiceProviderListLoading());

      final user = await userRepository.serviceProvided(
          services: services, username: username, agentId: agentId);

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

  Future<void> getReviews({required String userId}) async {
    try {
      emit(ReviewLoading());

      final reviews = await userRepository.getReviews(userId: userId);
      await viewModel.setReviews(reviews: reviews);

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

  Future<void> getGallery({required String userId}) async {
    try {
      emit(GalleryLoading());

      final gallery = await userRepository.getGallery(userId: userId);
      await viewModel.setGallery(gallery: gallery);

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

  Future<void> getAgentPackages(
      {required String agentId, required String serviceId}) async {
    try {
      emit(AgentPackagesLoading());

      final packages = await userRepository.getAgentPackages(
          agentId: agentId, serviceId: serviceId);
      await viewModel.setAgentPackages(agentPackage: packages);

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

  Future<void> confirmPayment(
      {required String purchaseId,
      required String username,
      required String orderId}) async {
    try {
      emit(ConfirmPaymentLoading());

      final payment = await userRepository.confirmPayment(
          purchaseId: purchaseId, username: username, orderId: orderId);

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

  Future<void> createOrder(
      {required String packageId,
      required String fee,
      required String pickupTime,
      required String dropOffTime,
      required String pickUpLocation}) async {
    try {
      emit(CreateOrderLoading());

      final order = await userRepository.createOrder(
          packageId: packageId,
          fee: fee,
          pickupTime: pickupTime,
          dropOffTime: dropOffTime,
          pickUpLocation: pickUpLocation);

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

  Future<void> orderList({
    required String username,
  }) async {
    try {
      emit(OrderListLoading());

      final userData = await userRepository.orderList(username: username);

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

  Future<void> shoppingList([String index = '0'] ) async {
    try {
      emit(ShoppingListLoading());

      final shoppingList = await userRepository.shoppingList(index: index);

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

  Future<void> agentShoppingList(String agentId) async {
    try {
      emit(ShoppingListLoading());

      final shoppingList =
          await userRepository.agentShoppingList(agentId: agentId);

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

  Future<void> productDetails({required String productId}) async {
    try {
      emit(ProductDetailsLoading());

      final shoppingList =
          await userRepository.productDetails(productId: productId);

      emit(ProductDetailsLoaded(shoppingList));
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

  Future<void> createOrderPayment({
    required String address,
    required String productId,
    required String quantity,
  }) async {
    try {
      emit(ProductOrderLoading());

      final productOrder = await userRepository.createOrderPayment(
        address: address,
        productId: productId,
        quantity: quantity,
      );

      emit(ProductOrderLoaded(productOrder));
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

  Future<void> userOrderList({
    required String username,
  }) async {
    try {
      emit(OrderListLoading());

      final orderList = await userRepository.orderList(
        username: username,
      );

      await viewModel.setOrderList(orders: orderList);

      emit(OrderListLoaded(orderList));
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

  Future<void> confirmShoppingOrderPay({
    required String username,
    required String purchaseId,
    required String shopOrderId,
  }) async {
    try {
      emit(ConfirmShoppingOrderLoading());

      final confirmOrder = await userRepository.confirmShoppingPayment(
        username: username,
        purchaseId: purchaseId,
        shopOrderId: shopOrderId,
      );

      emit(ConfirmShoppingOrderLoaded(confirmOrder));
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

  Future<void> getProductReviews({
    required String productId,
  }) async {
    try {
      emit(GetProductReviewsLoading());

      final getProducts = await userRepository.getProductReviews(
        productId: productId,
      );

      emit(GetProductReviewsLoaded(getProducts));
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

  Future<void> postProductReviews({
    required String url,
    required String rating,
    required String comment,
  }) async {
    try {
      emit(PostProductReviewsLoading());

      final postProducts = await userRepository.sendReviews(
        url: url,
        comment: comment,
        rating: rating,
      );

      emit(PostProductReviewsLoaded(postProducts));
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

  Future<void> uploadGallery(
      {required String agentId, required String image}) async {
    try {
      emit(UploadAgentGalleryLoading());

      final gallery =
          await userRepository.uploadGallery(agentId: agentId, image: image);

      emit(UploadAgentGalleryLoaded(gallery));
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

  Future<void> getUserShoppingList(String username) async {
    try {
      emit(UserShopListLoading());

      final shoppingList =
          await userRepository.shopOrderData(username: username);

      emit(UserShopListLoaded(shoppingList));
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

  Future<void> getUserProfile(String username) async {
    try {
      emit(UserProfileLoading());

      final userProfile =
          await userRepository.getUserProfile(userId: username);

      emit(UserProfileLoaded(userProfile));
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

  Future<void> getPetProfile(String username) async {
    try {
      emit(PetProfileLoading());

      final petProfile = await userRepository.getUserPet(username: username);

       viewModel.setPetPicture(petPicture: petProfile.data?.pets?[0].picture ?? '');

      emit(PetProfileLoaded(petProfile));
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

  Future<void> getPetProfileDetails(String petId) async {
    try {
      emit(PetProfileDetailsLoading());

      final petProfileDetails =
          await userRepository.getUserPetDetails(petId: petId);

      await viewModel.setPetDetails(pet: petProfileDetails);

      emit(PetProfileDetailsLoaded(petProfileDetails));
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

  Future<void> getFaq() async {
    try {
      emit(FaqLoading());

      final faq = await userRepository.getFaq();

      emit(FaqLoaded(faq));
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

  Future<void> updateNumber({required String username, required String email,required String phone,}) async {
    try {
      emit(ChangeNumberLoading());

      final number = await userRepository.updateNumber(username: username, email: email, number: phone);

      emit(ChangeNumberLoaded(number));
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

  Future<void> privacyPolicy() async {
    try {
      emit(PrivacyLoading());

      final privacy = await userRepository.privacy();

      emit(PrivacyLoaded(privacy));
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


  Future<void> deleteUserAccount(String username) async {
    try {
      emit(DeleteUserLoading());

      final user = await userRepository.deleteUser(username: username);

      emit(DeleteUserLoaded(user));
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

    Future<void> reportAgent({required String username,required String title,required String description, required String agentId}) async {
    try {
      emit(ReportAgentLoading());

      final user = await userRepository.reportAgent(username: username, title: title, description: description, agentId: agentId);

      emit(ReportAgentLoaded(user));
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

    Future<void> reportBug({required String username,required String title,required String description}) async {
    try {
      emit(ReportBugLoading());

      final user = await userRepository.reportBug(username: username, title: title, description: description);

      emit(ReportBugLoaded(user));
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

   Future<void> getNotification({required String username,}) async {
    try {
      emit(NotificatonsLoading());

      final notification = await userRepository.getNotification(username: username, );

      emit(NotificatonsLoaded(notification));
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

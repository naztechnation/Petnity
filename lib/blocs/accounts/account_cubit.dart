import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/view_models/user_view_model.dart';
import '../../requests/repositories/account_repository.dart';
import '../../utils/exceptions.dart';
import 'account_states.dart';

class AccountCubit extends Cubit<AccountStates> {


  AccountCubit({required this.accountRepository, required this.viewModel})
      : super(const InitialState());
  final AccountRepository accountRepository;
  final UserViewModel viewModel;

  Future<void> registerUser({
    required String username,
    required String url,
    required String email,
    required String password,
    required String phoneNumber,
  }) async {
    try {
      emit(AccountProcessing());

      final user = await accountRepository.registerUser(
        url: url,
        username: username,
          email: email, password: password, phone: phoneNumber);

       await viewModel.setUserData(username:email);
      emit(AccountLoaded(user));
    } on ApiException catch (e) {
      emit(AccountApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(AccountNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

  Future<void> resendCode({
    required String username,
    
  }) async {
    try {
      emit(AccountProcessing());

      final user = await accountRepository.resendCode(
        username: username,
          );

       await viewModel.setUserData(username:username);
      emit(AccountLoaded(user));
    } on ApiException catch (e) {
      emit(AccountApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(AccountNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

  Future<void> sendPetHealth({
    required String name,
    required String drug,
    required String prescription,
    required String url
  }) async {
    try {
      emit(AccountProcessing());

      final user = await accountRepository.sendPetHealth(
          name: name, drug: drug, prescription: prescription, url: url);

      //  await viewModel.setUserData(username:email);
      emit(AccountLoaded(user));
    } on ApiException catch (e) {
      emit(AccountApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(AccountNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

 
  Future<void> loginUser(
      {required String password, required String username}) async {
    try {
      emit(AccountLoading());

      final userData =
          await accountRepository.loginUser(username: username, password: password);

      // await viewModel.setUser(userData);
      emit(AccountLoaded(userData));
    } on ApiException catch (e) {
      emit(AccountApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(AccountNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }
 

  Future<void> registerUserPetProfile(
   {required String username,required String type,
   required String petname,required String gender,
   required String breed,required String size,
   required String about,required String picture}) async {
    try {
      emit(PetProfileLoading());

      final user = await accountRepository.registerUserPetProfile(
        username: username,
        type: type, petname: petname, size: size, breed: breed,
         gender: gender, picture: picture, about: about
          
      );
     
      emit(PetProfileLoaded(user));
    } on ApiException catch (e) {
      emit(AccountApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(AccountNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

  Future<void> registerServiceProviderProfile(
   { required String username,
    required String dob,required String name,required String gender,
    required String country,required String city,required String about,required String picture}) async {
    try {
      emit(PetProfileLoading());

      final user = await 
      accountRepository.registerServiceProviderProfile(username: username, dob: dob, name: name, gender: gender, country: country, city: city, about: about, picture: picture);
     
      emit(PetProfileLoaded(user));
    } on ApiException catch (e) {
      emit(AccountApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(AccountNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

   Future<void> serviceProvided({required List<String> services,required String username, required String agentId}) async {
    try {
      emit(AccountProcessing());

      final user = await accountRepository.serviceProvided(services: services, username: username, agentId: agentId
          );

      // await viewModel.setUserData(username:email);
      emit(AccountLoaded(user));
    } on ApiException catch (e) {
      emit(AccountApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(AccountNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

  Future<void> servicePetType({required List<String> petnames, required String username,
      required String agentId}) async {
    try {
      emit(PetProfileLoading());

      final user = await accountRepository.servicePetNames(petnames: petnames, agentId: agentId, username: username,
          );

      emit(PetProfileLoaded(user));
    } on ApiException catch (e) {
      emit(AccountApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(AccountNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }
  
  Future<void> verifyOTP(String username, String code) async {
    try {
      emit(AccountProcessing());

      final user = await accountRepository.verifyUser(username: username, code: code);

      // await viewModel.updateUser(user);
      emit(AccountUpdated(user));
    } on ApiException catch (e) {
      emit(AccountApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(AccountNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

  Future<void> uploadPhotoUrl(
      {required String photoId, required String photoUrl}) async {
    try {
      emit(AccountLoading());

      final userData =
          await accountRepository.uploadPhotoUrl(photoId: photoId, photoUrl: photoUrl);

      emit(AccountLoaded(userData));
    } on ApiException catch (e) {
      emit(AccountApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(AccountNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }
}

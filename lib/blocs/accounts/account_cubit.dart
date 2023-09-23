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
    required String email,
    required String password,
    required String phoneNumber,
  }) async {
    try {
      emit(AccountProcessing());

      final user = await accountRepository.registerUser(
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
      {required String password, required String email}) async {
    try {
      emit(AccountLoading());

      final userData =
          await accountRepository.loginUser(email: email, password: password);

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
   {required String username,required String type,required String petname,required String gender,required String breed,required String size,required String about,required File picture}) async {
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
    required String country,required String city,required String about,required File picture}) async {
    try {
      emit(PetProfileLoading());

      final user = await accountRepository.registerServiceProviderProfile(username: username, dob: dob, name: name, gender: gender, country: country, city: city, about: about, picture: picture);
     
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
  // Future<void> verifyOTP(String otp) async {
  //   try {
  //     emit(AccountProcessing());

  //     final user = await accountRepository.verifyOTP(otp);

  //     await viewModel.updateUser(user);
  //     emit(AccountUpdated(user));
  //   } on ApiException catch (e) {
  //     emit(AccountApiErr(e.message));
  //   } catch (e) {
  //     if (e is NetworkException ||
  //         e is BadRequestException ||
  //         e is UnauthorisedException ||
  //         e is FileNotFoundException ||
  //         e is AlreadyRegisteredException) {
  //       emit(AccountNetworkErr(e.toString()));
  //     } else {
  //       rethrow;
  //     }
  //   }
  // }

  // Future<void> resentOTP(String phone) async {
  //   try {
  //     emit(AccountProcessing());

  //     final message = await accountRepository.resendOTP(phone);

  //     emit(OTPResent(message));
  //   } on ApiException catch (e) {
  //     emit(AccountApiErr(e.message));
  //   } catch (e) {
  //     if (e is NetworkException ||
  //         e is BadRequestException ||
  //         e is UnauthorisedException ||
  //         e is FileNotFoundException ||
  //         e is AlreadyRegisteredException) {
  //       emit(AccountNetworkErr(e.toString()));
  //     } else {
  //       rethrow;
  //     }
  //   }
  // }

  // Future<void> createPin({required String pin, required String userId}) async {
  //   try {
  //     emit(AccountProcessing());

  //     final user = await accountRepository.createPin(pin: pin, userId: userId);

  //     await viewModel.setUser(user);
  //     emit(AccountLoaded(user));
  //   } on ApiException catch (e) {
  //     emit(AccountApiErr(e.message));
  //   } catch (e) {
  //     if (e is NetworkException ||
  //         e is BadRequestException ||
  //         e is UnauthorisedException ||
  //         e is FileNotFoundException ||
  //         e is AlreadyRegisteredException) {
  //       emit(AccountNetworkErr(e.toString()));
  //     } else {
  //       rethrow;
  //     }
  //   }
  // }

 

  // Future<void> logoutUser() async {
  //   try {
  //     emit(AccountProcessing());

  //     await viewModel.deleteUser();
  //     emit(const AccountLoggedOut('Logged out successfully'));
  //   } on ApiException catch (e) {
  //     emit(AccountApiErr(e.message));
  //   } catch (e) {
  //     if (e is NetworkException ||
  //         e is BadRequestException ||
  //         e is UnauthorisedException ||
  //         e is FileNotFoundException ||
  //         e is AlreadyRegisteredException) {
  //       emit(AccountNetworkErr(e.toString()));
  //     } else {
  //       rethrow;
  //     }
  //   }
  // }

  // Future<void> updateUser(
  //     {String? firstName,
  //     String? lastName,
  //     String? timezone,
  //     String? location,
  //     String? latitude,
  //     String? longitude,
  //     String? email}) async {
  //   try {
  //     emit(AccountProcessing());

  //     final user = await accountRepository.updateUser(
  //         firstName: firstName,
  //         lastName: lastName,
  //         timezone: timezone,
  //         location: location,
  //         latitude: latitude,
  //         longitude: longitude,
  //         email: email);

  //     await viewModel.updateUser(user);
  //     emit(AccountUpdated(user));
  //   } on ApiException catch (e) {
  //     emit(AccountApiErr(e.message));
  //   } catch (e) {
  //     if (e is NetworkException ||
  //         e is BadRequestException ||
  //         e is UnauthorisedException ||
  //         e is FileNotFoundException ||
  //         e is AlreadyRegisteredException) {
  //       emit(AccountNetworkErr(e.toString()));
  //     } else {
  //       rethrow;
  //     }
  //   }
  // }

  // Future<void> fetchUser() async {
  //   try {
  //     emit(AccountLoading());

  //     final user = await accountRepository.fetchUser();

  //     await viewModel.updateUser(user);
  //     emit(AccountUpdated(user));
  //   } on ApiException catch (e) {
  //     emit(AccountApiErr(e.message));
  //   } catch (e) {
  //     if (e is NetworkException ||
  //         e is BadRequestException ||
  //         e is UnauthorisedException ||
  //         e is FileNotFoundException ||
  //         e is AlreadyRegisteredException) {
  //       emit(AccountNetworkErr(e.toString()));
  //     } else {
  //       rethrow;
  //     }
  //   }
  // }

  // Future<void> changePin(
  //     {required String oldPin, required String newPin}) async {
  //   try {
  //     emit(AccountProcessing());

  //     final message = await accountRepository.changeAccountPin(
  //         oldPin: oldPin, newPin: newPin);

  //     emit(AccountPinChanged(message));
  //   } on ApiException catch (e) {
  //     emit(AccountApiErr(e.message));
  //   } catch (e) {
  //     if (e is NetworkException ||
  //         e is BadRequestException ||
  //         e is UnauthorisedException ||
  //         e is FileNotFoundException ||
  //         e is AlreadyRegisteredException) {
  //       emit(AccountNetworkErr(e.toString()));
  //     } else {
  //       rethrow;
  //     }
  //   }
  // }

  // Future<void> uploadAccountImage(File image) async {
  //   try {
  //     emit(AccountProcessing());

  //     final picture = await accountRepository.uploadAccountImage(image);
  //     final user = viewModel.user!.copyWith(picture: picture);

  //     await viewModel.updateUser(user);
  //     emit(AccountUpdated(user));
  //   } on ApiException catch (e) {
  //     emit(AccountApiErr(e.message));
  //   } catch (e) {
  //     if (e is NetworkException ||
  //         e is BadRequestException ||
  //         e is UnauthorisedException ||
  //         e is FileNotFoundException ||
  //         e is AlreadyRegisteredException) {
  //       emit(AccountNetworkErr(e.toString()));
  //     } else {
  //       rethrow;
  //     }
  //   }
  // }

  // late String firstName,
  //     lastName,
  //     dob,
  //     phoneNumber,
  //     nationality,
  //     idType,
  //     idNumber;
  // late File idFront, idBack;

  // Future<void> setKYCValue(
  //     {String? firstName,
  //     String? lastName,
  //     String? dob,
  //     String? phoneNumber,
  //     String? nationality,
  //     String? idType,
  //     String? idNumber,
  //     File? idFront,
  //     File? idBack}) async {
  //   if (firstName != null) this.firstName = firstName;
  //   if (lastName != null) this.lastName = lastName;
  //   if (dob != null) this.dob = dob;
  //   if (phoneNumber != null) this.phoneNumber = phoneNumber;
  //   if (nationality != null) this.nationality = nationality;
  //   if (idType != null) this.idType = idType;
  //   if (idNumber != null) this.idNumber = idNumber;
  //   if (idFront != null) this.idFront = idFront;
  //   if (idBack != null) this.idBack = idBack;
  // }

  // Future<void> submitKYC(File selfie) async {
  //   try {
  //     emit(AccountProcessing());

  //     final user = await accountRepository.submitKYC(
  //         firstName: firstName,
  //         lastName: lastName,
  //         dob: dob,
  //         phoneNumber: phoneNumber,
  //         nationality: nationality,
  //         idType: idType,
  //         idNumber: idNumber,
  //         idFront: idFront,
  //         idBack: idBack,
  //         selfie: selfie);

  //     await viewModel.updateUser(user);
  //     emit(AccountUpdated(user));
  //   } on ApiException catch (e) {
  //     emit(AccountApiErr(e.message));
  //   } catch (e) {
  //     if (e is NetworkException ||
  //         e is BadRequestException ||
  //         e is UnauthorisedException ||
  //         e is FileNotFoundException ||
  //         e is AlreadyRegisteredException) {
  //       emit(AccountNetworkErr(e.toString()));
  //     } else {
  //       rethrow;
  //     }
  //   }
  // }

  // Future<void> requestPinReset(String verifier) async {
  //   try {
  //     emit(AccountProcessing());

  //     final message = await accountRepository.requestPinReset(verifier);

  //     emit(PinResetOTPSent(message));
  //   } on ApiException catch (e) {
  //     emit(AccountApiErr(e.message));
  //   } catch (e) {
  //     if (e is NetworkException ||
  //         e is BadRequestException ||
  //         e is UnauthorisedException ||
  //         e is FileNotFoundException ||
  //         e is AlreadyRegisteredException) {
  //       emit(AccountNetworkErr(e.toString()));
  //     } else {
  //       rethrow;
  //     }
  //   }
  // }

  // Future<void> verifyPinRecoveryOTP(String otp) async {
  //   try {
  //     emit(AccountProcessing());

  //     final message = await accountRepository.verifyPinRecoveryOTP(otp);

  //     emit(PinResetOTPVerified(message));
  //   } on ApiException catch (e) {
  //     emit(AccountApiErr(e.message));
  //   } catch (e) {
  //     if (e is NetworkException ||
  //         e is BadRequestException ||
  //         e is UnauthorisedException ||
  //         e is FileNotFoundException ||
  //         e is AlreadyRegisteredException) {
  //       emit(AccountNetworkErr(e.toString()));
  //     } else {
  //       rethrow;
  //     }
  //   }
  // }

  // Future<void> resetPin({required String otp, required String newPin}) async {
  //   try {
  //     emit(AccountProcessing());

  //     final message =
  //         await accountRepository.resetPin(otp: otp, newPin: newPin);

  //     emit(PinResetCompleted(message));
  //   } on ApiException catch (e) {
  //     emit(AccountApiErr(e.message));
  //   } catch (e) {
  //     if (e is NetworkException ||
  //         e is BadRequestException ||
  //         e is UnauthorisedException ||
  //         e is FileNotFoundException ||
  //         e is AlreadyRegisteredException) {
  //       emit(AccountNetworkErr(e.toString()));
  //     } else {
  //       rethrow;
  //     }
  //   }
  // }
}

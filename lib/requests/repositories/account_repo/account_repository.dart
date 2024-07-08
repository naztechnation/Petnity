import 'package:petnity/model/account_models/auth_data.dart';
import 'package:petnity/model/user_models/id_types.dart';

import '../../../model/account_models/create_agent.dart';
import '../../../model/account_models/pet_profile.dart';
import '../../../model/account_models/pet_types.dart';

abstract class AccountRepository {
  Future<AuthData> registerUser(
      {required String username,
      required String profileImage,
      required String email,
      required String password,
      required String phone,
      required String url,
      required String deviceId,
      required String firebaseId});
  Future<AuthData> sendPetHealth(
      {required String name,
      required String drug,
      required String prescription,
      required String url});
  Future<AuthData> loginUser({
    required String email,
    required String password,
    required String deviceId,
  });
  Future<AuthData> logoutUser({
    required String username,
    required String password,
  });
  Future<AuthData> resendCode({
    required String email,
  });
  Future<AuthData> verifyUser({
    required String code,
    required String email,
  });
  Future<AuthData> uploadPhotoUrl(
      {required String agentId,
      required String photoUrl,
      required String idType,
      required String id});
  Future<PetProfile> registerUserPetProfile(
      {required String type,
      required String petname,
      required String gender,
      required String breed,
      required String size,
      required String about,
      required String picture});

  Future<CreateAgents> registerServiceProviderProfile(
      {required String username,
      required String dob,
      required String name,
      required String gender,
      required String country,
      required String city,
      required String about,
      required String picture});

  Future<PetTypesModel> petTypeList();

  Future<CreateAgents> servicePetNames(
      {required List<String> petId,
      required String username,
      required String agentId});
  Future<AuthData> forgetPassword({
    required String email,
  });
  Future<AuthData> resetPassword({
    required String token,
    required String password,
    required String email,
  });

  Future<IdTypeList> idTypeList();
}

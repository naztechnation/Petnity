import 'dart:io';

import '../../model/account_models/user_data.dart';
import '../../res/app_strings.dart';
import '../setup/requests.dart';
import 'account_repository.dart';

class AccountRepositoryImpl implements AccountRepository {
  @override
  Future<UserData> registerUser(
      {required String email,
      required String password,
      required String username,
      
      required String url,
      required String phone}) async {
    final map = await Requests().post(AppStrings.otpUrl(url), body: {
      "username": username,
      "email": email,
      "password": password,
      "phone_number": phone,
    });
    return UserData.fromJson(map);
  }

  @override
  Future<UserData> loginUser({
    required String username,
    required String password,
  }) async {
    final map = await Requests().post(AppStrings.loginUrl, body: {
      "username": username,
      "password": password,
    });
    return UserData.fromJson(map);
  }

  @override
  Future<UserData> registerUserPetProfile(
      {required String username,
      required String type,
      required String petname,
      required String gender,
      required String breed,
      required String size,
      required String about,
      required File picture}) async {
    final map = await Requests()
        .post(AppStrings.registerUserPetProfileUrl(username: username), body: {
      "type": type,
      "name": petname,
      "gender": gender,
      "breed": breed,
      "size": size,
      "about": about,
      'picture':
          'https://static.standard.co.uk/s3fs-public/thumbnails/image/2019/03/15/17/pixel-dogsofinstagram-3-15-19.jpg?width=1200&height=1200&fit=crop'
      // 'picture': picture.path
    });
    return UserData.fromJson(map);
  }

  Future<UserData> sendPetHealth(
      {required String name,
      required String drug,
      required String prescription,
      required String url}) async {
    final map = await Requests().post(AppStrings.petHealthUrl(url: url), body: {
      "name": name,
      "drug": drug,
      "prescription": prescription,
    });
    return UserData.fromJson(map);
  }

  @override
  Future<UserData> registerServiceProviderProfile(
      {required String username,
      required String dob,
      required String name,
      required String gender,
      required String country,
      required String city,
      required String about,
      required File picture}) async {
    final map = await Requests().post(
        AppStrings.registerServiceProviderProfileUrl(username: username),
        body: {
          "date_of_birth": dob,
          "name": name,
          "gender": gender,
          "about": about,
          "country": country,
          "city": city,
          'picture':
              'https://static.standard.co.uk/s3fs-public/thumbnails/image/2019/03/15/17/pixel-dogsofinstagram-3-15-19.jpg?width=1200&height=1200&fit=crop'
          // 'picture': picture.path
        });
    return UserData.fromJson(map);
  }

  @override
  Future<UserData> serviceProvided(
      {required List<String> services, required String username}) async {
    final map = await Requests().patch(AppStrings.selectServiceTypeUrl, body: {
      "service_types": services,
    }, headers: {
      'Authorization': AppStrings.token,
    });
    return UserData.fromJson(map);
  }

  @override
  Future<UserData> verifyUser(
      {required String code, required String username}) async {
    final map =
        await Requests().post(AppStrings.verifyUserProfileUrl(username), body: {



        
      "code": code,});
      
       return UserData.fromJson(map);}

  Future<UserData> servicePetNames({required List<String> petnames}) async {
    final map = await Requests().patch(AppStrings.selectPetTypeUrl, body: {
      "pet_types": petnames,
    }, headers: {
      'Authorization': AppStrings.token,
    });
    return UserData.fromJson(map);
  }
}

import 'dart:io';

import 'package:petnity/model/account_models/register.dart';

abstract class AccountRepository {
  Future<UserData> registerUser({required String email,required String password,required String phone});
  Future<UserData> loginUser({required String email,required String password,});
  Future<UserData> registerUserPetProfile({
    required String username,
    required String type,required String petname,required String gender,required String breed,required String size,required String about,required File picture});
}
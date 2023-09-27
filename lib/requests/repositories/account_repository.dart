import 'dart:io';

import 'package:petnity/model/account_models/user_data.dart';

import '../../model/account_models/create_agent.dart';

abstract class AccountRepository {
  Future<UserData> registerUser({
    required String username,
    
    required String email,required String password,required String phone,required String url, });
  Future<UserData> sendPetHealth({required String name,required String drug,required String prescription,required String url});
  Future<UserData> loginUser({required String username,required String password,});
  Future<UserData> resendCode({required String username,});
  Future<UserData> verifyUser({required String code,required String username,});
  Future<CreateAgents> registerUserPetProfile({
    required String username,
    required String type,required String petname,required String gender,required String breed,required String size,required String about,required File picture});


Future<CreateAgents> registerServiceProviderProfile({
    required String username,
    required String dob,required String name,required String gender,
    required String country,required String city,required String about,required File picture});

 Future<UserData> serviceProvided({required List<String> services,required String username,required String agentId});   
 Future<CreateAgents> servicePetNames({required List<String> petnames,});   
}
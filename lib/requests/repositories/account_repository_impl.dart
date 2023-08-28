


import '../../model/account_models/register.dart';
import '../../res/app_strings.dart';
import '../setup/requests.dart';
import 'account_repository.dart';

class AccountRepositoryImpl implements AccountRepository {
  @override
  Future<UserData> registerUser({required String email,required String password,required String phone})  async{
    final map= await Requests().post(AppStrings.registerUrl,
   
        body: {
          "username": email,
          "password": password,
          "phone_number": phone,
         
        });
    return UserData.fromJson(map);
  }
  
   @override
  Future<UserData> loginUser({required String email,required String password,})  async{
    final map= await Requests().post(AppStrings.loginUrl,
    
        body: {
          "username": email,
          "password": password,
         
        });
    return UserData.fromJson(map);
  }
}
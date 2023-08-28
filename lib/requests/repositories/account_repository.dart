import 'package:petnity/model/account_models/register.dart';

abstract class AccountRepository {
  Future<UserData> registerUser({required String email,required String password,required String phone});
  Future<UserData> loginUser({required String email,required String password,});
}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petnity/handlers/secure_handler.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_images.dart';
import 'package:petnity/res/enum.dart';
import 'package:petnity/ui/widgets/back_button.dart';
import 'package:petnity/ui/widgets/button_view.dart';
import 'package:petnity/ui/widgets/image_view.dart';
import 'package:petnity/ui/widgets/text_edit_view.dart';
import 'package:provider/provider.dart';

import '../../blocs/user/user.dart';
import '../../model/view_models/user_view_model.dart';
import '../../requests/repositories/user_repo/user_repository_impl.dart';
import '../../res/app_routes.dart';
import '../../utils/navigator/page_navigator.dart';
import '../../utils/validator.dart';
import '../widgets/loading_page.dart';
import '../widgets/modals.dart';
import 'update_successful_page.dart';

class ChangeNumber extends StatelessWidget {
  const ChangeNumber();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (BuildContext context) => UserCubit(
          userRepository: UserRepositoryImpl(),
          viewModel: Provider.of<UserViewModel>(context, listen: false)),
      child: ChangeNumberScreen(),
    );
  }
}

class ChangeNumberScreen extends StatefulWidget {
  @override
  State<ChangeNumberScreen> createState() => _ChangeNumberScreenState();
}

class _ChangeNumberScreenState extends State<ChangeNumberScreen> {
  final TextEditingController number = TextEditingController();

  String username = "";

  late UserCubit _userCubit;

  getUserName() async {
    _userCubit = context.read<UserCubit>();

    username = await StorageHandler.getUserName();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();


  Future<void> _signOut(BuildContext context) async {
    try {
      await _auth.signOut();
      AppNavigator.pushAndReplaceName(context, name: AppRoutes.signInScreen);
    } catch (e) {
      print("Error signing out: $e");
    }
  }

  @override
  void initState() {
    getUserName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        bottomNavigationBar:
            BlocConsumer<UserCubit, UserStates>(listener: (context, state) {
          if (state is ChangeNumberLoaded) {
            if (state.number.status!) {
              Modals.showToast(state.number.message ?? '',
                  messageType: MessageType.success);
              _signOut(context);
    
              // UpdateSuccessfulScreen(
              //               onPressed: () {
              //                 Navigator.pop(context);
              //               },
              //               successMessage: 'Your number has been updated')
              //         ;
            } else {
              Modals.showToast(state.number.message ?? '');
            }
          } else if (state is UserNetworkErrApiErr) {
            Modals.showToast(state.message ?? '');
          } else if (state is UserNetworkErr) {
            Modals.showToast(state.message ?? '');
          }
        }, builder: (context, state) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            height: 100,
            child: Column(
              children: [
                ButtonView(
                  processing: (state is ChangeNumberLoading),
                  borderRadius: 40,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                    _userCubit.updateNumber(
                        username: username,
                        email: 'agbo.raph111@gmail.com',
                        phone: number.text);
    
                    }
    
                    // showModalBottomSheet(
                    //   isScrollControlled: true,
                    //   context: context,
                    //   builder: (BuildContext context) {
                    //     return ConfirmOTP(
                    //       route:
                    //   },
                    // );
                  },
                  child: Text('Verify'),
                ),
              const SizedBox(height: 0,),
    
              ],
            ),
          );
        }),
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.lightBackground,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.lightBackground,
          leading: backButton(context),
          title: Text(
            'Change Number',
            style:
                TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30,),
              Text('New Number'),
              Form(
                  key: _formKey,
    
                child: Container(
                  padding: EdgeInsets.all(0),
                  margin: EdgeInsets.all(0),
                  decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(20)),
                  child: TextEditView(
                    controller: number,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                          return Validator.validate(value, 'Number');
                        },
                    isDense: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

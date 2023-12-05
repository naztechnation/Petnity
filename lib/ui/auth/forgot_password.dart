 
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../blocs/accounts/account.dart';
import '../../model/view_models/account_view_model.dart';
import '../../requests/repositories/account_repo/account_repository_impl.dart';
import '../../res/app_colors.dart';
import '../../res/app_images.dart';
import '../../res/enum.dart';

import '../../utils/navigator/page_navigator.dart';
import '../../utils/validator.dart';
import '../widgets/button_view.dart';
import '../widgets/image_view.dart';
import '../widgets/modals.dart';
import '../widgets/text_edit_view.dart';
import 'reset_password.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final setToken = Provider.of<AccountViewModel>(context, listen: false);

    return Scaffold(
        body: BlocProvider<AccountCubit>(
      lazy: false,
      create: (_) => AccountCubit(
          accountRepository: AccountRepositoryImpl(),
          viewModel: Provider.of<AccountViewModel>(context, listen: false)),
      child: BlocConsumer<AccountCubit, AccountStates>(
        listener: (context, state) {
          if (state is AccountLoaded) {
            if (state.userData.status == true) {
              Modals.showToast(state.userData.message ?? '',
                  messageType: MessageType.success);
               // setToken.setToken(state.userData.token!);

              AppNavigator.pushAndStackPage(context,
                  page: ResetPasswordScreen(
                    email: _emailController.text.trim(),
                     
                  ));
            } else {
              Modals.showToast(state.userData.message ?? '',
                  messageType: MessageType.success);
            }
          } else if (state is AccountApiErr) {
            if (state.message != null) {
              Modals.showToast(state.message!, messageType: MessageType.error);
            }
          } else if (state is AccountNetworkErr) {
            if (state.message != null) {
              Modals.showToast(state.message!, messageType: MessageType.error);
            }
          }
        },
        builder: (context, state) => SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
                height: MediaQuery.sizeOf(context).height,
                width: MediaQuery.sizeOf(context).width,
                decoration:   BoxDecoration(
                    gradient: LinearGradient(
                  colors: [
                    AppColors.scaffoldColor, Colors.red.shade50
                  ],
                  stops: [0.1, 0.8],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.05,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: ImageView.svg(AppImages.backButton, height: 30,),
                          )),
                    ),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.18,
                    ),
                    const Text(
                      'Forgot Password',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 32,
                      ),
                    ),
                    const SizedBox(height: 31),
                    const Text(
                      'Enter your email address',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 61,
                    ),
                     Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 12),
                      child: TextEditView(
                        controller: _emailController,
                         validator: (value) {
                        return Validator.validate(value, 'Email');
                      },
                      isDense: true,
                      textViewTitle: 'Your Email',
                      hintText: 'Enter your email',
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ImageView.svg(
                          AppImages.personIcon,
                        ),
                      ),
                      fillColor: AppColors.lightPrimary,
                      borderColor: AppColors.lightPrimary,
                    ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      child: ButtonView(
                        color: AppColors.lightSecondary,
                        processing: state is AccountProcessing,
                        borderColor: Colors.white,
                        borderRadius: 30,
                        onPressed: () {
                           forgotPassword(context);
                        
                        },
                        child: const Text(
                          'Continue',
                          style: TextStyle(color: AppColors.lightPrimary),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    )
                  ],
                )),
          ),
        ),
      ),
    ));
  }

  forgotPassword(BuildContext ctx) {
    if (_formKey.currentState!.validate()) {
      ctx.read<AccountCubit>().forgotPassword(
            email: _emailController.text.trim(),
          );
      FocusScope.of(ctx).unfocus();
    }
  }
}

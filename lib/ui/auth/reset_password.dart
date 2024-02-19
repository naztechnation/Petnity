import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petnity/ui/auth/sign_in_screen.dart';

import 'package:provider/provider.dart';

import '../../blocs/accounts/account.dart';
import '../../handlers/secure_handler.dart';
import '../../model/view_models/account_view_model.dart';
import '../../requests/repositories/account_repo/account_repository_impl.dart';
import '../../res/app_colors.dart';
import '../../res/app_images.dart';
import '../../res/app_routes.dart';
import '../../res/enum.dart';
import '../../utils/navigator/page_navigator.dart';
import '../../utils/validator.dart';
import '../widgets/button_view.dart';
import '../widgets/image_view.dart';
import '../widgets/modals.dart';
import '../widgets/text_edit_view.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;

  const ResetPasswordScreen({
    super.key,
    required this.email,
  });

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _pinController = TextEditingController();

  bool isLoading = false;


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
    _emailController.text = widget.email;
    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AccountViewModel>(context, listen: true);

    StorageHandler.saveOnboardState('true');
    return Scaffold(
        body: BlocProvider<AccountCubit>(
      lazy: false,
      create: (_) => AccountCubit(
          accountRepository: AccountRepositoryImpl(),
          viewModel: Provider.of<AccountViewModel>(context, listen: false)),
      child: BlocConsumer<AccountCubit, AccountStates>(
        listener: (context, state) {
          if (state is ResetPasswordLoaded) {
            if (state.userData.status == true) {
              resetFirebasePassword(_emailController.text);

                
            } else {
              Modals.showToast(state.userData.message ?? '',
                  messageType: MessageType.error);
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
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: [AppColors.scaffoldColor, Colors.red.shade50],
                  stops: [0.1, 0.8],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )),
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: ImageView.svg(
                              AppImages.backButton,
                              height: 28,
                            ),
                          )),
                    ),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.1,
                    ),
                    const Text(
                      'Reset Password',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 32,
                      ),
                    ),
                    const SizedBox(height: 31),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: const Text(
                        'Enter the code sent to registered email with your new password.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 61,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 0),
                      child: TextEditView(
                        controller: _emailController,
                        readOnly: true,
                        validator: (value) {
                          return Validator.validateEmail(value, 'Email');
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
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 0),
                      child: TextEditView(
                        controller: _pinController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          return Validator.validate(value, 'Code');
                        },
                        isDense: true,
                        textViewTitle: '',
                        hintText: 'Enter your code',
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ImageView.svg(
                            AppImages.awaitingIcon,
                            height: 20,
                          ),
                        ),
                        fillColor: AppColors.lightPrimary,
                        borderColor: AppColors.lightPrimary,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 0),
                      child: TextEditView(
                        controller: _passwordController,
                        validator: (value) {
                          return Validator.validate(value, 'Password');
                        },
                        isDense: true,
                        textViewTitle: 'Password',
                        hintText: 'Enter new password',
                        obscureText: user.showPasswordStatus,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            user.showPassword();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: user.showPasswordStatus
                                ? Icon(
                                    Icons.visibility_off,
                                    size: 24,
                                  )
                                : Icon(Icons.visibility, size: 24),
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
                        processing: state is ResetPasswordLoading || isLoading,
                        borderColor: Colors.white,
                        borderRadius: 30,
                        onPressed: () {
                          resetPassword(context);
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

  resetPassword(
    BuildContext ctx,
  ) {
    if (_formKey.currentState!.validate()) {
      ctx.read<AccountCubit>().resetPassword(
          token: _pinController.text.trim(),
          password: _passwordController.text.trim(),
          email: _emailController.text.trim());
      FocusScope.of(ctx).unfocus();
    }
  }

  Future<void> resetFirebasePassword(String email) async {
    try {
      setState(() {
        isLoading = true;
      });
      await _auth.sendPasswordResetEmail(email: email);
      setState(() {
        isLoading = false;
      });
      Modals.showDialogModal(context, page: successWidget());
      navigateToNextPage(context);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: SystemUiOverlay.values);
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      Modals.showToast("Error sending password reset email: $e");
    }
  }

  successWidget() {
    return const SizedBox(
      // height: 500,
      child: Padding(
        padding: EdgeInsets.all(14.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 30,
            ),
            ImageView.asset(AppImages.celebIcon),
            SizedBox(
              height: 43,
            ),
            Text(
              'Congratulations.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.lightSecondary,
                fontWeight: FontWeight.w400,
                fontSize: 32,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              'A confirmation link has been sent to your mail please follow the link to confirm the previous password. make sure the password is same with the one you entered here.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ImageView.asset(
              AppImages.loading,
              height: 60,
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  navigateToNextPage(BuildContext context) async {
    Future.delayed(
        const Duration(
          seconds: 25,
        ), () {
          _signOut(context);
      AppNavigator.pushAndReplacePage(context, page: SignInScreen());
    });
  }
}

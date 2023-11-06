import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_images.dart';
import 'package:petnity/ui/widgets/image_view.dart';
import 'package:petnity/utils/validator.dart';
import 'package:provider/provider.dart';

import '../../blocs/accounts/account.dart';
import '../../handlers/secure_handler.dart';
import '../../model/view_models/account_view_model.dart';
import '../../model/view_models/firebase_auth_viewmodel.dart';
import '../../requests/repositories/account_repo/account_repository_impl.dart';
import '../../res/app_routes.dart';
import '../../res/app_strings.dart';
import '../../res/enum.dart';
import '../../utils/navigator/page_navigator.dart';
import '../widgets/button_view.dart';
import '../widgets/custom_text.dart';
import '../widgets/modals.dart';
import '../widgets/text_edit_view.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();

  final _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AccountViewModel>(context, listen: true);
    final firebaseUser =
        Provider.of<FirebaseAuthProvider>(context, listen: true);
    StorageHandler.saveOnboardState('true');

    return Scaffold(
        body: Container(
      height: screenSize(context).height,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [AppColors.scaffoldColor, Colors.red.shade50],
              begin: Alignment.topRight,
              end: Alignment.topLeft)),
      child: Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 25),
        child: BlocProvider<AccountCubit>(
          lazy: false,
          create: (_) => AccountCubit(
              accountRepository: AccountRepositoryImpl(),
              viewModel: Provider.of<AccountViewModel>(context, listen: false)),
          child: BlocConsumer<AccountCubit, AccountStates>(
            listener: (context, state) {
              if (state is AccountLoaded) {
                if (state.userData.status!) {
                  Modals.showToast(state.userData.message!,
                      messageType: MessageType.success);

                  StorageHandler.saveIsLoggedIn('true');
                  StorageHandler.saveUserId(
                      state.userData.profile!.id.toString());
                  StorageHandler.saveUserPassword(_passwordController.text);
                  StorageHandler.saveUserName(_usernameController.text.trim());
                  StorageHandler.saveEmail(
                      state.userData.profile!.user!.email.toString());

                  if (state.userData.profile!.hasPets!) {
                    StorageHandler.saveUserPetState('true');
                  } else {
                    StorageHandler.saveUserPetState('');
                  }

                  if (!state.userData.isAgent!) {
                    StorageHandler.saveIsUserType('user');

                    AppNavigator.pushAndStackNamed(context,
                        name: AppRoutes.landingPage);
                  } else {
                    StorageHandler.saveIsUserType('service_provider');

                    AppNavigator.pushAndReplaceName(context,
                        name: AppRoutes.serviceProviderLandingPage);
                  }

                  // loginUser(
                  //     firebaseUser: firebaseUser,
                  //     context: context,
                  //     message: state.userData.message!,
                  //     userId: state.userData.profile!.id.toString(),
                  //     hasPet: state.userData.profile!.hasPets!,
                  //     isAgent: !state.userData.isAgent!);
                } else {
                  Modals.showToast(state.userData.message!,
                      messageType: MessageType.error);
                }
              } else if (state is AccountApiErr) {
                if (state.message != null) {
                  Modals.showToast(state.message!,
                      messageType: MessageType.error);
                }
              } else if (state is AccountNetworkErr) {
                if (state.message != null) {
                  Modals.showToast(state.message!,
                      messageType: MessageType.error);
                }
              }
            },
            builder: (context, state) => SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: screenSize(context).height * 0.13,
                    ),
                    CustomText(
                      textAlign: TextAlign.left,
                      maxLines: 2,
                      text: 'Sign in',
                      weight: FontWeight.w700,
                      size: 24,
                      fontFamily: AppStrings.interSans,
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    CustomText(
                      textAlign: TextAlign.left,
                      maxLines: 2,
                      text: 'Hey welcome back',
                      weight: FontWeight.w400,
                      size: 16,
                      fontFamily: AppStrings.interSans,
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    TextEditView(
                      controller: _usernameController,
                      validator: (value) {
                        return Validator.validate(value, 'Username');
                      },
                      isDense: true,
                      textViewTitle: 'Your Username',
                      hintText: 'Enter username',
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ImageView.svg(
                          AppImages.personIcon,
                        ),
                      ),
                      fillColor: AppColors.lightPrimary,
                      borderColor: AppColors.lightPrimary,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextEditView(
                      controller: _passwordController,
                      validator: (value) {
                        return Validator.validate(value, 'Password');
                      },
                      isDense: true,
                      textViewTitle: 'Password',
                      hintText: 'Enter your password',
                      obscureText: user.showPasswordStatus,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          user.showPassword();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ImageView.svg(
                            AppImages.visibleIcon,
                            height: 13,
                          ),
                        ),
                      ),
                      fillColor: AppColors.lightPrimary,
                      borderColor: AppColors.lightPrimary,
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    ImageView.asset(AppImages.line),
                    SizedBox(
                      height: 45,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ImageView.asset(AppImages.facebookIcon),
                        SizedBox(
                          width: 15,
                        ),
                        ImageView.asset(AppImages.appleIcon),
                        SizedBox(
                          width: 15,
                        ),
                        ImageView.asset(AppImages.goggleIcon),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0.0, horizontal: 0),
                      child: ButtonView(
                        processing: (state is AccountLoading ||
                            firebaseUser.status == Status.authenticating),
                        onPressed: () {
                          _submit(context);
                        },
                        color: AppColors.lightSecondary,
                        child: CustomText(
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          text: 'Sign In',
                          weight: FontWeight.w400,
                          size: 16,
                          fontFamily: AppStrings.interSans,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Don\'t Have an account?',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // registerAnounimousUser(user);
                                },
                            ),
                            TextSpan(
                                text: '  Create Account',
                                style:
                                    TextStyle(color: AppColors.lightSecondary),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    AppNavigator.pushAndReplaceName(context,
                                        name: AppRoutes.signUpScreen);
                                  }),
                            TextSpan(
                              text: '  in here',
                              style: TextStyle(color: Colors.black),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // Long Pressed.
                                },
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ));
  }

  _submit(BuildContext ctx) {
    if (_formKey.currentState!.validate()) {
      ctx.read<AccountCubit>().loginUser(
          username: _usernameController.text.trim(),
          password: _passwordController.text.trim());
      FocusScope.of(ctx).unfocus();
    }
  }

  loginUser(
      {final firebaseUser,
      required BuildContext context,
      required String message,
      required userId,
      required bool hasPet,
      required bool isAgent}) async {
   
    await firebaseUser.loginUserWithEmailAndPassword(
        email: '${_usernameController.text.trim()}@gmail.com',
        password: _passwordController.text.trim());

    if (firebaseUser.status == Status.authenticated) {
      Modals.showToast(message, messageType: MessageType.success);

      StorageHandler.saveIsLoggedIn('true');
      StorageHandler.saveUserId(userId);
      StorageHandler.saveUserPassword(_passwordController.text);
      StorageHandler.saveUserName(_usernameController.text.trim());

      Modals.showToast('success');

      if (hasPet) {
        StorageHandler.saveUserPetState('true');
      } else {
        StorageHandler.saveUserPetState('');
      }

      if (isAgent) {
        StorageHandler.saveIsUserType('user');

        AppNavigator.pushAndStackNamed(context, name: AppRoutes.landingPage);
      } else {
        StorageHandler.saveIsUserType('service_provider');

        AppNavigator.pushAndReplaceName(context,
            name: AppRoutes.serviceProviderLandingPage);
      }
    }
  }
}

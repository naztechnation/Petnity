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
import 'forgot_password.dart';
import 'otp_screen.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  final _passwordController = TextEditingController();

  final _emailController = TextEditingController();

  String deviceId = '';

  getToken() async {
    deviceId = await StorageHandler.getFirebaseToken();

    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    getToken();
  }

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
                if (state.userData.status ?? false) {
                  StorageHandler.saveUserPassword(
                      _passwordController.text.trim());
                  StorageHandler.saveIsLoggedIn('true');

                  if (state.userData.data?.user == null) {
                    if (state.userData.data?.agent?.user?.isAgent ?? false) {
                      StorageHandler.saveIsUserType('service_provider');
                      StorageHandler.saveUserToken(state.userData.data?.token);

                      StorageHandler.saveAgentId(
                          state.userData.data?.agent?.sId);
                      StorageHandler.saveUserId(
                          state.userData.data?.agent?.user?.sId.toString());

                      StorageHandler.saveEmail(
                          state.userData.data?.agent?.user?.email.toString());
                      StorageHandler.saveUserPhone(state
                          .userData.data?.agent?.user?.phoneNumber
                          .toString());
                      StorageHandler.saveUserPicture(state
                          .userData.data?.agent?.user?.profileImage
                          .toString());

                      StorageHandler.saveUserName(state
                          .userData.data?.agent?.user?.username
                          .toString());

                      user.setUserData(
                          username: state.userData.data?.agent?.user?.username
                                  .toString() ??
                              '');

                      if (state.userData.data?.agent?.user?.hasPets ?? false) {
                        StorageHandler.saveUserPetState('true');
                      } else {
                        StorageHandler.saveUserPetState('');
                      }

                      loginFirebaseUser(
                          firebaseUser: firebaseUser,
                          context: context,
                          message: state.userData.message ?? '',
                          isAgent: true);
                    }
                  } else {
                    StorageHandler.saveUserToken(state.userData.data?.token);

                    StorageHandler.saveIsUserType('user');

                    StorageHandler.saveUserId(
                        state.userData.data?.user?.sId.toString());

                    StorageHandler.saveEmail(
                        state.userData.data?.user?.email.toString());
                    StorageHandler.saveUserPhone(
                        state.userData.data?.user?.phoneNumber.toString());
                    StorageHandler.saveUserPicture(
                        state.userData.data?.user?.profileImage.toString());

                    StorageHandler.saveUserName(
                        state.userData.data?.user?.username.toString());

                    user.setUserData(
                        username:
                            state.userData.data?.user?.username.toString() ??
                                '');
                    if (state.userData.data?.user?.hasPets ?? false) {
                      StorageHandler.saveUserPetState('true');
                    } else {
                      StorageHandler.saveUserPetState('');
                    }

                    loginFirebaseUser(
                        firebaseUser: firebaseUser,
                        context: context,
                        message: state.userData.message!,
                        isAgent: false);
                  }
                } else {
                  Modals.showToast(state.userData.message ?? '',
                      messageType: MessageType.error);
                  if (state.userData.message == 'Profile is not verified') {
                    resendCode(context);
                  }
                }
              } else if (state is OTPResent) {
                if (state.user.status == true) {
                  Modals.showToast(state.user.message ?? '',
                      messageType: MessageType.success);
                  AppNavigator.pushAndReplacePage(context,
                      page: OtpScreen(
                        email: _emailController.text,
                        username: _emailController.text,
                      ));
                } else {
                  Modals.showToast(state.user.message ?? '',
                      messageType: MessageType.success);
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
                      controller: _emailController,
                      validator: (value) {
                        return Validator.validate(value, 'Email/Username');
                      },
                      isDense: true,
                      textViewTitle: 'Your Email/Username',
                      hintText: 'Enter your email/username',
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ImageView.svg(
                          AppImages.personIcon,
                        ),
                      ),
                      fillColor: AppColors.lightPrimary,
                      borderColor: AppColors.lightPrimary,
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
                          child: user.showPasswordStatus
                              ? Icon(
                                  Icons.visibility_off_outlined,
                                  size: 24,
                                )
                              : Icon(Icons.visibility_outlined, size: 24),
                        ),
                      ),
                      fillColor: AppColors.lightPrimary,
                      borderColor: AppColors.lightPrimary,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        AppNavigator.pushAndStackPage(context,
                            page: ForgotPasswordScreen());
                      },
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                              color: AppColors.lightSecondary,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   height: 35,
                    // ),
                    // ImageView.asset(AppImages.line),
                    SizedBox(
                      height: 45,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     ImageView.asset(AppImages.facebookIcon),
                    //     SizedBox(
                    //       width: 15,
                    //     ),
                    //     ImageView.asset(AppImages.appleIcon),
                    //     SizedBox(
                    //       width: 15,
                    //     ),
                    //     ImageView.asset(AppImages.goggleIcon),
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: 30,
                    // ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0.0, horizontal: 0),
                      child: ButtonView(
                        processing: (state is AccountLoading ||
                            firebaseUser.status == Status.authenticating ||
                            state is AccountProcessing),
                        onPressed: () {
                          _loginUser(context);
                        },
                        color: AppColors.lightSecondary,
                        title: 'authenticating...',
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
                                text: ' Create An Account',
                                style: TextStyle(
                                    color: AppColors.lightSecondary,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    AppNavigator.pushAndReplaceName(context,
                                        name: AppRoutes.signUpScreen);
                                  }),
                            TextSpan(
                              text: '  Here.',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
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

  _loginUser(BuildContext ctx) {
    if (_formKey.currentState!.validate()) {
      ctx.read<AccountCubit>().loginUser(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          deviceId: deviceId);
      FocusScope.of(ctx).unfocus();
    }
  }

  loginFirebaseUser(
      {final firebaseUser,
      required BuildContext context,
      required String message,
      required bool isAgent}) async {
    if (isAgent) {
      StorageHandler.saveIsUserType('service_provider');

      AppNavigator.pushAndReplaceName(context,
          name: AppRoutes.serviceProviderLandingPage);
    } else {
      StorageHandler.saveIsUserType('user');

      AppNavigator.pushAndStackNamed(context, name: AppRoutes.landingPage);
    }
  }

  resendCode(BuildContext ctx) {
    if (_formKey.currentState!.validate()) {
      ctx.read<AccountCubit>().resendCode(
            email: _emailController.text.trim(),
          );
      FocusScope.of(ctx).unfocus();
    }
  }
}

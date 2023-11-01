import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_images.dart';
import 'package:petnity/ui/auth/otp_screen.dart';
import 'package:petnity/ui/widgets/image_view.dart';
import 'package:petnity/utils/validator.dart';
import 'package:provider/provider.dart';

import '../../blocs/accounts/account.dart';
import '../../handlers/secure_handler.dart';
import '../../model/view_models/firebase_auth_viewmodel.dart';
import '../../model/view_models/service_provider_view_model.dart';
import '../../model/view_models/account_view_model.dart';
import '../../requests/repositories/account_repo/account_repository_impl.dart';
import '../../res/app_routes.dart';
import '../../res/app_strings.dart';
import '../../res/enum.dart';
import '../../utils/navigator/page_navigator.dart';
import '../widgets/button_view.dart';
import '../widgets/custom_text.dart';
import '../widgets/modals.dart';
import '../widgets/text_edit_view.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();

  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AccountViewModel>(context, listen: true);
    final firebaseAuth =
        Provider.of<FirebaseAuthProvider>(context, listen: true);
    final serviceProvider =
        Provider.of<ServiceProviderViewModel>(context, listen: true);
    StorageHandler.saveOnboardState('true');

    return Scaffold(
        body: Container(
      height: double.infinity,
      width: double.infinity,
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
                  AppNavigator.pushAndReplacePage(context,
                      page: OtpScreen(
                        email: _emailController.text,
                        password: _passwordController.text,
                        phone: _phoneController.text,
                        username: _usernameController.text,
                      ));
                  Modals.showToast(state.userData.message ?? '',
                      messageType: MessageType.success);
                  StorageHandler.saveUserName(_usernameController.text.trim());
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
                      text: 'Create an account',
                      weight: FontWeight.w700,
                      size: 24,
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
                      textViewTitle: 'Your  Username',
                      hintText: 'Enter username',
                       inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'\s'))],
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
                      controller: _emailController,
                      validator: (value) {
                        return Validator.validateEmail(value, 'Email');
                      },
                      isDense: true,
                      textViewTitle: 'Your  Email',
                      hintText: 'Enter email',
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ImageView.svg(
                          AppImages.messageIcon,
                        ),
                      ),
                      fillColor: AppColors.lightPrimary,
                      borderColor: AppColors.lightPrimary,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextEditView(
                      controller: _phoneController,
                      validator: (value) {
                        return Validator.validate(value, 'Phone Number');
                      },
                      isDense: true,
                      keyboardType: TextInputType.phone,
                      textViewTitle: 'Your Number',
                      hintText: 'Enter Number',
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ImageView.svg(
                          AppImages.phoneIcon,
                          color: Colors.black,
                          height: 10,
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
                    GestureDetector(
                      onTap: () {
                        firebaseAuth.setBack();
                      },
                      child: Row(
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
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0.0, horizontal: 20),
                      child: ButtonView(
                        processing: (state is AccountProcessing ||
                            firebaseAuth.status == Status.authenticating),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            RegistrationOptions(
                                context, user, serviceProvider, firebaseAuth);
                            //_firebaseRegUser(  firebaseAuth,    context);
                          }
                        },
                        color: AppColors.lightSecondary,
                        child: CustomText(
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          text: 'Create account',
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
                              text: 'Have an account already?',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                              recognizer: TapGestureRecognizer()..onTap = () {},
                            ),
                            TextSpan(
                                text: '  Sign In',
                                style: TextStyle(
                                    color: AppColors.lightSecondary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    AppNavigator.pushAndReplaceName(context,
                                        name: AppRoutes.signInScreen);
                                  }),
                            TextSpan(
                              text: '  in here',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                              recognizer: TapGestureRecognizer()..onTap = () {},
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

  _firebaseRegUser(final firebaseAuth, BuildContext context) async {
   
    if (_formKey.currentState!.validate()) {
      await firebaseAuth.registerUserWithEmailAndPassword(
          email: '${_usernameController.text.toLowerCase().trim()}@gmail.com',
          password: _passwordController.text,
          username: _usernameController.text);

      if (firebaseAuth.status == Status.authenticated) {
        _submit(context);
      }
    }
  }

  _submit(BuildContext ctx) {
    if (_formKey.currentState!.validate()) {
      ctx.read<AccountCubit>().registerUser(
          url: AppStrings.registerUrl,
          firebaseId: FirebaseAuth.instance.currentUser!.uid,
          username: _usernameController.text.trim(),
          phoneNumber: _phoneController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
      FocusScope.of(ctx).unfocus();
    }
  }

  RegistrationOptions(BuildContext context, final user, final serviceProvider,
      final firebaseAuth) {
    return Modals.showBottomSheetModal(context,
        isDissmissible: true,
        isScrollControlled: false,
        page: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Continue as...',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.w900),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          child: Icon(
                            Icons.arrow_downward,
                            color: Colors.white,
                          ),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.lightSecondary),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Divider(),
                  const SizedBox(
                    height: 10,
                  ),
                  userTypes('User', () {
                    Navigator.pop(context);
                    user.setUserType(UserType.user);
                    StorageHandler.saveUserName(
                        _usernameController.text.trim());
                    _firebaseRegUser(firebaseAuth, context);
                  }, context),
                  const SizedBox(
                    height: 10,
                  ),
                  Divider(),
                  const SizedBox(
                    height: 10,
                  ),
                  userTypes('Service Provider', () {
                    Navigator.pop(context);

                    user.setUserType(UserType.serviceProvider);

                    // Modals.showToast(user.serviceProviderId);
                    // AppNavigator.pushAndReplaceName(context,
                    //     name: AppRoutes.otpScreen);
                    _firebaseRegUser(firebaseAuth, context);
                  }, context),
                  const SizedBox(
                    height: 10,
                  ),
                  Divider(),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            )));
  }

  userTypes(String title, Function onTap, BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        color: Colors.white,
        width: MediaQuery.sizeOf(context).width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
              size: 16,
            )
          ],
        ),
      ),
    );
  }
}

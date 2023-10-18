import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:provider/provider.dart';
import '../../blocs/accounts/account.dart';
import '../../model/view_models/account_view_model.dart';
import '../../requests/repositories/account_repo/account_repository_impl.dart';
import '../../res/app_constants.dart';
import '../../res/app_routes.dart';
import '../../res/app_strings.dart';
import '../../res/enum.dart';
import '../../utils/navigator/page_navigator.dart';
import '../widgets/button_view.dart';
import '../widgets/custom_text.dart';
import '../widgets/modals.dart';
import '../widgets/pin_code_view.dart';

class OtpScreen extends StatefulWidget {
  final String? email;
  final String? password;
  final String? username;
  final String? phone;
  const OtpScreen(
      {super.key, this.email, this.password, this.username, this.phone});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _formKey = GlobalKey<FormState>();

  bool isCountdownComplete = false;
  int countdown = 60;

  final _pinController = TextEditingController();

  @override
  void initState() {
    startCountdown();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AccountViewModel>(context, listen: true);

    user.getUsername();

    return Scaffold(
        body: BlocProvider<AccountCubit>(
      lazy: false,
      create: (_) => AccountCubit(
          accountRepository: AccountRepositoryImpl(),
          viewModel: Provider.of<AccountViewModel>(context, listen: false)),
      child: BlocConsumer<AccountCubit, AccountStates>(
        listener: (context, state) {
          if (state is AccountUpdated) {
            
            if(state.user.status!){
              Modals.showToast(state.user.message!,
                messageType: MessageType.success);

            AppNavigator.pushAndReplaceName(context,
                name: AppRoutes.successScreen);
            }else{
              Modals.showToast(state.user.message!,
                messageType: MessageType.success);
            }
          } else if (state is AccountLoaded) {
            Modals.showToast(state.userData.message!,
                messageType: MessageType.success);

            isCountdownComplete = false;
            startCountdown();
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
          child: Column(
            children: [
              SizedBox(
                height: screenSize(context).height * 0.35,
              ),
              CustomText(
                textAlign: TextAlign.center,
                maxLines: 2,
                text: 'Confirm the code sent to\nyour Email',
                weight: FontWeight.w700,
                size: 24,
                fontFamily: AppStrings.interSans,
                color: Colors.black,
              ),
              SizedBox(
                height: 63,
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: PinCodeView(
                    length: 6,
                    controller: _pinController,
                    onChanged: (_) {},
                    onCompleted: (_) {},
                    // validator: Validator.validate
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {},
                  child: Text.rich(
                      TextSpan(
                          text: (!isCountdownComplete) ? 'Resend' : '',
                          style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.lightSecondary,
                              fontWeight: FontWeight.w400,
                              fontFamily: AppStrings.montserrat,
                              height: 2),
                          children: [
                            if (!isCountdownComplete)
                              TextSpan(
                                  text: ' in $countdown seconds',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                              fontFamily: AppStrings.montserrat,

                                    fontWeight: FontWeight.w500,
                                  )),
                            if (isCountdownComplete)
                              (state is AccountProcessing)
                                  ? TextSpan(
                                      text: '',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                              fontFamily: AppStrings.montserrat,

                                        fontWeight: FontWeight.w500,
                                      ))
                                  : TextSpan(
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          _resendCode(context, user);
                                        },
                                      text: '  Resend  ',
                                      style: const TextStyle(
                                          fontSize: 18,
                                          color: AppColors.lightSecondary,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: AppStrings.interSans,
                                          height: 2),
                                    )
                          ]),
                      textAlign: TextAlign.start),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20),
                child: ButtonView(
                  processing: state is AccountProcessing,
                  onPressed: () {
                      _submit(context, user);
                  //  AppNavigator.pushAndReplaceName(context,
                      // name: AppRoutes.successScreen);
                  },
                  color: AppColors.lightSecondary,
                  child: CustomText(
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    text: 'Confirm',
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
            ],
          ),
        ),
      ),
    ));
  }

  _submit(BuildContext ctx, user) {
    if (_pinController.text.isNotEmpty && _pinController.text.length == 6) {
      ctx.read<AccountCubit>().verifyOTP(
            user.username,
            _pinController.text.trim(),
          );
      FocusScope.of(ctx).unfocus();
    }
  }

  Future<void> startCountdown() async {
    for (int i = 60; i >= 0; i--) {
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        countdown = i;
      });
    }
    setState(() {
      isCountdownComplete = true;
    });
  }

  _resendCode(BuildContext ctx, user) {
    if (_formKey.currentState!.validate()) {
      ctx.read<AccountCubit>().resendCode(
          username: AppStrings.resendCodeUrl(user.username),
          );
      FocusScope.of(ctx).unfocus();
    }
  }
}

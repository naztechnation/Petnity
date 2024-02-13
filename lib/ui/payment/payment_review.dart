import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../model/view_models/account_view_model.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_constants.dart';
import '../../../res/app_strings.dart';
import '../../../res/enum.dart';
import '../../../utils/validator.dart';
import '../../blocs/service_provider/service_provider.dart';
import '../../handlers/secure_handler.dart';
import '../../model/view_models/service_provider_inapp.dart';
import '../../requests/repositories/service_provider_repo/service_provider_repository_impl.dart';
import '../../res/app_routes.dart';
import '../../utils/app_utils.dart';
import '../../utils/navigator/page_navigator.dart';
import '../settings/update_successful_page.dart';
import '../widgets/back_button.dart';
import '../widgets/button_view.dart';
import '../widgets/custom_text.dart';
import '../widgets/modals.dart';
import '../widgets/text_edit_view.dart';

class PaymentReview extends StatelessWidget {
  final String amount;
  final String accountName;
  final String accountNumber;
  final String bankName;

  PaymentReview({
    super.key,
    required this.amount,
    required this.accountName,
    required this.accountNumber,
    required this.bankName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ServiceProviderCubit>(
      create: (BuildContext context) => ServiceProviderCubit(
          serviceProviderRepository: ServiceProviderRepositoryImpl(),
          viewModel: Provider.of<ServiceProviderInAppViewModel>(context,
              listen: false)),
      child: Payment(
        amount: amount,
        accountName: accountName,
        accountNumber: accountNumber,
        bankName: bankName,
      ),
    );
  }
}

class Payment extends StatefulWidget {
  final String amount;
  final String accountName;
  final String accountNumber;
  final String bankName;

  Payment({
    super.key,
    required this.amount,
    required this.accountName,
    required this.accountNumber,
    required this.bankName,
  });

  @override
  State<Payment> createState() => _PaymentReviewState();
}

class _PaymentReviewState extends State<Payment> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _amountController = TextEditingController();

  final TextEditingController _bankDetailsController = TextEditingController();

  Color amountColor = Colors.black;

  late ServiceProviderCubit _serviceProviderCubit;

  String agentId = "";
  String mainAmount = "0";

  getAgentId() async {
    agentId = await StorageHandler.getUserId();

    _serviceProviderCubit = context.read<ServiceProviderCubit>();
  }

  @override
  void initState() {
    getAgentId();
    _bankDetailsController.text = widget.accountName;
    _amountController.text = widget.amount;

    _amountController.text = AppUtils.convertPrice(_amountController.text);

    mainAmount = widget.amount;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final petProfile = Provider.of<AccountViewModel>(context, listen: false);

    return Scaffold(
        body: Container(
      height: screenSize(context).height,
      width: screenSize(context).width,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [AppColors.scaffoldColor, Colors.red.shade50],
              begin: Alignment.topRight,
              end: Alignment.topLeft)),
      child: BlocConsumer<ServiceProviderCubit, ServiceProviderState>(
        listener: (context, state) {
          if (state is VetsCreateWithdrawalRequestLoaded) {
            if (state.requests.status!) {
             
              Modals.showToast(state.requests.message!,
                  messageType: MessageType.success);

              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return UpdateSuccessfulScreen(
                    notetext:
                        'Payment speed is subject to banks internal network',
                    buttonText: 'Back Home',
                    onPressed: () {
                      AppNavigator.pushAndReplaceName(context,
                          name: AppRoutes.serviceProviderLandingPage);
                    },
                    successMessage:
                        'Amount of NGN${AppUtils.convertPrice(widget.amount)} has been sent to you saved bank account Payment should arrive in an hour');
              }));
            }
          } else if (state is CreateServiceNetworkErr) {
            Modals.showToast(state.message ?? '');
          } else if (state is CreateServiceNetworkErrApiErr) {
            Modals.showToast(state.message ?? '');
          }
        },
        builder: (context, state) => SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SafeArea(
                    child: SizedBox(height: (Platform.isAndroid) ? 30 : 0)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    backButton(context),
                    const SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: CustomText(
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        text: 'Payment Review',
                        weight: FontWeight.w700,
                        size: 18,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: TextEditView(
                          isDense: true,
                          readOnly: true,
                          validator: (value) {
                            return Validator.validate(value, 'amount');
                          },
                          controller: _amountController,
                          filled: true,
                          textColor: amountColor,
                          fillColor: AppColors.lightPrimary,
                          borderRadius: 30,
                          textViewTitle: 'Withdraw',
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: TextEditView(
                          isDense: true,
                          readOnly: true,
                          keyboardType: TextInputType.number,
                          maxLines: 1,
                          controller: _bankDetailsController,
                          onChanged: (value) {},
                          validator: (value) {
                            return Validator.validate(value, 'Account');
                          },
                          filled: true,
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: Column(
                              children: [
                                Text(
                                  '${widget.bankName}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text('${widget.accountNumber}'),
                              ],
                            ),
                          ),
                          fillColor: AppColors.lightPrimary,
                          borderRadius: 30,
                          textViewTitle: 'To Account',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 180,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20),
                  child: ButtonView(
                    processing: state is VetsCreateWithdrawalRequestLoading,
                    onPressed: () {
                      _serviceProviderCubit.vetsCreateWithdrawalRequest(
                           amount: mainAmount);

                          
                    },
                    color: AppColors.lightSecondary,
                    borderRadius: 30,
                    borderColor: AppColors.lightSecondary,
                    child: CustomText(
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      text: 'Confirm',
                      weight: FontWeight.w700,
                      size: 16,
                      fontFamily: AppStrings.interSans,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

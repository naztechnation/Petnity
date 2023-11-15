import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../blocs/accounts/account.dart';
import '../../../model/view_models/account_view_model.dart';
import '../../../requests/repositories/account_repo/account_repository_impl.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_constants.dart';
import '../../../res/app_strings.dart';
import '../../../res/enum.dart';
import '../../../utils/validator.dart';
import '../../res/app_routes.dart';
import '../../utils/app_utils.dart';
import '../../utils/navigator/page_navigator.dart';
import '../settings/update_successful_page.dart';
import '../widgets/back_button.dart';
import '../widgets/button_view.dart';
import '../widgets/custom_text.dart';
import '../widgets/modals.dart';
import '../widgets/text_edit_view.dart';

class PaymentReview extends StatefulWidget {
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
  State<PaymentReview> createState() => _PaymentReviewState();
}

class _PaymentReviewState extends State<PaymentReview> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _amountController = TextEditingController();

  final TextEditingController _bankDetailsController = TextEditingController();

  Color amountColor = Colors.black;

  @override
  void initState() {
    _bankDetailsController.text = widget.accountName;
    _amountController.text = widget.amount;

    _amountController.text = AppUtils.convertPrice(_amountController.text);
    
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
                    padding:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 10),
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
                            onChanged: (value){
                              

                            },
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                    padding: const EdgeInsets.symmetric(
                        vertical: 0.0, horizontal: 20),
                    child: ButtonView(
                      processing: state is AccountProcessing,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return UpdateSuccessfulScreen(
                              notetext:
                                  'Payment speed is subject to bans internal network',
                              buttonText: 'Back Home',
                              onPressed: () {
                                AppNavigator.pushAndReplaceName(context,
                                    name: AppRoutes.serviceProviderLandingPage);
                              },
                              successMessage:
                                  'Amount of NGN${AppUtils.convertPrice(widget.amount)} has been sent to you saved bank account Payment should arrive in an hour');
                        }));
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
      ),
    ));
  }
}

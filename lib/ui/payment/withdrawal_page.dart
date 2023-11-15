import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petnity/ui/payment/payment_review.dart';
import 'package:petnity/ui/widgets/image_view.dart';
import 'package:petnity/ui/widgets/text_edit_view.dart';
import 'package:provider/provider.dart';

import '../../blocs/service_provider/service_provider.dart';
import '../../handlers/secure_handler.dart';
import '../../model/service_provider_models/account_details.dart';
import '../../model/view_models/service_provider_inapp.dart';
import '../../requests/repositories/service_provider_repo/service_provider_repository_impl.dart';
import '../../res/app_colors.dart';
import '../../res/app_constants.dart';
import '../../res/app_images.dart';
import '../../res/app_strings.dart';
import '../../utils/app_utils.dart';
import '../../utils/navigator/page_navigator.dart';
import '../../utils/validator.dart';
import '../settings/add_account_details.dart';
import '../widgets/back_button.dart';
import '../widgets/button_view.dart';
import '../widgets/custom_text.dart';
import '../widgets/loading_page.dart';
import '../widgets/modals.dart';

class WithdrawalPage extends StatelessWidget {
  const WithdrawalPage();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ServiceProviderCubit>(
      create: (BuildContext context) => ServiceProviderCubit(
          serviceProviderRepository: ServiceProviderRepositoryImpl(),
          viewModel: Provider.of<ServiceProviderInAppViewModel>(context,
              listen: false)),
      child: Withdrawal(),
    );
  }
}

class Withdrawal extends StatefulWidget {
  const Withdrawal({super.key});

  @override
  State<Withdrawal> createState() => _WithdrawalState();
}

class _WithdrawalState extends State<Withdrawal> {
  late ServiceProviderCubit _userCubit;
  final _formKey = GlobalKey<FormState>();

  final amountController = TextEditingController();

  List<AgentBankDetails> accountList = [];

  String agentId = "";

  String accountName = '';
  String accountNumber = '';
  String bankName = '';
  String amount = '95000';
  Color amountColor = Colors.black;

  Timer? _debounce;


  getAgentId() async {
    agentId = await StorageHandler.getAgentId();
    _userCubit = context.read<ServiceProviderCubit>();

    _userCubit.getAccount(agentId: agentId);
  }

  @override
  void initState() {
    getAgentId();
     amountController.addListener(updateTextColor);
    super.initState();
  }
  void updateTextColor() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        double enteredAmount = double.tryParse(amountController.text) ?? 0;
        double staticAmount = double.tryParse( amount) ?? 0;

        amountColor = enteredAmount > staticAmount ? Colors.red : Colors.black;
      //   if(amountController.text.isNotEmpty){
      //   amountController.text = AppUtils.convertPrice(amountController.text);

      //   }
       });
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: screenSize(context) * .08,
        child: Container(
          padding: EdgeInsets.only(top: 20),
          child: AppBar(
            centerTitle: true,
            title: Text(
              'Payments',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: backButton(context),
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
        ),
      ),
      body: BlocConsumer<ServiceProviderCubit, ServiceProviderState>(
          listener: (context, state) {
        if (state is AccountDetailsLoaded) {
          if (state.account.status!) {
            accountList = state.account.agentBankDetails ?? [];

            if (accountList.isNotEmpty) {
              accountName = accountList.last.accountName ?? "";
              accountNumber = accountList.last.accountNumber ?? "";
              bankName = accountList.last.bank ?? "";
            }
          }
        } else if (state is CreateServiceNetworkErrApiErr) {
          Modals.showToast(state.message ?? "");
        } else if (state is CreateServiceNetworkErrApiErr) {
          Modals.showToast(state.message ?? "");
        }
      }, builder: (context, state) {
        if (state is AccountDetailsLoaded) {
          if (accountList.isNotEmpty) {
            return SingleChildScrollView(
              child: Container(
                height: screenSize(context).height - 120,
                width: screenSize(context).width,
                padding: const EdgeInsets.symmetric(horizontal: 22),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [AppColors.scaffoldColor, Colors.red.shade50],
                        begin: Alignment.topRight,
                        end: Alignment.topLeft)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: screenSize(context).width,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: CustomText(
                                text: 'Withdrawable balance',
                                weight: FontWeight.bold,
                                maxLines: 2,
                                size: 13,
                              ),
                            ),
                            CustomText(
                              text: 'NGN ${AppUtils.convertPrice('9500')}',
                              weight: FontWeight.bold,
                              fontFamily: AppStrings.montserrat,
                              size: 13,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Form(
                        key: _formKey,
                        child: TextEditView(
                          validator: (value) {
                            return Validator.validate(value, 'input amount');
                          },
                          controller: amountController,
                          isDense: true,
                          keyboardType: TextInputType.number,
                          textColor: amountColor,
                          
                          textViewTitle: 'Amount',
                          hintText: 'input amount',
                          fillColor: Colors.white,
                          borderColor: Colors.white,
                          borderRadius: 30,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomText(
                        text: 'Destination account to withdraw',
                        weight: FontWeight.bold,
                        fontFamily: AppStrings.montserrat,
                        size: 13,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: screenSize(context).width * 0.5,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        decoration: BoxDecoration(
                          color: AppColors.lightSecondary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: accountName,
                                  weight: FontWeight.bold,
                                  color: Colors.white,
                                  size: 13,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            CustomText(
                              text: bankName,
                              weight: FontWeight.bold,
                              color: Colors.white,
                              size: 13,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomText(
                              text: accountNumber,
                              color: Colors.white,
                              weight: FontWeight.bold,
                              size: 13,
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          AppNavigator.pushAndReplacePage(context,
                              page: AddAccountDetails(
                                isWithdraw: true,
                              ));
                        },
                        child: Align(
                          child: CustomText(
                            text: 'Change Account',
                            weight: FontWeight.bold,
                            color: AppColors.lightSecondary,
                            size: 13,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 0),
                        child: ButtonView(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              AppNavigator.pushAndStackPage(context,
                                  page: PaymentReview(
                                    amount: amountController.text,
                                    accountName: accountName,
                                    accountNumber: accountNumber,
                                    bankName: bankName,
                                  ));
                            }
                          },
                          color: AppColors.lightSecondary,
                          borderRadius: 22,
                          child: CustomText(
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            text: 'Withdraw',
                            weight: FontWeight.w500,
                            size: 16,
                            fontFamily: AppStrings.interSans,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ]),
              ),
            );
          }
        } else if (state is AccountDetailsLoading) {
          return LoadingPage();
        }

        return SingleChildScrollView(
          child: Container(
            height: screenSize(context).height,
            width: screenSize(context).width,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [AppColors.scaffoldColor, Colors.red.shade50],
                    begin: Alignment.topRight,
                    end: Alignment.topLeft)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    height: 115,
                    width: MediaQuery.sizeOf(context).width,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          'You are yet to register any card',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Tap the button below to add an account',
                          style: TextStyle(fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Account',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      AppNavigator.pushAndReplacePage(context,
                          page: AddAccountDetails(
                            isWithdraw: true,
                          ));
                    },
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: screenSize(context).width * 0.4,
                        margin: const EdgeInsets.symmetric(horizontal: 0),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        decoration: BoxDecoration(
                          color: AppColors.lightPrimary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.add,
                                  color: AppColors.lightSecondary,
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            CustomText(
                              text: 'Add Account',
                              weight: FontWeight.bold,
                              color: AppColors.lightSecondary,
                              size: 13,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

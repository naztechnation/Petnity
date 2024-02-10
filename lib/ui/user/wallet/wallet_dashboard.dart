import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwave_standard/flutterwave.dart';
import 'package:petnity/ui/payment/withdrawal_page.dart';
import 'package:petnity/ui/widgets/back_button.dart';
import 'package:petnity/ui/widgets/button_view.dart';
import 'package:petnity/ui/widgets/text_edit_view.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../blocs/service_provider/service_provider.dart';
import '../../../handlers/secure_handler.dart';
import '../../../model/user_models/withdrawal_history.dart';
import '../../../model/view_models/service_provider_inapp.dart';
import '../../../requests/repositories/service_provider_repo/service_provider_repository_impl.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_constants.dart';
import '../../../res/app_images.dart';
import '../../../res/app_strings.dart';
import '../../../res/enum.dart';
import '../../../utils/app_utils.dart';
import '../../payment/widgets/payment_box.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/loading_page.dart';
import '../../widgets/modals.dart';

class UserWalletPage extends StatelessWidget {
  const UserWalletPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ServiceProviderCubit>(
      create: (BuildContext context) => ServiceProviderCubit(
          serviceProviderRepository: ServiceProviderRepositoryImpl(),
          viewModel: Provider.of<ServiceProviderInAppViewModel>(context,
              listen: false)),
      child: Payment(),
    );
  }
}

class Payment extends StatefulWidget {
  const Payment({
    super.key,
  });

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  late ServiceProviderCubit _serviceProviderCubit;

  final amountController = TextEditingController();

  var withdrawableAmount = '0';

  List<AgentWithdrawals> agentWithdrawals = [];

  String email = '';

  String transactionId = '';
  String txId = '';
  var uuid = const Uuid();

  String selectedPlan = '';

  String agentId = "";

  bool isPageLoading = false;

  getBalance() async {
    agentId = await StorageHandler.getUserId();
    email = await StorageHandler.getUserEmail();

    _serviceProviderCubit = context.read<ServiceProviderCubit>();
    await _serviceProviderCubit.getAgentBalance(
      url: AppStrings.getUserBalance,
    );

    await _serviceProviderCubit.agentWithdrawalHistory(
      agentId: agentId,
    );
  }

  _handlePaymentInitialization() async {
    final Customer customer = Customer(email: email);

    final Flutterwave flutterwave = Flutterwave(
        context: context,
        publicKey: AppStrings.flutterwaveApiKey,
        currency: 'NGN',
        redirectUrl: 'https://lucacify.com',
        txRef: uuid.v1(),
        amount: amountController.text,
        customer: customer,
        paymentOptions: "card",
        customization: Customization(
          title: "Lucacify",
          logo: AppImages.logo,
        ),
        isTestMode: true);
    final ChargeResponse response = await flutterwave.charge();

    if (response != null) {
      txId = response.transactionId ?? '';
      print(txId);
      if (txId != '') {
        creditWallet(
          txId: txId,
        );
      }
    } else {
      Modals.showToast('Unable to make payment Successfully.',
          messageType: MessageType.error);
    }
  }

  @override
  void initState() {
    getBalance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final service =
        Provider.of<ServiceProviderInAppViewModel>(context, listen: true);

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: screenSize(context) * .1,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: AppBar(
              elevation: 0,
              backgroundColor: AppColors.lightBackground,
              leading: backButton(context),
              title: Text(
                'Wallet',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
          ),
        ),
        body: BlocConsumer<ServiceProviderCubit, ServiceProviderState>(
            listener: (context, state) {
          if (state is CreateServiceNetworkErr) {
            Modals.showToast(state.message ?? '');
          } else if (state is CreateServiceNetworkErrApiErr) {
            Modals.showToast(state.message ?? '');
          } else if (state is CreditWalletLoaded) {
            if (state.data.status ?? false) {
              Modals.showToast(state.data.message ?? '',
                  messageType: MessageType.success);
            } else if (state.data.error != null) {
              Modals.showToast(
                state.data.error?.message ?? '',
              );
            } else if (state.data.status ?? false) {
              Modals.showToast(
                state.data.message ?? '',
              );
            }
          } else if (state is AgentBalanceLoaded) {
            withdrawableAmount = state.balance.data?.balance.toString() ?? '';

            service.setWithdrawableBalance(withdrawableAmount);
          } else if (state is AgentWithdrawalHistoryLoaded) {
            agentWithdrawals =
                state.requests.agentWithdrawals?.reversed.toList() ?? [];
          }
        }, builder: (context, state) {
          return (state is AgentBalanceLoading ||
                  state is AgentWithdrawalHistoryLoading ||
                  state is CreditWalletLoading)
              ? LoadingPage()
              : Container(
                  height: screenSize(context).height,
                  width: screenSize(context).width,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [AppColors.scaffoldColor, Colors.red.shade50],
                          begin: Alignment.topRight,
                          end: Alignment.topLeft)),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          GestureDetector(
                            onTap: () {
                              // AppNavigator.pushAndStackPage(context,
                              //     page: WithdrawalPage(
                              //       withdrawableAmount: withdrawableAmount,
                              //     ));
                            },
                            child: Container(
                              width: screenSize(context).width,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: CustomText(
                                          text: 'Available Balance',
                                          weight: FontWeight.bold,
                                          color: AppColors.lightSecondary,
                                          maxLines: 2,
                                          size: 13,
                                        ),
                                      ),
                                      CustomText(
                                        text: (withdrawableAmount != 'null')
                                            ? 'NGN ${AppUtils.convertPrice('$withdrawableAmount')} '
                                            : '0.00',
                                        weight: FontWeight.bold,
                                        color: AppColors.lightSecondary,
                                        fontFamily: AppStrings.montserrat,
                                        size: 13,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Modals.showDialogModal(context,
                                          page: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20, horizontal: 20),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Enter amount to top up.',
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                TextEditView(
                                                  isDense: true,
                                                  controller: amountController,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  hintText: 'Enter amount',
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: ButtonView(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        expanded: false,
                                                        color: Colors.white,
                                                        borderColor: AppColors
                                                            .lightSecondary,
                                                        child: Text(
                                                          'Cancel',
                                                          style: TextStyle(
                                                              fontSize: 14),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Expanded(
                                                      child: ButtonView(
                                                        onPressed: () {
                                                          if (amountController
                                                              .text
                                                              .isNotEmpty) {
                                                            Navigator.pop(
                                                                context);
                                                            // creditWallet(
                                                            //   txId: '4832288',
                                                            // );
                                                            _handlePaymentInitialization();
                                                          } else {
                                                            Modals.showToast(
                                                                'Please enter amount');
                                                          }
                                                        },
                                                        expanded: false,
                                                        color: AppColors
                                                            .lightSecondary,
                                                        borderColor: AppColors
                                                            .lightSecondary,
                                                        child: Text(
                                                          'Continue',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 14),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ));
                                      // AppNavigator.pushAndStackPage(context, page: page)
                                    },
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 6),
                                        decoration: BoxDecoration(
                                            color: AppColors.lightSecondary,
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        child: CustomText(
                                          text: 'Top Up',
                                          weight: FontWeight.bold,
                                          color: AppColors.lightPrimary,
                                          maxLines: 2,
                                          size: 13,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          // Container(
                          //   width: screenSize(context).width,
                          //   margin: const EdgeInsets.symmetric(horizontal: 10),
                          //   padding:
                          //       const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                          //   decoration: BoxDecoration(
                          //     color: Colors.white,
                          //     borderRadius: BorderRadius.circular(20),
                          //   ),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       Expanded(
                          //         child: CustomText(
                          //           text: 'Pending balance',
                          //           weight: FontWeight.bold,
                          //           maxLines: 2,
                          //           size: 13,
                          //         ),
                          //       ),
                          //       CustomText(
                          //         text: 'NGN ${AppUtils.convertPrice('950')}',
                          //         weight: FontWeight.bold,
                          //         fontFamily: AppStrings.montserrat,
                          //         size: 13,
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          // const SizedBox(
                          //   height: 20,
                          // ),
                          CustomText(
                            text: 'Wallet Activities',
                            weight: FontWeight.bold,
                            fontFamily: AppStrings.montserrat,
                            size: 13,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          if (agentWithdrawals.isNotEmpty) ...[
                            ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: agentWithdrawals.length,
                                shrinkWrap: true,
                                itemBuilder: ((context, index) {
                                  return PaymentBox(
                                    history: agentWithdrawals[index],
                                  );
                                }))
                          ] else ...[
                            Container(
                                height: 300,
                                child: Align(
                                    child: Card(
                                  elevation: 0.5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Container(
                                    height: 120,
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Text(
                                          'You have\'nt made any withdrawals yet',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: AppColors.lightSecondary,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ),
                                    ),
                                  ),
                                ))),
                          ]
                        ],
                      ),
                    ),
                  ),
                );
        }));
  }

  creditWallet({required String txId}) async {
    await _serviceProviderCubit.creditWallet(
      txId: txId,
    );
  }
}

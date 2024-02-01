import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petnity/ui/payment/withdrawal_page.dart';
import 'package:petnity/ui/widgets/back_button.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../blocs/service_provider/service_provider.dart';
import '../../handlers/secure_handler.dart';
import '../../model/user_models/withdrawal_history.dart';
import '../../model/view_models/service_provider_inapp.dart';
import '../../requests/repositories/service_provider_repo/service_provider_repository_impl.dart';
import '../../res/app_colors.dart';
import '../../res/app_constants.dart';
import '../../res/app_strings.dart';
import '../../utils/app_utils.dart';
import '../../utils/navigator/page_navigator.dart';
import '../widgets/custom_text.dart';
import '../widgets/loading_page.dart';
import '../widgets/modals.dart';
import 'widgets/payment_box.dart';

class PaymentPage extends StatelessWidget {
  final bool mainPage;
  const PaymentPage({Key? key, required this.mainPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ServiceProviderCubit>(
      create: (BuildContext context) => ServiceProviderCubit(
          serviceProviderRepository: ServiceProviderRepositoryImpl(),
          viewModel: Provider.of<ServiceProviderInAppViewModel>(context,
              listen: false)),
      child: Payment(
        mainPage: mainPage,
      ),
    );
  }
}

class Payment extends StatefulWidget {
  final bool mainPage;

  const Payment({
    super.key,
    required this.mainPage,
  });

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  late ServiceProviderCubit _serviceProviderCubit;

  var withdrawableAmount = '0';

  List<AgentWithdrawals> agentWithdrawals = [];

  String email = '';

  String transactionId = '';
  String txId = '';
  var uuid = const Uuid();

  String selectedPlan = '';

  String agentId = "";

  getBalance() async {
    agentId = await StorageHandler.getUserId();

    _serviceProviderCubit = context.read<ServiceProviderCubit>();
    await _serviceProviderCubit.getAgentBalance(
      agentId: agentId,
    );

    await _serviceProviderCubit.agentWithdrawalHistory(
      agentId: agentId,
    );
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
          preferredSize: (!widget.mainPage)
              ? screenSize(context) * 0
              : screenSize(context) * .1,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: AppBar(
              elevation: 0,
              backgroundColor: AppColors.lightBackground,
              leading: backButton(context),
              title: Text(
                'Payments',
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
          } else if (state is AgentBalanceLoaded) {
            withdrawableAmount = state.balance.data?.balance.toString() ?? '';

            


            service.setWithdrawableBalance(withdrawableAmount);
          } else if (state is AgentWithdrawalHistoryLoaded) {
            agentWithdrawals =
                state.requests.agentWithdrawals?.reversed.toList() ?? [];
          }
        }, builder: (context, state) {
          return (state is AgentBalanceLoading ||
                  state is AgentWithdrawalHistoryLoading)
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CustomText(
                                text: 'Lifetime earnings -',
                                weight: FontWeight.bold,
                                maxLines: 2,
                                size: 13,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              CustomText(
                                text: (withdrawableAmount != 'null')
                                    ? 'NGN ${AppUtils.convertPrice('$withdrawableAmount')} '
                                    : '0.00',
                                weight: FontWeight.w900,
                                fontFamily: AppStrings.montserrat,
                                maxLines: 2,
                                size: 12,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          GestureDetector(
                            onTap: () {
                              AppNavigator.pushAndStackPage(context,
                                  page: WithdrawalPage(
                                    withdrawableAmount: withdrawableAmount,
                                  ));
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
                                          text: 'Withdrawable balance',
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
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                          color: AppColors.lightSecondary,
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: CustomText(
                                        text: 'withdraw',
                                        weight: FontWeight.bold,
                                        color: AppColors.lightPrimary,
                                        maxLines: 2,
                                        size: 13,
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
                            text: 'Analytics',
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
}

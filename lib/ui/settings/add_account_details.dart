import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/ui/settings/update_successful_page.dart';
import 'package:petnity/ui/widgets/button_view.dart';
import 'package:petnity/ui/widgets/loading_page.dart';
import 'package:petnity/ui/widgets/text_edit_view.dart';
import 'package:provider/provider.dart';

import '../../blocs/service_provider/service_provider.dart';
import '../../handlers/secure_handler.dart';
import '../../model/service_provider_models/account_details.dart';
import '../../model/view_models/service_provider_inapp.dart';
import '../../requests/repositories/service_provider_repo/service_provider_repository_impl.dart';
import '../../res/app_images.dart';
import '../../res/app_routes.dart';
import '../../utils/navigator/page_navigator.dart';
import '../../utils/validator.dart';
import '../payment/withdrawal_page.dart';
import '../widgets/image_view.dart';
import '../widgets/modals.dart';

class AddAccountDetails extends StatelessWidget {
  final bool isWithdraw;

  const AddAccountDetails({this.isWithdraw = false});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ServiceProviderCubit>(
      create: (BuildContext context) => ServiceProviderCubit(
          serviceProviderRepository: ServiceProviderRepositoryImpl(),
          viewModel: Provider.of<ServiceProviderInAppViewModel>(context,
              listen: false)),
      child: AddAccount(
        isWithdraw: isWithdraw,
      ),
    );
  }
}

class AddAccount extends StatefulWidget {
  final bool isWithdraw;

  AddAccount({super.key, this.isWithdraw = false});

  @override
  State<AddAccount> createState() => _AddAccountState(isWithdraw: isWithdraw);
}

class _AddAccountState extends State<AddAccount> {
  final bool isWithdraw;

  _AddAccountState({this.isWithdraw = false});

  final TextEditingController accountNameController = TextEditingController();

  final TextEditingController accountNumberController = TextEditingController();

  final TextEditingController bankNameController = TextEditingController();

  final TextEditingController searchBankController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _formKey1 = GlobalKey<FormState>();

  late ServiceProviderCubit _userCubit;

  List<BankDetails> accountList = [];

  String amount = '0';

  String agentId = "";

  String bankCode = "";
  String email = "";
  String password = "";

  getAgentId() async {
    agentId = await StorageHandler.getUserId();
    email = await StorageHandler.getUserEmail();
    password = await StorageHandler.getUserPassword();

    agentId = await StorageHandler.getUserId();
    _userCubit = context.read<ServiceProviderCubit>();

    _userCubit.getAccount(agentId: agentId);
  }

  @override
  void initState() {
    getAgentId();
    super.initState();
  }

  Future<bool> onBackPress() {
    if (isWithdraw) {
      AppNavigator.pushAndReplacePage(context,
          page: WithdrawalPage(
            withdrawableAmount: amount,
          ));
    } else {
      Navigator.pop(context);
    }

    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    final serviceProvider =
        Provider.of<ServiceProviderInAppViewModel>(context, listen: true);

    amount = serviceProvider.withdrawableBalance;

    return BlocConsumer<ServiceProviderCubit, ServiceProviderState>(
      listener: (context, state) {
        if (state is UpdateAccountDetailsLoaded) {
          if (state.account.status!) {
            Modals.showToast(state.account.message ?? "");
            Modals.showToast(
                state.account.data?.bankDetails?.accountName ?? "");

            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return UpdateSuccessfulScreen(
                  buttonText: 'Done',
                  notetext:
                      'You cannot edit this account till after 30 days from today.',
                  onPressed: () {
                    AppNavigator.pushAndReplaceName(context,
                        name: AppRoutes.serviceProviderLandingPage);
                  },
                  successMessage: 'Your account details have been updated');
            }));
          } else {
            Modals.showToast(state.account.message ?? "");
          }
        }
        if (state is AccountDetailsLoaded) {
          if (state.account.status!) {
            accountList =
                state.account.data?.bankDetails?.reversed.toList() ?? [];

            if (accountList.isNotEmpty) {
              accountNameController.text = accountList[0].accountName ?? "";
              accountNumberController.text =
                  accountList[0].accountNumber.toString();
              bankNameController.text = accountList[0].bank ?? "";
            }
          }
        } else if (state is CreateServiceNetworkErrApiErr) {
          Modals.showToast(state.message ?? "");
        } else if (state is CreateServiceNetworkErrApiErr) {
          Modals.showToast(state.message ?? "");
        }
      },
      builder: (context, state) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: (state is AccountDetailsLoading)
            ? Scaffold(body: LoadingPage())
            : WillPopScope(
                onWillPop: onBackPress,
                child: Scaffold(
                  backgroundColor: AppColors.lightBackground,
                  appBar: PreferredSize(
                    preferredSize: screenSize(context) * .1,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: AppBar(
                        elevation: 0,
                        backgroundColor: AppColors.lightBackground,
                        leading: GestureDetector(
                          onTap: () {
                            if (isWithdraw) {
                              AppNavigator.pushAndReplacePage(context,
                                  page: WithdrawalPage(
                                    withdrawableAmount:
                                        serviceProvider.withdrawableBalance,
                                  ));
                            } else {
                              Navigator.pop(context);
                            }
                          },
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 22.0),
                                child: ImageView.svg(
                                  AppImages.backButton,
                                  height: 30,
                                  width: 30,
                                ),
                              )),
                        ),
                        title: Text(
                          'Account Details',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        centerTitle: true,
                      ),
                    ),
                  ),
                  body: SingleChildScrollView(
                    child: Container(
                        height: screenSize(context).height * .8,
                        padding: EdgeInsets.all(20),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextEditView(
                                isDense: true,
                                validator: (value) {
                                  return Validator.validate(
                                      value, 'Account name');
                                },
                                textViewTitle: 'Account name',
                                hintText: 'Enter account name',
                                fillColor: Colors.white,
                                borderColor: Colors.white,
                                controller: accountNameController,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextEditView(
                                isDense: true,
                                validator: (value) {
                                  return Validator.validate(
                                      value, 'Account number');
                                },
                                textViewTitle: 'Account number',
                                keyboardType: TextInputType.number,
                                fillColor: Colors.white,
                                borderColor: Colors.white,
                                hintText: 'Enter account number',
                                controller: accountNumberController,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextEditView(
                                controller: bankNameController,
                                isDense: true,
                                validator: (value) {
                                  return Validator.validate(value, 'Bank name');
                                },
                                fillColor: Colors.white,
                                borderColor: Colors.white,
                                textViewTitle: 'Bank name',
                                hintText: 'Select a bank',
                                readOnly: true,
                                suffixIcon: Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 22,
                                ),
                                onTap: () {
                                  serviceProvider.resetBankList();

                                  Modals.showBottomSheetModal(context,
                                      isDissmissible: true,
                                      heightFactor: 1,
                                      isScrollControlled: true,
                                      page: loadBankList(
                                          serviceProvider, context));
                                },
                              ),
                              Spacer(),
                              ButtonView(
                                borderRadius: 40,
                                processing:
                                    state is UpdateAccountDetailsLoading,
                                onPressed: () {
                                  Modals.showDialogModal(context,
                                      page: verifyUser());
                                },
                                child: Text(
                                  'Update Account',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
                ),
              ),
      ),
    );
  }

  verifyUser() {
    return Container(
      padding: EdgeInsets.all(15),
      child: Form(
        key: _formKey1,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Verify It's You!!!",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              height: 10,
            ),
            TextEditView(
              isDense: true,
              validator: (value) {
                return Validator.validate(value, 'Email');
              },
              textViewTitle: 'Email Address',
              hintText: 'Enter email',
              fillColor: Colors.white,
              borderColor: Colors.white,
              controller: emailController,
            ),
            SizedBox(
              height: 5,
            ),
            TextEditView(
              isDense: true,
              validator: (value) {
                return Validator.validate(value, 'Password');
              },
              textViewTitle: 'Password',
              fillColor: Colors.white,
              borderColor: Colors.white,
              hintText: 'Enter password',
              controller: passwordController,
            ),
            SizedBox(
              height: 35,
            ),
            ButtonView(
              borderRadius: 40,
              onPressed: () {
                if (_formKey1.currentState!.validate()) {
                if (email.toLowerCase().trim() == emailController.text.toLowerCase().trim() && password.toLowerCase().trim() == passwordController.text.toLowerCase().trim()) {
                  Modals.showToast('Authorization successful');
              Navigator.pop(context);

                   _submit(context: context, agentId: agentId);
                } else {
              Navigator.pop(context);

                  Modals.showToast('Failed to authorize user');
                  
                }
                }
              },
              child: Text(
                'Authorize',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(
              height: 25,
            ),
        
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text(
                "Close",
                
                style: TextStyle(
                  fontSize: 15,
                color: Colors.blue,
                
                
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  loadBankList(final user, BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextEditView(
                    isDense: true,
                    fillColor: Colors.white,
                    borderColor: Colors.grey,
                    controller: searchBankController,
                    hintText: 'Search bank...',
                    onChanged: ((value) {
                      user.searchBank(value);
                      setState(() {});
                    }),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      user.resetBankList();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 14.0),
                      child: Icon(
                        Icons.close,
                        size: 30,
                      ),
                    )),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Divider(
            height: 1,
          ),
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: user.filterBankList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      height: 40,
                      width: 40,
                      child: ImageView.network(
                        user.filterBankList[index]['logo'],
                      ),
                    ),
                  ),
                  subtitle: Text(user.filterBankList[index]['name']),
                  onTap: () {
                    Navigator.pop(context);

                    setState(() {
                      bankCode = user.filterBankList[index]['code'];
                      bankNameController.text =
                          user.filterBankList[index]['name'];
                    });
                  },
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  height: 1,
                );
              },
            ),
          ),
        ],
      );
    });
  }

  _submit({required BuildContext context, required String agentId}) {
    if (_formKey.currentState!.validate()) {
      context.read<ServiceProviderCubit>().updateAccount(
          bankCode: bankCode,
          bankName: bankNameController.text,
          accountName: accountNameController.text,
          accountNumber: accountNumberController.text);

      FocusScope.of(context).unfocus();
    }
  }
}

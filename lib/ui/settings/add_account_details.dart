import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petnity/model/view_models/account_view_model.dart';
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
import '../../res/app_routes.dart';
import '../../utils/navigator/page_navigator.dart';
import '../../utils/validator.dart';
import '../widgets/back_button.dart';
import '../widgets/modals.dart';


class AddAccountDetails extends StatelessWidget {
  
  const AddAccountDetails();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ServiceProviderCubit>(
      create: (BuildContext context) => ServiceProviderCubit(
          serviceProviderRepository: ServiceProviderRepositoryImpl(),
          viewModel: Provider.of<ServiceProviderInAppViewModel>(context,
              listen: false)),
      child: AddAccount(
         
      ),
    );
  }
}
class AddAccount extends StatefulWidget {
  AddAccount({super.key});

  @override
  State<AddAccount> createState() => _AddAccountState();
}

class _AddAccountState extends State<AddAccount> {
  final TextEditingController accountNameController = TextEditingController();

  final TextEditingController accountNumberController = TextEditingController();

  final TextEditingController bankNameController = TextEditingController();

  final TextEditingController searchBankController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  late ServiceProviderCubit _userCubit;

  List<AgentBankDetails> accountList = [];

  String agentId = "";

  getAgentId() async {
    agentId = await StorageHandler.getAgentId();
    _userCubit = context.read<ServiceProviderCubit>();

    _userCubit.getAccount(agentId: agentId);

  }

  @override
  void initState() {
    getAgentId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final serviceProvider =
        Provider.of<ServiceProviderInAppViewModel>(context, listen: true);

    return BlocConsumer<ServiceProviderCubit, ServiceProviderState>(
      listener: (context, state) {
        if (state is UpdateAccountDetailsLoaded) {
          if (state.account.status!) {
            Modals.showToast(state.account.message ?? "");
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return UpdateSuccessfulScreen(
                  buttonText: 'Done',
                  onPressed: () {
                    AppNavigator.pushAndReplaceName(context,
                        name: AppRoutes.serviceProviderLandingPage);
                  },
                  successMessage: 'Your account details have been updated');
            }));
          } else {
            Modals.showToast(state.account.message ?? "");

          }
        } if (state is AccountDetailsLoaded) {
          if (state.account.status!) {
             accountList = state.account.agentBankDetails ?? [];

             if(accountList.isNotEmpty){
              accountNameController.text = accountList.last.accountName ?? "";
              accountNumberController.text = accountList.last.accountNumber ?? "";
              bankNameController.text = accountList.last.bank ?? "";
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
        child: (state is AccountDetailsLoading) ?    Scaffold(body: LoadingPage()): Scaffold(
          backgroundColor: AppColors.lightBackground,
          appBar: PreferredSize(
            preferredSize: screenSize(context) * .1,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: AppBar(
                elevation: 0,
                backgroundColor: AppColors.lightBackground,
                leading: backButton(context),
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
                          return Validator.validate(value, 'Account name');
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
                          return Validator.validate(value, 'Account number');
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
                              page: loadBankList(serviceProvider, context));
                        },
                      ),
                      Spacer(),
                      ButtonView(
                        borderRadius: 40,
                        processing: state is UpdateAccountDetailsLoading,
                        onPressed: () {
                          _submit(context: context, agentId: agentId);
                        },
                        child: Text('Update Account'),
                      ),
                    ],
                  ),
                )),
          ),
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
                  leading: Text(user.filterBankList[index]),
                  onTap: () {
                    Navigator.pop(context);

                    setState(() {
                      bankNameController.text = user.filterBankList[index];
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
          agentId: agentId,
          bankName: bankNameController.text,
          accountName: accountNameController.text,
          accountNumber: accountNumberController.text);

      FocusScope.of(context).unfocus();
    }
  }
}

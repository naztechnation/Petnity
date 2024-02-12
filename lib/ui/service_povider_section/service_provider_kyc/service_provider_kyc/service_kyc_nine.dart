import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:petnity/handlers/secure_handler.dart';
import 'package:provider/provider.dart';

import '../../../../blocs/accounts/account.dart';
import '../../../../model/view_models/service_provider_view_model.dart';
import '../../../../model/view_models/account_view_model.dart';
import '../../../../requests/repositories/account_repo/account_repository_impl.dart';
import '../../../../res/app_colors.dart';
import '../../../../res/app_constants.dart';
import '../../../../res/app_strings.dart';
import '../../../../res/enum.dart';
import '../../../../utils/navigator/page_navigator.dart';
import '../../../user/user_kyc/widgets/service_provider_choice_container.dart';
import '../../../widgets/button_view.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/loading_page.dart';
import '../../../widgets/modals.dart';
import 'service_kyc_ten.dart';

class KycServiceScreenNine extends StatelessWidget {
  const KycServiceScreenNine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AccountCubit>(
      create: (BuildContext context) => AccountCubit(
          accountRepository: AccountRepositoryImpl(),
          viewModel: Provider.of<AccountViewModel>(context, listen: false)),
      child: KycScreenNine(),
    );
  }
}

class KycScreenNine extends StatefulWidget {
  KycScreenNine({super.key});

  @override
  State<KycScreenNine> createState() => _KycScreenNineState();
}

class _KycScreenNineState extends State<KycScreenNine> {
  var petTypes = [];

  bool isLoading = false;

  int _index = -1;

  String agentId = '';
  late AccountCubit _accountCubit;
 

  getServicesTypes() async {

    agentId = await StorageHandler.getUserId();
    _accountCubit = context.read<AccountCubit>();

    setState(() {
      isLoading = true;
    });
    await _accountCubit.getPetTypes();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getServicesTypes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<ServiceProviderViewModel>(context, listen: true);
    final userData = Provider.of<AccountViewModel>(context, listen: true);

    return Scaffold(
        body:  BlocConsumer<AccountCubit, AccountStates>(
        listener: (context, state) {
          if (state is AgentResLoaded) {
            Modals.showToast(state.agents.message!,
                messageType: MessageType.success);

            AppNavigator.pushAndStackPage(context, page: KycServiceScreenTen());
          } else if (state is PetTypesLoaded) {
            if (state.services.status!) {
               petTypes = state.services.data?.petTypes ?? [];
            } else {}
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
        builder: (context, state) => (state is AgentResLoading ||
                state is PetTypesLoading)
            ? Container(
                color: AppColors.lightPrimary,
                height: screenSize(context).height,
                width: screenSize(context).width,
                child: Center(child: LoadingPage()))
            : SingleChildScrollView(
                child: Container(
                  height: screenSize(context).height,
                  width: screenSize(context).width,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [AppColors.scaffoldColor, Colors.red.shade50],
                          begin: Alignment.topRight,
                          end: Alignment.topLeft)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SafeArea(
                            child: SizedBox(
                                height: (Platform.isAndroid) ? 30 : 0)),
                        CustomText(
                          textAlign: TextAlign.left,
                          maxLines: 2,
                          text: 'Pet type',
                          weight: FontWeight.w700,
                          size: 24,
                          fontFamily: AppStrings.montserrat,
                          color: Colors.black,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          margin: EdgeInsets.all(1),
                          child: StaggeredGridView.countBuilder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              crossAxisCount: 2,
                              crossAxisSpacing: 14,
                              mainAxisSpacing: 12,
                              itemCount: petTypes.length,
                              itemBuilder: (context, index) {
                                String petName = petTypes[index].name;
                                String petId = petTypes[index].sId;
                                return ServiceProviderChoice(
                                  isShowImage: false,
                                   imageUrl: '',
                                  serviceName: petName,
                                  isSelected:
                                      user.selectedPetType.contains(petId),
                                  onPressed: () {
                                    setState(() {
                                      _index = index;

                                      user.addPetServiceType(petId);

                                    });
                                  },
                                );
                              },
                              staggeredTileBuilder: (index) {
                                return StaggeredTile.count(1, 0.45);
                              }),
                        ),
                        Spacer(),
                        if (user.selectedPetType.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 0.0, horizontal: 0),
                            child: ButtonView(
                              onPressed: () {
                                _submit(context, user, userData);
                              },
                              color: AppColors.lightSecondary,
                              borderRadius: 22,
                              child: CustomText(
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                text: 'Select',
                                weight: FontWeight.w400,
                                size: 16,
                                fontFamily: AppStrings.interSans,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  _submit(BuildContext ctx, var user, var userData) {

    ctx.read<AccountCubit>().servicePetType(
          petId: user.selectedPetType,
          agentId: agentId,
          username: userData.username,
        );
  }
}

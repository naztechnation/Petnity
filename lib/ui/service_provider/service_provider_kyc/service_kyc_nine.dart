import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../../../blocs/accounts/account.dart';
import '../../../model/view_models/service_provider_view_model.dart';
import '../../../model/view_models/account_view_model.dart';
import '../../../requests/repositories/account_repo/account_repository_impl.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_constants.dart';
import '../../../res/app_images.dart';
import '../../../res/app_strings.dart';
import '../../../res/enum.dart';
import '../../../utils/navigator/page_navigator.dart';
import '../../user/user_kyc/widgets/service_provider_choice_container.dart';
import '../../widgets/button_view.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/loading_page.dart';
import '../../widgets/modals.dart';
import 'service_kyc_ten.dart';

class KycServiceScreenNine extends StatefulWidget {
  KycServiceScreenNine({super.key});

  @override
  State<KycServiceScreenNine> createState() => _KycServiceScreenNineState();
}

class _KycServiceScreenNineState extends State<KycServiceScreenNine> {
  int _index = -1;
  List<String> pets = [
    'Dogs ',
    'Cat',
    'Monkeys',
    'Squirrels',
    'Parrot',
    'Birds',
    'Rabbit',
  ];
  List<String> petsPics = [
    AppImages.dogsPic,
    AppImages.catPic,
    AppImages.monkeyPic,
    AppImages.squirrelPic,
    AppImages.parrotPic,
    AppImages.birdsPic,
    AppImages.rabbitPic,
  ];
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<ServiceProviderViewModel>(context, listen: true);
    final userData= Provider.of<AccountViewModel>(context, listen: true);
    userData.getUserId();

    return Scaffold(
        body: BlocProvider<AccountCubit>(
      lazy: false,
      create: (_) => AccountCubit(
          accountRepository: AccountRepositoryImpl(),
          viewModel: Provider.of<AccountViewModel>(context, listen: false)),
      child: BlocConsumer<AccountCubit, AccountStates>(
        listener: (context, state) {
          if (state is AgentResLoaded) {
            Modals.showToast(state.agents.message!,
                messageType: MessageType.success);

            AppNavigator.pushAndStackPage(context,
                                    page: KycServiceScreenTen());
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
        builder: (context, state) => (state is AgentResLoading)
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
                              itemCount: pets.length,
                              itemBuilder: (context, index) {
                                String petName = pets[index];
                                return ServiceProviderChoice(
                                  imageUrl: petsPics[index],
                                  serviceName: petName,
                                  isSelected:
                                      user.selectedPetType.contains(petName),
                                  onPressed: () {
                                    setState(() {
                                      _index = index;

                                      user.addPetServiceType(petName);
                                    
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
    ));
  }

  _submit(BuildContext ctx, var user, var userData) {
    ctx.read<AccountCubit>().servicePetType(
          petnames: user.selectedPetType, agentId: userData.serviceProviderId, username: userData.username,

        );
  }
}

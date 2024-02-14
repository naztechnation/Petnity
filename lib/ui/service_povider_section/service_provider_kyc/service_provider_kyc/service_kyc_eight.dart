import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:petnity/handlers/secure_handler.dart';
import 'package:petnity/ui/widgets/loading_page.dart';
import 'package:provider/provider.dart';

import '../../../../blocs/user/user.dart';
import '../../../../model/user_models/service_type.dart';
import '../../../../model/view_models/service_provider_view_model.dart';
import '../../../../model/view_models/account_view_model.dart';
import '../../../../model/view_models/user_view_model.dart';
import '../../../../requests/repositories/user_repo/user_repository_impl.dart';
import '../../../../res/app_colors.dart';
import '../../../../res/app_constants.dart';
import '../../../../res/app_routes.dart';
import '../../../../res/app_strings.dart';
import '../../../../res/enum.dart';
import '../../../../utils/navigator/page_navigator.dart';
import '../../../user/user_kyc/widgets/service_provider_choice_container.dart';
import '../../../widgets/button_view.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/modals.dart';
import 'service_kyc_nine.dart';

class KycServiceScreenEight extends StatelessWidget {
  final bool isRedo;
  const KycServiceScreenEight({Key? key, this.isRedo = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (BuildContext context) => UserCubit(
          userRepository: UserRepositoryImpl(),
          viewModel: Provider.of<UserViewModel>(context, listen: false)),
      child: KycServiceEight(
        isRedo: isRedo,
      ),
    );
  }
}

class KycServiceEight extends StatefulWidget {
  final bool isRedo;

  KycServiceEight({super.key, required this.isRedo});

  @override
  State<KycServiceEight> createState() => _KycServiceEightState();
}

class _KycServiceEightState extends State<KycServiceEight> {
  List<ServiceType> service = [];
  late UserCubit _userCubit;

  int _index = -1;

  String agentId = '';

  getUserDetails() async {
    agentId = await StorageHandler.getUserId();
  }

  @override
  void initState() {
    getUserDetails();
    _userCubit = context.read<UserCubit>();
    _userCubit.getServiceTypes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<ServiceProviderViewModel>(context, listen: true);
    final userData = Provider.of<AccountViewModel>(context, listen: true);
    final services = Provider.of<UserViewModel>(context, listen: true);
    
    return Scaffold(
        body: BlocProvider<UserCubit>(
      lazy: false,
      create: (_) => UserCubit(
          userRepository: UserRepositoryImpl(),
          viewModel: Provider.of<UserViewModel>(context, listen: false)),
      child: BlocConsumer<UserCubit, UserStates>(
        listener: (context, state) {
          if (state is ServiceProviderListLoaded) {
            if (state.userData.status ?? false) {
              Modals.showToast('Processed Successfully',
                  messageType: MessageType.success);
              if (widget.isRedo) {
                 AppNavigator.pushAndReplaceName(context,
            name: AppRoutes.serviceProviderLandingPage);
              } else {
                AppNavigator.pushAndStackPage(context,
                    page: KycServiceScreenNine());
              }
            } else {
              Modals.showToast('Something went wrong',
                  messageType: MessageType.error);
            }
          } else if (state is ServicesLoaded) {
            if (state.services.status ?? false) {
              service = _userCubit.viewModel.servicesType;
            } else {}
          } else if (state is UserNetworkErrApiErr) {
            if (state.message != null) {
              Modals.showToast(state.message ?? '', messageType: MessageType.error);
            }
          } else if (state is UserNetworkErr) {
            if (state.message != null) {
              Modals.showToast(state.message ?? '', messageType: MessageType.error);
            }
          }
        },
        builder: (context, state) => (state is ServiceProviderListLoading)
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
                          text: 'Select Service(s)',
                          weight: FontWeight.w700,
                          size: 20,
                          fontFamily: AppStrings.montserrat,
                          color: Colors.black,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomText(
                          textAlign: TextAlign.left,
                          maxLines: 2,
                          text: 'What service would you like to provide',
                          weight: FontWeight.w500,
                          size: 16,
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
                              itemCount: services.servicesType.length,
                              itemBuilder: (context, index) {
                                String serviceName =
                                    services.servicesType[index].name ?? '';
                                    String serviceId =
                                    services.servicesType[index].sId ?? '';
                                return ServiceProviderChoice(
                                  imageUrl:
                                      services.servicesType[index].image ?? '',
                                  serviceName: serviceName,
                                  isSelected: user.selectedServiceItems
                                      .contains(serviceId),
                                  onPressed: () {
                                    setState(() {
                                      user.addService(serviceId);
                                    });
                                  },
                                );
                              },
                              staggeredTileBuilder: (index) {
                                return StaggeredTile.count(1, 0.38);
                              }),
                        ),
                        Spacer(),
                        if (user.selectedServiceItems.isNotEmpty)
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
                                size: 15,
                                fontFamily: AppStrings.interSans,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        SizedBox(
                          height: 40,
                        )
                      ],
                    ),
                  ),
                ),
              ),
      ),
    ));
  }

  _submit(BuildContext ctx, var user, var userData) {

    ctx.read<UserCubit>().serviceProvided(
        services: user.selectedServiceItems,
        username: userData.username,
        agentId: agentId);
  }
}

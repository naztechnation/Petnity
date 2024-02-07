import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petnity/requests/repositories/service_provider_repo/service_provider_repository_impl.dart';
import 'package:petnity/res/enum.dart';
import 'package:provider/provider.dart';

import '../../../blocs/service_provider/service_provider.dart';
import '../../../handlers/secure_handler.dart';
import '../../../model/view_models/service_provider_inapp.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_constants.dart';
import '../../../res/app_strings.dart';
import '../../../utils/navigator/page_navigator.dart';
import '../../widgets/back_button.dart';
import '../../widgets/button_view.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/modals.dart';
import 'widgets/create_package_screen.dart';
import 'widgets/selected_container.dart';

class SelectPackageLevelAmount extends StatefulWidget {
  final String serviceType;
  final String serviceId;
  const SelectPackageLevelAmount(
      {super.key, required this.serviceType, required this.serviceId});

  @override
  State<SelectPackageLevelAmount> createState() => _SelectPackageLevelAmountState();
}

class _SelectPackageLevelAmountState extends State<SelectPackageLevelAmount> {

      String agentId = "";

  getAgentId() async{
    agentId = await StorageHandler.getAgentId();
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

    return Scaffold(
      body: BlocProvider<ServiceProviderCubit>(
        create: (BuildContext context) => ServiceProviderCubit(
            serviceProviderRepository: ServiceProviderRepositoryImpl(),
            viewModel: Provider.of<ServiceProviderInAppViewModel>(context,
                listen: false)),
        child: BlocConsumer<ServiceProviderCubit, ServiceProviderState>(
          listener: (context, state) {
            if (state is CreateServiceAmountLoaded) {
              if (state.serviceAmount.status!) {
                Modals.showToast(state.serviceAmount.message ?? '',
                    messageType: MessageType.success);

                AppNavigator.pushAndStackPage(context,
                    page: CreatePackageScreen(
                      serviceName: widget.serviceType,
                      serviceId: state.serviceAmount.data?.service?.sId ?? '',
                    ));
              } else {
                Modals.showToast(
                  state.serviceAmount.message ?? '',
                );
              }
            } else if (state is CreateServiceNetworkErrApiErr) {
              Modals.showSnackBar(state.message ?? '', context: context);
            } else if (state is CreateServiceNetworkErr) {}
          },
          builder: (context, state) => Container(
            height: screenSize(context).height,
            width: screenSize(context).width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [AppColors.scaffoldColor, Colors.red.shade50],
                    begin: Alignment.topRight,
                    end: Alignment.topLeft)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SafeArea(
                    child: SizedBox(height: (Platform.isAndroid) ? 30 : 0)),
                Row(
                  children: [
                    backButton(context),
                    const SizedBox(
                      width: 40,
                    ),
                    CustomText(
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      text: '${widget.serviceType}  packages',
                      weight: FontWeight.w800,
                      size: 16,
                      fontFamily: AppStrings.interSans,
                      color: Colors.black,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: CustomText(
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    text: 'select package level amount',
                    weight: FontWeight.w800,
                    size: 16,
                    fontFamily: AppStrings.interSans,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                SelectLevelContainer(),
                Spacer(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20),
                  child: ButtonView(
                    processing: state is CreateServiceAmountLoading,
                    onPressed: () {
                      _submit(context, serviceProvider);
                      
                    },
                    color: AppColors.lightSecondary,
                    borderRadius: 22,
                    borderColor: Colors.white,
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
                const SizedBox(
                  height: 60,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _submit(
    BuildContext ctx,
    var user,
  ) {
    ctx.read<ServiceProviderCubit>().setServiceAmount(
        agentId: agentId,
        serviceId: widget.serviceId,
        levelAmount: user.selectedIndex.toString());
  }
}

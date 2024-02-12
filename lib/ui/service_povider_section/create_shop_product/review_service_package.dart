import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../../../res/app_colors.dart';
import '../../../../../res/app_constants.dart';
import '../../../../../res/app_strings.dart'; 
import '../../../../model/view_models/account_view_model.dart';
import '../../../../res/app_images.dart';
import '../../../blocs/service_provider/service_provider.dart';
import '../../../handlers/secure_handler.dart';
import '../../../model/view_models/service_provider_inapp.dart';
import '../../../requests/repositories/service_provider_repo/service_provider_repository_impl.dart';
import '../../../utils/navigator/page_navigator.dart';
import '../../widgets/back_button.dart';
import '../../widgets/button_view.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/image_view.dart';
import '../../widgets/modals.dart';
import '../create_package/package_successful.dart';

class ReviewServicePackage extends StatefulWidget {
  final String serviceId;
   
  final String serviceName;
  final String serviceDescription;
  final String serviceDuration;
  final String servicePrice;
  const ReviewServicePackage(
      {super.key,
      required this.serviceId,
      
      required this.serviceName,
      required this.serviceDescription,
      required this.serviceDuration,
      required this.servicePrice});

  @override
  State<ReviewServicePackage> createState() => _PackagesState(
      serviceId,
      
      serviceName,
      serviceDescription,
      servicePrice,
      serviceDuration);
}

class _PackagesState extends State<ReviewServicePackage> {
  final String serviceId;
  
  final String serviceName;
  final String serviceDescription;
  final String serviceDuration;
  final String servicePrice;

  _PackagesState(this.serviceId,   this.serviceName,
      this.serviceDescription, this.servicePrice, this.serviceDuration);

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
        final agent = Provider.of<AccountViewModel>(context, listen: false);


    return BlocProvider<ServiceProviderCubit>(
      create: (BuildContext context) => ServiceProviderCubit(
          serviceProviderRepository: ServiceProviderRepositoryImpl(),
          viewModel: Provider.of<ServiceProviderInAppViewModel>(context,
              listen: false)),
      child: BlocConsumer<ServiceProviderCubit, ServiceProviderState>(
          listener: (context, state) {
            if (state is CreateServiceNetworkErr) {
              Modals.showToast(state.message ?? '');
            } else if (state is CreateServiceNetworkErrApiErr) {
              Modals.showToast(state.message ?? '');
            } else if (state is PublishPackageLoaded) {
              Modals.showToast(state.package.message ?? '');

                AppNavigator.pushAndReplacePage(context,
                    page: PackageSuccessful());
            }
          }
          ,
          builder: (context, state) {
            

            return Scaffold(
                body: Container(
              height: screenSize(context).height,
              width: screenSize(context).width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [AppColors.scaffoldColor, Colors.red.shade50],
                      begin: Alignment.topRight,
                      end: Alignment.topLeft)),
              child: Column(
                children: [
                  SafeArea(
                      child: Container(
                          color: AppColors.cardColor,
                          height: (Platform.isAndroid) ? 0 : 0)),
                  Container(
                    padding: const EdgeInsets.only(bottom: 0, top: 30),
                    child: Row(
                      children: [
                        backButton(context),
                        const SizedBox(
                          width: 40,
                        ),
                        CustomText(
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          text: 'Review packages',
                          weight: FontWeight.w700,
                          size: 20,
                          fontFamily: AppStrings.interSans,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: CustomText(
                                textAlign: TextAlign.left,
                                maxLines: 2,
                                text: 'Select package',
                                weight: FontWeight.w500,
                                size: 16,
                                fontFamily: AppStrings.interSans,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Container(
                                margin: const EdgeInsets.only(bottom: 20),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 20),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30)),
                                child: ListTile(
                                  leading:
                                      ImageView.asset(AppImages.beginnerPet),
                                  title: Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: CustomText(
                                      textAlign: TextAlign.left,
                                      maxLines: 2,
                                      text: serviceName,
                                      weight: FontWeight.w700,
                                      size: 14,
                                      fontFamily: AppStrings.interSans,
                                      color: Colors.black,
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      CustomText(
                                        textAlign: TextAlign.left,
                                        maxLines: 2,
                                        text: serviceDescription,
                                        weight: FontWeight.w500,
                                        size: 16,
                                        fontFamily: AppStrings.interSans,
                                        color: Colors.black,
                                      ),
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      CustomText(
                                        textAlign: TextAlign.left,
                                        maxLines: 2,
                                        text: 'NGN$servicePrice',
                                        weight: FontWeight.w400,
                                        size: 16,
                                        color: Colors.black,
                                      ),
                                      
                                      const SizedBox(
                                        height: 7,
                                      ),
                                       CustomText(
                                            textAlign: TextAlign.left,
                                            maxLines: 2,
                                            text: serviceDuration,
                                            weight: FontWeight.w400,
                                            size: 16,
                                            color: Colors.black,
                                          ),
                                    ],
                                  ),
                                )),
                                   SizedBox(
                              height: screenSize(context).height * 0.3,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0.0, horizontal: 20),
                              child: ButtonView(
                                processing: state is PublishPackageLoading,
                                onPressed: () {

                                 // Modals.showToast(agent.serviceId);
                                  _submit(context, '6597d14a64089012d0b505e7');
                                },
                                color: AppColors.lightSecondary,
                                borderRadius: 30,
                                borderColor: Colors.white,
                                child: CustomText(
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  text: 'Publish',
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
                ],
              ),
            ));
          }),
    );
  }

  _submit(
    BuildContext ctx,
    String id
  ) {
    ctx
        .read<ServiceProviderCubit>()
        .publishServicePackage(agentId: agentId, servicesId: serviceId);
  }
}

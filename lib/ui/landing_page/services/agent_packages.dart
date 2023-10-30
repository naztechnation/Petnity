import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petnity/utils/navigator/page_navigator.dart';
import 'package:provider/provider.dart';

import '../../../../res/app_colors.dart';
import '../../../../res/app_constants.dart';
import '../../../../res/app_strings.dart';
import '../../../blocs/user/user_cubit.dart';
import '../../../blocs/user/user_states.dart';
import '../../../model/account_models/agents_packages.dart';
import '../../../model/view_models/account_view_model.dart';
import '../../../model/view_models/user_view_model.dart';
import '../../../requests/repositories/user_repo/user_repository_impl.dart';
import '../../../res/app_images.dart';
import '../../../utils/app_utils.dart';
import '../../location/set_location_screen.dart';
import '../../widgets/back_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/empty_widget.dart';
import '../../widgets/image_view.dart';
import '../../widgets/loading_page.dart';




class PackagesScreen extends StatelessWidget {
  final String serviceId;
  final String agentId;

   
  const PackagesScreen(
      {super.key, required this.serviceId, required this.agentId, });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (BuildContext context) => UserCubit(
          userRepository: UserRepositoryImpl(),
          viewModel: Provider.of<UserViewModel>(context, listen: false)),
      child: PackagePage(
         serviceId: serviceId,agentId: agentId,
      ),
    );
  }
}

class PackagePage extends StatefulWidget {
  final String serviceId;
  final String agentId;
  const PackagePage({super.key, required this.serviceId, required this.agentId});

  @override
  State<PackagePage> createState() => _PackagesState(serviceId, agentId,);
}

class _PackagesState extends State<PackagePage> {
  final String serviceId;
  final String agentId;

  List<Packages> packages = [];

  late UserCubit _userCubit;

  _PackagesState(this.serviceId, this.agentId);

  @override
  void initState() {
    _userCubit = context.read<UserCubit>();
    _userCubit.getAgentPackages(serviceId: serviceId, agentId: agentId);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final agent = Provider.of<AccountViewModel>(context, listen: false);

    return BlocConsumer<UserCubit, UserStates>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is AgentPackagesLoading) {
                return LoadingPage();
              } else if (state is UserNetworkErr) {
                return EmptyWidget(
                  title: 'Network error',
                  description: state.message,
                  onRefresh: () => _userCubit.getAgentPackages(serviceId: serviceId, agentId: agentId),
                );
              } else if (state is UserNetworkErrApiErr) {
                return EmptyWidget(
                  title: 'Network error',
                  description: state.message,
                  onRefresh: () => _userCubit.getAgentPackages(serviceId: serviceId, agentId: agentId),
                );
              } else if (state is AgentPackagesLoaded) {
                packages = _userCubit.viewModel.packages ?? [];
              }

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
                    text: '${agent.selectedService} packages',
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
                      SizedBox(
                        height: screenSize(context).height,
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: packages.length,
                            itemBuilder: (__, index) {
                              return GestureDetector(
                                onTap: () {
                                  agent.setServicePrice('${packages[index].price}');
                                  agent.setServicePackage(packages[index].name ?? '');
                                  agent.setServiceDuration(packages[index].duration ?? '');
                                  agent.setPackageId(packages[index].id.toString());
                                AppNavigator.pushAndStackPage(context, page: SetLocationScreen());

                                },
                                child: Container(
                                    margin: const EdgeInsets.only(bottom: 20),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 20),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(30)),
                                    child: ListTile(
                                      leading: ImageView.asset(
                                          AppImages.beginnerPet),
                                      title: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8.0),
                                        child: CustomText(
                                          textAlign: TextAlign.left,
                                          maxLines: 3,
                                          text: packages[index].name,
                                          weight: FontWeight.w700,
                                          size: 14,
                                          fontFamily: AppStrings.interSans,
                                          color: Colors.black,
                                        ),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          
                                          
                                          const SizedBox(height: 7,),
                                          CustomText(
                                            textAlign: TextAlign.left,
                                            maxLines: 2,
                                            text: 'duration: ${packages[index].duration}',
                                            weight: FontWeight.w500,
                                            size: 16,
                                            fontFamily: AppStrings.interSans,
                                            color: Colors.black,
                                          ),
                                          const SizedBox(height: 7,),
                                          CustomText(
                                            textAlign: TextAlign.left,
                                            maxLines: 2,
                                            text: 'price: ₦${AppUtils.convertPrice(packages[index].price)}',
                                            weight: FontWeight.w500,
                                            size: 16,
                                            color: Colors.black,
                                          ),
                                          const SizedBox(height: 7,),
                                          CustomText(
                                            textAlign: TextAlign.left,
                                            maxLines: 2,
                                            text: packages[index].description,
                                            weight: FontWeight.w500,
                                            size: 16,
                                            fontFamily: AppStrings.interSans,
                                            color: Colors.black,
                                          ),
                                        ],
                                      ),
                                    )),
                              );
                            }),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ));
  });
  }
}

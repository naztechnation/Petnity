import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petnity/ui/widgets/button_view.dart';
import 'package:petnity/utils/navigator/page_navigator.dart';
import 'package:provider/provider.dart';

import '../../../blocs/user/user.dart';
import '../../../handlers/secure_handler.dart';
import '../../../model/agent/agent.dart';
import '../../../model/view_models/account_view_model.dart';
import '../../../model/view_models/service_provider_inapp.dart';
import '../../../model/view_models/user_view_model.dart';
import '../../../requests/repositories/user_repo/user_repository_impl.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_constants.dart';
import '../../../res/app_images.dart';
import '../../../res/app_strings.dart';
import '../../landing_page/services/agent_packages.dart';
import '../../landing_page/services/pet_sellers.dart/pet_on_sale.dart';
import '../../landing_page/services/pet_trainers/training_packages.dart';
import '../../landing_page/services/vets/vet_service.dart';
import '../../landing_page/services/widgets/gallery_rating_section.dart';
import '../../landing_page/services/widgets/providers_profile_body.dart';
import '../../widgets/back_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/empty_widget.dart';
import '../../widgets/image_view.dart';
import '../../widgets/loading_page.dart';
import '../../widgets/modals.dart';
import '../../widgets/profile_image.dart';

class AgentProfileScreen extends StatelessWidget {
  final String? agentId;
  const AgentProfileScreen({
    super.key,   this.agentId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (BuildContext context) => UserCubit(
          userRepository: UserRepositoryImpl(),
          viewModel: Provider.of<UserViewModel>(context, listen: false)),
      child: AgentProfile(agentId: agentId,),
    );
  }
}

class AgentProfile extends StatefulWidget {
  final String? agentId;

  AgentProfile({
    super.key, this.agentId,
  });

  @override
  State<AgentProfile> createState() => _AgentProfileState();
}

class _AgentProfileState extends State<AgentProfile> {
  final AccountViewModel userViewModel = AccountViewModel();

  Future<bool> onBackPress() {
    Navigator.pop(context);

    return Future.value(false);
  }

  Agent? agents;

  late UserCubit _userCubit;

  String agentId = "";
  String userType = '';
  bool isLoading = false;

  getAgentId() async {
    userType = await StorageHandler.getUserType();
   if (userType == 'user'){
      agentId = widget.agentId ?? '';
      
    }else{
    agentId = await StorageHandler.getAgentId();
        
    }
    setState(() {});
  }

  @override
  void initState() {
    getAgentId();

    _userCubit = context.read<UserCubit>();
    _userCubit.getAgentProfile();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final serviceProvider =
        Provider.of<ServiceProviderInAppViewModel>(context, listen: true);

    return WillPopScope(
        onWillPop: onBackPress,
        child: Scaffold(
          body: BlocConsumer<UserCubit, UserStates>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is ServiceProviderListLoading) {
                  return LoadingPage();
                } else if (state is UserNetworkErr) {
                  return Scaffold(
                    body: EmptyWidget(
                      title: 'Network error',
                      description: state.message,
                      onRefresh: () => _userCubit.getAgentProfile(),
                    ),
                  );
                } else if (state is UserNetworkErrApiErr) {
                  return EmptyWidget(
                    title: 'Network error',
                    description: state.message,
                    onRefresh: () => _userCubit.getAgentProfile(),
                  );
                } else if (state is ServiceProviderListLoaded) {
                  for (var item in state.userData.agents!) {
                    if (item.id.toString() == agentId) {
                      agents = item;
                      break;
                    }
                  }
                } else if (state is UploadAgentGalleryLoaded) {
                  serviceProvider.resetImage();
                  Modals.showToast(state.gallery.message!);
                  _userCubit.getAgentProfile();
                }

                return Stack(
                  children: [
                    Container(
                      height: screenSize(context).height,
                      width: screenSize(context).width,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                        AppColors.scaffoldColor,
                        Colors.red.shade50
                      ], begin: Alignment.topRight, end: Alignment.topLeft)),
                      child: Column(
                        children: [
                          SafeArea(
                              child: Container(
                                  color: AppColors.cardColor,
                                  height: (Platform.isAndroid) ? 0 : 0)),
                          Container(
                            color: AppColors.cardColor,
                            padding: const EdgeInsets.only(bottom: 20, top: 10),
                            child: Row(
                              children: [
                                backButton(context),
                                const SizedBox(
                                  width: 40,
                                ),
                                CustomText(
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  text: 'Service profile',
                                  weight: FontWeight.w700,
                                  size: 20,
                                  fontFamily: AppStrings.interSans,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 12,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ImageView.svg(AppImages.location),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Align(
                                      child: CustomText(
                                        textAlign: TextAlign.start,
                                        maxLines: 2,
                                        text:
                                            '${agents?.city}, ${agents?.country}',
                                        weight: FontWeight.w300,
                                        size: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                ProfileImage(
                                  '${agents?.picture}',
                                  placeHolder: AppImages.person,
                                  radius: 55,
                                  height: 120,
                                  width: 120,
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomText(
                                      textAlign: TextAlign.start,
                                      maxLines: 2,
                                      text: '${agents?.profile?.user?.username}',
                                      weight: FontWeight.w700,
                                      size: 14,
                                      fontFamily: AppStrings.interSans,
                                      color: Colors.black,
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    agents?.isVerified ?? false
                                        ? ImageView.svg(AppImages.verified)
                                        : SizedBox.shrink(),
                                  ],
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                CustomText(
                                  textAlign: TextAlign.start,
                                  maxLines: 2,
                                  text: agents?.isVerified ?? false
                                      ? 'Verified'
                                      : 'Not Verified',
                                  weight: FontWeight.w300,
                                  size: 11,
                                  fontFamily: AppStrings.interSans,
                                  color: agents?.isVerified ?? false
                                      ? Colors.green
                                      : Colors.red,
                                ),
                                const SizedBox(
                                  height: 12,
                                ),

                                ProviderProfileBody(
                                  agents: agents,
                                ),
                                //
                                GalleryRatingSection(userId: agentId),
                                const SizedBox(
                                  height: 150,
                                ),
                              ],
                            )),
                          ),
                        ],
                      ),
                    ),
                    if (userType != 'user')
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 40),
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (serviceProvider.imageURl1 != null)
                                GestureDetector(
                                  onTap: () {
                                    serviceProvider.resetImage();
                                  },
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 26.0),
                                      child: const Text(
                                        'Cancel',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            color: AppColors.lightSecondary,
                                            fontFamily: AppStrings.interSans,
                                            fontWeight: FontWeight.w900),
                                      ),
                                    ),
                                  ),
                                ),
                              if (serviceProvider.imageURl1 != null)
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    height: 130,
                                    width: 130,
                                    child: ImageView.file(
                                      File(serviceProvider.imageURl1!.path),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0,
                                ),
                                child: ButtonView(
                                  borderRadius: 30,
                                  processing: (isLoading ||
                                      state is UploadAgentGalleryLoading),
                                  onPressed: () async {
                                    String imgUrl = '';
                                    if (serviceProvider.imageURl1 != null) {
                                      setState(() {
                                        isLoading = true;
                                      });

                                      imgUrl =
                                          await serviceProvider.uploadImage(
                                              serviceProvider.imageURl1!.path,
                                              'petnity_service_provider');
                                      setState(() {
                                        isLoading = false;
                                      });
                                      if (imgUrl != null || imgUrl != "") {
                                        submit(context, imgUrl);
                                      }
                                    } else {
                                      serviceProvider.loadImage(
                                          context: context, isProfile: true);
                                    }
                                  },
                                  child: CustomText(
                                    textAlign: TextAlign.start,
                                    maxLines: 2,
                                    text: (serviceProvider.imageURl1 == null)
                                        ? 'Add photo'
                                        : 'Upload photo',
                                    weight: FontWeight.w500,
                                    size: 15,
                                    // fontFamily: AppStrings.interSans,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                  ],
                );
              }),
        ));
  }

  submit(BuildContext context, String imageURl) {
    context.read<UserCubit>().uploadGallery(agentId: agentId, image: imageURl);
  }
}

openServices(String services, BuildContext context) {
  switch (services) {
    case '':
      break;
    case 'dog walkers':
      AppNavigator.pushAndStackPage(context,
          page: PackagesScreen(
            serviceId:
                Provider.of<AccountViewModel>(context, listen: false).serviceId,
            agentId:
                Provider.of<AccountViewModel>(context, listen: false).agentId2,
          ));

      break;
    case 'pet date':
      break;
    case 'dog sitters':
      AppNavigator.pushAndStackPage(context,
          page: PackagesScreen(
            serviceId:
                Provider.of<AccountViewModel>(context, listen: false).serviceId,
            agentId:
                Provider.of<AccountViewModel>(context, listen: false).agentId2,
          ));

      break;
    case 'trainer':
      AppNavigator.pushAndStackPage(context, page: TrainingScreen());
      break;
    case 'vets':
      AppNavigator.pushAndStackPage(context, page: VetService());
      break;
    case 'grooming':
      break;
    case 'breeders':
      break;
    case 'pet sellers':
      AppNavigator.pushAndStackPage(context, page: PetsOnSale());

      break;
    case 'boarding':
      break;
    case 'pet care givers':
      break;

    default:
    //AppNavigator.pushAndStackPage(context, page: SetLocationScreen());
  }
}

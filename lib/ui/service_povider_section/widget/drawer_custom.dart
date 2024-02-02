import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_images.dart';
import 'package:petnity/res/app_strings.dart';
import 'package:petnity/ui/notfications_pages/notifications_session.dart';
import 'package:petnity/ui/profile/profile.dart' as profile;
import 'package:petnity/ui/settings/settings.dart';
import 'package:petnity/ui/support/support.dart';
import 'package:petnity/ui/widgets/custom_text.dart';
import 'package:petnity/ui/widgets/image_view.dart';
import 'package:provider/provider.dart';

import '../../../../utils/navigator/page_navigator.dart';
import '../../../blocs/user/user.dart';
import '../../../handlers/secure_handler.dart';
import '../../../model/agent/agent.dart';
import '../../../model/services/services.dart';
import '../../../model/user_models/service_provider_lists.dart';
import '../../../model/user_models/service_type.dart';
import '../../../model/view_models/user_view_model.dart';
import '../../../requests/repositories/user_repo/user_repository_impl.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_routes.dart';
import '../../landing_page/services/services_lists.dart';
import '../../payment/payment_screen.dart';
import '../service_profile/service_profile.dart';
import '../service_provider_kyc/service_provider_kyc/service_kyc_eight.dart';

class SPCustomDrawer extends StatelessWidget {
  const SPCustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (BuildContext context) => UserCubit(
          userRepository: UserRepositoryImpl(),
          viewModel: Provider.of<UserViewModel>(context, listen: false)),
      child: CustomDrawer(),
    );
  }
}

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  List<Services> service = [];

  late UserCubit _userCubit;

  bool isLoading = false;
  String agentId = "";
  Agent? agents;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signOut(BuildContext context) async {
    try {
      await _auth.signOut();
      AppNavigator.pushAndReplaceName(context, name: AppRoutes.signInScreen);
    } catch (e) {
      print("Error signing out: $e");
    }
  }

  List<Services> services = [];

  getServicesTypes() async {
    _userCubit = context.read<UserCubit>();

    try {
      agentId = await StorageHandler.getUserId();
      await _userCubit.getServiceTypes();
      await _userCubit.getAgentProfile(agentId);
    } catch (e) {}
  }

  String userType = '';
  String picture = '';

  getUserType() async {
    userType = await StorageHandler.getUserType();
    picture = await StorageHandler.getUserPicture();
  }

  @override
  void initState() {
    getUserType();
    getServicesTypes();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserStates>(
      listener: (context, state) {
        if (state is ServicesLoaded) {
          if (state.services.status!) {
            service = _userCubit.viewModel.services;
          } else {}
        } else if (state is ServiceProviderListLoaded) {
          ///TODO
          // for (var item in state.userData.agents!) {
          //   if (item.sId.toString() == agentId) {
          //     agents = item;
          //     break;
          //   }
          // }
          services = agents?.services ?? [];
        } else if (state is UserNetworkErrApiErr) {
        } else if (state is UserNetworkErr) {}
      },
      builder: (context, state) => Drawer(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                SafeArea(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 0),
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.close)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Center(
                          child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(80),
                            ),
                            child: Container(
                              width: 120,
                              height: 120,
                              margin: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(60),
                                    child: ImageView.network(
                                      picture,
                                      //userProfile?.profile?.profileImage,
                                      height: 120,
                                      width: 120,
                                      fit: BoxFit.cover,
                                    )),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);

                          if (userType == 'user') {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return profile.Profile();
                            }));
                          } else {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return AgentProfileScreen();
                            }));
                          }
                        },
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 13,
                            ),
                            ImageView.svg(
                              AppImages.personIcon,
                              width: 25,
                              height: 25,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Profile',
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);

                          AppNavigator.pushAndStackPage(context,
                              page: NotificationsScreen());
                        },
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 13,
                            ),
                            ImageView.svg(
                              AppImages.messageIcon,
                              width: 25,
                              height: 25,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Notifications',
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);

                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return Support();
                          }));
                        },
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 13,
                            ),
                            ImageView.svg(
                              AppImages.supportIcon,
                              width: 25,
                              height: 25,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Support',
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);

                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return PaymentPage(
                              mainPage: true,
                            );
                          }));
                        },
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 13,
                            ),
                            ImageView.asset(
                              AppImages.walletIcon,
                              width: 25,
                              height: 25,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Balance & Withdrawal',
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);

                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return SettingsScreen();
                          }));
                        },
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 13,
                            ),
                            ImageView.svg(
                              AppImages.settingsIcon,
                              width: 25,
                              height: 25,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Settings',
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);

                          showModalBottomSheet(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  topRight: Radius.circular(20.0),
                                ),
                              ),
                              isDismissible: true,
                              context: context,
                              builder: (context) {
                                return Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20)),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 20),
                                  height: screenSize(context).height * .8,
                                  child: SingleChildScrollView(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomText(
                                            text: 'Your services',
                                            weight: FontWeight.bold,
                                            size: 17,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              AppNavigator.pushAndStackPage(
                                                  context,
                                                  page: KycServiceScreenEight(
                                                    isRedo: true,
                                                  ));
                                            },
                                            child: Row(
                                              children: [
                                                ImageView.svg(
                                                  AppImages.addIcon,
                                                  height: 15,
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                CustomText(
                                                  text: 'add more',
                                                  weight: FontWeight.w400,
                                                  size: 14,
                                                  color:
                                                      AppColors.lightSecondary,
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      CustomText(
                                        size: 14,
                                        text: 'Create Service',
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      (state is ServiceProviderListLoading)
                                          ? Align(
                                              child: ImageView.asset(
                                              AppImages.loading,
                                              height: 50,
                                            ))
                                          : ServicesList(
                                              services: services,
                                            ),
                                    ],
                                  )),
                                );
                              });
                        },
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 13,
                            ),
                            Container(
                              width: screenSize(context).width * .1,
                              child: Stack(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Color(0xFFD9D9D9),
                                    radius: 14,
                                  ),
                                  Positioned(
                                      left: 8,
                                      child: Container(
                                        width: screenSize(context).width * .069,
                                        height:
                                            screenSize(context).height * .035,
                                        decoration: BoxDecoration(
                                            color: Color(0xFFD9D9D9),
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            border: Border.all(
                                                color: Colors.white)),
                                      ))
                                ],
                              ),
                            ),
                            Text(
                              'Add other Services',
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: screenSize(context).height * .1,
                ),
                ListTile(
                  onTap: () {
                    _signOut(context);
                  },
                  minLeadingWidth: 0,
                  leading: ImageView.svg(
                    AppImages.logoutIcon,
                    width: 25,
                    height: 25,
                  ),
                  title: Align(
                    alignment: Alignment(-1.1, 0),
                    child: Text(
                      'Log out',
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontFamily: AppStrings.interSans),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

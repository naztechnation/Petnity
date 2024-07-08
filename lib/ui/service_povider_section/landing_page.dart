import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_strings.dart';
import 'package:petnity/ui/service_povider_section/service_provider_home/service_provider_home.dart';
import 'package:petnity/ui/notfications_pages/notifications_session.dart';
import 'package:petnity/ui/widgets/image_view.dart';
import 'package:petnity/ui/widgets/notification_icon.dart';
import 'package:provider/provider.dart';

import '../../../res/app_images.dart';
import '../../../utils/navigator/page_navigator.dart';
import '../../blocs/accounts/account.dart';
import '../../blocs/user/user.dart';
import '../../handlers/secure_handler.dart';
import '../../model/agent/agent.dart';
import '../../model/user_models/service_type.dart';
import '../../model/view_models/account_view_model.dart';
import '../../model/view_models/user_view_model.dart';
import '../../requests/repositories/account_repo/account_repository_impl.dart';
import '../landing_page/services/services_lists.dart';
import '../payment/payment_screen.dart';
import '../widgets/custom_text.dart';
import 'create_shop_product/create_shop_products.dart';
import 'service_catalogue.dart';
import 'service_provider_kyc/service_provider_kyc/service_kyc_eight.dart';
import 'widget/drawer_custom.dart';

class ServiceProviderLandingPage extends StatefulWidget {
  @override
  _ServiceProviderLandingPageState createState() =>
      _ServiceProviderLandingPageState();
}

class _ServiceProviderLandingPageState
    extends State<ServiceProviderLandingPage> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    ServiceProviderHomePage(),
    ServiceProviderCatalogueScreen(),
    PaymentPage(
      mainPage: false,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SPCustomDrawer(),
      backgroundColor: AppColors.lightBackground,
      appBar: PreferredSize(
        preferredSize: _selectedIndex == 0
            ? screenSize(context) * .09
            : screenSize(context) * .09,
        child: Padding(
          padding: const EdgeInsets.only(top: 5, right: 20),
          child: _selectedIndex == 0
              ? HomepageAppbar()
              : _selectedIndex == 1
                  ? simpleAppbar(
                      'Shop Products',
                      centered: false,
                      GestureDetector(
                        onTap: () {
                          AppNavigator.pushAndStackPage(context,
                              page: CreateShopProducts());
                        },
                        child: Row(
                          children: [
                            ImageView.svg(
                              AppImages.addIcon,
                              height: 20,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Add product',
                              style: TextStyle(fontSize: 12),
                            )
                          ],
                        ),
                      ))
                  : _selectedIndex == 2
                      ? simpleAppbar('Payments', Text(''))
                      : Container(),
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        width: screenSize(context).width,
        color: Colors.white,
        height: 120,
        child: Column(
          children: [
            SizedBox(
              width: 300,
              height: 120,
              child: BottomNavigationBar(
                backgroundColor: Colors.white,
                elevation: 0,
                type: BottomNavigationBarType.fixed,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: ImageView.svg(
                      AppImages.activities,
                      height: 20,
                      width: 20,
                      color: Colors.black,
                    ),
                    activeIcon: ImageView.svg(
                      AppImages.activities,
                      height: 20,
                      width: 20,
                      color: AppColors.lightSecondary,
                    ),
                    label: 'Activities',
                  ),
                  BottomNavigationBarItem(
                    icon: ImageView.svg(
                      AppImages.coupon,
                      height: 20,
                      width: 20,
                      color: Colors.black,
                    ),
                    activeIcon: ImageView.svg(
                      AppImages.coupon,
                      height: 20,
                      width: 20,
                      color: AppColors.lightSecondary,
                    ),
                    label: 'Catalogue',
                  ),
                  BottomNavigationBarItem(
                    icon: ImageView.svg(
                      AppImages.creditcard,
                      height: 20,
                      width: 20,
                    ),
                    activeIcon: ImageView.svg(
                      AppImages.creditcard,
                      height: 20,
                      width: 20,
                      color: AppColors.lightSecondary,
                    ),
                    label: 'Payment',
                  ),
                ],
                currentIndex: _selectedIndex,
                unselectedItemColor: Colors.black,
                selectedItemColor: AppColors.lightSecondary,
                unselectedFontSize: 15,
                selectedFontSize: 15,
                iconSize: 16,
                selectedLabelStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontFamily: AppStrings.interSans),
                unselectedLabelStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontFamily: AppStrings.interSans),
                onTap: _onItemTapped,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          AppNavigator.pushAndStackPage(context, page: NotificationsScreen()),
      child: Container(
        child: Center(
          child: Text(
            'Services',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}

class HomepageAppbar extends StatelessWidget {
  const HomepageAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AccountCubit>(
      create: (BuildContext context) => AccountCubit(
          accountRepository: AccountRepositoryImpl(),
          viewModel: Provider.of<AccountViewModel>(context, listen: false)),
      child: HomepageBar(),
    );
  }
}

class HomepageBar extends StatefulWidget {
  @override
  State<HomepageBar> createState() => _HomepageBarState();
}

class _HomepageBarState extends State<HomepageBar> {
  // List<ServiceType> service = [];

  late AccountCubit _userCubit;

  bool isLoading = false;
  String password = '';
  String email = '';
  String agentId = "";
  String deviceId= "";

  List<ServiceType> services = [];

  Agent? agents;

  getServicesTypes() async {
    agentId = await StorageHandler.getAgentId();
    email = await StorageHandler.getUserEmail();
    password = await StorageHandler.getUserPassword();
    deviceId = await StorageHandler.getFirebaseToken();

    _userCubit = context.read<AccountCubit>();

    try {
      await _userCubit.loginUser(password: password, email: email, deviceId: deviceId);
      // await _userCubit.getAgentProfile(agentId);
    } catch (e) {}
  }

  @override
  void initState() {
    getServicesTypes();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserViewModel>(context, listen: false);

    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.lightBackground,
      iconTheme: IconThemeData(color: Colors.black),
      centerTitle: true,
      title:  BlocConsumer<AccountCubit, AccountStates>(
          listener: (context, state) {
            if (state is AccountLoaded) {
              if (state.userData.status ?? false) {
                if (state.userData.data?.user == null) {
                  if (state.userData.data?.agent?.user?.isAgent ?? false) {
                    StorageHandler.saveIsUserType('service_provider');
                    StorageHandler.saveUserToken(state.userData.data?.token);

                    StorageHandler.saveAgentId(state.userData.data?.agent?.sId);
                    StorageHandler.saveUserId(
                        state.userData.data?.agent?.user?.sId.toString());

                    StorageHandler.saveEmail(
                        state.userData.data?.agent?.user?.email.toString());
                    StorageHandler.saveUserPhone(state
                        .userData.data?.agent?.user?.phoneNumber
                        .toString());
                    StorageHandler.saveUserPicture(state
                        .userData.data?.agent?.user?.profileImage
                        .toString());

                    StorageHandler.saveUserName(
                        state.userData.data?.agent?.user?.username.toString());

                    user.setServicesTypeList(
                        services: state.userData.data?.agent?.services ?? []);

                    if (state.userData.data?.agent?.user?.hasPets ?? false) {
                      StorageHandler.saveUserPetState('true');
                    } else {
                      StorageHandler.saveUserPetState('');
                    }
                  }
                }
              }
            } else if (state is AccountApiErr) {
              if (state.message != null) {}
            } else if (state is AccountNetworkErr) {
              if (state.message != null) {}
            }
          },
          builder: (context, state) => GestureDetector(
              onTap: () {
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        height: screenSize(context).height * .8,
                        child: SingleChildScrollView(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: 'Your services'.toUpperCase(),
                                  weight: FontWeight.bold,
                                  size: 16,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    AppNavigator.pushAndStackPage(context,
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
                                        color: AppColors.lightSecondary,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              color: Colors.grey.shade300,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            CustomText(
                              size: 14,
                              text: 'Create Service Package',
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
                                    vetServiceId: '',
                                  ),
                          ],
                        )),
                      );
                    });
              },
              child: Card(
                elevation: 0.5,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width *0.45,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ImageView.svg(
                          AppImages.addIcon,
                          height: 22,
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        Text('Create Package'),
                      ],
                    ),
                  ),
                ),
              )),
        ),
         
     
      actions: [
          GestureDetector(
          onTap: () {
            AppNavigator.pushAndStackPage(context, page: NotificationsScreen());
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: NotificationIcon(
                icon: ImageView.svg(
                  AppImages.notificationIcon,
                  height: 25,
                ),
                nun_of_notifications: 5),
          ),
        ),
      ],
    );
  }
}

class simpleAppbar extends StatelessWidget {
  final Widget action;
  final String title;
  final bool centered;
  simpleAppbar(this.title, this.action, {this.centered = true});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.lightBackground,
      iconTheme: IconThemeData(color: Colors.black),
      title: Text(
        title,
        style: TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
      ),
      centerTitle: centered,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: action,
        )
      ],
    );
  }
}

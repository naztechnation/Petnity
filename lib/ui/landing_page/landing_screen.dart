import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_strings.dart';
import 'package:petnity/ui/landing_page/services/pet_profile/pet_profile.dart';
import 'package:petnity/ui/landing_page/widgets/custom_drawer.dart';
import 'package:petnity/ui/notfications_pages/notifications_session.dart';
import 'package:petnity/ui/widgets/image_view.dart';
import 'package:petnity/ui/widgets/loading_page.dart';
import 'package:petnity/ui/widgets/notification_icon.dart';
import 'package:provider/provider.dart';
import '../../blocs/accounts/account.dart';
import '../../handlers/secure_handler.dart';
import '../../model/view_models/account_view_model.dart';
import '../../requests/repositories/account_repo/account_repository_impl.dart';
import '../../res/app_routes.dart';
import '../../res/enum.dart';
import '../widgets/modals.dart';
import 'services/services_screen.dart';
import 'shop_screen/shop_screen.dart';

import '../../res/app_images.dart';
import '../../utils/navigator/page_navigator.dart';

import 'homepage.dart';
import 'track_purchase/track_purchase.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  // int _selectedIndex = 0;

  String username = '';
  String password = '';

  List<Widget> _widgetOptions = [];

  getUserDetails() async {
    username = await StorageHandler.getUserName();
    password = await StorageHandler.getUserPassword();

    setState(() {
      _widgetOptions = <Widget>[
        HomePage(),
        ServicesScreen(),
        ShopScreen(),
        TrackPurchase(
          username: username,
        ),
      ];
    });
  }

  @override
  void initState() {
    getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AccountViewModel>(context, listen: true);

    return BlocProvider<AccountCubit>(
        lazy: false,
        create: (_) => AccountCubit(
            accountRepository: AccountRepositoryImpl(),
            viewModel: Provider.of<AccountViewModel>(context, listen: false)),
        child: BlocConsumer<AccountCubit, AccountStates>(
          listener: (context, state) {
            if (state is AccountLoaded) {
              if (state.userData.status!) {
                Modals.showToast(state.userData.message!,
                    messageType: MessageType.success);

                user.deleteUser();
                AppNavigator.pushAndReplaceName(context,
                    name: AppRoutes.signInScreen);
              } else {
                Modals.showToast(state.userData.message!,
                    messageType: MessageType.error);
              }
            } else if (state is AccountApiErr) {
              if (state.message != null) {
                Modals.showToast(state.message!,
                    messageType: MessageType.error);
              }
            } else if (state is AccountNetworkErr) {
              if (state.message != null) {
                Modals.showToast(state.message!,
                    messageType: MessageType.error);
              }
            }
          },
          builder: (context, state) => (state is AccountLoading)
              ? Scaffold(
                  body: LoadingPage(),
                )
              : Scaffold(
                  drawer: customDrawer(
                    onLogOutPressesd: () {
                      user.deleteUser();
                      AppNavigator.pushAndReplaceName(context,
                          name: AppRoutes.signInScreen);
                    },
                  ),
                  backgroundColor: AppColors.lightBackground,
                  appBar: PreferredSize(
                    preferredSize: user.selectedIndex == 0
                        ? screenSize(context) * .09
                        : screenSize(context) * .09,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: user.selectedIndex == 0
                          ? HomepageAppbar()
                          : user.selectedIndex == 1
                              ? simpleAppbar('Services', Container())
                              : user.selectedIndex == 2
                                  ? simpleAppbar(
                                      'Shop Products',
                                      GestureDetector(
                                        onTap: () {
                                          AppNavigator.pushAndStackPage(context,
                                              page: NotificationsScreen());
                                        },
                                        child: NotificationIcon(
                                          icon: ImageView.svg(
                                            AppImages.bell,
                                          ),
                                          nun_of_notifications: 5,
                                        ),
                                      ))
                                  : user.selectedIndex == 3
                                      ? simpleAppbar(
                                          'Track Purchase',
                                          InkWell(
                                            onTap: () {},
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 15.0, top: 25),
                                              child: Text(
                                                'History',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.blue),
                                              ),
                                            ),
                                          ))
                                      : Container(),
                    ),
                  ),
                  body: Center(
                    child: _widgetOptions.elementAt(user.selectedIndex),
                  ),
                  bottomNavigationBar: SizedBox(
                    height: 88,
                    child: BottomNavigationBar(
                      type: BottomNavigationBarType.fixed,
                      items: const <BottomNavigationBarItem>[
                        BottomNavigationBarItem(
                          icon: ImageView.svg(
                            AppImages.homeIcon,
                            height: 20,
                            width: 20,
                          ),
                          activeIcon: ImageView.svg(
                            AppImages.homeIcon,
                            height: 20,
                            width: 20,
                            color: AppColors.lightSecondary,
                          ),
                          label: 'Home',
                        ),
                        BottomNavigationBarItem(
                          icon: ImageView.svg(
                            AppImages.userIcon,
                            height: 20,
                            width: 20,
                          ),
                          activeIcon: ImageView.svg(
                            AppImages.userIcon,
                            height: 20,
                            width: 20,
                            color: AppColors.lightSecondary,
                          ),
                          label: 'Services',
                        ),
                        BottomNavigationBarItem(
                          icon: ImageView.svg(
                            AppImages.bagIcon,
                            height: 20,
                            width: 20,
                          ),
                          activeIcon: ImageView.svg(
                            AppImages.bagIcon,
                            height: 20,
                            width: 20,
                            color: AppColors.lightSecondary,
                          ),
                          label: 'Shop',
                        ),
                        BottomNavigationBarItem(
                          icon: ImageView.svg(
                            AppImages.trackIcon,
                            height: 20,
                            width: 20,
                          ),
                          activeIcon: ImageView.svg(
                            AppImages.trackIcon,
                            height: 20,
                            width: 20,
                            color: AppColors.lightSecondary,
                          ),
                          label: 'Track',
                        ),
                      ],
                      currentIndex: user.selectedIndex,
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
                      onTap: (index) {
                        user.changeSelectedIndex(index);
                      },
                    ),
                  ),
                ),
        ));
  }

  _submit(BuildContext ctx, String username, String password) {
    if (username != '' && password != '') {
      ctx
          .read<AccountCubit>()
          .logoutUser(username: username, password: password);
    }
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
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.lightBackground,
      iconTheme: IconThemeData(color: Colors.black),
      actions: [
        GestureDetector(
           onTap: () {
                                          AppNavigator.pushAndStackPage(context,
                                              page: NotificationsScreen());
                                        },
          child: NotificationIcon(
              icon: ImageView.svg(AppImages.notificationIcon),
              nun_of_notifications: 5),
        ),
        const SizedBox(
          width: 20,
        ),
        GestureDetector(
          child: ClipOval(
            child: AspectRatio(
              aspectRatio: 1,
              child: ImageView.network(
                'https:',
                width: 30.0,
                height: 30.0,
                scale: 1,
                fit: BoxFit.cover,
              ),
            ),
          ),
          onTap: () => AppNavigator.pushAndStackPage(
            context,
            page: PetProfile(),
          ),
        ),
        const SizedBox(
          width: 12,
        ),
      ],
    );
  }
}

class simpleAppbar extends StatelessWidget {
  final Widget action;
  final String title;
  simpleAppbar(this.title, this.action);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.lightBackground,
      iconTheme: IconThemeData(color: Colors.black),
      title: Text(
        title,
        style: TextStyle(
            fontFamily: AppStrings.interSans,
            color: Colors.black,
            fontWeight: FontWeight.w500),
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: action,
        )
      ],
    );
  }
}

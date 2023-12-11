import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/ui/widgets/back_button.dart';
import 'package:petnity/ui/widgets/button_view.dart';
import 'package:petnity/utils/navigator/page_navigator.dart';
import 'package:provider/provider.dart';

import '../../blocs/user/user.dart';
import '../../handlers/secure_handler.dart';
import '../../model/view_models/user_view_model.dart';
import '../../requests/repositories/user_repo/user_repository_impl.dart';
import '../../res/app_images.dart';
import '../../res/app_routes.dart';
import '../../res/app_strings.dart';
import '../auth/forgot_password.dart';
import '../widgets/image_view.dart';
import '../widgets/modals.dart';
import 'add_account_details.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (BuildContext context) => UserCubit(
          userRepository: UserRepositoryImpl(),
          viewModel: Provider.of<UserViewModel>(context, listen: false)),
      child: Settings(),
    );
  }
}

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool switchValue1 = false;
  bool switchValue2 = false;
  String userType = '';

  late UserCubit _userCubit;

  String username = '';

  getUserDetails() async {
    userType = await StorageHandler.getUserType();
    username = await StorageHandler.getUserName();
    _userCubit = context.read<UserCubit>();

    setState(() {});
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signOut(BuildContext context) async {
    try {
      await _auth.signOut();
      AppNavigator.pushAndReplaceName(context, name: AppRoutes.signInScreen);
    } catch (e) {
      print("Error signing out: $e");
    }
  }


void deleteAccount(BuildContext context) async {
  try {
    User? user = FirebaseAuth.instance.currentUser;
    
    if (user != null) {
      await user.delete();
      _signOut(context);

      print("User account deleted successfully!");
    } else {
      print("No user signed in.");
    }
  } catch (e) {
    print("Error deleting user account: $e");
  }
}
  @override
  void initState() {
    getUserDetails();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.lightBackground,
        bottomNavigationBar: Container(
          height: 40,
          child: Center(
            child: InkWell(
              onTap: () => _showBottom(context),
              child: Text(
                'Delete Account',
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        appBar: PreferredSize(
          preferredSize: screenSize(context) * .1,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: AppBar(
              centerTitle: true,
              title: Text(
                'Settings',
                style: TextStyle(
                    fontSize: 19.0,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                    fontFamily: AppStrings.interSans),
              ),
              leading: backButton(context),
              elevation: 0,
              backgroundColor: Colors.transparent,
              iconTheme: IconThemeData(color: Colors.black),
            ),
          ),
        ),
        body: ListView.builder(
          itemCount: 8,
          itemBuilder: (context, index) {
            if (index == 0) {
              if (userType == 'user') {
                return SizedBox.shrink();
              } else {
                return TileWidget(
                    title: 'Add account details',
                    icon: Icon(Icons.account_balance),
                    onpressed: () {
                      AppNavigator.pushAndStackPage(context,
                          page: AddAccountDetails());
                    });
              }
            } else if (index == 1) {
              return TileWidget(
                  title: 'Change Password',
                  icon: Icon(Icons.lock),
                  onpressed: () {
                    AppNavigator.pushAndStackPage(context,
                        page: ForgotPasswordScreen());
                  });
            } else if (index == 2) {
              return TileWidget(
                  title: 'Change Number',
                  icon: Icon(Icons.change_circle),
                  onpressed: () {
                    Navigator.pushNamed(context, 'changeEmailandNumber');
                  });
            } else if (index == 3) {
              return TileWidget(
                  title: 'FAQ',
                  icon: Icon(Icons.question_mark),
                  onpressed: () {
                    Navigator.pushNamed(context, 'faqs');
                  });
            } else if (index == 4) {
              return TileWidget(
                  title: 'Privacy Policy',
                  icon: Icon(Icons.privacy_tip),
                  onpressed: () {
                    Navigator.pushNamed(context, 'privacyPolicy');
                  });
            }
          },
        ),
      ),
    );
  }

  Widget TileWidget(
      {required String title,
      required Widget icon,
      required VoidCallback onpressed}) {
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontFamily: AppStrings.interSans),
        ),
        leading: icon,
        onTap: onpressed,
      ),
    );
  }

  Widget TileWidgetWithSwitch(
      {required String title,
      required Widget icon,
      required Widget switchh,
      required Function onpressed}) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: ListTile(
          title: Text(
            title,
            style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontFamily: AppStrings.interSans),
          ),
          leading: icon,
          onTap: () => onpressed,
          trailing: switchh),
    );
  }

  _showBottom(BuildContext contxt) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      builder: (context) {
        return BlocProvider<UserCubit>(
          lazy: false,
          create: (_) => UserCubit(
              userRepository: UserRepositoryImpl(),
              viewModel: Provider.of<UserViewModel>(context, listen: false)),
          child: BlocConsumer<UserCubit, UserStates>(listener: (contxt, state) {
            if (state is DeleteUserLoaded) {
              if (state.deleteUserData.status ?? false) {
                Modals.showToast(state.deleteUserData.message ?? '');
                deleteAccount(context,);
              } else {
                Modals.showToast('Account not deleted');
              }
            } else if (state is UserNetworkErrApiErr) {
              Modals.showToast(state.message ?? '');
            } else if (state is UserNetworkErr) {
              Modals.showToast(state.message ?? '');
            }
          }, builder: (contxt, state) {
            return Container(
              padding: EdgeInsets.all(20),
              height: screenSize(context).height * .3,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Are you sure you want to delete?',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    if (state is DeleteUserLoading) ...[
                      Align(
                          child: ImageView.asset(
                        AppImages.loading,
                        height: 50,
                      )),
                    ] else ...[
                      Column(
                        children: [
                          Container(
                            width: screenSize(context).width * .4,
                            child: Center(
                              child: InkWell(
                                onTap: () {
                                  // Modals.showToast(username);

                                  contxt.read<UserCubit>().deleteUserAccount(username);
                                },
                                child: Text(
                                  'Yes, proceed',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                              width: screenSize(context).width * .8,
                              child: ButtonView(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('No, go back')))
                        ],
                      ),
                    ]
                  ]),
            );
          }),
        );
      },
    );
  }
}

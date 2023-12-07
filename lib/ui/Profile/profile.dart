import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petnity/extentions/custom_string_extension.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_images.dart';
import 'package:petnity/ui/widgets/back_button.dart';
import 'package:petnity/ui/widgets/button_view.dart';
import 'package:petnity/ui/widgets/image_view.dart';
import 'package:provider/provider.dart';

import '../../blocs/user/user.dart';
import '../../handlers/secure_handler.dart';
import '../../model/user_models/user_profile.dart';
import '../../model/view_models/user_view_model.dart';
import '../../requests/repositories/user_repo/user_repository_impl.dart';
import '../../res/app_strings.dart';
import '../widgets/custom_text.dart';
import '../widgets/loading_page.dart';
import '../widgets/modals.dart';

class Profile extends StatelessWidget {
  const Profile();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (BuildContext context) => UserCubit(
          userRepository: UserRepositoryImpl(),
          viewModel: Provider.of<UserViewModel>(context, listen: false)),
      child: ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool reachability = true;
  late UserCubit _userCubit;

  UserProfile? userProfile;

  String username = '';

  getUsername() async {
    username = await StorageHandler.getUserName();

    _userCubit = context.read<UserCubit>();

    _userCubit.getUserProfile(username);
  }

  TextEditingController bug = TextEditingController();

  @override
  void initState() {
    getUsername();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.lightBackground,
      appBar: PreferredSize(
        preferredSize: screenSize(context) * .1,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: AppBar(
            iconTheme: IconThemeData(color: Colors.black),
            elevation: 0,
            backgroundColor: AppColors.lightBackground,
            leading: backButton(context),
            title: Text(
              'Profile',
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontFamily: AppStrings.interSans),
            ),
            centerTitle: true,
            actions: [
              // ImageView.svg(
              //   AppImages.addIcon,
              //   height: 23,
              // ),
              // SizedBox(
              //   width: 20,
              // )
            ],
          ),
        ),
      ),
      body: BlocConsumer<UserCubit, UserStates>(listener: (context, state) {
        if (state is UserProfileLoaded) {
          if (state.username.status!) {
            userProfile = state.username;
          } else {
            Modals.showToast('Failed to load user profile');
          }
        } else if (state is UserNetworkErrApiErr) {
          Modals.showToast(state.message ?? '');
        } else if (state is UserNetworkErr) {
          Modals.showToast(state.message ?? '');
        }
      }, builder: (context, state) {
        if (state is UserProfileLoading) {
          return Scaffold(body: LoadingPage());
        }

        return (userProfile?.profile?.hasPets ?? false)
            ? Container(
                height: screenSize(context).height * .9,
                width: screenSize(context).width,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: screenSize(context).height * .3,
                        width: screenSize(context).width * .9,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: ImageView.network(
                              userProfile?.petHealthIssue?[0].pet?.picture,
                              //userProfile?.profile?.profileImage,
                              fit: BoxFit.cover,
                            )),
                      ),
                      const SizedBox(height: 20,),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Pet name: ${userProfile?.petHealthIssue?[0].pet?.name}'.capitalizeFirstOfEach,
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: AppStrings.interSans),
                            ),
                            Text(
                              'Pet Gender: ${userProfile?.petHealthIssue?[0].pet?.gender}'.capitalizeFirstOfEach,
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: AppStrings.interSans),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20,),

                      Container(
                        width: screenSize(context).width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 55,
                              width: 55,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: ImageView.network(userProfile?.profile?.profileImage, fit: BoxFit.cover,),
                              ),
                            ),
                            Container(
                              width: screenSize(context).width * .4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${userProfile?.profile?.user?.username}'.capitalizeFirstOfEach,
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w800,
                                        fontFamily: AppStrings.interSans),
                                  ),
                                  Text('You',
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          fontFamily: AppStrings.interSans)),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Text('Reachability',
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontFamily: AppStrings.interSans)),
                                Switch(
                                    value: reachability,
                                    onChanged: (value) {
                                      setState(() {
                                        reachability = value;
                                      });
                                    })
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          userProfile?.petHealthIssue?[0].pet?.about ?? '',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontSize: 14.0, fontFamily: AppStrings.interSans),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        width: screenSize(context).width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${userProfile?.petHealthIssue?[0].pet?.type?.name} bio'.capitalizeFirstOfEach,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 30),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.blue),
                                  color: Color(0xff8DADFF).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(30)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Health Issues',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text('${(userProfile?.petHealthIssue?[0].pet?.hasHealthIssues ?? false) ? 'Yes' : 'None'}'.capitalizeFirstOfEach,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 13))
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Size',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(userProfile?.petHealthIssue?[0].pet?.size ?? '',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 13))
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Breed',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontFamily:
                                                    AppStrings.interSans,
                                                fontSize: 14),
                                          ),
                                          Text(userProfile?.petHealthIssue?[0].pet?.breed ?? '',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily:
                                                      AppStrings.interSans,
                                                  fontSize: 13))
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Weight',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontFamily:
                                                    AppStrings.interSans,
                                                fontSize: 14),
                                          ),
                                          Text('Nil',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily:
                                                      AppStrings.interSans,
                                                  fontSize: 13))
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        width: screenSize(context).width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Health Status',
                                style: TextStyle(
                                    fontFamily: AppStrings.interSans,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14)),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 30),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.green),
                                  color: Color(0xFF96FF8D).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Dog Illness',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily:
                                                      AppStrings.interSans,
                                                  fontSize: 14)),
                                          Text(userProfile?.petHealthIssue?[0].name.toString().capitalizeFirstOfEach ?? 'None',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily:
                                                      AppStrings.interSans,
                                                  fontSize: 13))
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Medication',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontFamily:
                                                    AppStrings.interSans,
                                                fontSize: 14),
                                          ),
                                          Text(userProfile?.petHealthIssue?[0].drug.toString().capitalizeFirstOfEach ?? 'None',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily:
                                                      AppStrings.montserrat,
                                                  fontSize: 13))
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                   Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Prescription',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontFamily:
                                                    AppStrings.interSans,
                                                fontSize: 14),
                                          ),
                                          Align(
                                    alignment: Alignment.centerLeft,
                                     child: Text(
                                              userProfile?.petHealthIssue?[0].prescription.toString().capitalizeFirstOfEach ?? 'None',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                                fontFamily: AppStrings.interSans,
                                              ),
                                            ),
                                   ),
                                        ],
                                      ),
                                   
                                  SizedBox(
                                    height: 30,
                                  ),
                                 Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Dog Allergies',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily:
                                                      AppStrings.interSans,
                                                  fontSize: 14)),
                                          Text(userProfile?.petAllergy?[0].name.toString().capitalizeFirstOfEach ?? 'None',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily:
                                                      AppStrings.interSans,
                                                  fontSize: 13))
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Medication',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontFamily:
                                                    AppStrings.interSans,
                                                fontSize: 14),
                                          ),
                                          Text(userProfile?.petAllergy?[0].drug.toString().capitalizeFirstOfEach ?? 'None',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily:
                                                      AppStrings.montserrat,
                                                  fontSize: 13))
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                   Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Prescription',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontFamily:
                                                    AppStrings.interSans,
                                                fontSize: 14),
                                          ),
                                          Align(
                                    alignment: Alignment.centerLeft,
                                     child: Text(
                                              userProfile?.petAllergy?[0].prescription.toString().capitalizeFirstOfEach ?? 'None',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                                fontFamily: AppStrings.interSans,
                                              ),
                                            ),
                                   ),
                                        ],
                                      ),
                                   
                                 
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        width: screenSize(context).width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Gallery',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: screenSize(context).height * .25,
                              width: screenSize(context).width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: screenSize(context).width * .89,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: screenSize(context).width *
                                                .295,
                                            height: screenSize(context).height *
                                                .125,
                                            child: ImageView.asset(
                                              AppImages.playing,
                                              fit: BoxFit.cover,
                                            ),
                                            color: Colors.pink,
                                          ),
                                          Container(
                                            width: screenSize(context).width *
                                                .295,
                                            height: screenSize(context).height *
                                                .125,
                                            color: Colors.red,
                                            child: ImageView.asset(
                                              AppImages.playing,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Container(
                                            width: screenSize(context).width *
                                                .295,
                                            height: screenSize(context).height *
                                                .125,
                                            color: Colors.blue,
                                            child: ImageView.asset(
                                              AppImages.playing,
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: screenSize(context).width * .89,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: screenSize(context).width *
                                                .295,
                                            height: screenSize(context).height *
                                                .125,
                                            color: Colors.green,
                                            child: ImageView.asset(
                                              AppImages.playing,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Container(
                                            width: screenSize(context).width *
                                                .295,
                                            height: screenSize(context).height *
                                                .125,
                                            color: Colors.brown,
                                            child: ImageView.asset(
                                              AppImages.playing,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Container(
                                            width: screenSize(context).width *
                                                .295,
                                            height: screenSize(context).height *
                                                .125,
                                            color: Colors.purple,
                                            child: ImageView.asset(
                                              AppImages.playing,
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: screenSize(context).height * .08,
                        width: screenSize(context).width * .8,
                        child: ButtonView(
                            onPressed: () {},
                            child: Text(
                              'Edit profile',
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: AppStrings.interSans),
                            )),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              )
            : Container(
                height: MediaQuery.sizeOf(context).height - 50,
                padding: const EdgeInsets.all(12.0),
                alignment: Alignment.center,
                child: Align(
                    child: Card(
                  elevation: 0.5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Container(
                    height: 120,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'You currently do not have a pet registered',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )));
      }),
    );
  }
}

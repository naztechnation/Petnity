import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; 
import 'package:petnity/res/app_images.dart';
import 'package:petnity/ui/landing_page/services/pet_profile/widgets/pet_bio.dart';
import 'package:petnity/ui/landing_page/services/pet_profile/widgets/pet_image_status.dart';
import 'package:petnity/ui/landing_page/services/pet_profile/widgets/pet_owner.dart'; 
import 'package:provider/provider.dart';

import '../../../../blocs/user/user.dart';
import '../../../../handlers/secure_handler.dart';
import '../../../../model/user_models/pet_profile_details.dart';
import '../../../../model/view_models/user_view_model.dart';
import '../../../../requests/repositories/user_repo/user_repository_impl.dart'; 
import '../../../widgets/back_button.dart';
import '../../../widgets/image_view.dart';
import '../../../widgets/modals.dart';

import '../../../../model/user_models/pets_profile.dart' as pet;

class PetProfile extends StatelessWidget {
  final bool isUser;
  final String username;

  const PetProfile({super.key, this.isUser = false,  this.username = ''});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (BuildContext context) => UserCubit(
          userRepository: UserRepositoryImpl(),
          viewModel: Provider.of<UserViewModel>(context, listen: false)),
      child: PetProfileScreen(
        isUser: isUser,
        username: username,
      ),
    );
  }
}

class PetProfileScreen extends StatefulWidget {
  final bool isUser;
  final String username;

  const PetProfileScreen({super.key, this.isUser = false,  this.username = ''});

  @override
  State<PetProfileScreen> createState() => _PetProfileState();
}

class _PetProfileState extends State<PetProfileScreen> {
  late UserCubit _userCubit;

  pet.PetProfile? petProfile;
  PetProfileDetails? petProfileDetails;

  String username = '';
  String userType = '';

  getUsername() async {
    username = await StorageHandler.getUserName();
    userType = await StorageHandler.getUserType();

    _userCubit = context.read<UserCubit>();

    if(userType != 'user'){
      username = widget.username;
    }

    _userCubit.getPetProfile(username);
  }

  @override
  void initState() {
    getUsername();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var petDetails = Provider.of<UserViewModel>(context, listen: true);

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 25),
              SafeArea(
                child: Row(
                  children: [
                    backButton(context),
                    //pet profile
                    SizedBox(width: 70),
                    Text(
                      'Pet Profile',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
              BlocConsumer<UserCubit, UserStates>(listener: (context, state) {
                if (state is PetProfileLoaded) {
                  if (state.petData.status!) {
                    petProfile = state.petData;
                    var petId = state.petData.pets?.first.id ?? "";

                  
                    getUserPetDetails(petId.toString(),);
                  } else {
                    Modals.showToast('Failed to load pet profile');
                    petDetails.clearPetDetails();
                  }
                } else if (state is UserNetworkErrApiErr) {
                  Modals.showToast(state.message ?? '');
                } else if (state is UserNetworkErr) {
                  Modals.showToast(state.message ?? '');
                }
              }, builder: (context, state) {
                return (state is PetProfileLoading ||
                        state is PetProfileDetailsLoading)
                    ? Expanded(
                        child: Align(
                            child: ImageView.asset(
                        AppImages.loading,
                        height: 50,
                      )))
                    : (petDetails.petDetails != null )?  Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            child: Column(
                              children: [
                                PetStatus(),
                                const SizedBox(height: 15),
                                if (widget.isUser) PetOwner(),
                                const SizedBox(
                                  height: 15,
                                ),
                                PetBio(),
                                // ClipRRect(
                                //   borderRadius: BorderRadius.circular(40),
                                //   child: Container(
                                //     margin: const EdgeInsets.symmetric(
                                //         horizontal: 8),
                                //     decoration: BoxDecoration(
                                //         borderRadius: BorderRadius.circular(40),
                                //         color: Colors.white),
                                //     child: ClipRRect(
                                //       borderRadius: BorderRadius.circular(40),
                                //       child: GridView.builder(
                                //         padding: const EdgeInsets.all(.0),
                                //         physics: NeverScrollableScrollPhysics(),
                                //         shrinkWrap: true,
                                //         gridDelegate:
                                //             SliverGridDelegateWithFixedCrossAxisCount(
                                //           crossAxisCount: 3,
                                //           crossAxisSpacing: 0,
                                //           mainAxisSpacing: 0,
                                //         ),
                                //         itemCount: 6,
                                //         itemBuilder: (ctx, i) {
                                //           return Container(
                                //               decoration: BoxDecoration(
                                //                   color: Colors.white),
                                //               child: GestureDetector(
                                //                   onTap: () {
                                //                     AppNavigator
                                //                         .pushAndStackPage(
                                //                             context,
                                //                             page:
                                //                                 SingleImageView(
                                //                               image: AppImages
                                //                                   .dogPet,
                                //                             ));
                                //                   },
                                //                   child: ImageView.asset(
                                //                     AppImages.dogPet,
                                //                     fit: BoxFit.cover,
                                //                   )));
                                //         },
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                if (widget.isUser)
                                  const SizedBox(
                                    height: 120,
                                  )
                              ],
                            ),
                          ),
                        ),
                      ): Expanded(
                        child: Container(
                                      height: MediaQuery.sizeOf(context).height,
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
                                        )))),
                      );
              }),
            ],
          ),
          // if (widget.isUser)
          //   Positioned(
          //     bottom: 30,
          //     left: 25,
          //     right: 25,
          //     child: ButtonView(
          //       borderRadius: 30,
          //       padding: EdgeInsets.symmetric(vertical: 15),
          //       color: AppColors.lightSecondary,
          //       onPressed: () {
          //         Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //               builder: (context) => TimeSelections(),
          //             ));
          //       },
          //       child: Text(
          //         'Request video call inspection',
          //         style: TextStyle(fontSize: 15),
          //       ),
          //     ),
          //   ),
        ],
      ),
    );
  }

  getUserPetDetails(String petId,) async {
    await _userCubit.getPetProfileDetails(petId);
    
  }
}

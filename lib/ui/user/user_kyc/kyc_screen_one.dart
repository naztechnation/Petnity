import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:petnity/model/account_models/pet_types.dart';
import 'package:petnity/ui/widgets/loading_page.dart';
import 'package:provider/provider.dart';

import '../../../blocs/accounts/account.dart';
import '../../../model/view_models/account_view_model.dart';
import '../../../requests/repositories/account_repo/account_repository_impl.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_constants.dart';
import '../../../res/app_images.dart';
import '../../../res/app_strings.dart';
import '../../../utils/navigator/page_navigator.dart';
import '../../widgets/button_view.dart';
import '../../widgets/custom_text.dart';
import 'kyc_screen_two.dart';
import 'widgets/pet_type_container.dart';

class KycScreenOne extends StatelessWidget {
  const KycScreenOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AccountCubit>(
      create: (BuildContext context) => AccountCubit(
          accountRepository: AccountRepositoryImpl(),
          viewModel: Provider.of<AccountViewModel>(context, listen: false)),
      child: KycScreen(),
    );
  }
}

class KycScreen extends StatefulWidget {
  KycScreen({super.key});

  @override
  State<KycScreen> createState() => _KycScreenState();
}

class _KycScreenState extends State<KycScreen> {
  List<PetTypes> petServices = [];

  bool isLoading = false;

  late AccountCubit _accountCubit;
  int _index = -1;
  List<String> pets = [
    'Dogs ',
    'Cat',
    'Monkeys',
    'Squirrels',
    'Parrot',
    'Birds',
    'Rabbit',
  ];
  List<String> petsPics = [
    AppImages.dogsPic,
    AppImages.catPic,
    AppImages.monkeyPic,
    AppImages.squirrelPic,
    AppImages.parrotPic,
    AppImages.birdsPic,
    AppImages.rabbitPic,
  ];

  getServicesTypes() async {
    _accountCubit = context.read<AccountCubit>();

    setState(() {
      isLoading = true;
    });
    await _accountCubit.getPetTypes();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getServicesTypes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final petProfile = Provider.of<AccountViewModel>(context, listen: false);

    return Scaffold(
      body:
          BlocConsumer<AccountCubit, AccountStates>(listener: (context, state) {
        if (state is PetTypesLoaded) {
          if (state.services.status!) {
            petServices = state.services.petTypes ?? [];
          } else {}
        } else if (state is AccountApiErr) {
        } else if (state is AccountNetworkErr) {}
      }, builder: (context, state) {
        if (state is PetTypesLoading) {
          return LoadingPage();
        }
        return SingleChildScrollView(
          child: Container(
            height: screenSize(context).height,
            width: screenSize(context).width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [AppColors.scaffoldColor, Colors.red.shade50],
                    begin: Alignment.topRight,
                    end: Alignment.topLeft)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 58,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: CustomText(
                      textAlign: TextAlign.left,
                      maxLines: 2,
                      text: 'Pet type',
                      weight: FontWeight.w700,
                      size: 24,
                      fontFamily: AppStrings.montserrat,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: StaggeredGridView.countBuilder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 15,
                        itemCount: petServices.length,
                        itemBuilder: (context, index) {
                          return PetType(
                            imageUrl: petsPics[index],
                            petName: petServices[index].name ?? "",
                            isPetType: _index == index,
                            onPressed: () {
                              setState(() {
                                _index = index;

                                petProfile
                                    .setPetType(petServices[index].name ?? '');
                                petProfile.setPetTypeIndex('${index + 1}');
                              });
                            },
                          );
                        },
                        staggeredTileBuilder: (index) {
                          return StaggeredTile.count(1, 0.4);
                        }),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  if (_index != -1)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0.0, horizontal: 0),
                      child: ButtonView(
                        onPressed: () {
                          AppNavigator.pushAndStackPage(context,
                              page: KycScreenTwo());
                        },
                        color: AppColors.lightSecondary,
                        borderRadius: 22,
                        child: CustomText(
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          text: 'Select',
                          weight: FontWeight.w700,
                          size: 16,
                          fontFamily: AppStrings.interSans,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  // PetTypeBody(
                  //   onPressed: (petType, index) {
                  //     {
                  //       petProfile.setPetType(petType.capitalizeFirstOfEach);
                  //       petProfile.setPetTypeIndex(index.toString());
                  //       AppNavigator.pushAndStackPage(context,
                  //           page: KycScreenTwo());
                  //     }
                  //   },
                  // ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

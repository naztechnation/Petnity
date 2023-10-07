import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petnity/extentions/custom_string_extension.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_images.dart';
import 'package:petnity/res/app_strings.dart';
import 'package:petnity/ui/landing_page/widgets/listofservices_widget.dart';
import 'package:petnity/ui/widgets/button_view.dart';
import 'package:petnity/ui/widgets/image_view.dart';
import 'package:provider/provider.dart';

import '../../blocs/user/user.dart';
import '../../handlers/secure_handler.dart';
import '../../model/user_models/service_type.dart';
import '../../model/view_models/account_view_model.dart';
import '../../model/view_models/user_view_model.dart';
import '../../requests/repositories/user_repo/user_repository_impl.dart';
import '../widgets/filter_search_section.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (BuildContext context) => UserCubit(
          userRepository: UserRepositoryImpl(),
          viewModel: Provider.of<UserViewModel>(context, listen: false)),
      child:   HomePageScreen(),
    );
  }
}



class HomePageScreen extends StatefulWidget {
  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final TextEditingController search = TextEditingController();


  List<ServiceTypes> service= [];

  late UserCubit _userCubit;

  String username = '';

  getUsername()async{
    username = await StorageHandler.getUserName();

  }

  @override
  void initState() {
    getUsername();
    _userCubit = context.read<UserCubit>();
    _userCubit.getServiceTypes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AccountViewModel>(context, listen: true);

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: BlocProvider<UserCubit>(
        lazy: false,
        create: (_) => UserCubit(
          userRepository: UserRepositoryImpl(),
          viewModel: Provider.of<UserViewModel>(context, listen: false)),
        child: BlocConsumer<UserCubit, UserStates>(
          listener: (context, state) {
            if (state is ServicesLoaded) {
              if (state.services.status!) {
                service = _userCubit.viewModel.services;
              } else {
                
              }
            } else if (state is UserNetworkErrApiErr) {
              
            } else if (state is UserNetworkErr) {
               
            }
          },
          builder: (context, state) => Container(
            height: screenSize(context).height * .9,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: screenSize(context).width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            'Hi $username,',
                            maxLines: 1,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                                fontFamily: AppStrings.montserrat),
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                color: Colors.black.withOpacity(0.7),
                              ),
                              Text(
                                '${user.address.capitalizeFirstOfEach}',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.7),
                                    fontFamily: AppStrings.interSans),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'How is your pet doing?',
                    style: TextStyle(
                        fontFamily: AppStrings.interSans,
                        fontWeight: FontWeight.w800,
                        fontSize: 24),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FilterSearchView(
                    showFilter: false,
                    controller: search,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  card(context),
                  SizedBox(
                    height: 20,
                  ),
                (state is ServicesLoading)
              ? Align(child: ImageView.asset(AppImages.loading, height: 50,))
              :   ListOfServices( ),
                  const SizedBox(
                    height: 40,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }

  
  Widget card(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.white,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 6.0,
            ),
          ],
          gradient: LinearGradient(
              colors: [AppColors.scaffoldColor, Colors.red.shade50],
              begin: Alignment.topRight,
              end: Alignment.topLeft)),
      child: Row(
        children: [
          Container(
            width: screenSize(context).width * .60,
            height: screenSize(context).height * .22,
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Register pets to get full access to products \nand services.',
                  maxLines: 3,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 17,
                      fontFamily: AppStrings.interSans),
                ),
                SizedBox(
                  height: 10,
                ),
                ButtonView(
                  borderRadius: 30,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  onPressed: () {},
                  child: Text('Begin Now'),
                  expanded: false,
                ),
              ],
            ),
          ),
          SizedBox(width: 130, child: ImageView.asset(AppImages.playingCat))
        ],
      ),
    );
  }
}

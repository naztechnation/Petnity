import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/res/app_images.dart';
import 'package:petnity/ui/landing_page/widgets/listofservices_widget.dart';
import 'package:petnity/ui/widgets/image_view.dart';
import 'package:provider/provider.dart';

import '../../../blocs/user/user.dart';
import '../../../model/user_models/service_type.dart';
import '../../../model/view_models/user_view_model.dart';
import '../../../requests/repositories/user_repo/user_repository_impl.dart';


class ServicesScreen extends StatelessWidget {
  const ServicesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (BuildContext context) => UserCubit(
          userRepository: UserRepositoryImpl(),
          viewModel: Provider.of<UserViewModel>(context, listen: false)),
      child: Services(),
    );
  }
}
class Services extends StatefulWidget {
  @override
  State<Services> createState() => _ServicesState();
}

class _ServicesState extends State<Services> {

  List<ServiceTypes> service = [];

  late UserCubit _userCubit;

 bool isLoading = false;

  getServicesTypes() async {
    _userCubit = context.read<UserCubit>();

    setState(() {
      isLoading = true;
    });
    await _userCubit.getServiceTypes();
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
    return (isLoading)
        ? Scaffold(
            body: Align(
                child: ImageView.asset(
              AppImages.loading,
              height: 50,
            )),
          )
        : Scaffold(
        backgroundColor: AppColors.lightBackground,
        body: BlocConsumer<UserCubit, UserStates>(
                listener: (context, state) {
                  if (state is ServicesLoaded) {
                    if (state.services.status!) {
                      service = _userCubit.viewModel.services;
                    } else {}
                  } else if (state is UserNetworkErrApiErr) {
                  } else if (state is UserNetworkErr) {}
                },
                builder: (context, state) => Container(
            color: AppColors.lightBackground,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('All services'),
                      InkWell(
                        child: ImageView.svg(AppImages.filterIcon),
                      ),
                    ],
                  ),
                ),
                ListOfServices()
              ],
            ),
          ),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/ui/widgets/button_view.dart';
import 'package:provider/provider.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../blocs/user/user.dart';
import '../../model/user_models/privacy_policy.dart' as content;
import '../../model/view_models/user_view_model.dart';
import '../../requests/repositories/user_repo/user_repository_impl.dart';
import '../widgets/loading_page.dart';
import '../widgets/modals.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (BuildContext context) => UserCubit(
          userRepository: UserRepositoryImpl(),
          viewModel: Provider.of<UserViewModel>(context, listen: false)),
      child: PrivacyPolicyScreen(),
    );
  }
}

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  late UserCubit _userCubit;

  content.Content? privacy;

  String username = '';

  getData() async {
    _userCubit = context.read<UserCubit>();

    _userCubit.privacyPolicy();
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
     
      appBar: PreferredSize(
        preferredSize: screenSize(context) * .1,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: AppBar(
            centerTitle: true,
            title: Text(
              'Privacy Policy',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: Colors.black),
          ),
        ),
      ),
      body: BlocConsumer<UserCubit, UserStates>(listener: (context, state) {
        if (state is PrivacyLoaded) {
          if (state.privacyPolicy.status ?? false) {
            privacy = state.privacyPolicy.privacyPolicy;

            Modals.showToast(state.privacyPolicy.message ?? '');
          } else {
            Modals.showToast('Could not load data');
          }
        } else if (state is UserNetworkErrApiErr) {
          Modals.showToast(state.message ?? '');
        } else if (state is UserNetworkErr) {
          Modals.showToast(state.message ?? '');
        }
      }, builder: (context, state) {
        if (state is PrivacyLoading) {
          return Scaffold(body: LoadingPage());
        }

        return Container(
          height: screenSize(context).height * .8,
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          child: Html(
            data: privacy?.content ?? '',
          ),
        );
      }),
    );
  }
}

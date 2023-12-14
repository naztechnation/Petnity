import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petnity/blocs/user/user.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/enum.dart';
import 'package:petnity/ui/widgets/button_view.dart';
import 'package:petnity/ui/widgets/modals.dart';
import 'package:petnity/ui/widgets/text_edit_view.dart';
import 'package:provider/provider.dart';

import '../../handlers/secure_handler.dart';
import '../../model/view_models/user_view_model.dart';
import '../../requests/repositories/user_repo/user_repository_impl.dart';
import '../../utils/validator.dart';
import '../widgets/back_button.dart';

class ReportBug extends StatelessWidget {
  const ReportBug();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (BuildContext context) => UserCubit(
          userRepository: UserRepositoryImpl(),
          viewModel: Provider.of<UserViewModel>(context, listen: false)),
      child: ReportBugScreen(),
    );
  }
}

class ReportBugScreen extends StatefulWidget {
  @override
  State<ReportBugScreen> createState() => _ReportBugScreenState();
}

class _ReportBugScreenState extends State<ReportBugScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController bug = TextEditingController();

  final TextEditingController title = TextEditingController();

  late UserCubit _userCubit;

  String username = "";

  getUserDetails() async {
    username = await StorageHandler.getUserName();

    setState(() {});
  }

  @override
  void initState() {
    _userCubit = context.read<UserCubit>();
    getUserDetails();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserStates>(listener: (context, state) {
      if (state is ReportBugLoaded) {
        if (state.reportBug.status!) {
          Modals.showToast(state.reportBug.message,
              messageType: MessageType.success);

              bug.clear();
              title.clear();
        }
      } else if (state is UserNetworkErrApiErr) {
        Modals.showToast(state.message ?? '');
      } else if (state is UserNetworkErr) {
        Modals.showToast(state.message ?? '');
      }
    }, builder: (context, state) {
      return Scaffold(
        bottomNavigationBar: Container(
          height:   55,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: ButtonView(
            borderRadius: 40,
            processing: state is ReportBugLoading,
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _userCubit.reportBug(
                  username: username,
                  title: title.text,
                  description: bug.text,
                );
              }
            },
            child: Text('Done'),
          ),
        ),
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.lightBackground,
        appBar: PreferredSize(
          preferredSize: screenSize(context) * .1,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: AppBar(
              elevation: 0,
              backgroundColor: AppColors.lightBackground,
              leading: backButton(context),
              title: Text(
                'Report a bug',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextEditView(
                  controller: title,
                  fillColor: Colors.white,
                  isDense: true,
                  borderRadius: 20,
                  hintText: 'Enter a title',
                  validator: (value) {
                    return Validator.validate(value, 'title');
                  },
                ),
                TextEditView(
                  controller: bug,
                  fillColor: Colors.white,
                  isDense: true,
                  maxLines: 5,
                  validator: (value) {
                    return Validator.validate(value, 'bug');
                  },
                  borderRadius: 20,
                  hintText: 'Type bug',
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

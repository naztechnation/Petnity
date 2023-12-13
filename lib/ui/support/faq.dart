import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_images.dart';
import 'package:petnity/ui/widgets/image_view.dart';
import 'package:provider/provider.dart';

import '../../blocs/user/user.dart';
import '../../model/user_models/faq.dart';
import '../../model/view_models/user_view_model.dart';
import '../../requests/repositories/user_repo/user_repository_impl.dart';
import '../widgets/loading_page.dart';
import '../widgets/modals.dart';

class FAQs extends StatelessWidget {
  const FAQs();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (BuildContext context) => UserCubit(
          userRepository: UserRepositoryImpl(),
          viewModel: Provider.of<UserViewModel>(context, listen: false)),
      child: FAQsScreen(),
    );
  }
}

class FAQsScreen extends StatefulWidget {
  @override
  State<FAQsScreen> createState() => _FAQsScreenState();
}

class _FAQsScreenState extends State<FAQsScreen> {
  late UserCubit _userCubit;

  List<Faqs> faqs = [];

  @override
  void initState() {
    _userCubit = context.read<UserCubit>();

    _userCubit.getFaq();
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
            elevation: 0,
            backgroundColor: AppColors.lightBackground,
            leading: InkWell(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: ImageView.svg(AppImages.backButton, height: 20,),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              'FAQs',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
        ),
      ),
      body: BlocConsumer<UserCubit, UserStates>(listener: (context, state) {
        if (state is FaqLoaded) {
          if (state.faq.status!) {
            faqs = state.faq.faqs ?? [];
          }
        } else if (state is UserNetworkErrApiErr) {
          Modals.showToast(state.message ?? '');
        } else if (state is UserNetworkErr) {
          Modals.showToast(state.message ?? '');
        }
      }, builder: (context, state) {
        if (state is FaqLoading) {
          return Scaffold(body: LoadingPage());
        }

        if (faqs.isNotEmpty) {
          return ListView.builder(
            itemCount: faqs.length,
            itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'FAQs',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Icon(
                            Icons.circle,
                            color: Colors.blue,
                          ),
                        ),
                        Text(
                          faqs[index].question ?? "",
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Answer',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: screenSize(context).width * .9,
                    child: Text(
                      faqs[index].answer ?? "",
                      textAlign: TextAlign.justify,
                    ),
                  )
                ],
              ),
            );
          });
        }

        return SizedBox.shrink();
      }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petnity/handlers/secure_handler.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_images.dart';
import 'package:petnity/res/app_strings.dart';
import 'package:petnity/ui/widgets/back_button.dart';
import 'package:petnity/ui/widgets/button_view.dart';
import 'package:petnity/ui/widgets/image_view.dart';
import 'package:provider/provider.dart';

import '../../blocs/user/user.dart';
import '../../model/user_models/faq.dart';
import '../../model/view_models/user_view_model.dart';
import '../../requests/repositories/user_repo/user_repository_impl.dart';
import '../../utils/navigator/page_navigator.dart';
import '../widgets/custom_text.dart';
import '../widgets/modals.dart';
import 'live_support_chat.dart';

class Support extends StatelessWidget {
  const Support();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (BuildContext context) => UserCubit(
          userRepository: UserRepositoryImpl(),
          viewModel: Provider.of<UserViewModel>(context, listen: false)),
      child: SupportScreen(),
    );
  }
}

class SupportScreen extends StatefulWidget {
  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  String email = "";
  String phone = "";

  late UserCubit _userCubit;

  List<Faqs> faqs = [];

  getUserDetails() async {
    email = await StorageHandler.getUserEmail();
    phone = await StorageHandler.getUserPhone();

    setState(() {
      
    });
  }

  @override
  void initState() {
    _userCubit = context.read<UserCubit>();

    _userCubit.getFaq();
    getUserDetails();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    
    return Scaffold(
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        height: 180,
        width: screenSize(context).width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.email_outlined),
              title: CustomText(
                text: 'Email',
                fontFamily: AppStrings.interSans,
                size: 13,
                weight: FontWeight.w400,
              ),
              subtitle: CustomText(
                text: email,
                fontFamily: AppStrings.interSans,
                size: 13,
                weight: FontWeight.w400,
              ),
            ),
            Divider(),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.call),
              title: CustomText(
                text: 'Number',
                fontFamily: AppStrings.interSans,
                size: 13,
                weight: FontWeight.w400,
              ),
              subtitle: CustomText(
                text: phone,
                fontFamily: AppStrings.interSans,
                size: 13,
                weight: FontWeight.w400,
              ),
            )
          ],
        ),
      ),
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.lightBackground,
      appBar: PreferredSize(
        preferredSize: screenSize(context) * .08,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: AppBar(
            elevation: 0,
            backgroundColor: AppColors.lightBackground,
            leading: backButton(context),
            title: Text(
              'Support',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        width: screenSize(context).width,
        height: screenSize(context).height * .9,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: screenSize(context).width * .5,
                height: screenSize(context).height * .2,
                child: ImageView.asset(AppImages.supportPic),
              ),
              Container(
                margin: EdgeInsets.all(10),
                width: screenSize(context).width * .6,
                child: ButtonView(
                    expanded: false,
                    borderRadius: 30,
                    borderColor: Colors.transparent,
                    color: Colors.blue.withOpacity(0.2),
                    onPressed: () {
                      AppNavigator.pushAndStackPage(context,
                          page: LiveSupportPage());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.message,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Live Chat',
                          style: TextStyle(color: Colors.blue),
                        )
                      ],
                    )),
              ),
              
              InkWell(
                onTap: () => Navigator.pushNamed(context, 'reportBug'),
                child: Container(
                  width: screenSize(context).width * .9,
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Icon(
                          Icons.file_copy,
                        ),
                      ),
                      Text('Report a bug/issue'),
                      ImageView.svg(AppImages.arrowDown)
                    ],
                  ),
                ),
              ),
              // InkWell(
              //   onTap: () => Navigator.pushNamed(context, 'reportVendor'),
              //   child: Container(
              //     width: screenSize(context).width * .9,
              //     padding: EdgeInsets.all(5),
              //     margin: EdgeInsets.all(5),
              //     decoration: BoxDecoration(
              //       color: Colors.white,
              //       borderRadius: BorderRadius.circular(20),
              //     ),
              //     child: Row(
              //       children: [
              //         Padding(
              //           padding: const EdgeInsets.all(15.0),
              //           child: Icon(
              //             Icons.file_copy,
              //           ),
              //         ),
              //         Text('Report a vendor'),
              //       ],
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: screenSize(context).width,
                padding: EdgeInsets.all(5),
                child: Text(
                  'FAQs',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              BlocConsumer<UserCubit, UserStates>(listener: (context, state) {
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
                  return Align(child: ImageView.asset(AppImages.loading, height: 50,));
                }

                if (faqs.isNotEmpty) {
                return  ListView.builder(
                  itemCount: faqs.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: ListTile(
                      leading: Icon(
                        Icons.circle,
                        size: 16,
                        color: Colors.blue,
                      ),
                      // trailing: Icon(
                      //   Icons.arrow_forward_ios,
                      //   size: 18,
                      // ),
                      title: Text(
                        faqs[index].question ?? '',
                        style: TextStyle(fontSize: 14),
                      ),
                      subtitle: Text(
                        faqs[index].answer ?? '',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  );
                });
                }
                ;

                return SizedBox.shrink();
              }),
              SizedBox(
                height: 25,
              )
            ],
          ),
        ),
      ),
    );
  }
}

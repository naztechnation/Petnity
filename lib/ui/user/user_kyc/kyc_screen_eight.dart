import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../blocs/accounts/account.dart';
import '../../../model/view_models/account_view_model.dart';
import '../../../requests/repositories/account_repo/account_repository_impl.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_constants.dart';
import '../../../res/app_strings.dart';
import '../../../res/enum.dart';
import '../../../utils/navigator/page_navigator.dart';
import '../../widgets/back_button.dart';
import '../../widgets/button_view.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/modals.dart';
import 'kyc_screen_nine.dart';
import 'kyc_screen_ten.dart';

class KycScreenEight extends StatelessWidget {
  KycScreenEight({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final petProfile = Provider.of<AccountViewModel>(context, listen: false);

    return Scaffold(
      body: Container(
        height: screenSize(context).height,
        width: screenSize(context).width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [AppColors.scaffoldColor, Colors.red.shade50],
                begin: Alignment.topRight,
                end: Alignment.topLeft)),
        child:  BlocProvider<AccountCubit>(
          lazy: false,
          create: (_) => AccountCubit(
              accountRepository: AccountRepositoryImpl(),
              viewModel: Provider.of<AccountViewModel>(context, listen: false)),
          child: BlocConsumer<AccountCubit, AccountStates>(
            listener: (context, state) {
              if (state is PetProfileLoaded) {
                if(state.petData.status!){

                
                }else{
                   Modals.showToast(state.petData.message ?? '',
                      messageType: MessageType.success);
                }
                
              } else if (state is AccountApiErr) {
                if (state.message != null) {
                  Modals.showToast(state.message!,
                      messageType: MessageType.error);
                }
              }else if (state is AccountNetworkErr) {
                if (state.message != null) {
                  Modals.showToast(state.message!,
                      messageType: MessageType.error);
                }
              }
            },
            builder: (context, state) => SingleChildScrollView(
            child: Column(
              children: [
                SafeArea(child: SizedBox(height: (Platform.isAndroid) ? 44 : 0)),
                backButton(context),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 15),
                  child: Column(
                    children: [
                      SizedBox(
                        height: screenSize(context).height * 0.25,
                      ),
                      CustomText(
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        text: 'Your ${petProfile.petType} health',
                        weight: FontWeight.w700,
                        size: 28,
                        fontFamily: AppStrings.montserrat,
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: 28,
                      ),
                      CustomText(
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        text:
                            'Does your ${petProfile.petType} have health issues?',
                        weight: FontWeight.w500,
                        size: 16,
                        fontFamily: AppStrings.interSans,
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: 45,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0.0, horizontal: 8),
                              child: ButtonView(
                                onPressed: () {
                                  AppNavigator.pushAndStackPage(context,
                                      page: KycScreenNine());
                                },
                                color: Colors.red.shade100,
                                borderRadius: 32,
                                expanded: false,
                                borderColor: Colors.white,
                                child: CustomText(
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  text: 'Yes',
                                  weight: FontWeight.w600,
                                  size: 18,
                                  fontFamily: AppStrings.interSans,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0.0, horizontal: 8),
                              child: ButtonView(
                                onPressed: () {
                                  AppNavigator.pushAndStackPage(context,
                                      page: KycScreenTen());
                                },
                                color: Colors.greenAccent.shade100,
                                borderRadius: 32,
                                expanded: false,
                                borderColor: Colors.white,
                                child: CustomText(
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  text: 'No',
                                  weight: FontWeight.w600,
                                  size: 18,
                                  fontFamily: AppStrings.interSans,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

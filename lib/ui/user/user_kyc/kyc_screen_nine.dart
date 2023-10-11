import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petnity/utils/validator.dart';
import 'package:provider/provider.dart';

import '../../../blocs/accounts/account_cubit.dart';
import '../../../blocs/accounts/account_states.dart';
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
import '../../widgets/text_edit_view.dart';
import 'kyc_screen_ten.dart';

class KycScreenNine extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();


  KycScreenNine({super.key, });

  final TextEditingController _illnessNameController = TextEditingController();
  final TextEditingController _drugNameController = TextEditingController();
  final TextEditingController _prescribeNameController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {

    final petProfile = Provider.of<AccountViewModel>(context, listen: true);

    return Scaffold(
      body: Container(
        height: screenSize(context).height,
        width: screenSize(context).width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [AppColors.scaffoldColor, Colors.red.shade50],
                begin: Alignment.topRight,
                end: Alignment.topLeft)),
        child: BlocProvider<AccountCubit>(
          lazy: false,
          create: (_) => AccountCubit(
              accountRepository: AccountRepositoryImpl(),
              viewModel: Provider.of<AccountViewModel>(context, listen: false)),
          child: BlocConsumer<AccountCubit, AccountStates>(
            listener: (context, state) {
              if (state is AccountLoaded) {
                  if(state.userData.status!){
                    AppNavigator.pushAndStackPage(context,
                                      page: KycScreenTen());
                 Modals.showToast(state.userData.message!,
                      messageType: MessageType.success);
                  }
                 
              } else if (state is AccountApiErr) {
                if (state.message != null) {
                  Modals.showToast(state.message!,
                      messageType: MessageType.error);
                }
              } else if (state is AccountNetworkErr) {
                if (state.message != null) {
                  Modals.showToast(state.message!,
                      messageType: MessageType.error);
                }
              }
            },
            builder: (context, state) => SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SafeArea(child: SizedBox(height: (Platform.isAndroid) ? 44 : 0)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      backButton(context),
                      const SizedBox(
                        width: 40,
                      ),
                      Flexible(
                        child: CustomText(
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          text: 'Your ${petProfile.petType} health',
                          weight: FontWeight.w700,
                          size: 22,
                          fontFamily: AppStrings.interSans,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: TextEditView(
                            isDense: true,
                            validator: (value){
                              return Validator.validate(value, 'Name of Illeness');
                            },
                            controller: _illnessNameController,
                            filled: true,
                            fillColor: AppColors.lightPrimary,
                            borderRadius: 30,
                            textViewTitle: 'What\'s the name of the illness',
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: TextEditView(
                            isDense: true,
                             validator: (value){
                              return Validator.validate(value, 'Drug administered');
                            },
                            controller: _drugNameController,
                            filled: true,
                            fillColor: AppColors.lightPrimary,
                            borderRadius: 30,
                            textViewTitle: 'Drug administered',
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: TextEditView(
                            isDense: true,
                            controller: _prescribeNameController,
                             validator: (value){
                              return Validator.validate(value, 'Drug prescription');
                            },
                            filled: true,
                            fillColor: AppColors.lightPrimary,
                            borderRadius: 30,
                            textViewTitle: 'Drug prescription',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20),
                    child: ButtonView(
                      processing: state is AccountProcessing,
                      onPressed: () {
                         _submit(context, petProfile.petId);
                       
                      },
                      padding: EdgeInsets.symmetric(vertical: 12),
                      color: AppColors.lightSecondary,
                      borderRadius: 30,
                      borderColor: Colors.white,
                      child: CustomText(
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        text: 'Next',
                        weight: FontWeight.w700,
                        size: 20,
                        fontFamily: AppStrings.interSans,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }

  _submit(BuildContext ctx, String petId) {
    if (_formKey.currentState!.validate()) {
      ctx.read<AccountCubit>().sendPetHealth(
          
          name: _illnessNameController.text.trim(),
          drug: _drugNameController.text.trim(),
          prescription: _prescribeNameController.text.trim(),
          url: 'pets/add-health-issue/$petId'
          );
      FocusScope.of(ctx).unfocus();
    }
  }
}

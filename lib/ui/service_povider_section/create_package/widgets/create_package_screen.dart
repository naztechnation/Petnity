import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:provider/provider.dart';

import '../../../../blocs/service_provider/service_provider.dart';
import '../../../../model/view_models/service_provider_inapp.dart';
import '../../../../requests/repositories/service_provider_repo/service_provider_repository_impl.dart';
import '../../../../res/app_colors.dart';
import '../../../../res/app_strings.dart';
import '../../../../utils/validator.dart';
import '../../../widgets/back_button.dart';
import '../../../widgets/button_view.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/modals.dart';
import '../../../widgets/text_edit_view.dart';
import 'duration_content.dart';

class CreatePackageScreen extends StatelessWidget {
  final String serviceName;

  CreatePackageScreen({
    super.key,
    required this.serviceName,
  });
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameOfLevelController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _duration1Controller = TextEditingController();
  final TextEditingController _pricingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final serviceProvider =
        Provider.of<ServiceProviderInAppViewModel>(context, listen: true);

    return Scaffold(
        body: Container(
      height: screenSize(context).height,
      width: screenSize(context).width,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [AppColors.scaffoldColor, Colors.red.shade50],
              begin: Alignment.topRight,
              end: Alignment.topLeft)),
      child: BlocProvider<ServiceProviderCubit>(
        lazy: false,
        create: (_) => ServiceProviderCubit(
            serviceProviderRepository: ServiceProviderRepositoryImpl(),
            viewModel: Provider.of<ServiceProviderInAppViewModel>(context,
                listen: false)),
        child: BlocConsumer<ServiceProviderCubit, ServiceProviderState>(
          listener: (context, state) {
            // if (state is AccountLoaded) {
            //     if(state.userData.status!){
            //         AppNavigator.pushAndStackPage(context,
            //                       page: KycScreenTwelve(
            //                         selectedPet: petProfile.petType,
            //                       ));
            //    Modals.showToast(state.userData.message!,
            //         messageType: MessageType.success);
            //     }

            // } else if (state is AccountApiErr) {
            //   if (state.message != null) {
            //     Modals.showToast(state.message!,
            //         messageType: MessageType.error);
            //   }
            // } else if (state is AccountNetworkErr) {
            //   if (state.message != null) {
            //     Modals.showToast(state.message!,
            //         messageType: MessageType.error);
            //   }
            // }
          },
          builder: (context, state) => SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SafeArea(
                      child: SizedBox(height: (Platform.isAndroid) ? 44 : 0)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      backButton(context),
                      const SizedBox(
                        width: 20,
                      ),
                      Flexible(
                        child: CustomText(
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          text: '$serviceName packages',
                          weight: FontWeight.w700,
                          size: 16,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                            'Edit package level ${serviceProvider.selectedIndex}'),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: TextEditView(
                            isDense: true,
                            validator: (value) {
                              return Validator.validate(value, 'Name of level');
                            },
                            controller: _nameOfLevelController,
                            filled: true,
                            fillColor: AppColors.lightPrimary,
                            borderRadius: 30,
                            textViewTitle: 'Name of level',
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: TextEditView(
                            isDense: true,
                            controller: _descriptionController,
                            validator: (value) {
                              return Validator.validate(value, 'Description');
                            },
                            filled: true,
                            fillColor: AppColors.lightPrimary,
                            borderRadius: 30,
                            maxLines: 5,
                            hintText: 'About level',
                            textViewTitle: 'Description',
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: TextEditView(
                            isDense: true,
                            controller: _durationController,
                            validator: (value) {
                              return Validator.validate(value, 'Duration');
                            },
                            filled: true,
                            fillColor: AppColors.lightPrimary,
                            borderRadius: 30,
                            readOnly: true,
                            hintText: 'Select Duration',
                            suffixIcon: Icon(
                              Icons.keyboard_arrow_down,
                              size: 25,
                            ),
                            textViewTitle: 'Duration',
                            onTap: () {
                              Modals.showBottomSheetModal(context,
                                  heightFactor: 1.5,
                                  isDissmissible: true,
                                  page: durationContent(context));
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: TextEditView(
                            isDense: true,
                            controller: _pricingController,
                            validator: (value) {
                              return Validator.validate(value, 'Pricing');
                            },
                            filled: true,
                            fillColor: AppColors.lightPrimary,
                            borderRadius: 30,
                            hintText: 'Selected Pricing',
                            textViewTitle: 'Pricing',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 0.0, horizontal: 20),
                    child: ButtonView(
                      // processing: state is AccountProcessing,
                      onPressed: () {
                        //  Modals.showToast(petProfile.petId);
                        // _submit(context, petProfile.petId);
                      },
                      color: AppColors.lightSecondary,
                      borderRadius: 30,
                      borderColor: AppColors.lightSecondary,
                      child: CustomText(
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        text: 'Next',
                        weight: FontWeight.w700,
                        size: 16,
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
      // ctx.read<AccountCubit>().sendPetHealth(

      //     name: _illnessNameController.text.trim(),
      //     drug: _drugNameController.text.trim(),
      //     prescription: _prescribeNameController.text.trim(),
      //     url: 'pets/add-allergies/$petId'
      //     );
      FocusScope.of(ctx).unfocus();
    }
  }

  durationContent(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.horizontal(
                left: Radius.circular(30), right: Radius.circular(30)),
            gradient: LinearGradient(
                colors: [AppColors.scaffoldColor, Colors.red.shade50],
                begin: Alignment.topRight,
                end: Alignment.topLeft)),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          text: 'Select Duration',
                          weight: FontWeight.w700,
                          size: 16,
                          fontFamily: AppStrings.interSans,
                          color: Colors.black,
                        ),
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Icon(
                            Icons.close,
                            size: 30,
                          )),
                    ),
                  ),
                ],
              ),
            ),
             const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextEditView(
                isDense: true,
                onChanged: (value) {},
                controller: _duration1Controller,
                filled: true,
                fillColor: Colors.grey.withOpacity(0.3),
                borderRadius: 30,
                hintText: 'Type Duration',
                textViewTitle: '',
                onTap: () {},
              ),
            ),
             const SizedBox(
              height: 30,
            ),
            DurationContent(
              onTap: ((value) {
                _duration1Controller.text = value;
              }),
            ),
           
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20),
              child: ButtonView(
                // processing: state is AccountProcessing,
                onPressed: () {
                  if (_duration1Controller.text.isNotEmpty) {
                    _durationController.text = _duration1Controller.text;
                    Navigator.pop(context);
                  } else {
                    Modals.showToast('please select a duration');
                  }
                },
                color: AppColors.lightSecondary,
                borderRadius: 30,
                borderColor: AppColors.lightSecondary,
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
          ],
        ),
      ),
    );
  }
}

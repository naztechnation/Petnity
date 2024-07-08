import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:petnity/requests/repositories/service_provider_repo/service_provider_repository_impl.dart';
import 'package:petnity/ui/service_povider_section/landing_page.dart';
import 'package:petnity/ui/widgets/text_edit_view.dart';
import 'package:petnity/utils/navigator/page_navigator.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../blocs/service_provider/service_provider.dart';
import '../../../handlers/secure_handler.dart';
import '../../../model/view_models/service_provider_inapp.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_constants.dart';
import '../../../res/app_routes.dart';
import '../../../res/app_strings.dart';
import '../../../utils/app_utils.dart';
import '../../../utils/validator.dart';
import '../../widgets/back_button.dart';
import '../../widgets/button_view.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/modals.dart';
import '../create_package/widgets/duration_content.dart';

class EditPackage extends StatelessWidget {
  final String packageName;
  final String packageDuration;
  final String packagePrice;
  final String packageDescription;
  final String packageId;

  EditPackage({
    super.key,
    required this.packageName,
    required this.packageDuration,
    required this.packagePrice,
    required this.packageDescription,
    required this.packageId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ServiceProviderCubit>(
      create: (BuildContext context) => ServiceProviderCubit(
          serviceProviderRepository: ServiceProviderRepositoryImpl(),
          viewModel: Provider.of<ServiceProviderInAppViewModel>(context,
              listen: false)),
      child: Edit(
        packageName: packageName,
        packageDuration: packageDuration,
        packagePrice: packagePrice,
        packageDescription: packageDescription,
        packageId: packageId,
      ),
    );
  }
}

class Edit extends StatefulWidget {
  final String packageName;
  final String packageDuration;
  final String packagePrice;
  final String packageDescription;
  final String packageId;

  const Edit({
    super.key,
    required this.packageName,
    required this.packageDuration,
    required this.packagePrice,
    required this.packageDescription,
    required this.packageId,
  });

  @override
  State<Edit> createState() => _ReviewState();
}

class _ReviewState extends State<Edit> {
  late ServiceProviderCubit _userCubit;

  final _formKey = GlobalKey<FormState>();


  final _amountController = TextEditingController();
  final _durationController = TextEditingController();
  final TextEditingController _duration1Controller = TextEditingController();

  final _descriptionController = TextEditingController();

  String email = '';
  String agentId = '';

  String transactionId = '';
  String txId = '';
  var uuid = const Uuid();

  getEmail() async {
    email = await StorageHandler.getUserEmail();
    agentId = await StorageHandler.getUserId();
  }

  @override
  void initState() {
    getEmail();

    _userCubit = context.read<ServiceProviderCubit>();

    transactionId = uuid.v1();

    _amountController.text = AppUtils.convertPrice(widget.packagePrice);
    _descriptionController.text = widget.packageDescription;
    _durationController.text = widget.packageDuration;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ServiceProviderCubit, ServiceProviderState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is CreateServiceNetworkErr) {
              Modals.showToast(state.message ?? '');
            } else if (state is CreateServiceNetworkErrApiErr) {
              Modals.showToast(state.message ?? '');
            } else if (state is EditPackageLoaded) {
              Modals.showToast(state.data.message ?? '');
              
            }
            return Stack(
              children: [
                Container(
                  height: screenSize(context).height,
                  width: screenSize(context).width,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [AppColors.scaffoldColor, Colors.red.shade50],
                          begin: Alignment.topRight,
                          end: Alignment.topLeft)),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SafeArea(
                            child: SizedBox(
                                height: (Platform.isAndroid) ? 30 : 0)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            backButton(context),
                            CustomText(
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              text: 'Edit Pricing',
                              weight: FontWeight.w600,
                              size: 18,
                              fontFamily: AppStrings.montserrat,
                              color: Colors.black,
                            ),
                           
                            Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: GestureDetector(
                                onTap: () {
                                  AppNavigator.pushAndReplaceName(context,
                          name: AppRoutes.serviceProviderLandingPage);
                                },
                                child: Icon(Icons.close, size: 30,color: Colors.red,)),
                            ),
                             
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 12.0),
                                        child: CustomText(
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                          text: 'Package',
                                          weight: FontWeight.w600,
                                          size: 14,
                                          fontFamily: AppStrings.montserrat,
                                          color: Colors.black,
                                        ),
                                      ),
                                      TextEditView(
                                        controller: TextEditingController(
                                          text: widget.packageName,
                                        ),
                                        borderRadius: 30,
                                        boxHeight: 8,
                                        readOnly: true,
                                        borderColor: Colors.white,
                                        filled: true,
                                        fillColor: Colors.white,
                                        isDense: true,
                                        textViewTitle: 'Package',
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                        Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: CustomText(
                                    maxLines: 1,
                                    text: 'Duration',
                                    weight: FontWeight.w600,
                                    size: 14,
                                    fontFamily: AppStrings.montserrat,
                                    color: Colors.black,
                                  ),
                                ),
                                      TextEditView(
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
                                       
                                        onTap: () {
                                          Modals.showBottomSheetModal(context,
                                              heightFactor: 1.5,
                                              isDissmissible: true,
                                              page: durationContent(context));
                                        },
                                      ),
                                     
                                    
                                const SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: CustomText(
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    text: 'Description',
                                    weight: FontWeight.w600,
                                    size: 14,
                                    fontFamily: AppStrings.montserrat,
                                    color: Colors.black,
                                  ),
                                ),
                                
                                TextEditView(
                                  controller: _descriptionController,
                                  borderRadius: 30,
                                  //readOnly: true,
                                  boxHeight: 8,
                                  borderColor: Colors.white,
                                  filled: true,
                                  maxLines: 5,
                                   validator: (value) {
                                          return Validator.validate(value, 'Description');
                                        },
                                  fillColor: Colors.white,
                                  isDense: true,
                                  textViewTitle: 'Description',
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: CustomText(
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    text: 'Price (NGN)',
                                    
                                    weight: FontWeight.w600,
                                    size: 14,
                                    fontFamily: AppStrings.montserrat,
                                    color: Colors.black,
                                  ),
                                ),
                                TextEditView(
                                  controller: _amountController,
                                  borderRadius: 30,
                                  readOnly: false,
                                  boxHeight: 8,
                                  keyboardType: TextInputType.number,
                                  borderColor: Colors.white,
                                  filled: true,
                                    validator: (value) {
                                          return Validator.validate(value, 'New Price');
                                        },
                                  fillColor: Colors.white,
                                  isDense: true,
                                  textViewTitle: 'Input New Price',
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    ThousandsSeparatorInputFormatter(),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 30.0, horizontal: 15),
                          child: ButtonView(
                            processing: state is EditPackageLoading,
                            onPressed: () {
                              
                                String amount = _amountController.text.trim();
                                if (amount.contains(',')) {
                                  amount = amount.replaceAll(',', '');
                                }

                                 if (_formKey.currentState!.validate()) {

                                _userCubit.editPackage(
                                    agentId: agentId,
                                    price: amount,
                                    packageId: widget.packageId,
                                    name: widget.packageName,
                                    description: _descriptionController.text,
                                    duration: _durationController.text
                                    );

                                 }
                              
                            },
                            color: AppColors.lightSecondary,
                            borderRadius: 22,
                            child: CustomText(
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              text: 'Update Pricing',
                              weight: FontWeight.w400,
                              size: 15,
                              fontFamily: AppStrings.interSans,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
    );
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

  String formatTime(String time) {
    String inputTime = time.replaceAll(RegExp(r'[\sA-Za-z]'), '');
    print(inputTime);

    return inputTime;
  }
}

class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  final NumberFormat _formatter = NumberFormat('#,###');

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // Remove all non-digit characters
    final intValue = int.tryParse(newValue.text.replaceAll(',', ''));
    if (intValue == null) {
      return oldValue;
    }

    final newText = _formatter.format(intValue);

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }


 
}

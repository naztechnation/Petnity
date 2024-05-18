import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:petnity/requests/repositories/service_provider_repo/service_provider_repository_impl.dart';
import 'package:petnity/ui/widgets/text_edit_view.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../blocs/service_provider/service_provider.dart';
import '../../../handlers/secure_handler.dart';
import '../../../model/view_models/service_provider_inapp.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_constants.dart';
import '../../../res/app_strings.dart';
import '../../../utils/app_utils.dart';
import '../../widgets/back_button.dart';
import '../../widgets/button_view.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/modals.dart';

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

  final _amountController = TextEditingController();
  final _durationController = TextEditingController();
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
                            const SizedBox(
                              width: 40,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SingleChildScrollView(
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
                                      padding:
                                          const EdgeInsets.only(left: 12.0),
                                      child: CustomText(
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        text: 'Duration',
                                        weight: FontWeight.w600,
                                        size: 14,
                                        fontFamily: AppStrings.montserrat,
                                        color: Colors.black,
                                      ),
                                    ),
                                    TextEditView(
                                      controller: _durationController,
                                      borderRadius: 30,
                                      boxHeight: 8,
                                      //readOnly: true,
                                      borderColor: Colors.white,
                                      filled: true,
                                      fillColor: Colors.white,
                                      isDense: true,
                                      textViewTitle: 'Duration',
                                    ),
                                  ],
                                ),
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
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 30.0, horizontal: 15),
                          child: ButtonView(
                            processing: state is EditPackageLoading,
                            onPressed: () {
                              if (_amountController.text !=
                                  AppUtils.convertPrice(widget.packagePrice)) {
                                String amount = _amountController.text.trim();
                                if (amount.contains(',')) {
                                  amount = amount.replaceAll(',', '');
                                }

                                _userCubit.editPackage(
                                    agentId: agentId,
                                    price: amount,
                                    packageId: widget.packageId);
                              } else {
                                Modals.showToast(
                                    'Please enter a price different from the former');
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

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:petnity/res/enum.dart';
import 'package:petnity/ui/landing_page/services/payment_success_screen.dart';
import 'package:petnity/ui/widgets/text_edit_view.dart';
import 'package:provider/provider.dart';

import '../../../model/view_models/account_view_model.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_constants.dart';
import '../../../res/app_strings.dart';
import '../../../utils/navigator/page_navigator.dart';
import '../../widgets/back_button.dart';
import '../../widgets/button_view.dart';
import '../../widgets/custom_text.dart';

class ReviewScreen extends StatefulWidget {
  final String date1,date2,time1,time2;
  const ReviewScreen({super.key, required this.date1, required this.date2, required this.time1, required this.time2});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
              SafeArea(child: SizedBox(height: (Platform.isAndroid) ? 30 : 0)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  backButton(context),
                  CustomText(
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    text: 'Review',
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
                  children: [
                     Column(
                            children: [
                              TextEditView(
                                controller: TextEditingController(
                                  text: 'Basic',
                                ),
                                borderRadius: 30,
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
                              TextEditView(
                                controller: TextEditingController(
                                  text: 'Less than a Week',
                                ),
                                borderRadius: 30,
                                readOnly: true,
                                borderColor: Colors.white,
                                filled: true,
                                fillColor: Colors.white,
                                isDense: true,
                                textViewTitle: 'Duration',
                                suffixIcon: Container(
                                  width: 80,
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 12.0),
                                    child: CustomText(
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      text: '\$450',
                                      weight: FontWeight.w500,
                                      size: 14,
                                      fontFamily: AppStrings.montserrat,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                       // : SizedBox.shrink(),
                    const SizedBox(
                      height: 20,
                    ),
                    TextEditView(
                      controller: TextEditingController(
                        text: widget.date1,
                      ),
                      borderRadius: 30,
                      readOnly: true,
                      borderColor: Colors.white,
                      filled: true,
                      fillColor: Colors.white,
                      isDense: true,
                      textViewTitle: 'Pick up date',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextEditView(
                      controller: TextEditingController(
                        text: widget.time1,
                      ),
                      borderRadius: 30,
                      readOnly: true,
                      borderColor: Colors.white,
                      filled: true,
                      fillColor: Colors.white,
                      isDense: true,
                      textViewTitle: 'Pick up time',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextEditView(
                      controller: TextEditingController(
                        text: widget.date2,
                      ),
                      borderRadius: 30,
                      readOnly: true,
                      borderColor: Colors.white,
                      filled: true,
                      fillColor: Colors.white,
                      isDense: true,
                      textViewTitle: 'Drop off date',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextEditView(
                      controller: TextEditingController(
                        text: widget.time2,
                      ),
                      borderRadius: 30,
                      readOnly: true,
                      borderColor: Colors.white,
                      filled: true,
                      fillColor: Colors.white,
                      isDense: true,
                      textViewTitle: 'Drop off time',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextEditView(
                      controller: TextEditingController(
                        text: Provider.of<AccountViewModel>(context, listen: false).location,
                      ),
                      borderRadius: 30,
                      readOnly: true,
                      borderColor: Colors.white,
                      filled: true,
                      fillColor: Colors.white,
                      isDense: true,
                      textViewTitle: 'Pick up Location',
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 250,
        color: Colors.grey.shade100,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(30)),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      text: 'Fee',
                      weight: FontWeight.w600,
                      size: 14,
                      fontFamily: AppStrings.interSans,
                      color: Colors.black,
                    ),
                    CustomText(
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      text: '\$129',
                      weight: FontWeight.w600,
                      size: 14,
                      color: Colors.black,
                    ),
                  ]),
            ),
            const SizedBox(
              height: 45,
            ),
            ButtonView(
              color: AppColors.lightSecondary,
              borderColor: Colors.white,
              borderRadius: 40,
              onPressed: () {
                AppNavigator.pushAndStackPage(context,
                    page: PaymentSuccessScreen());
              },
              child: CustomText(
                textAlign: TextAlign.left,
                maxLines: 2,
                text: 'Make payment',
                weight: FontWeight.w600,
                size: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

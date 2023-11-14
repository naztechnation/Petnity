

import 'package:flutter/material.dart';
import 'package:petnity/ui/widgets/text_edit_view.dart';

import '../../res/app_colors.dart';
import '../../res/app_constants.dart';
import '../../res/app_strings.dart';
import '../../utils/app_utils.dart';
import '../widgets/back_button.dart';
import '../widgets/custom_text.dart';

class WithdrawalPage extends StatelessWidget {
  const WithdrawalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: PreferredSize(
          preferredSize: screenSize(context) * .1,
          child: Container(
            padding: EdgeInsets.only(top: 20),
            child: AppBar(
              centerTitle: true,
              title: Text(
                'Payments',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: backButton(context),
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
          ),
        ),
        body: Container(
           height: screenSize(context).height,
        width: screenSize(context).width,
        padding: const EdgeInsets.symmetric(horizontal: 22),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [AppColors.scaffoldColor, Colors.red.shade50],
                begin: Alignment.topRight,
                end: Alignment.topLeft)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            const SizedBox(height: 30,),
            Container(
                    width: screenSize(context).width,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CustomText(
                            text: 'Withdrawable balance',
                            weight: FontWeight.bold,
                            maxLines: 2,
                            size: 13,
                          ),
                        ),
                        CustomText(
                          text: 'NGN ${AppUtils.convertPrice('950')}',
                          weight: FontWeight.bold,
                          fontFamily: AppStrings.montserrat,
                          size: 13,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextEditView(controller: TextEditingController(), 
                  isDense: true,
                  textViewTitle: 'Amount',
                  fillColor: Colors.white, borderColor: Colors.white, borderRadius: 30,),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomText(
                          text: 'Select account to withdraw',
                          weight: FontWeight.bold,
                          fontFamily: AppStrings.montserrat,
                          size: 13,
                        ),
          ]),
        ),
    );
  }
}
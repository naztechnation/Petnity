

import 'package:flutter/material.dart';
import 'package:petnity/ui/payment/payment_review.dart';
import 'package:petnity/ui/widgets/image_view.dart';
import 'package:petnity/ui/widgets/text_edit_view.dart';

import '../../res/app_colors.dart';
import '../../res/app_constants.dart';
import '../../res/app_images.dart';
import '../../res/app_strings.dart';
import '../../utils/app_utils.dart';
import '../../utils/navigator/page_navigator.dart';
import '../widgets/back_button.dart';
import '../widgets/button_view.dart';
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
        body: SingleChildScrollView(
          child: Container(
             height: screenSize(context).height - 120,
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
                    hintText: 'input amount',
                    fillColor: Colors.white, borderColor: Colors.white, borderRadius: 30,),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomText(
                            text: 'Destination account to withdraw',
                            weight: FontWeight.bold,
                            fontFamily: AppStrings.montserrat,
                            size: 13,
                          ),
                           const SizedBox(
                      height: 20,
                    ),
                          Container(
                      width: screenSize(context).width * 0.5,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      padding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      decoration: BoxDecoration(
                        color: AppColors.lightSecondary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                    text: 'Stephen Agbo',
                                    weight: FontWeight.bold,
                                    color: Colors.white,
                                    size: 13,
                                  ),
                                ImageView.svg(AppImages.select, 
                                    color: Colors.white,
                                
                                )
                            ],
                          ),
                          const SizedBox(height: 50,),
                          CustomText(
                                    text: 'Opay',
                                    weight: FontWeight.bold,
                                    color: Colors.white,
        
                                    size: 13,
                                  ),
                          const SizedBox(height: 10,),
        
                                  CustomText(
                                    text: '12898573847',
                                    color: Colors.white,
        
                                    weight: FontWeight.bold,
                                    size: 13,
                                  ),
                        ],
                      ),
                      ),
        
                      const Spacer(),
                      Align(
                        child: CustomText(
                                      text: 'Change Account',
                                      weight: FontWeight.bold,
                                      color: AppColors.lightSecondary,
                                      size: 13,
                                    ),
                                    
                      ),
                      const SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 0),
                        child: ButtonView(
                          
                          onPressed: () {
                              AppNavigator.pushAndStackPage(context, page: PaymentReview());
                          },
                          color: AppColors.lightSecondary,
                          borderRadius: 22,
                          child: CustomText(
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            text: 'Withdraw',
                            weight: FontWeight.w500,
                            size: 16,
                            fontFamily: AppStrings.interSans,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30,),
        
            ]),
          ),
        ),
    );
  }
}
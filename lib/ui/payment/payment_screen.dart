import 'package:flutter/material.dart';
import 'package:petnity/ui/payment/withdrawal_page.dart';
import 'package:petnity/ui/widgets/image_view.dart';
import 'package:uuid/uuid.dart';

import '../../res/app_colors.dart';
import '../../res/app_constants.dart';
import '../../res/app_strings.dart';
import '../../utils/app_utils.dart';
import '../../utils/navigator/page_navigator.dart';
import '../widgets/custom_text.dart';
import 'widgets/payment_box.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({
    super.key,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final String amount = '';

  String email = '';

  String transactionId = '';
  String txId = '';
  var uuid = const Uuid();

  String selectedPlan = '';

  @override
  void initState() {
    super.initState();
  }

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
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomText(
                      text: 'Lifetime earnings -',
                      weight: FontWeight.bold,
                      maxLines: 2,
                      size: 13,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    CustomText(
                      text: 'NGN ${AppUtils.convertPrice('20000')}',
                      weight: FontWeight.w900,
                      fontFamily: AppStrings.montserrat,
                      maxLines: 2,
                      size: 12,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: (){
                    AppNavigator.pushAndStackPage(context, page: WithdrawalPage());
                  },
                  child: Container(
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
                            color: AppColors.lightSecondary,
                            maxLines: 2,
                            size: 13,
                          ),
                        ),
                        CustomText(
                          text: 'NGN ${AppUtils.convertPrice('1000')}',
                          weight: FontWeight.bold,
                          color: AppColors.lightSecondary,
                          fontFamily: AppStrings.montserrat,
                          size: 13,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
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
                          text: 'Pending balance',
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
                  height: 20,
                ),
                CustomText(
                  text: 'Analytics',
                  weight: FontWeight.bold,
                  fontFamily: AppStrings.montserrat,
                  size: 13,
                ),
                const SizedBox(
                  height: 30,
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 4,
                  shrinkWrap: true,
                  itemBuilder: ((context, index) {
                  return 
        
                PaymentBox();
        
                }))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

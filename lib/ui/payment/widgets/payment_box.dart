

import 'package:flutter/material.dart';
import 'package:petnity/model/user/transactions/transactions_list.dart';

import '../../../model/user_models/withdrawal_history.dart';
import '../../../res/app_constants.dart';
import '../../../res/app_strings.dart';
import '../../../utils/app_utils.dart';

class PaymentBox extends StatelessWidget {

  final WithdrawalRequests? history;
  final Transactions? userhistory;
  final bool isUser;
  const PaymentBox.user({super.key,   this.history,   this.userhistory, required this.isUser});
  const PaymentBox.agent({super.key,   this.history,   this.userhistory, required this.isUser});

  @override
  Widget build(BuildContext context) {

    if(isUser){
      return Container(
                width: screenSize(context).width,
                margin: const EdgeInsets.only(left: 10, right: 10, bottom: 14),
                padding: const EdgeInsets.only(right: 12, top: 15, bottom: 15, left: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    
                    Expanded(
                      flex: 6,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                           if(userhistory?.amount != null)  Text(
                                'NGN ${AppUtils.convertPrice(userhistory?.amount)}',
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontFamily: AppStrings.montserrat),
                              ),
                              const SizedBox(height: 10,),

                           
                              Text(
                                'Txn Id: ${userhistory?.transactionId ?? ''}',
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontFamily: AppStrings.montserrat),
                              ),
                              const SizedBox(height: 10,),

                              Text(
                            AppUtils.formatComplexDate(dateTime: userhistory?.createdAt ?? ''),
                            style: TextStyle(color: Colors.black, fontSize: 12),
                          )
                            ],
                          ),
                          const SizedBox(height: 10,),
                           if(userhistory?.transactionStatus == 'success')...[
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.greenAccent.withOpacity(0.1)),
                                child: Text(
                                  'Credit Sucessful',
                                  style: TextStyle(color: Colors.greenAccent, fontSize: 12),
                                ),
                              ),
                              
                            ]else ...[
                                  Container(
                                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.red.withOpacity(0.1)),
                                child: Text(
                                  'Failed',
                                  style: TextStyle(color: Colors.red, fontSize: 12),
                                ),
                              ), 
                            ]  
                          
                        ],
                      ),
                    )
                  ],
                ),
              );
  }else{
return Container(
                width: screenSize(context).width,
                margin: const EdgeInsets.only(left: 10, right: 10, bottom: 14),
                padding: const EdgeInsets.only(right: 12, top: 15, bottom: 15, left: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    
                    Expanded(
                      flex: 6,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                           if(history?.amount != null)  Text(
                                'NGN ${AppUtils.convertPrice(history?.amount)}',
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontFamily: AppStrings.montserrat),
                              ),
                              const SizedBox(height: 10,),

                            if(history?.status == 'pending')...[
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.orangeAccent.withOpacity(0.1)),
                                child: Text(
                                  'Pending',
                                  style: TextStyle(color: Colors.orangeAccent, fontSize: 12),
                                ),
                              ),
                            ]else if(history?.status == 'approved')...[
                                 Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.greenAccent.withOpacity(0.1)),
                                child: Text(
                                  'Withdrawn',
                                  style: TextStyle(color: Colors.greenAccent, fontSize: 12),
                                ),
                              ),
                            ]  
                            ],
                          ),
                          const SizedBox(height: 10,),
                          Text(
                            AppUtils.formatComplexDate(dateTime: history?.createdAt ?? ''),
                            style: TextStyle(color: Colors.black, fontSize: 11),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
  }

    }

   
    
}
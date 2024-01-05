

import 'package:flutter/material.dart';

import '../../../model/user_models/withdrawal_history.dart';
import '../../../res/app_constants.dart';
import '../../../res/app_strings.dart';
import '../../../utils/app_utils.dart';

class PaymentBox extends StatelessWidget {

  final AgentWithdrawals history;
  const PaymentBox({super.key, required this.history});

  @override
  Widget build(BuildContext context) {

    
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
                             Text(
                                'NGN ${AppUtils.convertPrice(history.amount)}',
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontFamily: AppStrings.montserrat),
                              ),
                              const SizedBox(height: 10,),

                            if(history.status == 'pending')...[
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
                            ]else if(history.status == 'approved')...[
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
                            AppUtils.formatComplexDate(dateTime: history.createdAt ?? ''),
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
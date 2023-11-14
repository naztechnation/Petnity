

import 'package:flutter/material.dart';

import '../../../res/app_constants.dart';
import '../../../res/app_strings.dart';
import '../../../utils/app_utils.dart';
import '../../widgets/image_view.dart';

class PaymentBox extends StatelessWidget {
  const PaymentBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
                width: screenSize(context).width,
                margin: const EdgeInsets.only(left: 10, right: 10, bottom: 14),
                padding: const EdgeInsets.only(right: 12, top: 15, bottom: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: ImageView.network(
                            'https://tinyurl.com/5n86mjnc',
                            height: 60,
                          )),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 6,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Sandra Lee',
                                style: TextStyle(color: Colors.black),
                              ),
                              const SizedBox(height: 10,),

                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.greenAccent.withOpacity(0.1)),
                                child: Text(
                                  'Withdrawn',
                                  style: TextStyle(color: Colors.greenAccent),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'NGN ${AppUtils.convertPrice('950')}',
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontFamily: AppStrings.montserrat),
                              ),
                              const SizedBox(height: 10,),
                              Text(
                                '23/08/09',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
  }
}
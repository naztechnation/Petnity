

import 'package:flutter/material.dart';

import '../../../../res/app_images.dart';
import '../../../../res/app_strings.dart';
import '../../../widgets/button_view.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/image_view.dart';

Widget contactTop ({required String date1,required String date2,required String time1,required String time2,required Function onTap1,required Function onTap2,required Function onTap3,required Function onTap4}){
  return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      text: 'Drop off time',
                      weight: FontWeight.w700,
                      size: 16,
                      fontFamily: AppStrings.interSans,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                ImageView.svg(
                                  AppImages.calender,
                                  height: 18,
                                ),
                                SizedBox(width: 5),
                                CustomText(
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  text: 'Date',
                                  weight: FontWeight.w700,
                                  size: 16,
                                  fontFamily: AppStrings.interSans,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ButtonView(
                              color: Colors.white,
                              expanded: false,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              borderColor: Colors.white,
                              borderRadius: 40,
                              onPressed: () {
                                onTap1();
                              },
                              child: CustomText(
                                textAlign: TextAlign.left,
                                maxLines: 2,
                                text: date1,
                                weight: FontWeight.w500,
                                size: 16,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                ImageView.svg(
                                  AppImages.time,
                                  height: 18,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                CustomText(
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  text: 'Time',
                                  weight: FontWeight.w700,
                                  size: 16,
                                  fontFamily: AppStrings.interSans,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ButtonView(
                              color: Colors.white,
                              expanded: false,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              borderColor: Colors.white,
                              borderRadius: 40,
                              onPressed: () {
                                onTap2();

                              },
                              child: CustomText(
                                textAlign: TextAlign.left,
                                maxLines: 2,
                                text: time1,
                                weight: FontWeight.w500,
                                size: 16,
                                color: Colors.black,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 50,),
                    CustomText(
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      text: 'Pick up time',
                      weight: FontWeight.w700,
                      size: 16,
                      fontFamily: AppStrings.interSans,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                ImageView.svg(
                                  AppImages.calender,
                                  height: 18,
                                ),
                                SizedBox(width: 5),
                                CustomText(
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  text: 'Date',
                                  weight: FontWeight.w700,
                                  size: 16,
                                  fontFamily: AppStrings.interSans,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ButtonView(
                              color: Colors.white,
                              expanded: false,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              borderColor: Colors.white,
                              borderRadius: 40,
                              onPressed: () {
                                onTap3();

                              },
                              child: CustomText(
                                textAlign: TextAlign.left,
                                maxLines: 2,
                                text: date2,
                                weight: FontWeight.w500,
                                size: 16,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                        
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                ImageView.svg(
                                  AppImages.time,
                                  height: 18,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                CustomText(
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  text: 'Time',
                                  weight: FontWeight.w700,
                                  size: 16,
                                  fontFamily: AppStrings.interSans,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ButtonView(
                              color: Colors.white,
                              expanded: false,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              borderColor: Colors.white,
                              borderRadius: 40,
                              onPressed: () {
                                onTap4();

                              },
                              child: CustomText(
                                textAlign: TextAlign.left,
                                maxLines: 2,
                                text: time2,
                                weight: FontWeight.w500,
                                size: 16,
                                color: Colors.black,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              );
}
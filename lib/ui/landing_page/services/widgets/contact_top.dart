

import 'package:flutter/material.dart';

import '../../../../res/app_images.dart';
import '../../../../res/app_strings.dart';
import '../../../widgets/button_view.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/image_view.dart';

Widget contactTop (){
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
                              onPressed: () {},
                              child: CustomText(
                                textAlign: TextAlign.left,
                                maxLines: 2,
                                text: '12-2-2022',
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
                              onPressed: () {},
                              child: CustomText(
                                textAlign: TextAlign.left,
                                maxLines: 2,
                                text: '04:pm',
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
                              onPressed: () {},
                              child: CustomText(
                                textAlign: TextAlign.left,
                                maxLines: 2,
                                text: '12-2-2022',
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
                              onPressed: () {},
                              child: CustomText(
                                textAlign: TextAlign.left,
                                maxLines: 2,
                                text: '04:pm',
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
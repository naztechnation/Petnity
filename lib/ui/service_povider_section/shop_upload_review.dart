import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_images.dart';
import 'package:petnity/res/enum.dart';
import 'package:petnity/ui/widgets/image_view.dart';
import 'package:provider/provider.dart';
import '../../blocs/service_provider/service_provider.dart';
import '../../model/view_models/service_provider_inapp.dart';
import '../../requests/repositories/service_provider_repo/service_provider_repository_impl.dart';
import '../../res/app_colors.dart';
import '../../res/app_strings.dart';
import '../widgets/button_view.dart';
import '../widgets/custom_text.dart';
import '../widgets/modals.dart';

class ProductReviewDetail extends StatefulWidget {
  final String productName;
  final String price;
  final String aboutProduct;

  const ProductReviewDetail(
      {super.key,
      required this.productName,
      required this.price,
      required this.aboutProduct});

  @override
  State<ProductReviewDetail> createState() =>
      _ProductDetailState(productName, price, aboutProduct);
}

class _ProductDetailState extends State<ProductReviewDetail> {
  final String productName;
  final String price;
  final String aboutProduct;

  _ProductDetailState(
    this.productName,
    this.price,
    this.aboutProduct,
  );

  bool isChecked = false;

  @override
  void initState() {
    super.initState();
  }

  var count = 0;
  @override
  Widget build(BuildContext context) {
    final serviceProvider =
        Provider.of<ServiceProviderInAppViewModel>(context, listen: true);

    return BlocProvider<ServiceProviderCubit>(
      create: (BuildContext context) => ServiceProviderCubit(
          serviceProviderRepository: ServiceProviderRepositoryImpl(),
          viewModel: Provider.of<ServiceProviderInAppViewModel>(context,
              listen: false)),
      child: BlocConsumer<ServiceProviderCubit, ServiceProviderState>(
          listener: (context, state) {
        if (state is CreateServiceAmountLoaded) {
          if (state.serviceAmount.status!) {
            Modals.showToast(state.serviceAmount.message ?? '',
                messageType: MessageType.success);

            // AppNavigator.pushAndStackPage(context,
            //     page: CreatePackageScreen(
            //       serviceName: serviceType,
            //       serviceId: state.serviceAmount.service!.id!.toString(),
            //     ));
          } else {
            Modals.showToast(
              state.serviceAmount.message ?? '',
            );
          }
        } else if (state is CreateServiceNetworkErrApiErr) {
          Modals.showSnackBar(state.message ?? '', context: context);
        } else if (state is CreateServiceNetworkErr) {}
      }, builder: (context, state) {
        return Scaffold(
          body: Scaffold(
            backgroundColor: Color(0xFFF2F6FF),
            appBar: PreferredSize(
              preferredSize: screenSize(context) * .08,
              child: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                centerTitle: true,
                title: Text(
                  'Review',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                leading: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: InkWell(
                    child: ImageView.svg(AppImages.backButton),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                 height: screenSize(context).height,
        width: screenSize(context).width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [AppColors.scaffoldColor, Colors.red.shade50],
                begin: Alignment.topRight,
                end: Alignment.topLeft)),
                child: Column(
                  children: [
                     SizedBox(
                      height: 30,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.all(20),
                      child: ImageView.file(
                          File(
                            serviceProvider.imageURl!.path,
                          ),
                          height: 150,
                          fit: BoxFit.cover),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      color: Colors.yellow.withOpacity(0.1),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    productName,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Mark as in stock',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Checkbox(
                                        value: isChecked,
                                        onChanged: (value) {
                                          setState(() {
                                            isChecked = value!;
                                          });
                                        })
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              width: screenSize(context).width,
                              child: Text(
                                'About Product',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              aboutProduct,
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Price',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              price,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ]),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0.0, horizontal: 20),
                      child: ButtonView(
                        onPressed: () {},
                        color: AppColors.lightSecondary,
                        borderRadius: 16,
                        child: CustomText(
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          text: 'Publish',
                          weight: FontWeight.w500,
                          size: 16,
                          fontFamily: AppStrings.interSans,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

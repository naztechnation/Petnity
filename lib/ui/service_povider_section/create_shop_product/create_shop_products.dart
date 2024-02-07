import 'dart:io';

import 'package:flutter/material.dart';
import 'package:petnity/ui/widgets/image_view.dart';
import 'package:petnity/utils/navigator/page_navigator.dart';
import 'package:provider/provider.dart';

import '../../../../model/view_models/service_provider_inapp.dart';
import '../../../../res/app_colors.dart';
import '../../../../res/app_constants.dart';
import '../../../../res/app_strings.dart';
import '../../../res/app_images.dart';
import '../../../utils/validator.dart';
import '../../widgets/back_button.dart';
import '../../widgets/button_view.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/modals.dart';
import '../../widgets/text_edit_view.dart';
import '../shop_upload_review.dart';

class CreateShopProducts extends StatefulWidget {
  CreateShopProducts({
    super.key,
  });

  @override
  State<CreateShopProducts> createState() => _CreateShopProductsState();
}

class _CreateShopProductsState extends State<CreateShopProducts> {
  final _formKey = GlobalKey<FormState>();

  final productName = TextEditingController();
  final quantity = TextEditingController();

  final productPrice = TextEditingController();

  final aboutProduct = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final serviceProvider =
        Provider.of<ServiceProviderInAppViewModel>(context, listen: true);

    return Scaffold(
      body: Container(
        height: screenSize(context).height,
        width: screenSize(context).width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [AppColors.scaffoldColor, Colors.red.shade50],
                begin: Alignment.topRight,
                end: Alignment.topLeft)),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SafeArea(child: SizedBox(height: (Platform.isAndroid) ? 30 : 0)),
              Row(
                children: [
                  backButton(context),
                  const SizedBox(
                    width: 40,
                  ),
                  CustomText(
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    text: 'Add Products',
                    weight: FontWeight.w800,
                    size: 16,
                    fontFamily: AppStrings.interSans,
                    color: Colors.black,
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: TextEditView(
                        isDense: true,
                        validator: (value) {
                          return Validator.validate(value, 'Product name');
                        },
                        controller: productName,
                        filled: true,
                        fillColor: AppColors.lightPrimary,
                        borderRadius: 30,
                        hintText: 'Product name',
                        textViewTitle: '',
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),

                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 0.0,
                          mainAxisSpacing: 8.0,
                        ),
                        itemCount: serviceProvider.addProductImage.length,
                        itemBuilder: (context, index) {
                          return imageWidget(
                              context,
                              serviceProvider.addProductImage[index],
                              index,
                              serviceProvider);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: TextEditView(
                        isDense: true,
                        validator: (value) {
                          return Validator.validate(value, 'Product price');
                        },
                        controller: productPrice,
                        keyboardType: TextInputType.number,
                        filled: true,
                        fillColor: AppColors.lightPrimary,
                        borderRadius: 30,
                        hintText: 'input amount',
                        textViewTitle: 'Product price',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: TextEditView(
                        isDense: true,
                        validator: (value) {
                          return Validator.validate(value, 'Product quantity');
                        },
                        controller: quantity,
                        keyboardType: TextInputType.number,
                        filled: true,
                        fillColor: AppColors.lightPrimary,
                        borderRadius: 30,
                        hintText: 'input quantity',
                        textViewTitle: 'Product quantity',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: TextEditView(
                        isDense: true,
                        validator: (value) {
                          return Validator.validate(value, 'About product');
                        },
                        controller: aboutProduct,
                        filled: true,
                        fillColor: AppColors.lightPrimary,
                        borderRadius: 30,
                        maxLines: 5,
                        hintText: 'Tell your buyers about the product',
                        textViewTitle: 'About product',
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0.0, horizontal: 20),
                      child: ButtonView(
                        onPressed: () async {
                          List<String> selectedImages = serviceProvider
                              .addProductImage
                              .where((image) => image.isNotEmpty)
                              .toList();

                          if (selectedImages.isEmpty) {
                             Modals.showToast('please select at least one image');
                          } else {
                           _submit(context, selectedImages);
                          }
                          
                        },
                        color: AppColors.lightSecondary,
                        borderRadius: 22,
                        borderColor: Colors.white,
                        child: CustomText(
                          textAlign: TextAlign.center,
                          maxLines: 5,
                          text: 'Review & publish',
                          weight: FontWeight.w400,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _submit(BuildContext context, List<String> image) {
    if (_formKey.currentState!.validate()) {
      AppNavigator.pushAndStackPage(context,
          page: ProductReviewDetail(
            productName: productName.text,
            price: productPrice.text,
            aboutProduct: aboutProduct.text,
            quantity: quantity.text, images: image,
          ));
    }
  }

  Widget imageWidget(BuildContext context, image, index, services) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
        ),
        child: (image.isEmpty)
            ? GestureDetector(
                onTap: () {
                  services.loadImage(context: context, index: index);
                },
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ImageView.svg(
                        AppImages.cross,
                        height: 18,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Add display image',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: AppStrings.interSans,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width/3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(22),
                      child: ImageView.file(
                          File(
                            image,
                          ),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        services.removeImageFromList(index);
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.black.withOpacity(0.7),
                        ),
                        child: Align(
                            child: Icon(
                          Icons.delete_forever,
                          color: Color.fromARGB(255, 230, 130, 130),
                        )),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

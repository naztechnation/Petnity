import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petnity/requests/repositories/service_provider_repo/service_provider_repository_impl.dart';
import 'package:petnity/res/enum.dart';
import 'package:petnity/ui/widgets/image_view.dart';
import 'package:petnity/utils/navigator/page_navigator.dart';
import 'package:provider/provider.dart';

import '../../../blocs/service_provider/service_provider.dart';
import '../../../model/view_models/service_provider_inapp.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_constants.dart';
import '../../../res/app_strings.dart';
import '../../res/app_images.dart';
import '../../utils/validator.dart';
import '../widgets/back_button.dart';
import '../widgets/button_view.dart';
import '../widgets/custom_text.dart';
import '../widgets/modals.dart';
import '../widgets/text_edit_view.dart';
import 'shop_upload_review.dart';

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

  final productPrice = TextEditingController();

  final aboutProduct = TextEditingController();

  bool isLoading = false;


  @override
  Widget build(BuildContext context) {
    final serviceProvider =
        Provider.of<ServiceProviderInAppViewModel>(context, listen: true);

    return Scaffold(
      body:  Container(
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
                SafeArea(
                    child: SizedBox(height: (Platform.isAndroid) ? 30 : 0)),
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
                  height: 30,
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
                  if (serviceProvider.imageURl == null) ...[
                    GestureDetector(
                      onTap: () {
                        serviceProvider.loadImage(
                          context,
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Center(
                          child: Container(
                            width: screenSize(context).width,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(22),
                            ),
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
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: AppStrings.interSans,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ] else ...[
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                              height: 200,
                              width: screenSize(context).width,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(22),
                                child: ImageView.file(
                                    File(
                                      serviceProvider.imageURl!.path,
                                    ),
                                    fit: BoxFit.cover),
                              )),
                        ),
                        Positioned(
                          top: 80,
                          child: GestureDetector(
                            onTap: (){
                              serviceProvider.loadImage(
                          context,
                        );
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.white,
                              ),
                              child:  Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: ImageView.svg(
                                        AppImages.cross,
                                        height: 12,
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: TextEditView(
                      isDense: true,
                      validator: (value) {
                        return Validator.validate(value, 'Product price');
                      },
                      controller: productPrice,
                      filled: true,
                      fillColor: AppColors.lightPrimary,
                      borderRadius: 30,
                      hintText: 'input amount',
                      textViewTitle: 'Product price',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
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
                    padding:
                        const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20),
                    child: ButtonView(
                      onPressed: () async{
                      
                        // setState(() {
                        //           isLoading = true;
                        //         });
                        //       String imgUrl = await serviceProvider.uploadImage(
                        //           serviceProvider.imageURl!.path,
                        //           'petnity_service_provider');
                        //           setState(() {
                        //           isLoading = false;
                        //         });
                      
                      if(serviceProvider.imageURl != null){
                         _submit(context);
                      }else{
                        Modals.showToast('please select an image first');
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
                  ],),
                )
              ],
            ),
          ),
        ),
      
    );
  }

  _submit(BuildContext context){
    if(_formKey.currentState!.validate()){
                      AppNavigator.pushAndStackPage(context, page: ProductReviewDetail(productName: productName.text, price: productPrice.text, aboutProduct: aboutProduct.text,));

    }
  }
}

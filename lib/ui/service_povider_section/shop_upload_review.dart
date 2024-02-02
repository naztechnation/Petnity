import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petnity/extentions/custom_string_extension.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_images.dart';
import 'package:petnity/res/enum.dart';
import 'package:petnity/ui/widgets/image_view.dart';
import 'package:provider/provider.dart';
import '../../blocs/service_provider/service_provider.dart';
import '../../handlers/secure_handler.dart';
import '../../model/view_models/service_provider_inapp.dart';
import '../../requests/repositories/service_provider_repo/service_provider_repository_impl.dart';
import '../../res/app_colors.dart';
import '../../res/app_strings.dart';
import '../../utils/app_utils.dart';
import '../../utils/navigator/page_navigator.dart';
import '../widgets/button_view.dart';
import '../widgets/custom_text.dart';
import '../widgets/modals.dart';
import 'create_shop_product/shop_created_success.dart';

class ProductReviewDetail extends StatefulWidget {
  final String productName;
  final String price;
  final String aboutProduct;
  final String quantity;
  final List<String> images;
  const ProductReviewDetail(
      {super.key,
      required this.productName,
      required this.price,
      required this.quantity,
      required this.aboutProduct,
      required this.images});

  @override
  State<ProductReviewDetail> createState() =>
      _ProductDetailState(productName, price, aboutProduct, quantity, images);
}

class _ProductDetailState extends State<ProductReviewDetail> {
  final String productName;
  final String price;
  final String aboutProduct;
  final String quantity;
  final List<String> images;

  _ProductDetailState(
    this.productName,
    this.price,
    this.aboutProduct,
    this.quantity,
    this.images,
  );

  bool isChecked = false;

  bool isLoading = false;

  String agentId = "";

  getAgentId() async {
    agentId = await StorageHandler.getAgentId();
  }

  @override
  void initState() {
    getAgentId();
    super.initState();
  }

  var count = 0;
  @override
  Widget build(BuildContext context) {
    final serviceProvider =
        Provider.of<ServiceProviderInAppViewModel>(context, listen: false);

    return BlocProvider<ServiceProviderCubit>(
      create: (BuildContext context) => ServiceProviderCubit(
          serviceProviderRepository: ServiceProviderRepositoryImpl(),
          viewModel: Provider.of<ServiceProviderInAppViewModel>(context,
              listen: false)),
      child: BlocConsumer<ServiceProviderCubit, ServiceProviderState>(
          listener: (context, state) {
        if (state is CreateShopProductsLoaded) {
          if (state.createShopProduct.status!) {
            Modals.showToast(state.createShopProduct.message ?? '',
                messageType: MessageType.success);

            AppNavigator.pushAndStackPage(context,
                page: ShopUploadSuccessful());
          } else {
            Modals.showToast(
              state.createShopProduct.message ?? '',
            );
          }
        } else if (state is CreateServiceNetworkErrApiErr) {
          Modals.showToast(
            state.message ?? '',
          );
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
            body: Container(
              height: screenSize(context).height,
              width: screenSize(context).width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                AppColors.scaffoldColor,
                AppColors.scaffoldColor
              ], begin: Alignment.topRight, end: Alignment.topLeft)),
              child: ListView(
                children: [
                  SizedBox(
                    height: 30,
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
                      itemCount: images.length,
                      itemBuilder: (context, index) {
                        return imageWidget(
                            context, images, index, serviceProvider);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    color: Colors.blue.withOpacity(0.05),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  productName.capitalizeFirstOfEach,
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Price',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'NGN${AppUtils.convertPrice(price)}',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    'Quantity',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    quantity,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
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
                      onPressed: () async {
                        List<String> uploadedImages = [];

                        for (int i = 0; i < images.length; i++) {
                          String image = images[i];

                          if (image.isNotEmpty) {
                            setState(() {
                              isLoading = true;
                            });
                            String imgUrl = await serviceProvider.uploadImage(
                                serviceProvider.imageURl!.path,
                                'petnity_service_provider');
                                uploadedImages.add(imgUrl);

                            if (i == images.length - 1) {
                              Modals.showToast("I am the last.");
                              setState(() {
                                isLoading = false;
                              });
                               _submit(context, uploadedImages);
                            }
                          }
                        }
                      },
                      processing:
                          (state is CreateShopProductsLoading || isLoading),
                      color: AppColors.lightSecondary,
                      borderRadius: 30,
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
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  _submit(BuildContext ctx, List<String> image) {
    ctx.read<ServiceProviderCubit>().createShoppingProduct(
        quantity: quantity,
        name: productName,
        pricing: price,
        image: image,
        description: aboutProduct);
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
        child: ClipRRect(
          borderRadius: BorderRadius.circular(22),
          child: ImageView.file(
              File(
                image[index],
              ),
              fit: BoxFit.cover),
        ),
      ),
    );
  }
}

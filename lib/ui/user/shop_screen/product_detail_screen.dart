import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petnity/extentions/custom_string_extension.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_images.dart';
import 'package:petnity/res/app_strings.dart';
import 'package:petnity/ui/user/shop_screen/widgets/review_widget.dart';
import 'package:petnity/ui/landing_page/widgets/rating_widget.dart';
import 'package:petnity/ui/widgets/button_view.dart';
import 'package:petnity/ui/widgets/image_view.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../blocs/user/user.dart';
import '../../../handlers/secure_handler.dart';
import '../../../model/product/product.dart';
import '../../../model/user_models/get_product_reviews.dart'; 
import '../../../model/view_models/account_view_model.dart';
import '../../../model/view_models/user_view_model.dart';
import '../../../requests/repositories/user_repo/user_repository_impl.dart';
import '../../../res/app_colors.dart';
import '../../../utils/app_utils.dart';
import '../../../utils/navigator/page_navigator.dart';
import '../../../utils/validator.dart';
import '../../landing_page/services/single_image_view.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/loading_page.dart';
import '../../widgets/modals.dart';
import '../../widgets/ratings_views.dart';
import '../../widgets/text_edit_view.dart';

class ProductDetailScreen extends StatelessWidget {
  final String productId;
  final String amount;
  final String username;
  final String agentId;

  const ProductDetailScreen(this.productId, this.amount, this.username, this.agentId);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (BuildContext context) => UserCubit(
          userRepository: UserRepositoryImpl(),
          viewModel: Provider.of<UserViewModel>(context, listen: false)),
      child: ProductDetail(
        productId: productId,
        amount: amount,
        username: username,
      ),
    );
  }
}

class ProductDetail extends StatefulWidget {
  final String productId;
  final String amount;
  final String username;

  const ProductDetail(
      {super.key,
      required this.productId,
      required this.amount,
      required this.username});

  @override
  State<ProductDetail> createState() =>
      _ProductDetailState(productId: productId);
}

class _ProductDetailState extends State<ProductDetail> {
  final String productId;

  _ProductDetailState({required this.productId});

  final commentController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  late UserCubit _userCubit;

  List<Reviews> reviews = [];

  Products? _products;

  double totalAmount = 0;

  String email = '';
  int ratingNumber = 0;

  String transactionId = '';
  String txId = '';
  var uuid = const Uuid();

  bool isProcessing = false;
  String userType = '';

  getEmail() async {
    email = await StorageHandler.getUserEmail();
    userType = await StorageHandler.getUserType();
  }

  

  @override
  void initState() {
    _userCubit = context.read<UserCubit>();
    getEmail();

    transactionId = uuid.v1();

    _userCubit.productDetails(productId: productId);
    _userCubit.getProductReviews(productId: productId);
    super.initState();
  }

  var count = 1;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AccountViewModel>(context, listen: true);
    user.getUsername();

    return BlocConsumer<UserCubit, UserStates>(listener: (context, state) {
      if (state is ProductDetailsLoaded) {
        if (state.productDetails.status ?? false) {
          _products = state.productDetails.data?.product;
          totalAmount = double.parse(_products?.price.toString() ?? '0.0');
        } else {
          Modals.showToast('Opps an error occured');
        }
      } else if (state is GetProductReviewsLoaded) {
        if (state.getAgentPayment.status?? false) {
          reviews = state.getAgentPayment.data?.reviews ?? [];
        } else {}
      } else if (state is ProductOrderLoaded) {
        if (state.createPaymentOrder.status?? false) {
          Modals.showToast(state.createPaymentOrder.message ?? '');

          // _handlePaymentInitialization(
          //     state.createPaymentOrder.shopOrder!.id.toString());
        } else {
           Modals.showToast(state.createPaymentOrder.message ?? '');

        }
      } else if (state is ConfirmShoppingOrderLoaded) {
        if (state.confirmPaymentOrder.status?? false) {
          Modals.showToast(state.confirmPaymentOrder.message ?? '');
        } else {}
      } else if (state is UserNetworkErrApiErr) {
        Modals.showToast(state.message ?? '');
      } else if (state is UserNetworkErr) {
        Modals.showToast(state.message ?? '');
      } else if (state is PostProductReviewsLoaded) {
        if (state.postReview.status?? false) {
          Modals.showToast(state.postReview.message ?? '');
          _userCubit.getProductReviews(productId: productId);
          Navigator.pop(context);
        } else {}
      }
    }, builder: (context, state) {
      if (state is ProductDetailsLoading ||
          state is ProductOrderLoading ||
          state is ConfirmShoppingOrderLoading ||
          state is GetProductReviewsLoading) {
        return Scaffold(body: LoadingPage());
      }

      return Scaffold(
        body: Scaffold(
          backgroundColor: Color(0xFFF2F6FF),
          bottomNavigationBar: (userType == 'user')
              ? Container(
                  color: Colors.white,
                  height: 90,
                  padding: EdgeInsets.all(5),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${AppUtils.convertPrice(totalAmount.toString())}',
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: AppStrings.interSans,
                              fontWeight: FontWeight.w800),
                        ),
                        ButtonView(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          expanded: false,
                          borderRadius: 30,
                          onPressed: () {
                            Modals.showAlertOptionDialog(context,
                                title: 'Proceed to make payment',
                                message:
                                    'Are you sure you want to Continue to make payment',
                                onTap: () {
                              createOrder(
                                  context, user, productId, count.toString());
                            });
                          },
                          child: Text('Make payment',
                              style: TextStyle(fontWeight: FontWeight.w300,  color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                )
              : SizedBox.shrink(),
          appBar: PreferredSize(
            preferredSize: screenSize(context) * .08,
            child: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: Padding(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                  child: ImageView.svg(AppImages.backButton),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              centerTitle: true,
              title: Text(
                _products?.name ?? '',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [

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
                        itemCount: _products?.images?.length,
                        itemBuilder: (context, index) {
                          return imageWidget(
                              context,
                              _products?.images?[index],
                              index,
                               );
                        },
                      ),
                    ),
              
                const SizedBox(
                  height: 20,
                ),
                if (userType == 'user')
                  Container(
                    width: screenSize(context).width * .4,
                    height: 45,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30)),
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            updateTotalAmount(false);
                          },
                          child: Icon(Icons.remove),
                        ),
                        Text('$count',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 20)),
                        InkWell(
                          onTap: () {
                            updateTotalAmount(true);
                          },
                          child: Icon(Icons.add),
                        ),
                      ],
                    ),
                  ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  color: Colors.yellow.shade50,
                  padding: EdgeInsets.all(10),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            _products?.name ?? '',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            (_products?.inStock ?? false)
                                ? 'in stock'
                                : 'out of stock',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: (_products?.inStock ?? false)
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // RatingWidget(
                        //   coloredStars: 4,
                        //   size: 20,
                        // ),
                        SizedBox(
                          width: 10,
                        ),
                        if (userType == 'user')
                          Align(
                            alignment: Alignment.centerRight,
                            child: ButtonView(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 2),
                              expanded: false,
                              borderRadius: 30,
                              onPressed: () {
                                Modals.showBottomSheetModal(context,
                                    isDissmissible: true,
                                    heightFactor: 1,
                                    page: Ratings(
                                        ctxt: context,
                                        username: user.username,
                                        agentName: _products?.agent?.name ?? '',
                                        productId:
                                            _products?.sId.toString() ?? ''));
                              },
                              child: Text(
                                'Add Review',
                                style: TextStyle(fontWeight: FontWeight.w300, color: Colors.white),
                              ),
                            ),
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
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        _products?.description ?? '',
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      width: screenSize(context).width,
                      child: Text(
                        'Review',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    if (reviews.isNotEmpty) ...[
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: reviews.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return ReviewWidget(
                              reviews: reviews[index],
                            );
                          })
                    ] else ...[
                      if (reviews.isEmpty)
                        SizedBox(
                          height: 100,
                          child: Center(
                            child: Text(
                                ' No Reviews available for this product',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w300)),
                          ),
                        )
                    ]
                  ]),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  createOrder(BuildContext ctx, user, String productId, String quantity) {
    if (count != 0) {
      ctx.read<UserCubit>().createOrderPayment(
            address: user.address,
            quantity: quantity,
            productId: productId,
          );
      FocusScope.of(ctx).unfocus();
    } else {
      Modals.showToast(
          'please increase the product quantity above the current quantity');
    }
  }

 

  Ratings({
    required String username,
    required BuildContext ctxt,
    required String agentName,
    required String productId,
  }) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Rate this ${agentName.capitalizeFirstOfEach}\'s Product',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 20,
              ),
              RatingView(
                rating: ratingNumber,
                size: 30,
                onSelected: (value) {
                  setState((() {
                    ratingNumber = value + 1;
                  }));
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: TextEditView(
                  controller: commentController,
                  validator: (value) {
                    return Validator.validate(value, 'comment');
                  },
                  isDense: true,
                  textViewTitle: 'Write a review',
                  hintText: 'Enter comment',
                  borderWidth: 0.5,
                  fillColor: AppColors.lightPrimary,
                  borderColor: Color.fromARGB(255, 41, 12, 12),
                  borderRadius: 30,
                  onChanged: ((value) {
                    setState(() {});
                  }),
                  maxLines: 6,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              if (commentController.text.isEmpty)
                Center(
                  child: InkWell(
                  // onTap: () => AppNavigator.pushAndStackPage(context, page: ReportVendor(widget.agentName?.id.toString() ?? '')),

                    child: Text(
                      'Report ${agentName.capitalizeFirstOfEach}',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              const SizedBox(
                height: 20,
              ),
              if (commentController.text.isNotEmpty)
                ButtonView(
                  processing: isProcessing,
                  onPressed: () {
                    setState(() {});
                    _postProductReviews(
                      ctx: ctxt,
                      username: username,
                      productId: productId,
                      rating: ratingNumber.toString(),
                      comment: commentController.text,
                    );
                  },
                  color: AppColors.lightSecondary,
                  child: CustomText(
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    text: 'Submit',
                    weight: FontWeight.w400,
                    size: 16,
                    fontFamily: AppStrings.interSans,
                    color: Colors.white,
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }

  _postProductReviews(
      {required BuildContext ctx,
      required String username,
      required String productId,
      required String rating,
      required String comment}) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isProcessing = true;
      });
      await ctx.read<UserCubit>().postProductReviews(
            url: 'shop/review-product/$productId',
            rating: rating,
            comment: comment,
          );
      setState(() {
        isProcessing = false;
      });
      FocusScope.of(ctx).unfocus();
    } else {
      Modals.showToast('please enter a comment');
    }
  }

  void updateTotalAmount(bool isAdding) {
  setState(() {
    if (isAdding) {
      count += 1;
    } else {
      if (count > 1) {
        count -= 1;
      }
    }
    totalAmount = count * double.parse(_products?.price.toString() ?? '0.0') ;  
  });
}

  Widget imageWidget(BuildContext context, image, index,  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
        ),
        child: GestureDetector(
                onTap: () {
                  AppNavigator.pushAndStackPage(context,
                              page: SingleImageView(
                                image: image,
                              ));
                },
                child: Container(
                    width: MediaQuery.of(context).size.width/3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(22),
                      child: ImageView.network(
                          image,
                          fit: BoxFit.cover),
                    ),
                  ),
              
          
      ),
    ));
  }
}



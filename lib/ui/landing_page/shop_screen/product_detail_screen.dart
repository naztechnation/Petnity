import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwave_standard/flutterwave.dart';
import 'package:petnity/extentions/custom_string_extension.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_images.dart';
import 'package:petnity/res/app_strings.dart';
import 'package:petnity/res/enum.dart';
import 'package:petnity/ui/landing_page/shop_screen/widgets/review_widget.dart';
import 'package:petnity/ui/landing_page/widgets/rating_widget.dart';
import 'package:petnity/ui/widgets/button_view.dart';
import 'package:petnity/ui/widgets/image_view.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../blocs/user/user.dart';
import '../../../handlers/secure_handler.dart';
import '../../../model/user_models/get_product_reviews.dart';
import '../../../model/user_models/products_detail.dart';
import '../../../model/view_models/account_view_model.dart';
import '../../../model/view_models/user_view_model.dart';
import '../../../requests/repositories/user_repo/user_repository_impl.dart';
import '../../../res/app_colors.dart';
import '../../../utils/app_utils.dart';
import '../../../utils/validator.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/loading_page.dart';
import '../../widgets/modals.dart';
import '../../widgets/ratings_views.dart';
import '../../widgets/text_edit_view.dart';

class ProductDetailScreen extends StatelessWidget {
  final String productId;
  final String amount;
  final String username;

  const ProductDetailScreen(this.productId, this.amount, this.username);

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

  List<ProductReviews> reviews = [];

  Product? _products;

  String email = '';
  int ratingNumber = 0;

  String transactionId = '';
  String txId = '';
  var uuid = const Uuid();

  bool isProcessing = false;

  getEmail() async {
    email = await StorageHandler.getUserEmail();
  }

  _handlePaymentInitialization(String shopOrder) async {
    final Customer customer = Customer(email: email);

    final Flutterwave flutterwave = Flutterwave(
        context: context,
        publicKey: AppStrings.flutterwaveApiKey,
        currency: 'NGN',
        redirectUrl: 'https://petnity.com',
        txRef: uuid.v1(),
        amount: widget.amount,
        customer: customer,
        paymentOptions: "card",
        customization: Customization(
          title: "Petnity",
          //logo: AppImages.logo,
        ),
        isTestMode: true);
    final ChargeResponse response = await flutterwave.charge();

    if (response != null) {
      txId = response.transactionId ?? '';
      if (txId != '') {
        String message = 'Payment Ref: ${response.txRef}';

        confirmPaymentOrder(
          context,
          widget.username,
          txId,
          shopOrder,
        );
      }
    } else {
      Modals.showToast('Unable to make payment Successfully.',
          messageType: MessageType.error);
    }
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

  var count = 0;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AccountViewModel>(context, listen: true);
    user.getUsername();

    return BlocConsumer<UserCubit, UserStates>(listener: (context, state) {
      if (state is ProductDetailsLoaded) {
        if (state.productDetails.status!) {
          _products = state.productDetails.product;
        } else {}
      } else if (state is GetProductReviewsLoaded) {
        if (state.getAgentPayment.status!) {
          reviews = state.getAgentPayment.reviews ?? [];
        } else {}
      } else if (state is ProductOrderLoaded) {
        if (state.createPaymentOrder.status!) {
          _handlePaymentInitialization(
              state.createPaymentOrder.shopOrder!.id.toString());
        } else {}
      } else if (state is ConfirmShoppingOrderLoaded) {
        if (state.confirmPaymentOrder.status!) {
          Modals.showToast(state.confirmPaymentOrder.message ?? '');
        } else {}
      } else if (state is UserNetworkErrApiErr) {
        Modals.showToast(state.message ?? '');
      } else if (state is UserNetworkErr) {
        Modals.showToast(state.message ?? '');
      } else if (state is PostProductReviewsLoaded) {
        if (state.postReview.status!) {
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
          bottomNavigationBar: Container(
            color: Colors.white,
            height: 90,
            padding: EdgeInsets.all(5),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${AppUtils.convertPrice(_products?.price ?? '0')}',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: AppStrings.interSans,
                        fontWeight: FontWeight.w800),
                  ),
                  ButtonView(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    expanded: false,
                    borderRadius: 30,
                    onPressed: () {
                      Modals.showAlertOptionDialog(context,
                          title: 'Proceed to make payment',
                          message:
                              'Are you sure you want to Continue to make payment',
                          onTap: () {
                        createOrder(context, user, productId, count.toString());
                      });
                    },
                    child: Text('Make payment'),
                  ),
                ],
              ),
            ),
          ),
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
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                ImageView.network(
                  _products?.image ?? '',
                  height: 150,
                ),
                const SizedBox(
                  height: 20,
                ),
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
                          if (count > 0) {
                            count -= 1;
                            setState(() {
                              count;
                            });
                          }
                        },
                        child: Icon(Icons.remove),
                      ),
                      Text('$count',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 20)),
                      InkWell(
                        onTap: () {
                          setState(() {
                            count += 1;
                          });
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
                        Text(
                          _products?.name ?? '',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                        Text(
                          (_products?.inStock ?? false)
                              ? 'in stock'
                              : 'out of stock',
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        RatingWidget(
                          coloredStars: 4,
                          size: 20,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        ButtonView(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 5),
                          expanded: false,
                          borderRadius: 30,
                          onPressed: () {
                            Modals.showBottomSheetModal(context,
                                isDissmissible: true,
                                heightFactor: 1,
                                page: Ratings(
                                    ctxt: context,
                                    username: user.username,
                                    agentName: _products?.name ?? '',
                                    productId:
                                        _products?.id.toString() ?? ''));
                          },
                          child: Text('Add Review'),
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
                      _products?.description ?? '',
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(
                      height: 10,
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
                    ]
                  ]),
                ),
                const SizedBox(
                  height: 50,
                ),
                if (reviews.isEmpty)
                  Center(
                    child: Text(' No Reviews available for the product'),
                  )
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
            username: user.username,
            quantity: quantity,
            productId: productId,
          );
      FocusScope.of(ctx).unfocus();
    } else {
      Modals.showToast(
          'please increase the product quantity above the current quantity');
    }
  }

  confirmPaymentOrder(BuildContext ctx, String username, String purchaseId,
      String shopOrderId) {
    ctx.read<UserCubit>().confirmShoppingOrderPay(
          username: username,
          purchaseId: purchaseId,
          shopOrderId: shopOrderId,
        );
    FocusScope.of(ctx).unfocus();
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
                  child: Text(
                    'Report ${agentName.capitalizeFirstOfEach}',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.w700),
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
            url: 'shop/review-product/$username/$productId',
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
}

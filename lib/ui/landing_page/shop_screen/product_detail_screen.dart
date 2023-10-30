import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_images.dart';
import 'package:petnity/res/app_strings.dart';
import 'package:petnity/ui/landing_page/shop_screen/widgets/review_widget.dart';
import 'package:petnity/ui/landing_page/widgets/rating_widget.dart';
import 'package:petnity/ui/widgets/button_view.dart';
import 'package:petnity/ui/widgets/image_view.dart';
import 'package:petnity/ui/widgets/notification_icon.dart';
import 'package:provider/provider.dart';

import '../../../blocs/user/user.dart';
import '../../../model/user_models/products_detail.dart';
import '../../../model/view_models/account_view_model.dart';
import '../../../model/view_models/user_view_model.dart';
import '../../../requests/repositories/user_repo/user_repository_impl.dart';
import '../../widgets/loading_page.dart';
import '../../widgets/modals.dart';

class ProductDetailScreen extends StatelessWidget {
  final String productId;
  const ProductDetailScreen(this.productId);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (BuildContext context) => UserCubit(
          userRepository: UserRepositoryImpl(),
          viewModel: Provider.of<UserViewModel>(context, listen: false)),
      child: ProductDetail(
        productId: productId,
      ),
    );
  }
}

class ProductDetail extends StatefulWidget {
  final String productId;

  const ProductDetail({super.key, required this.productId});

  @override
  State<ProductDetail> createState() =>
      _ProductDetailState(productId: productId);
}

class _ProductDetailState extends State<ProductDetail> {
  final String productId;

  late UserCubit _userCubit;

  Product? _products;

  _ProductDetailState({required this.productId});

  @override
  void initState() {
    _userCubit = context.read<UserCubit>();

    _userCubit.productDetails(productId: productId);
    super.initState();
  }

  var count = 0;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AccountViewModel>(context, listen: true);
    user.getUsername();

    return BlocConsumer<UserCubit, UserStates>(
      listener: (context, state) {
        if (state is ProductDetailsLoaded) {
          if (state.productDetails.status!) {
            _products = state.productDetails.product;
          } else {}
        }else if (state is ProductOrderLoaded) {
          if (state.createPaymentOrder.status!) {
          Modals.showToast(state.createPaymentOrder.message ?? '');

          } else {}
        } else if (state is UserNetworkErrApiErr) {
          Modals.showToast(state.message ?? '');
        } else if (state is UserNetworkErr) {
          Modals.showToast(state.message ?? '');
        }
      },
      builder: (context, state) => (state is ProductDetailsLoading || state is ProductOrderLoading)
          ? LoadingPage()
          : Scaffold(
              backgroundColor: Color(0xFFF2F6FF),
              bottomNavigationBar: Container(
                color: Colors.white,
                height: 90,
                padding: EdgeInsets.all(5),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal:20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                       '${_products?.price ?? ''}',
                        style: TextStyle(fontSize: 20, fontFamily: AppStrings.interSans, fontWeight: FontWeight.w800),
                      ),
                      ButtonView(
                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                        expanded: false,
                        borderRadius: 30,
                          onPressed: () {
                
                           Modals.showAlertOptionDialog(context, title: 'Proceed to make payment', 
                           message: 'Are you sure you want to Continue to make payment',onTap:  (){
                            createOrder(context, user, productId, count.toString());
                           });
                          },
                          child:Text('Make payment'),)
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
                          Text('$count',style: TextStyle(
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
                              (_products!.inStock!)
                                  ? 'in stock'
                                  : 'out of stock',
                              style: TextStyle(fontSize: 12),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        RatingWidget(
                          coloredStars: 4,
                          size: 20,
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
                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 5,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return ReviewWidget();
                            })
                      ]),
                    )
                  ],
                ),
              ),
            ),
    );
  }

   createOrder(BuildContext ctx, user, String productId, String quantity) {
   
      ctx.read<UserCubit>().createOrderPayment(
          username: user.username,
          quantity: quantity,
          productId: productId,
          );
      FocusScope.of(ctx).unfocus();
    
  }
}

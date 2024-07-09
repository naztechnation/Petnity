import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/ui/user/shop_screen/product_detail_screen.dart';

import 'package:petnity/ui/widgets/image_view.dart';
import 'package:petnity/ui/widgets/loading_page.dart';
import 'package:petnity/ui/widgets/modals.dart';
import 'package:provider/provider.dart';

import '../../../blocs/user/user.dart'; 
import '../../../model/view_models/account_view_model.dart';
import '../../../model/view_models/user_view_model.dart';
import '../../../requests/repositories/user_repo/user_repository_impl.dart';
import '../../../res/app_images.dart';
import '../../../utils/app_utils.dart';
import '../../handlers/secure_handler.dart';
import '../../model/product/product.dart';
import '../../utils/navigator/page_navigator.dart';
import '../widgets/text_edit_view.dart';
import 'create_shop_product/create_shop_products.dart';

class ServiceProviderCatalogueScreen extends StatelessWidget {
  const ServiceProviderCatalogueScreen();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (BuildContext context) => UserCubit(
          userRepository: UserRepositoryImpl(),
          viewModel: Provider.of<UserViewModel>(context, listen: false)),
      child: Shop(),
    );
  }
}

class Shop extends StatefulWidget {
  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  late UserCubit _userCubit;

  List<Products> products = [];
  List<Products> filteredProducts = [];
  final searchController = TextEditingController();

  String agentId = "";

  getAgentId() async {
    agentId = await StorageHandler.getAgentId();

    _userCubit = context.read<UserCubit>();

    _userCubit.agentShoppingList(agentId);
  }

  @override
  void initState() {
    getAgentId();
    super.initState();
  }

  void searchShopList(String query) {
    setState(() {
      filteredProducts = filteredProducts
          .where((posts) =>
              posts.name!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AccountViewModel>(context, listen: false);
    user.getUsername();
    return Scaffold(
        backgroundColor: AppColors.lightBackground,
        body: BlocConsumer<UserCubit, UserStates>(
          listener: (context, state) {
            if (state is ShoppingListLoaded) {
              if (state.shoppingList.status!) {
                products = state.shoppingList.data?.products ?? [];
                filteredProducts = products;
              } else {}
            } else if (state is UserNetworkErrApiErr) {
              Modals.showToast(state.message ?? '');
            } else if (state is UserNetworkErr) {
              Modals.showToast(state.message ?? '');
            }
          },
          builder: (context, state) => (state is ShoppingListLoading)
              ? LoadingPage()
              : Container(
                  height: screenSize(context).height * .9,
                  width: screenSize(context).width,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: TextEditView(
                              controller: searchController,
                              borderColor: Colors.white,
                              fillColor: Colors.white,
                              borderRadius: 30,
                              textColor: Colors.grey,
                              hintText: 'Search Products',
                              labelText: 'Search Products',
                              isDense: true,
                              prefixIcon: const Padding(
                                padding: EdgeInsets.all(15.0),
                                child: ImageView.svg(
                                  AppImages.searchIcon,
                                ),
                              ),
                              onChanged: (query) {
                                searchShopList(query);

                                if (query.length == 0) {
                                  filteredProducts = products;
                                }
                              },
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        Text('All Products'),
                        SizedBox(
                          height: 10,
                        ),
                        if (products.isEmpty) ...[
                          Container(
                              height: 400,
                              child: Align(
                                  child: Card(
                                elevation: 0.5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Container(
                                  height: 120,
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Nothing to show in your catalogue',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w300),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              AppNavigator.pushAndStackPage(
                                                  context,
                                                  page: CreateShopProducts());
                                            },
                                            child: Text(
                                              'Add products',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                decoration:
                                                    TextDecoration.underline,
                                                    
                                                color: AppColors.lightSecondary,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ))),
                        ] else if (products.isNotEmpty) ...[
                          Container(
                            margin: EdgeInsets.all(12),
                            child: StaggeredGridView.countBuilder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 1,
                                itemCount: filteredProducts.length,
                                itemBuilder: (context, index) {
                                  Color randomColor = getRandomColor();

                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (_) {
                                        return ProductDetailScreen(
                                            filteredProducts[index]
                                                .sId
                                                .toString(),
                                            filteredProducts[index]
                                                .price
                                                .toString(),
                                            user.username, filteredProducts[index].agent?.sId.toString() ?? '');
                                      }));
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Container(
                                            height: 150,
                                            width: MediaQuery.sizeOf(context)
                                                .width,
                                            color: randomColor.withOpacity(0.3),
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: ImageView.network(
                                                  filteredProducts[index].images?[0],
                                                  placeholder:
                                                      AppImages.appLogo,
                                                  fit: BoxFit.cover,
                                                  color: randomColor,
                                                )),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          filteredProducts[index].name ?? '',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(AppUtils.convertPrice(
                                                filteredProducts[index]
                                                    .price) ??
                                            ''),
                                        // RatingWidget(
                                        //   coloredStars: 3,
                                        // ),
                                      ],
                                    ),
                                  );
                                },
                                staggeredTileBuilder: (index) {
                                  return StaggeredTile.count(
                                      1,  1.36 );
                                }),
                          ),
                        ] else if (filteredProducts.isEmpty)
                          ...[
                            Container(
                              height: 400,
                              child: Align(
                                  child: Card(
                                elevation: 0.5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Container(
                                  height: 120,
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Nothing to show in your catalogue',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w300),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ))),
                          ]
                      ],
                    ),
                  ),
                ),
        ));
  }

  Color getRandomColor() {
    Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }
}

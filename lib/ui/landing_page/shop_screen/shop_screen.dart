import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/ui/landing_page/shop_screen/product_detail_screen.dart';

import 'package:petnity/ui/landing_page/widgets/rating_widget.dart';
import 'package:petnity/ui/widgets/image_view.dart';
import 'package:petnity/ui/widgets/loading_page.dart';
import 'package:petnity/ui/widgets/modals.dart';
import 'package:provider/provider.dart';

import '../../../blocs/user/user.dart';
import '../../../model/user_models/shopping_lists.dart';
import '../../../model/view_models/account_view_model.dart';
import '../../../model/view_models/user_view_model.dart';
import '../../../requests/repositories/user_repo/user_repository_impl.dart';
import '../../../res/app_images.dart';
import '../../../utils/app_utils.dart';
import '../../widgets/text_edit_view.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen();

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

  @override
  void initState() {
    _userCubit = context.read<UserCubit>();

    _userCubit.shoppingList();
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
                products = state.shoppingList.products ?? [];
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
                                      return ProductDetailScreen(filteredProducts[index].id.toString(), 
                                      filteredProducts[index].price.toString(), user.username);
                                    }));
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Container(
                                          color: randomColor.withOpacity(0.3),
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: ImageView.network(
                                                
                                                filteredProducts[index].image,
                                                placeholder: AppImages.appLogo,
                                                fit: BoxFit.contain,
                                                color: randomColor,
                                              )),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        filteredProducts[index].name ?? '',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(AppUtils.convertPrice(filteredProducts[index].price) ?? ''),
                                      RatingWidget(
                                        coloredStars: 3,
                                      ),
                                    ],
                                  ),
                                );
                              },
                              staggeredTileBuilder: (index) {
                                return StaggeredTile.count(
                                    1, index.isEven ? 1.45 : 1.6);
                              }),
                        ),
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

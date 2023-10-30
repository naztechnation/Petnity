import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/ui/landing_page/shop_screen/product_detail_screen.dart';


import 'package:petnity/ui/landing_page/widgets/rating_widget.dart';
import 'package:petnity/ui/widgets/loading_page.dart';
import 'package:petnity/ui/widgets/modals.dart';
import 'package:provider/provider.dart';

import '../../../blocs/user/user.dart';
import '../../../model/user_models/shopping_lists.dart';
import '../../../model/view_models/user_view_model.dart';
import '../../../requests/repositories/user_repo/user_repository_impl.dart';
import '../../widgets/filter_search_section.dart';


class ShopScreen extends StatelessWidget {
  const ShopScreen(
);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (BuildContext context) => UserCubit(
          userRepository: UserRepositoryImpl(),
          viewModel: Provider.of<UserViewModel>(context, listen: false)),
      child: Shop(
        
      ),
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


  @override
  void initState() {
    _userCubit = context.read<UserCubit>();

    _userCubit.shoppingList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: BlocProvider<UserCubit>(
                lazy: false,
                create: (_) => UserCubit(
                    userRepository: UserRepositoryImpl(),
                    viewModel:
                        Provider.of<UserViewModel>(context, listen: false)),
                child: BlocConsumer<UserCubit, UserStates>(
                  listener: (context, state) {
                    if (state is ShoppingListLoaded) {
                      if (state.shoppingList.status!) {

                        products = state.shoppingList.products ?? [];
                      } else {

                      }
                    } else if (state is UserNetworkErrApiErr) {
                      Modals.showToast(state.message ?? '');

                    } else if (state is UserNetworkErr) {
                      Modals.showToast(state.message ?? '');
                    }
                  },
                  builder: (context, state) => (state is ShoppingListLoading) ? LoadingPage() : Container(
          height: screenSize(context).height * .9,
          width: screenSize(context).width,
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child:  FilterSearchView(showFilter: false,),
                ),
                SizedBox(
                  height: 10,
                ),
                Text('All Products'),
                Container(
                  margin: EdgeInsets.all(12),
                  child: Expanded(
                    child: StaggeredGridView.countBuilder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 1,
                        itemCount: 9,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (_) {
                                return ProductDetailScreen();
                              }));
                            },
                            child: Container(
                              height: screenSize(context).height * .23,
                              child: Column(
                                children: [
                                  Container(
                                    height: screenSize(context).height * .2,
                                    width: screenSize(context).width * .4,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image:
                                                AssetImage('assets/images/logo2.jpg'),
                                            fit: BoxFit.fill),
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(15))),
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                    ),
                                  ),
                                  ListTile(
                                      title: Text(products[index].name ?? ''),
                                      trailing: Text(products[index].price ?? ''),
                                      subtitle: RatingWidget(
                                        coloredStars: 3,
                                      ))
                                ],
                              ),
                            ),
                          );
                        },
                        staggeredTileBuilder: (index) {
                          return StaggeredTile.count(1, index.isEven ? 1.45 : 1.6);
                        }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

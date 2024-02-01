import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/ui/support/track_purchase/track_purchase_screens/all_services.dart';
import 'package:petnity/ui/widgets/modals.dart';
import 'package:provider/provider.dart';

import '../../../blocs/user/user.dart';
import '../../../handlers/secure_handler.dart';
import '../../../model/user_models/order_list.dart';
import '../../../model/user_models/orders.dart';
import '../../../model/user_models/user_shopping_data.dart';
import '../../../model/user_models/vet_orders.dart';
import '../../../model/view_models/user_view_model.dart';
import '../../../requests/repositories/user_repo/user_repository_impl.dart';
import '../../../res/app_images.dart';
import '../../widgets/image_view.dart';

class TrackPurchase extends StatelessWidget {
  const TrackPurchase({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (BuildContext context) => UserCubit(
          userRepository: UserRepositoryImpl(),
          viewModel: Provider.of<UserViewModel>(context, listen: false)),
      child: TrackPurchaseScreen(),
    );
  }
}

class TrackPurchaseScreen extends StatefulWidget {
  const TrackPurchaseScreen({
    super.key,
  });

  @override
  State<TrackPurchaseScreen> createState() => _TrackPurchaseScreenState();
}

class _TrackPurchaseScreenState extends State<TrackPurchaseScreen> {
  String username = '';

  _TrackPurchaseScreenState();

  List<Orders> allUserOrder = [];
  List<Orders> completedUserOrder = [];
  List<Orders> pendingUserOrder = [];
  List<UserShopList> userShopOrder = [];
  List<Orders> ongoingUserOrder = [];
  List<Orders> rejectedUserOrder = [];

   List<VetOrders> vetOrders  = [];


  late UserCubit _userCubit;

  bool isLoading = false;

  getServicesTypes() async {
    username = await StorageHandler.getUserName();

    _userCubit = context.read<UserCubit>();

    setState(() {
      isLoading = true;
    });
    await _userCubit.userOrderList(username: username);
    await _userCubit.getUserShoppingList(username);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getServicesTypes();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserStates>(
      listener: (context, state) {
        if (state is OrderListLoaded) {
          if (state.orderList.status!) {
            allUserOrder = state.orderList.data?.orders?.reversed.toList() ?? [];
            ongoingUserOrder =
                _userCubit.viewModel.onGoingOrdersList.reversed.toList();
            completedUserOrder =
                _userCubit.viewModel.onCompletedOrdersList.reversed.toList();
            pendingUserOrder =
                _userCubit.viewModel.onPendingOrderList.reversed.toList();
            rejectedUserOrder =
                _userCubit.viewModel.onRejectedOrdersList.reversed.toList();

             vetOrders =    state.orderList.data?.vetOrders?.reversed.toList()  ?? [];
                 
          } else {}
        }else if(state is UserShopListLoaded){
          userShopOrder = state.userShopData.shopOrders ?? [];
        } 
        else if (state is UserNetworkErrApiErr) {
        } else if (state is UserNetworkErr) {}
      },
      builder: (context, state) => (state is OrderListLoading)
          ? Align(
              child: ImageView.asset(
              AppImages.loading,
              height: 50,
            ))
          : DefaultTabController(
              length: 7,
              child: Scaffold(
                backgroundColor: AppColors.lightBackground,
                body: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Text(
                            'Total Services (${allUserOrder.length + vetOrders.length})',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          )),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: Text(
                            'Ongoing Services (${ongoingUserOrder.length})',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TabBar(
                        unselectedLabelColor: Colors.black,
                        labelStyle: TextStyle(
                color: Colors.white, 
              ),
                        isScrollable: true,
                        indicator: BoxDecoration(
                            color: AppColors.lightSecondary,
                            borderRadius: BorderRadius.circular(20)),
                        tabs: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: Tab(
                              child: Align(
                                alignment: Alignment.center,
                                child: Text('All', ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Tab(
                              child: Align(
                                alignment: Alignment.center,
                                child: Text('Ongoing Services'),
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Tab(
                              child: Align(
                                alignment: Alignment.center,
                                child: Text('Vet Services'),
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Tab(
                              child: Align(
                                alignment: Alignment.center,
                                child: Text('Product Purchases'),
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Tab(
                              child: Align(
                                alignment: Alignment.center,
                                child: Text('Pending Services'),
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Tab(
                              child: Align(
                                alignment: Alignment.center,
                                child: Text('Completed Services'),
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Tab(
                              child: Align(
                                alignment: Alignment.center,
                                child: Text('Rejected Services'),
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          AllServices.services(
                            allOrders: allUserOrder,
                          ),
                          AllServices.services(
                            allOrders: ongoingUserOrder,
                          ),
                          AllServices.vet(
                            allOrders: ongoingUserOrder, userShopOrder: [], vetOrders: vetOrders,
                          ),
                          AllServices.shop(
                              userShopOrder: userShopOrder,
                              emptyListTitle: 'No available purchases'),

                              
                          AllServices.services(
                            allOrders: pendingUserOrder,
                          ),
                          AllServices.services(
                            allOrders: completedUserOrder,
                          ),
                          AllServices.services(
                            allOrders: rejectedUserOrder,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

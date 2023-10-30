import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/ui/landing_page/track_purchase/track_purchase_screens/all_services.dart';
import 'package:petnity/ui/landing_page/track_purchase/track_purchase_screens/awaiting_sessions.dart';
import 'package:petnity/ui/landing_page/track_purchase/track_purchase_screens/ongoing_purchase.dart';
import 'package:petnity/ui/landing_page/track_purchase/track_purchase_screens/ongoing_services.dart';
import 'package:petnity/ui/widgets/modals.dart';
import 'package:provider/provider.dart';

import '../../../blocs/user/user.dart';
import '../../../model/user_models/order_list.dart';
import '../../../model/view_models/user_view_model.dart';
import '../../../requests/repositories/user_repo/user_repository_impl.dart';
import '../../../res/app_images.dart';
import '../../widgets/image_view.dart';


class TrackPurchase extends StatelessWidget {

  final String username;
  const TrackPurchase({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (BuildContext context) => UserCubit(
          userRepository: UserRepositoryImpl(),
          viewModel: Provider.of<UserViewModel>(context, listen: false)),
      child: TrackPurchaseScreen(username: username,),
    );
  }
}
class TrackPurchaseScreen extends StatefulWidget {
  final String username;

  const TrackPurchaseScreen({super.key, required this.username});


  @override
  State<TrackPurchaseScreen> createState() => _TrackPurchaseScreenState(username: username, );
}

class _TrackPurchaseScreenState extends State<TrackPurchaseScreen> {
  final String username;

  _TrackPurchaseScreenState({required this.username});


  List<UserOrders> userOrder = [];

  late UserCubit _userCubit;

 bool isLoading = false;



  getServicesTypes() async {
    _userCubit = context.read<UserCubit>();

    setState(() {
      isLoading = true;
    });
    await _userCubit.userOrderList(username: username);
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
    return (isLoading)
        ? Scaffold(
            body: Align(
                child: ImageView.asset(
              AppImages.loading,
              height: 50,
            )),
          )
        :  BlocConsumer<UserCubit, UserStates>(
                listener: (context, state) {
                  if (state is OrderListLoaded) {
                    if (state.orderList.status!) {
                      Modals.showToast('Good one',);
                      
                    } else {}
                  } else if (state is UserNetworkErrApiErr) {
                  } else if (state is UserNetworkErr) {}
                },
                builder: (context, state) => DefaultTabController(
          length: 5,  
          child: Scaffold(
            backgroundColor: AppColors.lightBackground,
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total Purchases 56'),
                      Text('Ongoing Purchases 16')
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TabBar(
                    unselectedLabelColor: Colors.black,
                    isScrollable: true,
                    indicator: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20)),
                    tabs: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Tab(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text('All'),
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
                            child: Text('Ongoing Purchases'),
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
                            child: Text('Pending Products'),
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          // Customize the color as desired
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Tab(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text('Awaiting Sessions'),
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
                      AllServices(),
                      OngoinServices(),
                      OngoingPurchases(),
                      Center(child: Text('Tab 5 View')),
                      AwaitingSession(),
                      // Repeat the same pattern for other tab views
                      // Tab 3 View, Tab 4 View, Tab 5 View
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

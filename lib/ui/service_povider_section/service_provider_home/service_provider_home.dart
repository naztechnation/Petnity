import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:petnity/extentions/custom_string_extension.dart';
import 'package:petnity/requests/repositories/service_provider_repo/service_provider_repository_impl.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_images.dart';
import 'package:petnity/res/app_strings.dart';
import 'package:petnity/ui/service_povider_section/service_provider_home/all_requests_section/new_requests_delivery.dart';
import 'package:petnity/ui/widgets/button_view.dart';
import 'package:petnity/ui/widgets/filter_search_section.dart';
import 'package:petnity/ui/widgets/image_view.dart';
import 'package:provider/provider.dart';

import '../../../blocs/service_provider/service_provider.dart';
import '../../../handlers/secure_handler.dart';
import '../../../model/service_provider_models/all_agent_orders.dart';
import '../../../model/user_models/agent_services_lists.dart';
import '../../../model/view_models/service_provider_inapp.dart';
import '../../widgets/modals.dart';

class ServiceProviderHomePage extends StatelessWidget {
  const ServiceProviderHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ServiceProviderCubit>(
      create: (BuildContext context) => ServiceProviderCubit(
          serviceProviderRepository: ServiceProviderRepositoryImpl(),
          viewModel: Provider.of<ServiceProviderInAppViewModel>(context,
              listen: false)),
      child: ServiceProviderPage(),
    );
  }
}

class ServiceProviderPage extends StatefulWidget {
  ServiceProviderPage({super.key});

  @override
  State<ServiceProviderPage> createState() => _ServiceProviderPageState();
}

class _ServiceProviderPageState extends State<ServiceProviderPage> {
  final TextEditingController search = TextEditingController();

  String username = '';

  getUsername() async {
    username = await StorageHandler.getUserName();
  }

  final TextEditingController searchField = TextEditingController();

  List<ShopOrders> orders = [];
  List<AgentServicesListOrders> availableServices = [];

  late ServiceProviderCubit _serviceProviderCubit;
 
  String agentId = "";

  fetchOrders() async {
    agentId = await StorageHandler.getAgentId();
    _serviceProviderCubit = context.read<ServiceProviderCubit>();
    _serviceProviderCubit.getAllAgentOrder(agentId: agentId, pageIndex: '1');
    _serviceProviderCubit.getAgentsAvailableServices(agentId: agentId,);
  }
 

  @override
  void initState() {
    getUsername();
    fetchOrders();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: BlocConsumer<ServiceProviderCubit, ServiceProviderState>(
            listener: (context, state) {
          if (state is CreateServiceNetworkErr) {
            Modals.showToast(state.message ?? '');
          } else if (state is CreateServiceNetworkErrApiErr) {
            Modals.showToast(state.message ?? '');
          } else if (state is AgentOrdersLoaded) {
            orders = state.agentsOrderRequests.shopOrders ?? [];
          } else if (state is AgentServicesListLoaded) {
            availableServices = state.services.orders ?? [];

            
          }
        }, builder: (context, state) {
          if (state is AgentOrdersLoading || state is AgentServicesListLoading) {
            return Align(
                child: ImageView.asset(
              AppImages.loading,
              height: 50,
            ));
          }else if (state is AgentServicesListLoaded) {
            availableServices = state.services.orders ?? [];

             return Container(
             height: MediaQuery.of(context).size.height - kToolbarHeight,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: screenSize(context).width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            'Hi ${username.capitalizeFirstOfEach},',
                            maxLines: 1,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                fontFamily: AppStrings.interSans),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    'How is your pet doing?',
                    style: TextStyle(
                        fontFamily: AppStrings.interSans,
                        fontWeight: FontWeight.w800,
                        fontSize: 22),
                  ),
                  FilterSearchView(
                    showFilter: false,
                    controller: search,
                  ),
                  SizedBox(
                    height: 20,
                  ),
               ServiceProviderPetDeliveryHomeBody(serviceProviderCubit: _serviceProviderCubit,agentId: agentId,
                   
                 ),
                 
                ],
              ),
            ),
          );
          }

         return Align(
                child: ImageView.asset(
              AppImages.loading,
              height: 50,
            ));
        }),
      ),
    );
  }

  Widget card(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.white,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 6.0,
            ),
          ],
          gradient: LinearGradient(
              colors: [AppColors.scaffoldColor, Colors.red.shade50],
              begin: Alignment.topRight,
              end: Alignment.topLeft)),
      child: Row(
        children: [
          Container(
            width: screenSize(context).width * .60,
            height: screenSize(context).height * .2,
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Begin by adding your services and pricing',
                  maxLines: 3,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 17,
                      fontFamily: AppStrings.interSans),
                ),
                SizedBox(
                  height: 10,
                ),
                ButtonView(
                  borderRadius: 30,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  onPressed: () {},
                  child: Text('Begin Now'),
                  expanded: false,
                ),
              ],
            ),
          ),
          SizedBox(width: 130, child: ImageView.asset(AppImages.playingCat))
        ],
      ),
    );
  }

  Widget emptyBody(BuildContext context) {
    return Container(
      height: screenSize(context).height * .6,
      child: Column(
        children: [
          card(context),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: screenSize(context).width * .04),
            height: screenSize(context).height * .2,
            width: screenSize(context).width * .9,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Card(
                child: Center(
                    child: Text('Your ongoing sessions would appear here')),
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          )
        ],
      ),
    );
  }
}

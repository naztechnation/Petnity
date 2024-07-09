import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../blocs/user/user_cubit.dart';
import '../../../blocs/user/user_states.dart';
import '../../../model/agent/agent.dart';
import '../../../model/view_models/user_view_model.dart';
import '../../../requests/repositories/user_repo/user_repository_impl.dart';
import '../../../res/app_strings.dart';
import '../../widgets/back_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/empty_widget.dart';
import '../../widgets/filter_search_section.dart';
import '../../widgets/loading_page.dart';
import 'widgets/providers_card.dart';

class ServiceProvidersDetails extends StatelessWidget {
  final String petProvider;
  final String serviceId;
  const ServiceProvidersDetails(
      {super.key, required this.petProvider, required this.serviceId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (BuildContext context) => UserCubit(
          userRepository: UserRepositoryImpl(),
          viewModel: Provider.of<UserViewModel>(context, listen: false)),
      child: ServiceProvidersScreen(
        petProvider: petProvider,
        serviceId: serviceId,
      ),
    );
  }
}

class ServiceProvidersScreen extends StatefulWidget {
  ServiceProvidersScreen(
      {super.key, required this.petProvider, required this.serviceId});

  final String petProvider;
  final String serviceId;

  @override
  State<ServiceProvidersScreen> createState() => _ServiceProvidersScreenState();
}

class _ServiceProvidersScreenState extends State<ServiceProvidersScreen> {
  final List<String> addressSpinnerItems = [
    'State',
    'Enugu',
    'Ebonyi',
    'Lagos',
    'Kano',
    'Kastina',
    'Anambra'
  ];

  final List<String> age = ['18-25', '27-35', '36-45', '46-100'];

  final List<String> gender = ['Male', 'Female'];

  final List<String> animals = [
    'Dogs',
    'Cat',
    'Monkeys',
    'Rabbits',
    'Squirrels',
    'Parrots',
    'Birds'
  ];

  List<Agent> agentList = [];

  late UserCubit _userCubit;

  final TextEditingController _searchController = TextEditingController();


  @override
  void initState() {
    _userCubit = context.read<UserCubit>();
 
    _userCubit.getServiceProviderList(serviceId: widget.serviceId);
    super.initState();
  }

 

 @override
void dispose() {
  _searchController.dispose();
  super.dispose();
}


  @override
  Widget build(BuildContext context) {
    final user1 = Provider.of<UserViewModel>(context, listen: true);

    
    return Scaffold(
        body: BlocConsumer<UserCubit, UserStates>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is ServiceProviderListLoading) {
                return LoadingPage();
              } else if (state is UserNetworkErr) {
                return EmptyWidget(
                  title: 'Network error',
                  description: state.message,
                  onRefresh: () => _userCubit.getServiceProviderList(
                      serviceId: widget.serviceId),
                );
              } else if (state is UserNetworkErrApiErr) {
                return EmptyWidget(
                  title: 'Network error',
                  description: state.message,
                  onRefresh: () => _userCubit.getServiceProviderList(
                      serviceId: widget.serviceId),
                );
              } else if (state is ServiceProviderListLoaded) {
                agentList = _userCubit.viewModel.agents;
              }

              return Container(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                    SafeArea(
                        child: SizedBox(height: (Platform.isAndroid) ? 30 : 0)),
                    Row(
                      children: [
                        backButton(context),
                        const SizedBox(
                          width: 40,
                        ),
                        CustomText(
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          text: widget.petProvider,
                          weight: FontWeight.w600,
                          size: 22,
                          fontFamily: AppStrings.interSans,
                          color: Colors.black,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: FilterSearchView(
                        hintText: 'Search ${widget.petProvider}',
                        controller: _searchController,
                        onChanged: (value) {
                            user1.filterAgents(query: value);
                          },
                        showFilter: false,
                        onFilterTap: () {
                          // Modals.showBottomSheetModal(
                          //   context,
                          //   isDissmissible: true,
                          //   page: BottomSheetContent(
                          //       addressSpinnerItems: addressSpinnerItems,
                          //       age: age,
                          //       gender: gender,
                          //       animals: animals),
                          //   borderRadius: 30,
                          //   heightFactor: 1.5,
                          // );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    if (agentList.isNotEmpty) ...[
                      Expanded(
                          child: ListView.builder(
                              itemCount: agentList.length,
                              shrinkWrap: true,
                              itemBuilder: (_, index) {
                                return ProvidersCard(
                                  index: index,
                                );
                              }))
                    ]else ...[
                      Expanded(
                        child: SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.6,
                          child: Align(child: Text('No Agents Available for this service'))),
                      )
                    ]
                  ]));
            }));
  }
}

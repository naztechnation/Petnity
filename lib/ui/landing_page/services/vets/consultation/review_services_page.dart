import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/ui/widgets/back_button.dart';
import 'package:petnity/ui/widgets/button_view.dart';
import 'package:petnity/utils/app_utils.dart';
import 'package:provider/provider.dart';

import '../../../../../blocs/service_provider/service_provider.dart';
import '../../../../../handlers/secure_handler.dart';
import '../../../../../model/user_models/medium_types.dart';
import '../../../../../model/user_models/session_types.dart';
import '../../../../../model/view_models/account_view_model.dart';
import '../../../../../model/view_models/service_provider_inapp.dart';
import '../../../../../requests/repositories/service_provider_repo/service_provider_repository_impl.dart';
import '../../../../widgets/loading_page.dart';
import '../../../../widgets/modals.dart';

class ReviewServices extends StatelessWidget {
  final List<VetSessionTypes> sessionTypesSelectedItems;
 final List<VetContactMediums> contactMediumsSelectedItems;
  const ReviewServices({
    Key? key, required this.sessionTypesSelectedItems, required this.contactMediumsSelectedItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ServiceProviderCubit>(
      create: (BuildContext context) => ServiceProviderCubit(
          serviceProviderRepository: ServiceProviderRepositoryImpl(),
          viewModel: Provider.of<ServiceProviderInAppViewModel>(context,
              listen: false)),
      child: ReviewServicesPage(sessionTypesSelectedItems: sessionTypesSelectedItems, contactMediumsSelectedItems: contactMediumsSelectedItems,),
    );
  }
}

class ReviewServicesPage extends StatefulWidget {
  final List<VetSessionTypes> sessionTypesSelectedItems;
 final List<VetContactMediums> contactMediumsSelectedItems;
  const ReviewServicesPage({super.key, required this.sessionTypesSelectedItems, required this.contactMediumsSelectedItems});
  @override
  State<ReviewServicesPage> createState() => _ReviewServicesPageState();
}

class _ReviewServicesPageState extends State<ReviewServicesPage> {
  late ServiceProviderCubit _serviceProviderCubit;

  final amountController = TextEditingController();

  bool showButton = false;

  String agentId = "";
  String servicesId = "";

  getAgentId() async {
    agentId = await StorageHandler.getUserId();

    _serviceProviderCubit = context.read<ServiceProviderCubit>();
  }

  List<String>  contactMediums = [];
  List<String>  sessionTypes = [];


  @override
  void initState() {
    getAgentId();

     contactMediums = extractIds(widget.contactMediumsSelectedItems);
     sessionTypes = extractIds1(widget.sessionTypesSelectedItems);
    super.initState();
  }

  
  

  List<String> extractIds(List<VetContactMediums> itemList) {
  List<String> ids = [];
  for (var map in itemList) {
    String id = map.sId ?? '';
    ids.add(id);
  }
  return ids;
}

  List<String> extractIds1(List<VetSessionTypes> itemList) {
  List<String> ids = [];
  for (var map in itemList) {
    String id = map.sId ?? '';
    ids.add(id);
  }
  return ids;
}

  @override
  Widget build(BuildContext context) {
    final serviceProvider =
        Provider.of<ServiceProviderInAppViewModel>(context, listen: true);

    final serviceAccount = Provider.of<AccountViewModel>(context, listen: true);

    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(
        leading: backButton(context),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Review',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: 'InterSans'),
        ),
      ),
      body: BlocConsumer<ServiceProviderCubit, ServiceProviderState>(
          listener: (context, state) {
        if (state is CreateServiceNetworkErr) {
          Modals.showToast(state.message ?? '');
        } else if (state is CreateServiceNetworkErrApiErr) {
          Modals.showToast(state.message ?? '');
        } else if (state is CreateServicesLoaded) {
          _serviceProviderCubit.publishAgentServices(
              agentId: agentId,
              serviceId: state.data.data?.vetService?.sId.toString() ?? '');
        } else if (state is PublishServicesLoaded) {
          Modals.showToast(state.data.message ?? '');
        }
      }, builder: (context, state) {
        return (state is PublishServicesLoading ||
                state is CreateServicesLoading)
            ? LoadingPage()
            : Container(
                height: screenSize(context).height * .9,
                padding: EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: screenSize(context).width,
                        child: Text(
                          'Your Choice',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'InterSans'),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Selected session and choice',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'InterSans',
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Contact Medium',
                        style: TextStyle(
                          color: Colors.black,
                           fontWeight: FontWeight.bold,
                          fontFamily: 'InterSans',
                        ),
                      ),
                      ListView.builder(
                        itemCount: widget.contactMediumsSelectedItems.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          String item = widget.contactMediumsSelectedItems[index].name ?? '';
                          

                          return buildServiceTypeWidget(
                              index, item,);
                        },
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Divider(),
                       SizedBox(
                        height: 15,
                      ),
                       Text(
                        'Session Type',
                        style: TextStyle(
                          color: Colors.black,
                           fontWeight: FontWeight.bold,
                          fontFamily: 'InterSans',
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      ListView.builder(
                        itemCount: widget.sessionTypesSelectedItems.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          String item = widget.sessionTypesSelectedItems[index].name ?? '';
                           

                          return buildSessionTypeWidget(
                              index, item);
                        },
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Divider(),
                      SizedBox(
                        height: 15,
                      ),
                       Text(
                        'Session Amount',
                        style: TextStyle(
                          color: Colors.black,
                           fontWeight: FontWeight.bold,
                          fontFamily: 'InterSans',
                        ),
                      ),
                       SizedBox(
                        height: 5,
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        height: screenSize(context).height * .07,
                        width: screenSize(context).width ,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.lightPrimary,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              'NGN ${AppUtils.convertPrice(serviceProvider.amountController)}',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'InterSans'),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30,),
                      Container(
                        height: screenSize(context).height * .12,
                        padding:
                            EdgeInsets.symmetric(vertical: 23, horizontal: 6),
                        child: ButtonView(
                            borderRadius: 50,
                            onPressed: () {
                              _serviceProviderCubit.createAgentServices(
                                agentId: agentId,
                                serviceId: serviceAccount.serviceId,
                                amount: int.parse(serviceProvider.amountController),
                                contactMedium:contactMediums,
                                sessionType: sessionTypes,
                              );

                              
                            },
                            child: Text(
                              'Publish Session',
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                    ],
                  ),
                ),
              );
      }),
    );
  }

  Widget buildSessionTypeWidget(
      int index, String label, ) {
    return Card(
      elevation: 1,
      color: AppColors.lightPrimary,
      child: Container(
        height: screenSize(context).height * .07,
        width: screenSize(context).width * .9,
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.lightPrimary,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'InterSans'),
            ),
            // ImageView.svg(
            //   image,
            //   color: Colors.black,
            // ),
          ],
        ),
      ),
    );
  }

  Widget buildServiceTypeWidget(
      int index, String label,) {
    return Card(
      elevation: 1,
      color: AppColors.lightPrimary,
      child: Container(
        padding: EdgeInsets.all(10),
        height: screenSize(context).height * .07,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.lightPrimary,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'InterSans'),
            ),
            // ImageView.asset(
            //   image,
            // ),
          ],
        ),
      ),
    );
  }
}

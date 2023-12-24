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
import '../../../../../model/view_models/account_view_model.dart';
import '../../../../../model/view_models/service_provider_inapp.dart';
import '../../../../../requests/repositories/service_provider_repo/service_provider_repository_impl.dart';
import '../../../../widgets/image_view.dart';
import '../../../../widgets/loading_page.dart';
import '../../../../widgets/modals.dart';

class ReviewServices extends StatelessWidget {
  const ReviewServices({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ServiceProviderCubit>(
      create: (BuildContext context) => ServiceProviderCubit(
          serviceProviderRepository: ServiceProviderRepositoryImpl(),
          viewModel: Provider.of<ServiceProviderInAppViewModel>(context,
              listen: false)),
      child: ReviewServicesPage(),
    );
  }
}

class ReviewServicesPage extends StatefulWidget {
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
    agentId = await StorageHandler.getAgentId();

    _serviceProviderCubit = context.read<ServiceProviderCubit>();
  }

  @override
  void initState() {
    getAgentId();
    super.initState();
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
              serviceId: state.data.vetService?.id.toString() ?? '');
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
                      ListView.builder(
                        itemCount: serviceProvider.servicesType.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          String item = serviceProvider.servicesType[index]
                              .split('-')
                              .first
                              .trim();
                          String image = serviceProvider.servicesType[index]
                              .split('-')
                              .last
                              .trim();

                          return buildServiceTypeWidget(
                              index, image, item, serviceProvider);
                        },
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Divider(),
                      SizedBox(
                        height: 5,
                      ),
                      ListView.builder(
                        itemCount: serviceProvider.contactType.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          String item = serviceProvider.contactType[index]
                              .split('-')
                              .first
                              .trim();
                          String image = serviceProvider.contactType[index]
                              .split('-')
                              .last
                              .trim();

                          return buildSessionTypeWidget(
                              index, image, item, serviceProvider);
                        },
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Divider(),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        height: screenSize(context).height * .07,
                        width: screenSize(context).width * .9,
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
                            EdgeInsets.symmetric(vertical: 23, horizontal: 20),
                        child: ButtonView(
                            borderRadius: 50,
                            onPressed: () {
                              _serviceProviderCubit.createAgentServices(
                                agentId: agentId,
                                serviceId: serviceAccount.serviceId,
                                amount: serviceProvider.amountController,
                                contactMedium: serviceProvider.contactType,
                                sessionType: serviceProvider.servicesType,
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
      int index, String image, String label, var services) {
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
            ImageView.svg(
              image,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildServiceTypeWidget(
      int index, String image, String label, var service) {
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
            ImageView.asset(
              image,
            ),
          ],
        ),
      ),
    );
  }
}

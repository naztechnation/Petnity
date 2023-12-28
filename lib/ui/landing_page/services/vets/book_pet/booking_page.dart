import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petnity/model/user_models/vet_services.dart';
import 'package:provider/provider.dart';

import '../../../../../blocs/service_provider/service_provider.dart';
import '../../../../../handlers/secure_handler.dart';
import '../../../../../model/view_models/service_provider_inapp.dart';
import '../../../../../requests/repositories/service_provider_repo/service_provider_repository_impl.dart';
import '../../../../../res/app_colors.dart';
import '../../../../../res/app_constants.dart';
import '../../../../../utils/app_utils.dart';
import '../../../../widgets/back_button.dart';
import '../../../../widgets/button_view.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/image_view.dart';
import '../../../../widgets/loading_page.dart';
import '../../../../widgets/modals.dart';

class VetBookingPage extends StatelessWidget {
  final String name;
  final String image;
  final String gender;
  final String location;
  final String about;
  const VetBookingPage({
    Key? key,
    required this.name,
    required this.image,
    required this.gender,
    required this.location,
    required this.about,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ServiceProviderCubit>(
      create: (BuildContext context) => ServiceProviderCubit(
          serviceProviderRepository: ServiceProviderRepositoryImpl(),
          viewModel: Provider.of<ServiceProviderInAppViewModel>(context,
              listen: false)),
      child: VetBooking(
        name: name,
        image: image,
        gender: gender,
        location: location,
        about: about,
      ),
    );
  }
}

class VetBooking extends StatefulWidget {
  final String name;

  final String image;

  final String gender;

  final String location;

  final String about;

  VetBooking(
      {super.key,
      required this.name,
      required this.image,
      required this.gender,
      required this.location,
      required this.about});
  @override
  State<VetBooking> createState() => _VetBookingState();
}

class _VetBookingState extends State<VetBooking> {
  late ServiceProviderCubit _serviceProviderCubit;

  VetsServices? vetServices;

  String agentId = "";

  getAgentId() async {
    agentId = await StorageHandler.getAgentId();

    _serviceProviderCubit = context.read<ServiceProviderCubit>();

    _serviceProviderCubit.vetServices(agentId: agentId);
  }

  @override
  void initState() {
    getAgentId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: backButton(context),
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            'Vets Services',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 16,
                fontFamily: 'InterSans'),
          ),
        ),
        body: BlocConsumer<ServiceProviderCubit, ServiceProviderState>(
            listener: (context, state) {
          if (state is CreateServiceNetworkErr) {
            Modals.showToast(state.message ?? '');
          } else if (state is CreateServiceNetworkErrApiErr) {
            Modals.showToast(state.message ?? '');
          } else if (state is VetsServicesLoaded) {
            vetServices = state.vetService;
          } else if (state is PublishServicesLoaded) {
            Modals.showToast(state.data.message ?? '');
          }
        }, builder: (context, state) {
          return (state is VetsServicesLoading ||
                  state is CreateServicesLoading)
              ? LoadingPage()
              : Container(
                  height: screenSize(context).height,
                  width: screenSize(context).width,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [AppColors.scaffoldColor, Colors.red.shade50],
                          begin: Alignment.topRight,
                          end: Alignment.topLeft)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Vets Profile',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                fontFamily: 'InterSans'),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: MediaQuery.sizeOf(context).width,
                            child: Card(
                              elevation: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 90,
                                          height: 90,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: ImageView.network(
                                                  widget.image)),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    children: [
                                                      CustomText(
                                                        text: 'Name',
                                                        size: 12,
                                                      ),
                                                      CustomText(
                                                        text: widget.name,
                                                        weight: FontWeight.bold,
                                                        size: 12,
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    width: 40,
                                                  ),
                                                  Column(
                                                    children: [
                                                      CustomText(
                                                        text: 'Gender',
                                                        size: 12,
                                                      ),
                                                      CustomText(
                                                        text: widget.gender,
                                                        weight: FontWeight.bold,
                                                        size: 12,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              CustomText(
                                                text: 'Location',
                                                size: 12,
                                              ),
                                              CustomText(
                                                text: widget.location,
                                                weight: FontWeight.bold,
                                                size: 12,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    CustomText(
                                      text: 'About:',
                                      size: 12,
                                      weight: FontWeight.bold,
                                    ),
                                    CustomText(
                                      text: widget.about,
                                      size: 12,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomText(
                            text: 'Vets Package',
                            size: 15,
                            weight: FontWeight.bold,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.sizeOf(context).width,
                            child: Card(
                              elevation: 1,
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Align(
                                    child: Container(
                                      width: 130,
                                      height: 130,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(150),
                                          child: ImageView.network(
                                            vetServices?.vetService?.serviceType
                                                ?.image,
                                            fit: BoxFit.cover,
                                          )),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  CustomText(
                                    text:
                                        'Service Amount: NGN ${AppUtils.convertPrice(vetServices?.vetService?.price)}',
                                    size: 15,
                                    weight: FontWeight.w700,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomText(
                            text: 'Service Types',
                            size: 15,
                            weight: FontWeight.bold,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Card(
                            elevation: 1,
                            child: Container(
                             // height: screenSize(context).height * .07,
                              width: screenSize(context).width * .9,
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                                                color: Colors.grey.withOpacity(0.04),

                              ),
                              child: ListView.builder(
                                itemCount: vetServices
                                    ?.vetService?.sessionTypes?.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return buildSessionTypeWidget(
                                      index,
                                      '',
                                      vetServices?.vetService
                                              ?.sessionTypes?[index].name ??
                                          '',
                                      context);
                                },
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomText(
                            text: 'Contact Medium',
                            size: 15,
                            weight: FontWeight.bold,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Card(
                            elevation: 1,
                            child: Container(
                             // height: screenSize(context).height * .07,
                              width: screenSize(context).width * .9,
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey.withOpacity(0.04),
                              ),
                              child: ListView.builder(
                                itemCount: vetServices
                                    ?.vetService?.contactMediums?.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return buildSessionTypeWidget(
                                      index,
                                      '',
                                      vetServices?.vetService
                                              ?.contactMediums?[index].name ??
                                          '',
                                      context);
                                },
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: screenSize(context).height * .12,
                            padding: EdgeInsets.symmetric(
                                vertical: 23, horizontal: 20),
                            child: ButtonView(
                                borderRadius: 50,
                                onPressed: () {},
                                child: Text(
                                  'Pay for Session',
                                  style: TextStyle(color: Colors.white),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
        }));
  }

  Widget buildSessionTypeWidget(
      int index, String image, String label, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          label,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: 'InterSans'),
        ),
        const SizedBox(
          height: 10,
        ),
        Divider()
      ],
    );
  }
}

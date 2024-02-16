import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwave_standard/flutterwave.dart';
import 'package:intl/intl.dart';
import 'package:petnity/model/user_models/vet_service.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../../../blocs/service_provider/service_provider.dart';
import '../../../../../handlers/secure_handler.dart';
import '../../../../../model/service_provider_models/vetservices_model.dart';
import '../../../../../model/view_models/service_provider_inapp.dart';
import '../../../../../requests/repositories/service_provider_repo/service_provider_repository_impl.dart';
import '../../../../../res/app_colors.dart';
import '../../../../../res/app_constants.dart';
import '../../../../../res/app_images.dart';
import '../../../../../res/app_strings.dart';
import '../../../../../res/enum.dart';
import '../../../../../utils/app_utils.dart';
import '../../../../widgets/back_button.dart';
import '../../../../widgets/button_view.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/image_view.dart';
import '../../../../widgets/loading_page.dart';
import '../../../../widgets/modals.dart';

class VetBookingPage extends StatelessWidget {
  final String name;
  final String agentId;
  final String image;
  final String gender;
  final String location;
  final String about;
  final String vetId;
  const VetBookingPage({
    Key? key,
    required this.name,
    required this.image,
    required this.gender,
    required this.location,
    required this.about, required this.agentId, required this.vetId,
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
        vetId: vetId,
        image: image,
        gender: gender,
        location: location,
        about: about, agentId: agentId,
      ),
    );
  }
}

class VetBooking extends StatefulWidget {
  final String name;
  final String agentId;

  final String image;

  final String gender;

  final String location;

  final String about;
  final String vetId;

  VetBooking(
      {super.key,
      required this.name,
      required this.image,
      required this.gender,
      required this.location,
      required this.about, required this.agentId, required this.vetId});
  @override
  State<VetBooking> createState() => _VetBookingState();
}

class _VetBookingState extends State<VetBooking> {
  DateTime selectedDate1 = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String selectedTime1 = 'Select Time';
  late ServiceProviderCubit _serviceProviderCubit;

  VetServices? vetServices;

  String amount = "";

   
  String username = "";
  String vetServiceId = "";

  String email = '';

  String transactionId = '';
  String txId = '';
  var uuid = const Uuid();

  bool isLoading = true;
  bool isLive = false;

  getAgentId() async {
   // agentId = await StorageHandler.getAgentId();
    username = await StorageHandler.getUserName();
    email = await StorageHandler.getUserEmail();

    _serviceProviderCubit = context.read<ServiceProviderCubit>();

    setState(() {
      isLoading = true;
    });

    await _serviceProviderCubit.vetServices(agentId: widget.vetId);
    setState(() {
      isLoading = false;
    });
    transactionId = uuid.v1();
  }

  _handlePaymentInitialization(String orderId) async {
    final Customer customer = Customer(email: email);

    final Flutterwave flutterwave = Flutterwave(
        context: context,
        publicKey: AppStrings.flutterwaveApiKey,
        currency: 'NGN',
        redirectUrl: 'https://lucacify.com',
        txRef: uuid.v1(),
        amount: amount,
        customer: customer,
        paymentOptions: "card",
        customization: Customization(
          title: "Lucacify",
          logo: AppImages.logo,
        ),
        isTestMode: true);
    final ChargeResponse response = await flutterwave.charge();

    if (response != null) {
      txId = response.transactionId ?? '';

      if (txId != '') {
        _serviceProviderCubit.verifyVetOrder(
            orderId: orderId,
            username: username,
            purchaseId: txId,
            vetServiceId: vetServiceId);
      }
    } else {
      Modals.showToast('Unable to make payment Successfully.',
          messageType: MessageType.error);
    }
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

            amount = vetServices?.data?.vetService?.price.toString() ?? '';
            vetServiceId = vetServices?.data?.vetService?.sId.toString() ?? '';

            isLive = vetServices?.data?.vetService?.isLive ?? false;
             
          } else if (state is VetsServicesOrderLoaded) {
            _handlePaymentInitialization(
                state.vetService.order?.id.toString() ?? '');
          } else if (state is VetsConfirmOrderLoaded) {
            Modals.showToast(state.vetService.message ?? '');
          }
        }, builder: (context, state) {
          return (isLoading)
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
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white.withOpacity(0.8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                                BorderRadius.circular(120),
                                            child: ImageView.network(
                                              widget.image,
                                              fit: BoxFit.cover,
                                            )),
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
                          const SizedBox(
                            height: 10,
                          ),
                          if (isLive) ...[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: 'Vets Package',
                                  weight: FontWeight.w700,
                                  size: 14,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: MediaQuery.sizeOf(context).width,
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white.withOpacity(0.8),
                                  ),
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
                                                // vetServices?.data?.vetService
                                                //         ?.serviceType?. ??
                                                    '',
                                                fit: BoxFit.cover,
                                              )),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      CustomText(
                                        text:
                                            'Service Amount: NGN ${AppUtils.convertPrice(vetServices?.data?.vetService?.price ?? '0')}',
                                        size: 13,
                                        weight: FontWeight.w600,
                                        color: AppColors.lightSecondary,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomText(
                                  text: 'Service Types',
                                  weight: FontWeight.w700,
                                  size: 14,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: screenSize(context).width * .9,
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white.withOpacity(0.8),
                                  ),
                                  child: ListView.builder(
                                    itemCount: vetServices?.data?.vetService
                                            ?.sessionTypes?.length ??
                                        0,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return buildSessionTypeWidget(
                                          index,
                                          '',
                                          vetServices?.data?.vetService
                                                  ?.sessionTypes?[index].name ??
                                              '',
                                          context);
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                CustomText(
                                  text: 'Contact Medium',
                                  weight: FontWeight.w700,
                                  size: 14,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: screenSize(context).width * .9,
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white.withOpacity(0.8),
                                  ),
                                  child: ListView.builder(
                                    itemCount: vetServices?.data?.vetService
                                            ?.contactMediums?.length ??
                                        0,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return buildSessionTypeWidget(
                                          index,
                                          '',
                                          vetServices
                                                  ?.data?.vetService
                                                  ?.contactMediums?[index]
                                                  .name ??
                                              '',
                                          context);
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomText(
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  text: 'Select Session Time',
                                  weight: FontWeight.w700,
                                  size: 14,
                                  fontFamily: AppStrings.interSans,
                                  color: Colors.black,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            ImageView.svg(
                                              AppImages.calender,
                                              height: 18,
                                            ),
                                            SizedBox(width: 5),
                                            CustomText(
                                              textAlign: TextAlign.center,
                                              maxLines: 2,
                                              text: 'Date',
                                              weight: FontWeight.w600,
                                              size: 14,
                                              fontFamily: AppStrings.interSans,
                                              color: Colors.black,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        ButtonView(
                                          color: Colors.white,
                                          expanded: false,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          borderColor: Colors.white,
                                          borderRadius: 40,
                                          onPressed: () {
                                            _selectDate(context);
                                          },
                                          child: CustomText(
                                            textAlign: TextAlign.left,
                                            maxLines: 2,
                                            text: selectedDate1
                                                .toString()
                                                .split(' ')
                                                .first,
                                            weight: FontWeight.w500,
                                            size: 16,
                                            color: Colors.black,
                                          ),
                                        )
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            ImageView.svg(
                                              AppImages.time,
                                              height: 18,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            CustomText(
                                              textAlign: TextAlign.center,
                                              maxLines: 2,
                                              text: 'Time',
                                              weight: FontWeight.w600,
                                              size: 14,
                                              fontFamily: AppStrings.interSans,
                                              color: Colors.black,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        ButtonView(
                                          color: Colors.white,
                                          expanded: false,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          borderColor: Colors.white,
                                          borderRadius: 40,
                                          onPressed: () {
                                            _selectTime(context);
                                          },
                                          child: CustomText(
                                            textAlign: TextAlign.left,
                                            maxLines: 2,
                                            text: selectedTime1,
                                            weight: FontWeight.w500,
                                            size: 16,
                                            color: Colors.black,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 23, horizontal: 0),
                                  child: ButtonView(
                                      borderRadius: 50,
                                      processing:
                                          state is VetsServicesOrderLoading ||
                                              state is VetsConfirmOrderLoading,
                                      onPressed: () {
                                        DateTime combinedDateTime = DateTime(
                                          selectedDate1.year,
                                          selectedDate1.month,
                                          selectedDate1.day,
                                          selectedTime.hour,
                                          selectedTime.minute,
                                        );

                                        String formattedDateTime =
                                            DateFormat("yyyy-MM-dd'T'HH:mm:ssZ")
                                                .format(combinedDateTime);

                                        if (selectedTime1 != 'Select Time') {
                                          _serviceProviderCubit
                                              .vetServicesOrder(
                                                  agentId: widget.agentId,
                                                  fee: amount,
                                                  vetService: widget.vetId,
                                                  sessionTime:
                                                      formattedDateTime);
                                        } else {
                                          Modals.showToast(
                                              'please select session date and time');
                                        }
                                      },
                                      child: Text(
                                        'Pay for Session',
                                        style: TextStyle(color: Colors.white),
                                      )),
                                ),
                              ],
                            )
                          ] else 
                            ...[
                              SizedBox(
                                height: MediaQuery.sizeOf(context).height * 0.5,
                                child: Center(
                                  child: Text(
                                            'No available packages for this agent',
                                            style: TextStyle(color: Colors.black),
                                          ),
                                ),
                              )
                            ],
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
              fontWeight: FontWeight.w600,
              fontSize: 13,
              fontFamily: 'InterSans'),
        ),
        const SizedBox(
          height: 10,
        ),
        Divider()
      ],
    );
  }

  Future<void> _selectDate(
    BuildContext context,
  ) async {
    DateTime selectedDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate1 = picked;
      });
    }
  }

  Future<void> _selectTime(
    BuildContext context,
  ) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;

        selectedTime1 = '${selectedTime.hour}:${selectedTime.minute}';

        String formattedTime = selectedTime.format(context);
        selectedTime1 = formattedTime;
      });
    }
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petnity/ui/widgets/button_view.dart';
import 'package:petnity/ui/widgets/image_view.dart';
import 'package:petnity/ui/widgets/loading_page.dart';
import 'package:petnity/ui/widgets/modals.dart';
import 'package:provider/provider.dart';

import '../../../../blocs/service_provider/service_provider.dart';
import '../../../../blocs/user/user.dart';
import '../../../../handlers/secure_handler.dart';
import '../../../../model/view_models/account_view_model.dart';
import '../../../../model/view_models/service_provider_inapp.dart';
import '../../../../model/view_models/user_view_model.dart';
import '../../../../requests/repositories/service_provider_repo/service_provider_repository_impl.dart';
import '../../../../requests/repositories/user_repo/user_repository_impl.dart';
import '../../../../res/app_colors.dart';
import '../../../../res/app_constants.dart';
import '../../../../res/app_routes.dart';
import '../../../../res/app_strings.dart';
import '../../../../utils/navigator/page_navigator.dart';
import '../../../widgets/back_button.dart';
import '../../../widgets/custom_text.dart';
import 'track_service_body.dart';

class TrackServicesScreen extends StatelessWidget {
  final String sellerName;
  final String sellerImage;
  final String phone;
  final String serviceOffered;
  final String agentId;
  final String orderId;
  final String customerName;

  final String sellerId;
  final String startDate1;
  final String startDate2;
  final String amount;
  final String paymentId;
  final bool isAcceptedService;
  final bool isOngoingService;
  final bool isCompletedService;

  const TrackServicesScreen(
      {required this.sellerName,
      required this.phone,
      required this.serviceOffered,
      required this.agentId,
      required this.sellerId,
      required this.startDate1,
      required this.startDate2,
      required this.amount,
      required this.paymentId,
      required this.sellerImage,
      required this.isAcceptedService,
      required this.isOngoingService,
      required this.isCompletedService,
      required this.orderId, required this.customerName});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (BuildContext context) => UserCubit(
          userRepository: UserRepositoryImpl(),
          viewModel: Provider.of<UserViewModel>(context, listen: false)),
      child: TrackServices(
        phone: phone,
        sellerName: sellerName,
        serviceOffered: serviceOffered,
        agentId: agentId,
        startDate1: startDate1,
        startDate2: startDate2,
        amount: amount,
        paymentId: paymentId,
        sellerPhoto: sellerImage,
        sellerId: sellerId,
        isAcceptedService: isAcceptedService,
        isOngoingService: isOngoingService,
        isCompletedService: isCompletedService,
        orderId: orderId, customerName: customerName,
      ),
    );
  }
}

class TrackServices extends StatefulWidget {
  final String sellerName;
  final String sellerPhoto;
  final String phone;
  final String serviceOffered;
  final String agentId;
  final String sellerId;
  final String orderId;
  final String customerName;


  final String startDate1;
  final String startDate2;
  final String amount;
  final String paymentId;
  final bool isAcceptedService;
  final bool isOngoingService;
  final bool isCompletedService;

  const TrackServices(
      {super.key,
      required this.sellerName,
      required this.phone,
      required this.serviceOffered,
      required this.agentId,
      required this.sellerId,
      required this.startDate1,
      required this.startDate2,
      required this.amount,
      required this.paymentId,
      required this.sellerPhoto,
      required this.isAcceptedService,
      required this.isOngoingService,
      required this.isCompletedService,
      required this.orderId, required this.customerName});

  @override
  State<TrackServices> createState() => _TrackServicesState();
}

class _TrackServicesState extends State<TrackServices> {
  late UserCubit _userCubit;
  String username = '';

  String userType = '';
  String sessionStatus = '';

  getUsername() async {
    username = await StorageHandler.getUserName();
    userType = await StorageHandler.getUserType();

    _userCubit = context.read<UserCubit>();

    _userCubit.orderList(username: username);

    setState(() {});
    checkStatus();
  }

  @override
  void initState() {
    getUsername();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider<ServiceProviderCubit>(
      lazy: false,
      create: (_) => ServiceProviderCubit(
          serviceProviderRepository: ServiceProviderRepositoryImpl(),
          viewModel: Provider.of<ServiceProviderInAppViewModel>(context,
              listen: false)),
      child: BlocConsumer<ServiceProviderCubit, ServiceProviderState>(
        listener: (context, state) {
          if (state is AcceptOrderLoaded) {
            if (state.order.status!) {
              Modals.showToast(state.order.message ?? '');
              AppNavigator.pushAndReplaceName(context,
                  name: AppRoutes.serviceProviderLandingPage);
            } else {
              Modals.showToast(state.order.message ?? '');
            }
          } else if (state is AcceptCompletedOrderLoaded) {
            if (state.order.status!) {
              AppNavigator.pushAndReplaceName(context,
                  name: AppRoutes.serviceProviderLandingPage);
              Modals.showToast(state.order.message ?? '');
            } else {
              Modals.showToast(state.order.message ?? '');
            }
          } else if (state is AcceptOngoingOrderLoaded) {
            if (state.order.status!) {
              AppNavigator.pushAndReplaceName(context,
                  name: AppRoutes.serviceProviderLandingPage);
              Modals.showToast(state.order.message ?? '');
            } else {
              Modals.showToast(state.order.message ?? '');
            }
          } else if (state is CreateServiceNetworkErr) {
            Modals.showToast(state.message ?? '');
          } else if (state is CreateServiceNetworkErrApiErr) {
            Modals.showToast(state.message ?? '');
          }
        },
        builder: (context, state) => (state is AcceptOrderLoading)
            ? LoadingPage()
            : Stack(
                children: [
                  Container(
                    height: screenSize(context).height,
                    width: screenSize(context).width,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                      AppColors.scaffoldColor,
                      Colors.red.shade50
                    ], begin: Alignment.topRight, end: Alignment.topLeft)),
                    child: Column(
                      children: [
                        SafeArea(
                            child: Container(
                                color: AppColors.cardColor,
                                height: (Platform.isAndroid) ? 0 : 0)),
                        Container(
                          padding: const EdgeInsets.only(bottom: 20, top: 20),
                          child: Row(
                            children: [
                              backButton(context),
                              const SizedBox(
                                width: 40,
                              ),
                              CustomText(
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                text:  'Track service',
                                weight: FontWeight.w700,
                                size: 20,
                                fontFamily: AppStrings.interSans,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                              child: Column(
                            children: [
                              const SizedBox(
                                height: 30,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      textAlign: TextAlign.left,
                                      maxLines: 2,
                                      text: (userType == 'user') ? 'Service provider details' : 'Customer details',
                                      weight: FontWeight.w700,
                                      size: 12,
                                      fontFamily: AppStrings.interSans,
                                      color: Colors.black,
                                    ),
                                   Row(
                                      children: [
                                        CustomText(
                                          textAlign: TextAlign.left,
                                          maxLines: 2,
                                          text: 'Service:',
                                          weight: FontWeight.w400,
                                          size: 12,
                                          fontFamily: AppStrings.interSans,
                                          color: Colors.black,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        CustomText(
                                          textAlign: TextAlign.left,
                                          maxLines: 2,
                                          text: widget.serviceOffered,
                                          weight: FontWeight.w700,
                                          size: 12,
                                          fontFamily: AppStrings.interSans,
                                          color: Colors.black,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TrackServicesBody(
                                sellerName: widget.sellerName,
                                phone: widget.phone,
                                agentId: widget.agentId,
                                sellerId: widget.sellerId,
                                startDate1: widget.startDate1,
                                startDate2: widget.startDate2,
                                amount: widget.amount,
                                paymentId: widget.paymentId,
                                sellerPhoto: widget.sellerPhoto,
                                sessionStatus: sessionStatus,
                              )
                            ],
                          )),
                        ),
                      ],
                    ),
                  ),
                  if (userType == 'user')
                    Positioned(
                      bottom: 30,
                      left: 0,
                      right: 0,
                      child: Container(
                        margin: const EdgeInsets.only(
                            bottom: 50, left: 20, right: 20),
                        child: ButtonView(
                          borderRadius: 30,
                          onPressed: () {
                            // AppNavigator.pushAndStackPage(context,
                            //     page: DateSelection());
                          },
                          child: CustomText(
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            text: 'Release payment',
                            weight: FontWeight.w700,
                            size: 16,
                            fontFamily: AppStrings.interSans,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  if (userType == 'service_provider') ...[
                    if (!widget.isAcceptedService) ...[
                      Positioned(
                        bottom: 30,
                        left: 0,
                        right: 0,
                        child: Container(
                          margin: const EdgeInsets.only(
                              bottom: 50, left: 20, right: 20),
                          child: ButtonView(
                            borderRadius: 30,
                            onPressed: () {
                              markAccepted(
                                ctx: context,
                                agentId: widget.sellerId,
                                orderId: widget.orderId,
                              );
                            },
                            child: CustomText(
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              text: 'Accept Services',
                              weight: FontWeight.w400,
                              size: 15,
                              fontFamily: AppStrings.interSans,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ] else if (widget.isAcceptedService &&
                        !widget.isOngoingService) ...[
                      Positioned(
                        bottom: 30,
                        left: 0,
                        right: 0,
                        child: Container(
                          margin: const EdgeInsets.only(
                              bottom: 50, left: 20, right: 20),
                          child: ButtonView(
                            borderRadius: 30,
                            onPressed: () {
                              markOngoingAccepted(
                                ctx: context,
                                agentId: widget.sellerId,
                                orderId: widget.orderId,
                              );
                            },
                            child: CustomText(
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              text: 'Tag as ongoing service',
                              weight: FontWeight.w400,
                              size: 15,
                              fontFamily: AppStrings.interSans,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ] else if (widget.isAcceptedService &&
                        widget.isOngoingService && !widget.isCompletedService) ...[
                      Positioned(
                        bottom: 30,
                        left: 0,
                        right: 0,
                        child: Container(
                          margin: const EdgeInsets.only(
                              bottom: 50, left: 20, right: 20),
                          child: ButtonView(
                            borderRadius: 30,
                            onPressed: () {
                              markCompletedAccepted(
                                ctx: context,
                                agentId: widget.sellerId,
                                orderId: widget.orderId,
                              );
                            },
                            child: CustomText(
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              text: 'Mark as completed',
                              weight: FontWeight.w400,
                              size: 15,
                              fontFamily: AppStrings.interSans,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ] else if (widget.isAcceptedService &&
                        widget.isOngoingService &&
                        widget.isCompletedService) ...[
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          color: Colors.white,
                          margin: const EdgeInsets.only(
                              bottom: 0, left: 0, right: 0),
                          padding: const EdgeInsets.all(50),
                          child: Column(
                            children: [
                              ButtonView(
                                borderRadius: 30,
                                onPressed: () {},
                                child: CustomText(
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  text: 'Receive Payment',
                                  weight: FontWeight.w400,
                                  size: 15,
                                  fontFamily: AppStrings.interSans,
                                  color: Colors.white,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal:
                                        screenSize(context).width * .05),
                                padding: EdgeInsets.all(15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      child: CustomText(
                                        text: 'Report owner',
                                        color: Colors.red,
                                        size: 12,
                                        weight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              CustomText(
                                text: 'Why service charge?',
                                size: 12,
                                weight: FontWeight.bold,
                                color: Colors.blue,
                              ),

                              const SizedBox(height: 20,),
                              Row(
                                children: [
                                  Icon(Icons.info, size: 20, color: Colors.red.shade300,),
                              const SizedBox(width: 10,),

                                  CustomText(
                                text: 'Note',
                                size: 12,
                                weight: FontWeight.w400,
                                color: Colors.black,
                              ),
                                ],
                              ),
                              const SizedBox(height: 10,),

                              CustomText(
                                text: '• Process would be tagged as completed when buyer receives payment.',
                                size: 12,
                                maxLines: 2,
                                weight: FontWeight.w400,
                                color: Colors.black,
                              ),
                              const SizedBox(height: 10,),

                              CustomText(
                                text: '• Payment would be released for withdrawal immediately user flags service completed.',
                                size: 12,
                                maxLines: 2,
                                weight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]
                  ]
                ],
              ),
      ),
    ));
  }

  checkStatus() {
    if (!widget.isAcceptedService) {
      sessionStatus = 'Awaiting session';
    } else if (widget.isAcceptedService && !widget.isOngoingService) {
      sessionStatus = 'Session is Accepted';
    } else if (widget.isAcceptedService && widget.isOngoingService) {
      sessionStatus = 'Session is ongoing';
    } else if (widget.isAcceptedService &&
        widget.isOngoingService &&
        widget.isCompletedService) {
      sessionStatus = 'Session is completed';
    }

    setState(() {});
  }

  markAccepted({
    required BuildContext ctx,
    required String agentId,
    required String orderId,
  }) {
    ctx
        .read<ServiceProviderCubit>()
        .acceptAgentOrder(agentId: agentId, orderId: orderId);
  }

  markOngoingAccepted({
    required BuildContext ctx,
    required String agentId,
    required String orderId,
  }) {
    ctx
        .read<ServiceProviderCubit>()
        .markOngoingAgentOrder(agentId: agentId, orderId: orderId);
  }

  markCompletedAccepted({
    required BuildContext ctx,
    required String agentId,
    required String orderId,
  }) {
    ctx
        .read<ServiceProviderCubit>()
        .markCompleteAgentOrder(agentId: agentId, orderId: orderId);
  }
}

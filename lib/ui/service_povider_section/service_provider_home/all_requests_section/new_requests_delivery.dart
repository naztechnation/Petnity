import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:petnity/extentions/custom_string_extension.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_images.dart';
import 'package:petnity/ui/support/track_purchase/track_purchase_widgets/ongoing_delivery_widget.dart';
import 'package:petnity/ui/widgets/button_view.dart';
import 'package:petnity/ui/widgets/custom_text.dart';
import 'package:petnity/ui/widgets/image_view.dart';
import 'package:provider/provider.dart';

import '../../../../blocs/service_provider/service_provider_cubit.dart';
import '../../../../model/service_provider_models/all_agent_orders.dart';
import '../../../../model/user_models/agent_services_lists.dart';
import '../../../../model/user_models/order_list.dart';
import '../../../../model/view_models/service_provider_inapp.dart';
import '../../../../model/view_models/user_view_model.dart';
import '../../../../res/enum.dart';
import '../../../../utils/app_utils.dart';
import '../../../../utils/navigator/page_navigator.dart';
import '../../../landing_page/services/track_services/track_services.dart';
import '../../../landing_page/services/track_services/track_vet_services.dart';
import '../../../widgets/modals.dart';
import 'product_shopping_details.dart';
import 'widgets/all_ongoing_page.dart';

class ServiceProviderPetDeliveryHomeBody extends StatefulWidget {
  final ServiceProviderCubit serviceProviderCubit;
  final String agentId;
  ServiceProviderPetDeliveryHomeBody(
      {super.key, required this.serviceProviderCubit, required this.agentId});

  @override
  State<ServiceProviderPetDeliveryHomeBody> createState() =>
      _ServiceProviderPetDeliveryHomeBodyState();
}

class _ServiceProviderPetDeliveryHomeBodyState
    extends State<ServiceProviderPetDeliveryHomeBody>
    with SingleTickerProviderStateMixin {
  requestsType isServices = requestsType.services;

  List<SessionTypes> contacts = [];
  List<SessionTypes> sessions = [];

  int _currentPage = 0;

  changePage(requestsType serve) {
    setState(() {
      isServices = serve;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    final serviceProvider =
        Provider.of<ServiceProviderInAppViewModel>(context, listen: true);

    final userModel = Provider.of<UserViewModel>(context, listen: true);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (serviceProvider.onGoingOrdersList.isNotEmpty)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: 'Ongoing Services',
                weight: FontWeight.bold,
              ),
              GestureDetector(
                onTap: () {
                  AppNavigator.pushAndStackPage(context,
                      page: AllOngoingDeliveryScreen());
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: CustomText(
                    text: 'View all',
                    weight: FontWeight.w400,
                    size: 14,
                    color: AppColors.lightSecondary,
                  ),
                ),
              ),
            ],
          ),
        if (serviceProvider.onGoingOrdersList.isNotEmpty)
          SizedBox(
            height: 10,
          ),
        if (serviceProvider.onGoingOrdersList.isNotEmpty)
          SizedBox(
            height: 300,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: serviceProvider.onGoingOrdersList.length,
                itemBuilder: (context, index) {
                  return OngoingDeliveryWidget(
                    label: 'Track',
                    services: serviceProvider.onGoingOrdersList[index],
                  );
                }),
          ),
        if (serviceProvider.onGoingOrdersList.isNotEmpty)
          SizedBox(
            height: 10,
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
              _buildPageIndicator(serviceProvider.onGoingOrdersList.length),
        ),
        SizedBox(
          height: 20,
        ),
        CustomText(
          text:
              'All new requests (${(isServices.name == 'services' || isServices.name == 'vets') ? serviceProvider.availableServices.length + serviceProvider.vetOrders.length : serviceProvider.order.length})',
          maxLines: 2,
          weight: FontWeight.bold,
          size: 13,
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 1.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    changePage(requestsType.services);
                  });
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: isServices.name == 'services'
                            ? AppColors.lightSecondary
                            : Colors.transparent,
                        width: 5.0,
                      ),
                    ),
                  ),
                  child: Text(
                    'Services',
                    style: TextStyle(
                      color: isServices.name == 'services'
                          ? AppColors.lightSecondary
                          : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    changePage(requestsType.vets);
                  });
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: isServices.name == 'vets'
                            ? AppColors.lightSecondary
                            : Colors.transparent,
                        width: 5.0,
                      ),
                    ),
                  ),
                  child: Text(
                    'Vet Services',
                    style: TextStyle(
                      color: isServices.name == 'vets'
                          ? AppColors.lightSecondary
                          : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  changePage(requestsType.products);
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: isServices.name == 'products'
                            ? AppColors.lightSecondary
                            : Colors.transparent,
                        width: 5.0,
                      ),
                    ),
                  ),
                  child: Text(
                    'Products',
                    style: TextStyle(
                      color: isServices.name == 'products'
                          ? AppColors.lightSecondary
                          : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        if (serviceProvider.availableServices.isEmpty &&
            isServices.name == 'services') ...[
          Container(
              height: 400,
              child: Align(
                  child: Card(
                elevation: 0.5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Container(
                  height: 120,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'Your ongoing and new sessions would appear here',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w300),
                      ),
                    ),
                  ),
                ),
              ))),
        ] else ...[
          Visibility(
            visible: isServices.name == 'services',
            child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: serviceProvider.availableServices.length,
                itemBuilder: ((context, index) {
                  return _newRequestWidget(context,
                      serviceProvider.availableServices[index], userModel);
                })),
          ),
        ],
        if (serviceProvider.availableServices.isEmpty &&
            isServices.name == 'vets') ...[
          Container(
              height: 400,
              child: Align(
                  child: Card(
                elevation: 0.5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Container(
                  height: 120,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'Your ongoing vet sessions would appear here',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w300),
                      ),
                    ),
                  ),
                ),
              ))),
        ] else ...[
          Visibility(
            visible: isServices.name == 'vets',
            child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: serviceProvider.vetOrders.length,
                itemBuilder: ((context, index) {
                  contacts = serviceProvider
                          .vetOrders[index].vetService?.contactMediums ??
                      [];
                  sessions = serviceProvider
                          .vetOrders[index].vetService?.sessionTypes ??
                      [];

                  return _newVetRequestWidget(
                      context, serviceProvider.vetOrders[index], userModel);
                })),
          ),
        ],
        if (serviceProvider.order.isEmpty && isServices.name == 'products') ...[
          Container(
              height: 400,
              child: Align(
                  child: Card(
                elevation: 0.5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Container(
                  height: 120,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'Your available product order would appear here',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w300),
                      ),
                    ),
                  ),
                ),
              ))),
        ] else ...[
          Visibility(
            visible: isServices.name == 'products',
            child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: serviceProvider.order.length,
                itemBuilder: ((context, index) {
                  return _shoppingOrder(context, serviceProvider.order[index]);
                })),
          ),
          if (serviceProvider.pageIndex > 1 && isServices.name == 'products')
            Container(
              color: Colors.transparent,
              padding: const EdgeInsets.only(top: 18),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                    padding: const EdgeInsets.only(bottom: 18.0),
                    child: NumberPaginator(
                      numberPages: serviceProvider.pageIndex,
                      onPageChange: (int index) {
                        serviceProvider.setOrderPageIndex(index + 1);
                        widget.serviceProviderCubit.getAllAgentOrder(
                            agentId: widget.agentId,
                            pageIndex: serviceProvider.currentPage.toString());
                      },
                      config: NumberPaginatorUIConfig(
                        buttonSelectedForegroundColor: AppColors.lightSecondary,
                        buttonUnselectedForegroundColor:
                            AppColors.lightSecondary,
                        buttonUnselectedBackgroundColor: AppColors.lightPrimary,
                        buttonSelectedBackgroundColor: AppColors.lightPrimary,
                      ),
                    )),
              ),
            )
        ],
      ],
    );
  }

  Widget _newRequestWidget(
      BuildContext context, AgentServicesListOrders order, userModel) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: ListTile(
        leading: Container(
          width: 55,
          height: 50,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: ImageView.network(
                order.package?.service?.serviceType?.image,
                fit: BoxFit.cover,
              )),
        ),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text:
                        '${order.profile?.user?.username.toString().capitalizeFirstOfEach}',
                    weight: FontWeight.bold,
                  ),
                  CustomText(
                    text: '${order.package?.service?.serviceType?.name}',
                    size: 12,
                  ),
                ],
              ),
            ),
            CustomText(
              text: order.isPaid! ? 'Paid' : 'Not Paid',
              size: 12,
              color: order.isPaid! ? Colors.green : Colors.red,
              weight: FontWeight.bold,
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 6,
            ),
            CustomText(
              text: 'Pick up time',
              size: 12,
              weight: FontWeight.w600,
            ),
            Row(
              children: [
                ImageView.svg(
                  AppImages.time,
                  height: 16,
                ),
                const SizedBox(
                  width: 6,
                ),
                CustomText(
                  text: userModel.formatDateTimeToAMPM(order.pickupTime),
                  size: 10,
                ),
                const SizedBox(
                  width: 12,
                ),
                ImageView.svg(
                  AppImages.calender,
                  height: 16,
                ),
                const SizedBox(
                  width: 6,
                ),
                Expanded(
                  child: CustomText(
                    text: AppUtils.formatComplexDateOnly(
                        dateTime: order.pickupTime ?? ''),
                    size: 10,
                    maxLines: 2,
                  ),
                ),
              ],
            )
          ],
        ),
        trailing: Container(
          width: screenSize(context).width * .2,
          child: ButtonView(
            onPressed: () {
              // Navigator.push(context, MaterialPageRoute(builder: (_) {
              //   return ServiceRequest();
              // }));

              // if (order.isPaid ?? false) {
              AppNavigator.pushAndStackPage(context,
                  page: TrackServicesScreen(
                    agentName: order.agent?.profile?.user?.username ?? '',
                    phone: order.agent?.profile?.phoneNumber ?? '',
                    serviceOffered:
                        order.package?.service?.serviceType?.name ?? '',
                    agentId: order.agent?.profile?.firebaseId ?? '',
                    sellerId: order.agent?.id.toString() ?? '',
                    startDate1: order.pickupTime ?? '0',
                    startDate2: order.dropoffTime ?? '0',
                    amount: order.fee ?? '',
                    paymentId: order.purchaseId ?? '',
                    sellerImage: order.agent?.picture ?? '',
                    isAcceptedService: order.isAccepted ?? false,
                    isOngoingService: order.isOngoing ?? false,
                    isCompletedService: order.isCompleted ?? false,
                    orderId: order.id.toString(),
                    customerName: order.profile?.user?.username ?? '',
                    customerFireBaseId: order.profile?.firebaseId ?? '',
                    customerImage: order.profile?.profileImage ?? '',
                    customerPhone: order.profile?.phoneNumber ?? '',
                    isRejected: order.isRejected ?? false,
                    isUserMarkedService: order.userMarkedDelivered ?? false,
                    isAgentMarkedService: order.agentMarkedDelivered ?? false,
                  ));
              // }
              // else {
              Modals.showToast('This Service has not been paid for.');
              //  }
            },
            child: Text(
              'view',
              style: TextStyle(color: AppColors.lightSecondary),
            ),
            borderRadius: 100,
            padding: const EdgeInsets.symmetric(vertical: 10),
            color: AppColors.lightSecondary.withOpacity(0.5),
            expanded: false,
            borderColor: Colors.transparent,
          ),
        ),
      ),
    );
  }

  Widget _newVetRequestWidget(
      BuildContext context, AgentServicesListVetOrders order, userModel) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: ListTile(
        leading: Container(
          width: 55,
          height: 50,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: ImageView.network(
                order.profile?.profileImage,
                fit: BoxFit.cover,
              )),
        ),
        title: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: order.profile?.user?.username
                        .toString()
                        .capitalizeFirstOfEach,
                    weight: FontWeight.bold,
                  ),
                  CustomText(
                    text: 'Vet service',
                    size: 12,
                  )
                ],
              ),
            ),
            CustomText(
              text: order.isPaid! ? 'Paid' : 'Not Paid',
              size: 12,
              color: order.isPaid! ? Colors.green : Colors.red,
              weight: FontWeight.bold,
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 6,
            ),
            CustomText(
              text: 'Session time',
              size: 12,
              weight: FontWeight.w600,
            ),
            Row(
              children: [
                ImageView.svg(
                  AppImages.time,
                  height: 16,
                ),
                const SizedBox(
                  width: 6,
                ),
                CustomText(
                  text: userModel.formatDateTimeToAMPM(order.sessionTime),
                  size: 10,
                ),
                const SizedBox(
                  width: 12,
                ),
                ImageView.svg(
                  AppImages.calender,
                  height: 16,
                ),
                const SizedBox(
                  width: 6,
                ),
                Expanded(
                  child: CustomText(
                    text: AppUtils.formatComplexDateOnly(
                        dateTime: order.sessionTime ?? ''),
                    size: 10,
                    maxLines: 2,
                  ),
                ),
              ],
            )
          ],
        ),
        trailing: Container(
          width: screenSize(context).width * .2,
          child: ButtonView(
            onPressed: () {
              // Navigator.push(context, MaterialPageRoute(builder: (_) {
              //   return ServiceRequest();
              // }));

              // if (order.isPaid ?? false) {
              AppNavigator.pushAndStackPage(context,
                  page: TrackVetServicesScreen(
                    agentName: order.agent?.profile?.user?.username ?? '',
                    phone: order.agent?.profile?.phoneNumber ?? '',
                    agentId: order.agent?.profile?.firebaseId ?? '',
                    sellerId: order.agent?.id.toString() ?? '',
                    startDate1: order.sessionTime ?? '0',
                    amount: order.fee ?? '',
                    paymentId: order.purchaseId ?? '',
                    sellerImage: order.agent?.picture ?? '',
                    isAcceptedService: order.isAccepted ?? false,
                    isOngoingService: order.isOngoing ?? false,
                    isCompletedService: order.isCompleted ?? false,
                    orderId: order.id.toString(),
                    customerName: order.profile?.user?.username ?? '',
                    customerFireBaseId: order.profile?.firebaseId ?? '',
                    customerImage: order.profile?.profileImage ?? '',
                    customerPhone: order.profile?.phoneNumber ?? '',
                    isRejected: order.isRejected ?? false,
                    isUserMarkedService: order.userMarkedDelivered ?? false,
                    isAgentMarkedService: order.agentMarkedDelivered ?? false,
                    contactMediums: contacts,
                    sessionMediums: sessions,
                  ));
              // }
              // else {
              Modals.showToast('This Service has not been paid for.');
              //  }
            },
            child: Text(
              'view',
              style: TextStyle(color: AppColors.lightSecondary),
            ),
            borderRadius: 100,
            padding: const EdgeInsets.symmetric(vertical: 10),
            color: AppColors.lightSecondary.withOpacity(0.2),
            expanded: false,
            borderColor: Colors.transparent,
          ),
        ),
      ),
    );
  }

  Widget _shoppingOrder(BuildContext context, ShopOrders order) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: ListTile(
        leading: Container(
          width: 60,
          height: 80,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(60),
              child: ImageView.network(
                order.product?.image,
                fit: BoxFit.cover,
                height: 80,
              )),
        ),
        title: Row(
          children: [
            Expanded(
              child: CustomText(
                text: order.profile?.user?.username
                    .toString()
                    .capitalizeFirstOfEach,
                size: 14,
                weight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                  color: order.isPaid!
                      ? Colors.green.shade100
                      : Colors.red.shade100,
                  borderRadius: BorderRadius.circular(30)),
              child: Container(
                child: CustomText(
                  text: order.isPaid! ? 'Paid' : 'Not Paid',
                  size: 12,
                  color: order.isPaid! ? Colors.green : Colors.red,
                  weight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: CustomText(
                text: 'Purchase ID  ${order.paymentId}',
                size: 12,
                weight: FontWeight.w400,
              ),
            ),
            CustomText(
              text: '${order.product?.name}',
              size: 12,
              weight: FontWeight.w400,
            ),
          ],
        ),
        trailing: Container(
          width: screenSize(context).width * .2,
          child: ButtonView(
            onPressed: () {
              // if (order.isPaid ?? false) {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return PurchaseRequest(
                  agentName: '${order.product?.agent?.name}',
                  customerName: '${order.profile?.user?.username}',
                  productName: '${order.product?.name}',
                  productImage: '${order.product?.image}',
                  quantity: '${order.quantity}',
                  price: '${order.product?.price}',
                  purchaseId: '${order.paymentId}',
                  deliveryDate: today,
                  deliveryLocation: ' ',
                  ownerImage: '${order.profile?.profileImage}',
                  ownerNumber: '${order.profile?.phoneNumber}',
                  ownerFirebaseId: '${order.profile?.firebaseId}',
                  isUserMarkedOrder: order.userMarkedDelivered ?? false,
                  isAgentMarkedOrder: order.agentMarkedDelivered ?? false,
                  orderId: order.product?.id.toString() ?? '',
                  ownerNormalId: order.product?.agent?.id.toString() ?? '',
                );
              }));
              // } else {
              Modals.showToast('This product has not been paid for.');
              // }
            },
            child: Text(
              'view',
              style: TextStyle(color: AppColors.lightSecondary),
            ),
            borderRadius: 100,
            color: AppColors.lightSecondary.withOpacity(0.5),
            padding: const EdgeInsets.symmetric(vertical: 10),
            expanded: false,
            borderColor: Colors.transparent,
          ),
        ),
      ),
    );
  }

  List<Widget> _buildPageIndicator(int length) {
    List<Widget> reverseIndicators = [];
    for (int i = length - 1; i >= 0; i--) {
      reverseIndicators.add(
        Container(
          width: 8.0,
          height: 8.0,
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPage == (length - 1 - i)
                ? AppColors.lightSecondary
                : Colors.grey,
          ),
        ),
      );
    }
    return reverseIndicators;
  }
}

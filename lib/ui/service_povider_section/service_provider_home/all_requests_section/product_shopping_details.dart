import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:petnity/blocs/location/location.dart';
import 'package:petnity/extentions/custom_string_extension.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/res/app_images.dart';
import 'package:petnity/ui/location/widgets/map_view.dart';
import 'package:petnity/ui/widgets/back_button.dart';
import 'package:petnity/ui/widgets/button_view.dart';
import 'package:petnity/ui/widgets/custom_text.dart';
import 'package:provider/provider.dart';

import '../../../../blocs/service_provider/service_provider.dart';
import '../../../../handlers/secure_handler.dart';
import '../../../../model/view_models/account_view_model.dart';
import '../../../../model/view_models/service_provider_inapp.dart';
import '../../../../requests/repositories/location_repo/location_repository_impl.dart';
import '../../../../requests/repositories/service_provider_repo/service_provider_repository_impl.dart';
import '../../../../res/app_routes.dart';
import '../../../../res/app_strings.dart';
import '../../../../utils/app_utils.dart';
import '../../../../utils/navigator/page_navigator.dart';
import '../../../notfications_pages/chat_pages/chat_page.dart';
import '../../../video.dart';
import '../../../widgets/image_view.dart';
import '../../../widgets/loading_page.dart';
import '../../../widgets/modals.dart';

class PurchaseRequest extends StatelessWidget {
  final String customerName;
  final String agentName;
  final String ownerImage;
  final String ownerNumber;
  final String ownerNormalId;
  final String ownerFirebaseId;
  final bool isUserMarkedOrder;
  final bool isAgentMarkedOrder;

  final String productName;
  final String productImage;
  final String quantity;
  final String price;
  final String purchaseId;
  final String orderId;
  final String deliveryDate;
  final String deliveryLocation;

  const PurchaseRequest(
      {super.key,
      required this.customerName,
      required this.productName,
      required this.productImage,
      required this.quantity,
      required this.price,
      required this.purchaseId,
      required this.deliveryDate,
      required this.deliveryLocation,
      required this.ownerImage,
      required this.ownerNumber,
      required this.ownerFirebaseId,
      required this.agentName,
      required this.isUserMarkedOrder,
      required this.isAgentMarkedOrder,
      required this.orderId,
      required this.ownerNormalId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ServiceProviderCubit>(
      create: (BuildContext context) => ServiceProviderCubit(
          serviceProviderRepository: ServiceProviderRepositoryImpl(),
          viewModel: Provider.of<ServiceProviderInAppViewModel>(context,
              listen: false)),
      child: Purchase(
        customerName: customerName,
        productName:productName,
        productImage: productImage,
        quantity: quantity,
        price: price,
        purchaseId: purchaseId,
        deliveryDate: deliveryDate,
        deliveryLocation: deliveryLocation,
        ownerImage: ownerImage,
        ownerNumber: ownerNumber,
        ownerFirebaseId: ownerFirebaseId,
        agentName: agentName,
        isUserMarkedOrder: isUserMarkedOrder,
        isAgentMarkedOrder: isAgentMarkedOrder,
        orderId: orderId,
        ownerNormalId: ownerNormalId,
      ),
    );
  }
}

class Purchase extends StatefulWidget {
  final String customerName;
  final String agentName;
  final String ownerImage;
  final String ownerNumber;
  final String ownerNormalId;
  final String ownerFirebaseId;
  final bool isUserMarkedOrder;
  final bool isAgentMarkedOrder;

  final String productName;
  final String productImage;
  final String quantity;
  final String price;
  final String purchaseId;
  final String orderId;
  final String deliveryDate;
  final String deliveryLocation;

  const Purchase(
      {super.key,
      required this.customerName,
      required this.productName,
      required this.productImage,
      required this.quantity,
      required this.price,
      required this.purchaseId,
      required this.deliveryDate,
      required this.deliveryLocation,
      required this.ownerImage,
      required this.ownerNumber,
      required this.ownerFirebaseId,
      required this.agentName,
      required this.isUserMarkedOrder,
      required this.isAgentMarkedOrder,
      required this.orderId,
      required this.ownerNormalId});

  @override
  State<Purchase> createState() => _PurchaseState();
}

class _PurchaseState extends State<Purchase> {
  String userType = '';
  String username = '';
  String serviceCharge = '';

  late ServiceProviderCubit _serviceProviderCubit;
  bool isLoading = false;

     

  getUserDetails() async {
    _serviceProviderCubit = context.read<ServiceProviderCubit>();

    userType = await StorageHandler.getUserType();
    username = await StorageHandler.getUserName();

    setState(() {});
  }

  @override
  void initState() {
    getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LocationCubit>(
          lazy: false,
          create: (_) => LocationCubit(
              locationRepository: LocationRepositoryImpl(),
              userViewModel:
                  Provider.of<AccountViewModel>(context, listen: false)),
        )
      ],
      child: Scaffold(
        backgroundColor: AppColors.scaffoldColor,
        appBar: PreferredSize(
          preferredSize: screenSize(context) * .1,
          child: Container(
            padding: EdgeInsets.only(top: 20),
            child: AppBar(
              centerTitle: true,
              title: Text(
                'Purchase Request',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: backButton(context),
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
          ),
        ),
        body: BlocProvider<ServiceProviderCubit>(
            lazy: false,
            create: (_) => ServiceProviderCubit(
                serviceProviderRepository: ServiceProviderRepositoryImpl(),
                viewModel: Provider.of<ServiceProviderInAppViewModel>(context,
                    listen: false)),
            child: BlocConsumer<ServiceProviderCubit, ServiceProviderState>(
              listener: (context, state) {
                if (state is AgentDeliveredShopOrderLoaded) {
                  if (state.order.status!) {
                    AppNavigator.pushAndReplaceName(context,
                        name: AppRoutes.serviceProviderLandingPage);
                    Modals.showToast(state.order.message ?? '');
                  } else {
                    Modals.showToast(state.order.message ?? '');
                  }
                } else if (state is DeliveredShopOrderLoaded) {
                  if (state.order.status!) {
                    AppNavigator.pushAndReplaceName(context,
                        name: AppRoutes.landingPage);

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
              builder: (context, state) => (state is AcceptShopOrderLoading)
                  ? LoadingPage()
                  : Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      height: screenSize(context).height * .9,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: (userType == 'user')
                                  ? 'Product Seller Details'
                                  : 'Product Buyer Details',
                              weight: FontWeight.bold,
                            ),
                            Container(
                              width: screenSize(context).width,
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          child: ImageView.network(
                                            widget.ownerImage,
                                            height: 52,
                                            width: 52,
                                            fit: BoxFit.cover,
                                          )),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      Container(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomText(
                                              text: (userType == 'user')
                                                  ? 'Seller name'
                                                  : 'Buyer name',
                                              size: 12,
                                            ),
                                            CustomText(
                                              text: (userType == 'user')
                                                  ? widget.agentName
                                                      .capitalizeFirstOfEach
                                                  : widget.customerName
                                                      .capitalizeFirstOfEach,
                                              weight: FontWeight.bold,
                                              size: 13,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                          onTap: () {
                                            _callNumber(widget.ownerNumber);
                                          },
                                          child: ImageView.svg(
                                              AppImages.callBorder)),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      GestureDetector(
                                          onTap: () {
                                            if (widget.ownerFirebaseId == '') {
                                              Modals.showToast(
                                                  'Can\'t communicate with this agent at the moment. Please');
                                            } else {
                                              AppNavigator.pushAndStackPage(
                                                  context,
                                                  page: ChatPage(
                                                      customerName:
                                                          widget.customerName,
                                                      userImage:
                                                          widget.ownerImage,
                                                      orderId: widget.orderId, agentId: widget.ownerNormalId, agentName: widget.agentName,));
                                            }
                                          },
                                          child: ImageView.svg(
                                              AppImages.messageBorder)),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      GestureDetector(
                                          onTap: () {
                                            AppNavigator.pushAndStackPage(
                                                context,
                                                page: VideoCall(
                                                  customerName: widget.customerName,
                                                  agentName: widget.agentName,
                                                ));
                                          },
                                          child: ImageView.svg(
                                              AppImages.videoBorder)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CustomText(
                                    text: 'Product name',
                                  ),
                                  CustomText(
                                    text: widget.productName,
                                    weight: FontWeight.bold,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Container(
                                  height: 160,
                                  width: 160,
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  decoration:
                                      BoxDecoration(color: Colors.white),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: ImageView.network(
                                      widget.productImage,
                                       height: 160,
                                  width: 160,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Container(
                              width: screenSize(context).width,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: [
                                  CustomText(
                                    text: 'Purchase Review',
                                    weight: FontWeight.bold,
                                    size: 15,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: CustomText(
                                          text: 'Product name',
                                          weight: FontWeight.bold,
                                          maxLines: 2,
                                          size: 13,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(
                                        child: CustomText(
                                          text: widget.productName,
                                          weight: FontWeight.bold,
                                          maxLines: 2,
                                          size: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomText(
                                        text: 'QTY',
                                        weight: FontWeight.bold,
                                        size: 13,
                                      ),
                                      CustomText(
                                        text: widget.quantity,
                                        weight: FontWeight.bold,
                                        size: 13,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomText(
                                        text: 'Price',
                                        weight: FontWeight.bold,
                                        size: 13,
                                      ),
                                      CustomText(
                                        text:
                                            'NGN ${AppUtils.convertPrice(widget.price)}',
                                        weight: FontWeight.bold,
                                        size: 13,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Container(
                              width: screenSize(context).width,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    text: 'Purchase Id',
                                    weight: FontWeight.bold,
                                    size: 13,
                                  ),
                                  CustomText(
                                    text: widget.purchaseId,
                                    weight: FontWeight.bold,
                                    size: 13,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: CustomText(
                                text: 'Delivery due date',
                                size: 13,
                                weight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(20),
                              margin: EdgeInsets.symmetric(
                                  horizontal: screenSize(context).width * .05,
                                  vertical: 10),
                              width: screenSize(context).width,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ImageView.svg(AppImages.calender),
                                  CustomText(
                                    text: widget.deliveryDate,
                                    size: 14,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: screenSize(context).width,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 0,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        text: 'Amount paid -',
                                        weight: FontWeight.w900,
                                        size: 12,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      CustomText(
                                        text:
                                            'NGN ${AppUtils.convertPrice(double.parse(widget.price) * double.parse(widget.quantity))}',
                                        weight: FontWeight.w900,
                                        size: 12,
                                        fontFamily: AppStrings.montserrat,
                                        maxLines: 2,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        text: 'App service charge -',
                                        weight: FontWeight.w900,
                                        size: 12,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      CustomText(
                                        text:
                                            '${AppUtils.convertPrice(double.parse(serviceCharge))}',
                                        weight: FontWeight.w900,
                                        size: 12,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        text: 'Amount withdrawable -',
                                        weight: FontWeight.w900,
                                        size: 12,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      CustomText(
                                        text:
                                            'NGN ${AppUtils.convertPrice(double.parse(widget.price) * double.parse(widget.quantity) - double.parse(serviceCharge))}',
                                        weight: FontWeight.w900,
                                        fontFamily: AppStrings.montserrat,
                                        size: 12,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 14,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 19.0),
                              child: CustomText(
                                text: 'Why service charge?',
                                color: AppColors.lightSecondary,
                                weight: FontWeight.w700,
                                // fontFamily: AppStrings.montserrat,
                                size: 14,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            _map(context),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
            )),
        bottomNavigationBar: Container(
          height: 170,
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              if (userType == 'user') ...[
                if (!widget.isUserMarkedOrder) ...[
                  ButtonView(
                    borderRadius: 30,
                    expanded: false,
                    processing: isLoading,
                    color: Colors.green,
                    onPressed: () {
                      
                      setState(() {});
                      Modals.showAlertOptionDialog(context,
                          title: 'Warning!!!',
                          message:
                              'Are you sure you want to mark this order as delivered? Action cannot be reversed once completed.',
                          onTap: () {
                        userMarkDelivered(
                             
                            username: username,
                            orderId: widget.orderId);
                      });
                    },
                    child: Center(
                      child: CustomText(
                        text: (userType == 'user')
                            ? 'Mark order as Delivered'
                            : '',
                        color: Colors.white,
                        size: 16,
                        weight: FontWeight.w400,
                      ),
                    ),
                  ),
                ] else ...[
                  GestureDetector(
                    onTap: () {},
                    child: Center(
                      child: CustomText(
                        text: 'Product has been delivered',
                        color: AppColors.lightSecondary,
                        size: 14,
                        weight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ] else ...[
                if (!widget.isUserMarkedOrder) ...[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Modals.showToast(
                              'You are yet to deliver the item to the customer.');
                        },
                        child: Center(
                          child: CustomText(
                            text: 'Delivery in progress...',
                            color: AppColors.lightSecondary,
                            size: 14,
                            weight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomText(
                        text:
                            'Please note that this order is still in progress because you have not delivered this product to the user or the user is yet to confirm that the order has been delivered.',
                        color: Colors.red,
                        maxLines: 4,
                        size: 12,
                        weight: FontWeight.w400,
                      ),
                    ],
                  ),
                ] else if (widget.isUserMarkedOrder) ...[
                  ButtonView(
                    borderRadius: 30,
                    expanded: false,
                    color: Colors.green,
                    onPressed: () {
                      BuildContext cont = context;
                      setState(() {});

                      Modals.showAlertOptionDialog(context,
                          title: 'Confirm Order!!!',
                          message:
                              'Please confirm this payment to receive payment directly to your balance.',
                          onTap: () {
                        agentMarkAsDelivered(
                            ctx: cont,
                            agentId: widget.ownerNormalId,
                            orderId: widget.orderId);
                      });
                    },
                    child: Center(
                      child: CustomText(
                        text: 'Confirm order as Delivered',
                        color: Colors.white,
                        size: 16,
                        weight: FontWeight.w400,
                      ),
                    ),
                  ),
                ]
              ],
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _map(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            20,
          ),
          color: Colors.black12,
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                MapViews(
                  zoom: 15,
                ),
                Positioned(
                  left: 0,
                  bottom: 0,
                  child: Container(
                    width: screenSize(context).width * .72,
                    height: screenSize(context).height * .08,
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ImageView.svg(AppImages.location),
                            const SizedBox(
                              width: 10,
                            ),
                            CustomText(
                              text: 'delivery location',
                              size: 12,
                              weight: FontWeight.bold,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            )),
        height: screenSize(context).height * .3,
        width: screenSize(context).width * .8,
      ),
    );
  }

  _callNumber(String number) async {
    bool res = await FlutterPhoneDirectCaller.callNumber(number) ?? false;
  }

  agentMarkAsDelivered({
    required BuildContext ctx,
    required String agentId,
    required String orderId,
  }) {
    _serviceProviderCubit
        .agentDeliveredOrder(agentId: agentId, orderId: orderId);
  }

  userMarkDelivered({
    
    required String username,
    required String orderId,
  }) async{
    setState(() {
      isLoading = true;
    });
   await  _serviceProviderCubit
        .userDeliveredOrder(username: username, orderId: orderId);
         setState(() {
      isLoading = false;
    });
  }
}

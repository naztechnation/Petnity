import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterwave_standard/flutterwave.dart';
import 'package:intl/intl.dart';
import 'package:petnity/blocs/user/user_cubit.dart';
import 'package:petnity/res/enum.dart';
import 'package:petnity/ui/widgets/text_edit_view.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../blocs/user/user_states.dart';
import '../../../handlers/secure_handler.dart';
import '../../../model/view_models/account_view_model.dart';
import '../../../model/view_models/user_view_model.dart';
import '../../../requests/repositories/user_repo/user_repository_impl.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_constants.dart';
import '../../../res/app_strings.dart';
import '../../../utils/app_utils.dart';
import '../../../utils/navigator/page_navigator.dart';
import '../../widgets/back_button.dart';
import '../../widgets/button_view.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/empty_widget.dart';
import '../../widgets/loading_page.dart';
import '../../widgets/modals.dart';
import 'payment_success_screen.dart';

class ReviewScreen extends StatelessWidget {
  final String date1, date2, time1, time2, amount, orderId, username;
  const ReviewScreen(
      {super.key,
      required this.date1,
      required this.date2,
      required this.time1,
      required this.time2,
      required this.amount,
      required this.orderId,
      required this.username});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (BuildContext context) => UserCubit(
          userRepository: UserRepositoryImpl(),
          viewModel: Provider.of<UserViewModel>(context, listen: false)),
      child: Review(
        amount: amount,
        date1: date1,
        date2: date2,
        time1: time1,
        time2: time2,
        orderId: orderId,
        username: username,
      ),
    );
  }
}

class Review extends StatefulWidget {
  final String date1, date2, time1, time2, amount, orderId, username;
  const Review(
      {super.key,
      required this.date1,
      required this.date2,
      required this.time1,
      required this.time2,
      required this.amount,
      required this.orderId,
      required this.username});

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  late UserCubit _userCubit;

  String email = '';

  String transactionId = '';
  String txId = '';
  var uuid = const Uuid();

  getEmail() async {
    email = await StorageHandler.getUserEmail();
  }

  @override
  void initState() {
    getEmail();

    _userCubit = context.read<UserCubit>();

    transactionId = uuid.v1();

    super.initState();
  }

  _handlePaymentInitialization(String orderId) async {
    final Customer customer = Customer(email: email);

    final Flutterwave flutterwave = Flutterwave(
        context: context,
        publicKey: AppStrings.flutterwaveApiKey,
        currency: 'NGN',
        redirectUrl: 'https://petnity.com',
        txRef: uuid.v1(),
        amount: widget.amount,
        customer: customer,
        paymentOptions: "card",
        customization: Customization(
          title: "Petnity",
          //logo: AppImages.logo,
        ),
        isTestMode: true);
    final ChargeResponse response = await flutterwave.charge();

    if (response != null) {
      txId = response.transactionId ?? '';
      if (txId != '') {
        String message = 'Payment Ref: ${response.txRef}';

        _userCubit.confirmPayment(
            orderId: orderId, username: widget.username, purchaseId: txId);
      }
    } else {
      Modals.showToast('Unable to make payment Successfully.',
          messageType: MessageType.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final agent = Provider.of<AccountViewModel>(context, listen: false);

    return Scaffold(
      body: BlocConsumer<UserCubit, UserStates>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is ConfirmPaymentLoading || state is CreateOrderLoading) {
              return LoadingPage();
            } else if (state is UserNetworkErr) {
              return EmptyWidget(
                title: 'Network error',
                description: state.message,
                onRefresh: () => _userCubit.confirmPayment(
                    orderId: widget.orderId,
                    username: widget.username,
                    purchaseId: txId),
              );
            } else if (state is UserNetworkErrApiErr) {
              return EmptyWidget(
                title: 'Network error',
                description: state.message,
                onRefresh: () => _userCubit.confirmPayment(
                    orderId: widget.orderId,
                    username: widget.username,
                    purchaseId: txId),
              );
            } else if (state is CreateOrderNetworkErr) {
              return EmptyWidget(
                  title: 'Network error',
                  description: state.message,
                  onRefresh: () => _userCubit.createOrder(
                      packageId: agent.packageId,
                      username: widget.username,
                      pickupTime: '${widget.date1} ${formatTime(widget.time1)}',
                      dropOffTime:
                          '${widget.date2} ${formatTime(widget.time2)}',
                      pickUpLocation: agent.location));
            } else if (state is CreateOrderNetworkErrApiErr) {
              return EmptyWidget(
                title: 'Network error',
                description: state.message,
                onRefresh: () => _userCubit.createOrder(
                    packageId: agent.packageId,
                    username: widget.username,
                    pickupTime: '${widget.date1} ${formatTime(widget.time1)}',
                    dropOffTime: '${widget.date2} ${formatTime(widget.time2)}',
                    pickUpLocation: agent.location),
              );
            } else if (state is ConfirmPaymentLoaded) {
              Modals.showToast(state.packages.message ?? '');
             Future.delayed(Duration(seconds: 2), (){
               AppNavigator.pushAndReplacePage(context,
                  page: PaymentSuccessScreen(
                    txId: txId,
                  ));
             });
            } else if (state is CreateOrderLoaded) {
              _handlePaymentInitialization(
                  state.createOrder.order!.id.toString());
            }

            return Stack(
              children: [
                Container(
                  height: screenSize(context).height,
                  width: screenSize(context).width,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [AppColors.scaffoldColor, Colors.red.shade50],
                          begin: Alignment.topRight,
                          end: Alignment.topLeft)),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SafeArea(
                            child: SizedBox(
                                height: (Platform.isAndroid) ? 30 : 0)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            backButton(context),
                            CustomText(
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              text: 'Review',
                              weight: FontWeight.w600,
                              size: 18,
                              fontFamily: AppStrings.montserrat,
                              color: Colors.black,
                            ),
                            const SizedBox(
                              width: 40,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              SingleChildScrollView(
                                child: Column(
                                  children: [
                                    TextEditView(
                                      controller: TextEditingController(
                                        text: Provider.of<AccountViewModel>(
                                                context,
                                                listen: false)
                                            .servicePackage,
                                      ),
                                      borderRadius: 30,
                                      readOnly: true,
                                      borderColor: Colors.white,
                                      filled: true,
                                      fillColor: Colors.white,
                                      isDense: true,
                                      textViewTitle: 'Package',
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextEditView(
                                      controller: TextEditingController(
                                        text: Provider.of<AccountViewModel>(
                                                context,
                                                listen: false)
                                            .serviceDuration,
                                      ),
                                      borderRadius: 30,
                                      readOnly: true,
                                      borderColor: Colors.white,
                                      filled: true,
                                      fillColor: Colors.white,
                                      isDense: true,
                                      textViewTitle: 'Duration',
                                      suffixIcon: Container(
                                        width: 130,
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 12.0),
                                          child: CustomText(
                                            textAlign: TextAlign.center,
                                            maxLines: 2,
                                            text:
                                                '₦${AppUtils.convertPrice(Provider.of<AccountViewModel>(context, listen: false).servicePrice)}',
                                            weight: FontWeight.w500,
                                            size: 14,
                                            fontFamily: AppStrings.montserrat,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextEditView(
                                controller: TextEditingController(
                                  text: widget.date1,
                                ),
                                borderRadius: 30,
                                readOnly: true,
                                borderColor: Colors.white,
                                filled: true,
                                fillColor: Colors.white,
                                isDense: true,
                                textViewTitle: 'Pick up date',
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextEditView(
                                controller: TextEditingController(
                                  text: widget.time1,
                                ),
                                borderRadius: 30,
                                readOnly: true,
                                borderColor: Colors.white,
                                filled: true,
                                fillColor: Colors.white,
                                isDense: true,
                                textViewTitle: 'Pick up time',
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextEditView(
                                controller: TextEditingController(
                                  text: widget.date2,
                                ),
                                borderRadius: 30,
                                readOnly: true,
                                borderColor: Colors.white,
                                filled: true,
                                fillColor: Colors.white,
                                isDense: true,
                                textViewTitle: 'Drop off date',
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextEditView(
                                controller: TextEditingController(
                                  text: widget.time2,
                                ),
                                borderRadius: 30,
                                readOnly: true,
                                borderColor: Colors.white,
                                filled: true,
                                fillColor: Colors.white,
                                isDense: true,
                                textViewTitle: 'Drop off time',
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextEditView(
                                controller: TextEditingController(
                                  text: Provider.of<AccountViewModel>(context,
                                          listen: false)
                                      .location,
                                ),
                                borderRadius: 30,
                                readOnly: true,
                                borderColor: Colors.white,
                                filled: true,
                                fillColor: Colors.white,
                                isDense: true,
                                textViewTitle: 'Pick up Location',
                              ),
                              SizedBox(
                                height: 250,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 250,
                    color: Colors.grey.shade100,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          height: 60,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30)),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  text: 'Fee',
                                  weight: FontWeight.w600,
                                  size: 14,
                                  fontFamily: AppStrings.interSans,
                                  color: Colors.black,
                                ),
                                CustomText(
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  text:
                                      '₦${AppUtils.convertPrice(Provider.of<AccountViewModel>(context, listen: false).servicePrice)}',
                                  weight: FontWeight.w600,
                                  size: 14,
                                  color: Colors.black,
                                ),
                              ]),
                        ),
                        const SizedBox(
                          height: 45,
                        ),
                        ButtonView(
                          color: AppColors.lightSecondary,
                          borderColor: Colors.white,
                          borderRadius: 40,
                          onPressed: () {

                            // Modals.showToast('${widget.date1} ${formatTime(widget.time1)}');
                            // Modals.showToast('${widget.date2} ${formatTime(widget.time2)}');

                            _userCubit.createOrder(
                                packageId: agent.packageId,
                                username: widget.username,
                                pickupTime:
                                    '${widget.date1} ${formatTime(widget.time1)}',
                                dropOffTime:
                                    '${widget.date2} ${formatTime(widget.time2)}',
                                pickUpLocation: agent.location);
                          },
                          child: CustomText(
                            textAlign: TextAlign.left,
                            maxLines: 2,
                            text: 'Make payment',
                            weight: FontWeight.w600,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          }),
    );
  }

  String formatTime(String time) {
    // Replace non-breaking spaces with regular spaces
    String inputTime = time.replaceAll(RegExp(r'[\sA-Za-z]'), '');
    print(inputTime);

    return inputTime;
  }
}

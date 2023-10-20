 
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutterwave_standard/flutterwave.dart';
// import 'package:provider/provider.dart';
// import 'package:uuid/uuid.dart';

// import '../../blocs/accounts/account.dart';
// import '../../model/view_models/account_view_model.dart';
// import '../../requests/repositories/account_repo/account_repository_impl.dart';
// import '../../res/app_strings.dart';

// class PricingPageScreen extends StatelessWidget {
//   const PricingPageScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) => BlocProvider<AccountCubit>(
//       create: (BuildContext context) => AccountCubit(
//           accountRepository: AccountRepositoryImpl(),
//           viewModel: Provider.of<AccountViewModel>(context, listen: false)),
//       child: const PricingPage());
// }

// class PricingPage extends StatefulWidget {
//   const PricingPage({super.key});

//   @override
//   State<PricingPage> createState() => _PricingPageState();
// }

// class _PricingPageState extends State<PricingPage> {
//   late AccountCubit _accountCubit;
  
//   String planId = '';

   

  

//   String email = '';
//   String password = '';
//   String teamId = '';
//   String transactionId = '';
//   String txref = '';
//   String txId = '';
//   String message = '';
//   String amount = '';
//   String selectedCurrency = '';
//   String url  = '';
//   bool isCurrencyConverted = false;
//   var uuid = const Uuid();

//   String selectedPlan = '';

//   // List<Datum> plans = [];

//   @override
//   void initState() {
//     transactionId = uuid.v1();
//     _asyncInitMethod();
//     getUserdata();
//     super.initState();
//   }

//   void _asyncInitMethod() {
//     _accountCubit = context.read<AccountCubit>();
//     // _accountCubit.plansList();
//   }

//   // getUserdata() async {
//   //   email = await HelperFunctions.getUserEmailFromSF() ?? '';
//   //   password = await HelperFunctions.getUserPasswordFromSF() ?? '';
//   //   teamId = await HelperFunctions.getUserTeamIdSF() ?? '';

//   //   setState(() {});
//   // }

//   _handlePaymentInitialization({
//     required String info,
//   }) async {
//     final Customer customer = Customer(email: email);

//     final Flutterwave flutterwave = Flutterwave(
//         context: context,
//         publicKey: AppStrings.flutterwaveApiKey,
//         currency: selectedCurrency,
//         redirectUrl: 'https://betslipswitch.com',
//         txRef: transactionId,
//         amount: amount,
//         customer: customer,
//         paymentOptions:
//             "ussd, card, barter, payattitude, account, banktransfer, mpesa, mobilemoneyghana, mobilemoneyfranco, mobilemoneyuganda, mobilemoneyrwanda, mobilemoneyzambia, nqr",
//         customization: Customization(
//           title: "BetSlipSwitch",
//           logo: AppImages.ball,
//         ),
//         isTestMode: true);
//     final ChargeResponse response = await flutterwave.charge();

//     if (response != null) {
//       txId = response.transactionId ?? '';
//       if (txId != '') {
//         message = 'Payment Ref: ${response.txRef}';
//         url = AppStrings.confirmFluttewaveSubscriptionUrl;
//         _accountCubit.subscription(txId, url, planId).then((value) => {
//               if (_accountCubit.viewModel.paymentStatus)
//                 {
//                   AppNavigator.pushAndReplacePage(context,
//                       page: PaymentSuccess(
//                         message: message,
//                         info: info,
//                       )),
//                 }
//             });
//       }
//     } else {
//       Modals.showToast('Unable to make payment Successfully.',
//           messageType: MessageType.error);
//     }
//   }

//   void makePayment({required String email, required String info}) async {
//     int price = int.parse(amount) * 100;
//     Charge charge = Charge()
//       ..amount = price
//       ..reference = transactionId
//       ..email = email
//       ..currency = selectedCurrency;

//     CheckoutResponse response = await plugin.checkout(
//       context,
//       method: CheckoutMethod.card,
//       charge: charge,
//       fullscreen: true,
//       logo: const ImageView.asset(
//         AppImages.ball,
//         width: 80,
//       ),
//     );

//     if (response.status == true) {
//       if (mounted) {}

//       txId = response.reference ?? '';
//       if (txId != '') {
//         message = 'Payment. Ref: ${response.reference}';
//         url = AppStrings.confirmPaystackSubscriptionUrl;
//         _accountCubit.subscription(txId, url, planId).then((value) => {
//               if (_accountCubit.viewModel.paymentStatus)
//                 {
//                   AppNavigator.pushAndReplacePage(context,
//                       page: PaymentSuccess(
//                         message: message,
//                         info: info,
//                       )),
//                 }
//             });
//       }
//     } else {
//       Modals.showToast('Unable to make payment Successfully.',
//           messageType: MessageType.error);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         AppNavigator.pushAndReplacePage(context,
//             page: Dashboard(
//               email: email,
//               password: password,
//               startSeason: '',
//               endSeason: '',
//               leagueId: '',
//               teamId: teamId,
//             ));
//         return false;
//       },
//       child: Scaffold(
//         appBar: AppBar(
//             centerTitle: true,
//             elevation: 5,
//             title: const Text('Unit Pricing'),
//             leading: GestureDetector(
//               onTap: () => AppNavigator.pushAndReplacePage(context,
//                   page: Dashboard(
//                     email: email,
//                     password: password,
//                     startSeason: '',
//                     endSeason: '',
//                     leagueId: '',
//                     teamId: teamId,
//                   )),
//               child: Icon(
//                 Icons.arrow_back,
//                 color: Theme.of(context).colorScheme.secondary,
//                 size: 32,
//               ),
//             ),
//             backgroundColor: Theme.of(context).primaryColor),
//         body: BlocConsumer<AccountCubit, AccountStates>(
//             listener: (context, state) {},
//             builder: (context, state) {
//               if (state is AccountProcessing) {
//                 return Container(
//                     color: Colors.white,
//                     height: AppUtils.deviceScreenSize(context).height,
//                     width: AppUtils.deviceScreenSize(context).width,
//                     child: const LoadingPage(length: 20));
//               } else if (state is SubscriptionProcessing) {
//                 return Container(
//                     color: Colors.white,
//                     height: AppUtils.deviceScreenSize(context).height,
//                     width: AppUtils.deviceScreenSize(context).width,
//                     child: const LoadingPage(length: 20));
//               }  else if (state is SubscriptionNetworkErr) {
//                 // print(txId);
//                 // Modals.showToast(txId);
//                 return EmptyWidget(
//                   title: 'Network error',
//                   description: state.message,
//                   onRefresh: () => _accountCubit.subscription(txId, url, planId).then((value) => {
//                                        Modals.showToast(txId)

//                   }),
//                 );
//               } else if (state is SubscriptionApiErr) {
               
//                 return EmptyWidget(
//                   title: 'Network error',
//                   description: state.message,
//                   onRefresh: () => _accountCubit.subscription(txId, url, planId).then((value) => {
//                   }),
//                 );
//               } else if (state is SubscriptionLoaded) {
//                 _accountCubit.plansList();
//               } else if (state is CurrencyLoaded) {
//                 _accountCubit.plansList();
//                 selectedCurrency = '';
//               } else if (state is AccountNetworkErr) {
//                 return EmptyWidget(
//                   title: 'Network error',
//                   description: state.message,
//                   onRefresh: () => _accountCubit.plansList(),
//                 );
//               } else if (state is AccountApiErr) {
//                 return EmptyWidget(
//                   title: 'Network error',
//                   description: state.message,
//                   onRefresh: () => _accountCubit.plansList(),
//                 );
//               } else if (state is PlansLoaded) {
//                 plans = state.plansList.data ?? [];
//                 return (plans.isEmpty)
//                     ? const Center(child: Text('No Plans Available'))
//                     : ListView.builder(
//                         itemCount: plans.length,
//                         itemBuilder: (BuildContext context, index) {
//                           Datum plan = plans[index];
//                           return Container(
//                             margin: const EdgeInsets.symmetric(horizontal: 25),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: <Widget>[
//                                 const SizedBox(
//                                   height: 20,
//                                 ),
//                                 (index % 2 != 0)
//                                     ? Container(
//                                         margin: const EdgeInsets.symmetric(
//                                             vertical: 10.0),
//                                         padding: const EdgeInsets.all(16.0),
//                                         width:
//                                             AppUtils.deviceScreenSize(context)
//                                                 .width,
//                                         height: 350,
//                                         decoration: BoxDecoration(
//                                           color: Theme.of(context)
//                                               .colorScheme
//                                               .secondary,
//                                           borderRadius:
//                                               BorderRadius.circular(20.0),
//                                         ),
//                                         child: Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           children: <Widget>[
//                                             Text(
//                                               '${plan.name}',
//                                               style: TextStyle(
//                                                 fontSize: 20.0,
//                                                 fontWeight: FontWeight.bold,
//                                                 color: Theme.of(context)
//                                                     .primaryColor,
//                                               ),
//                                             ),
//                                             const SizedBox(
//                                               height: 10.0,
//                                             ),
//                                             Text(
//                                               'NGN ${plan.price} For ${plan.unit} UNIT\'S/month',
//                                               style: const TextStyle(
//                                                 fontSize: 16.0,
//                                                 fontWeight: FontWeight.bold,
//                                                 color: AppColors.red,
//                                               ),
//                                             ),
//                                             const SizedBox(
//                                               height: 10.0,
//                                             ),
//                                             Text(
//                                               '${plan.communities}',
//                                               style: TextStyle(
//                                                 fontSize: 14.0,
//                                                 color: Theme.of(context)
//                                                     .primaryColor,
//                                               ),
//                                             ),
//                                             const SizedBox(
//                                               height: 6.0,
//                                             ),
//                                             Text(
//                                               '${plan.abilities}',
//                                               style: TextStyle(
//                                                 fontSize: 14.0,
//                                                 color: Theme.of(context)
//                                                     .primaryColor,
//                                               ),
//                                             ),
//                                             const SizedBox(
//                                               height: 6.0,
//                                             ),
//                                             Text(
//                                               '${plan.sportsApi}',
//                                               textAlign: TextAlign.center,
//                                               style: TextStyle(
//                                                 fontSize: 14.0,
//                                                 color: Theme.of(context)
//                                                     .primaryColor,
//                                               ),
//                                             ),
//                                             const SizedBox(
//                                               height: 30.0,
//                                             ),
//                                             ButtonView(
//                                                 onPressed: () {
//                                                   setState(() {
//                                                     selectedPlan =
//                                                         plan.name ?? '';
//                                                         planId = plan.id.toString();
//                                                   });
//                                                   Modals.showBottomSheetModal(
//                                                       context,
//                                                       isScrollControlled: false,
//                                                       heightFactor: 1,
//                                                       page: Column(
//                                                           crossAxisAlignment:
//                                                               CrossAxisAlignment
//                                                                   .start,
//                                                           children: [
//                                                             Padding(
//                                                               padding: const EdgeInsets
//                                                                       .symmetric(
//                                                                   horizontal:
//                                                                       18.0,
//                                                                   vertical:
//                                                                       22.0),
//                                                               child: Text(
//                                                                   'To Purchase Units Pay With...',
//                                                                   textAlign:
//                                                                       TextAlign
//                                                                           .center,
//                                                                   style: TextStyle(
//                                                                       fontSize:
//                                                                           18,
//                                                                       fontWeight:
//                                                                           FontWeight
//                                                                               .w700,
//                                                                       color: Theme.of(
//                                                                               context)
//                                                                           .colorScheme
//                                                                           .primary)),
//                                                             ),
//                                                             const Divider(),
//                                                             const SizedBox(
//                                                                 height: 10),
//                                                             GestureDetector(
//                                                               onTap: (() {
//                                                                 Navigator.pop(
//                                                                     context);
//                                                                 // Modals.showToast(
//                                                                 //     'Not available!!!',
//                                                                 //     messageType:
//                                                                 //         MessageType
//                                                                 //             .error);

//                                                                 Modals.showDialogModal(
//                                                                         context,
//                                                                         page: _getCurrency(
//                                                                             'flutterwave'))
//                                                                     .then(
//                                                                         (value) =>
//                                                                             {
//                                                                               //amount = plan.price ?? '',
//                                                                               if (selectedCurrency == '')
//                                                                                 {}
//                                                                               else
//                                                                                 {
//                                                                                   if (selectedCurrency == 'NGN')
//                                                                                     {
//                                                                                       _handlePaymentInitialization(info: plan.unit ?? ''),
//                                                                                     }
//                                                                                   else
//                                                                                     {
//                                                                                       _handlePaymentInitialization(info: plan.unit ?? ''),
//                                                                                     }
//                                                                                 }
//                                                                             });
//                                                               }),
//                                                               child: Container(
//                                                                 color: AppColors
//                                                                     .lightBackground,
//                                                                 padding:
//                                                                     const EdgeInsets
//                                                                             .all(
//                                                                         12.0),
//                                                                 width: MediaQuery.of(
//                                                                         context)
//                                                                     .size
//                                                                     .width,
//                                                                 child: Row(
//                                                                   mainAxisSize:
//                                                                       MainAxisSize
//                                                                           .max,
//                                                                   children: [
//                                                                     const ImageView
//                                                                             .asset(
//                                                                         height:
//                                                                             35,
//                                                                         width:
//                                                                             35,
//                                                                         'assets/images/others/flutterwave.png'),
//                                                                     const SizedBox(
//                                                                         width:
//                                                                             12),
//                                                                     Text(
//                                                                         'Flutterwave',
//                                                                         style: TextStyle(
//                                                                             fontSize:
//                                                                                 18,
//                                                                             fontWeight:
//                                                                                 FontWeight.w700,
//                                                                             color: Theme.of(context).colorScheme.secondary)),
//                                                                   ],
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                             const Divider(),
//                                                             const SizedBox(
//                                                                 height: 5),
//                                                             const Divider(),
//                                                             GestureDetector(
//                                                               onTap: (() {
//                                                                 Navigator.pop(
//                                                                     context);
//                                                                 amount =
//                                                                     plan.price ??
//                                                                         '';
//                                                                 selectedCurrency =
//                                                                     'NGN';
//                                                                 makePayment(
//                                                                     email:
//                                                                         email,
//                                                                     info:
//                                                                         plan.unit ??
//                                                                             '');
//                                                               }),
//                                                               child: Container(
//                                                                 color: AppColors
//                                                                     .lightBackground,
//                                                                 padding:
//                                                                     const EdgeInsets
//                                                                             .all(
//                                                                         12.0),
//                                                                 width: MediaQuery.of(
//                                                                         context)
//                                                                     .size
//                                                                     .width,
//                                                                 child: Row(
//                                                                   children: [
//                                                                     const ImageView
//                                                                             .asset(
//                                                                         height:
//                                                                             35,
//                                                                         width:
//                                                                             35,
//                                                                         'assets/images/others/paystack.png'),
//                                                                     const SizedBox(
//                                                                         width:
//                                                                             12),
//                                                                     Text(
//                                                                         'PayStack',
//                                                                         style: TextStyle(
//                                                                             fontSize:
//                                                                                 18,
//                                                                             fontWeight:
//                                                                                 FontWeight.w700,
//                                                                             color: Theme.of(context).colorScheme.secondary)),
//                                                                   ],
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                            const SizedBox(
//                                                                 height: 5),
//                                                             const Divider(),
//                                                             const SizedBox(
//                                                                 height: 15),

//                                                              Padding(
//                                                               padding: const EdgeInsets
//                                                                       .symmetric(
//                                                                   horizontal:
//                                                                       10.0),
//                                                               child: Text(
//                                                                   'Paystack is available for Nigerians Only, while Flutterwave is available for Nigerians and Other available Countries.',
//                                                                   textAlign: TextAlign.justify,
//                                                                   style: TextStyle(
//                                                                       fontSize:
//                                                                           12,
//                                                                       fontWeight:
//                                                                           FontWeight
//                                                                               .w700,
//                                                                       color: Theme.of(
//                                                                               context)
//                                                                           .colorScheme
//                                                                           .primary)),
//                                                             ),
//  const SizedBox(
//                                                                 height: 45),
//                                                             Row(
//                                                               mainAxisAlignment:
//                                                                   MainAxisAlignment
//                                                                       .center,
//                                                               children: [
//                                                                 Icon(
//                                                                   Icons.lock,
//                                                                   color: Theme.of(
//                                                                           context)
//                                                                       .colorScheme
//                                                                       .primary,
//                                                                   size: 13,
//                                                                 ),
//                                                                 Text(
//                                                                     'Secured Payment',
//                                                                     style: TextStyle(
//                                                                         fontSize:
//                                                                             12,
//                                                                         fontWeight:
//                                                                             FontWeight
//                                                                                 .w700,
//                                                                         color: Theme.of(context)
//                                                                             .colorScheme
//                                                                             .primary)),

                                                                            
//                                                               ],
//                                                             ),
                                                           
                                                            
//                                                           ]));
//                                                 },
//                                                 processing: false,
//                                                 borderRadius: 30,
//                                                 expanded: true,
//                                                 color: Theme.of(context)
//                                                     .primaryColor,
//                                                 child: Text('Buy Unit',
//                                                     textAlign: TextAlign.center,
//                                                     style: TextStyle(
//                                                         fontSize: 18,
//                                                         fontWeight:
//                                                             FontWeight.w700,
//                                                         color: Theme.of(context)
//                                                             .colorScheme
//                                                             .secondary))),
//                                           ],
//                                         ),
//                                       )
//                                     : Container(
//                                         margin: const EdgeInsets.symmetric(
//                                             vertical: 10.0),
//                                         padding: const EdgeInsets.all(16.0),
//                                         decoration: BoxDecoration(
//                                           color: Theme.of(context).primaryColor,
//                                           borderRadius:
//                                               BorderRadius.circular(20.0),
//                                         ),
//                                         width:
//                                             AppUtils.deviceScreenSize(context)
//                                                 .width,
//                                         height: 350,
//                                         child: Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           children: <Widget>[
//                                             Text(
//                                               '${plan.name}',
//                                               style: TextStyle(
//                                                 fontSize: 20.0,
//                                                 fontWeight: FontWeight.bold,
//                                                 color: Theme.of(context)
//                                                     .colorScheme
//                                                     .secondary,
//                                               ),
//                                             ),
//                                             const SizedBox(
//                                               height: 10.0,
//                                             ),
//                                             Text(
//                                               'NGN ${plan.price} For ${plan.unit} UNIT\'S/month',
//                                               style: const TextStyle(
//                                                 fontSize: 16.0,
//                                                 fontWeight: FontWeight.bold,
//                                                 color: AppColors.red,
//                                               ),
//                                             ),
//                                             const SizedBox(
//                                               height: 10.0,
//                                             ),
//                                             Text(
//                                               '${plan.communities}',
//                                               style: TextStyle(
//                                                 fontSize: 14.0,
//                                                 color: Theme.of(context)
//                                                     .colorScheme
//                                                     .secondary,
//                                               ),
//                                             ),
//                                             const SizedBox(
//                                               height: 6.0,
//                                             ),
//                                             Text(
//                                               '${plan.abilities}',
//                                               style: TextStyle(
//                                                 fontSize: 14.0,
//                                                 color: Theme.of(context)
//                                                     .colorScheme
//                                                     .secondary,
//                                               ),
//                                             ),
//                                             const SizedBox(
//                                               height: 6.0,
//                                             ),
//                                             Text(
//                                               '${plan.sportsApi}',
//                                               textAlign: TextAlign.center,
//                                               style: TextStyle(
//                                                 fontSize: 14.0,
//                                                 color: Theme.of(context)
//                                                     .colorScheme
//                                                     .secondary,
//                                               ),
//                                             ),
//                                             const SizedBox(
//                                               height: 50.0,
//                                             ),
//                                             ButtonView(
//                                                 onPressed: () {
//                                                   setState(() {
//                                                     selectedPlan =
//                                                         plan.name ?? '';

//                                                         planId = plan.id.toString();

//                                                   });
//                                                   Modals.showBottomSheetModal(
//                                                       context,
//                                                       isScrollControlled: false,
//                                                       heightFactor: 1,
//                                                       page: Column(
//                                                           crossAxisAlignment:
//                                                               CrossAxisAlignment
//                                                                   .start,
//                                                           children: [
//                                                             Padding(
//                                                               padding: const EdgeInsets
//                                                                       .symmetric(
//                                                                   horizontal:
//                                                                       18.0,
//                                                                   vertical:
//                                                                       22.0),
//                                                               child: Text(
//                                                                   'To Purchase Units Pay With...',
//                                                                   textAlign:
//                                                                       TextAlign
//                                                                           .center,
//                                                                   style: TextStyle(
//                                                                       fontSize:
//                                                                           18,
//                                                                       fontWeight:
//                                                                           FontWeight
//                                                                               .w700,
//                                                                       color: Theme.of(
//                                                                               context)
//                                                                           .colorScheme
//                                                                           .primary)),
//                                                             ),
//                                                             const SizedBox(
//                                                                 height: 5),
//                                                             const Divider(),
//                                                             GestureDetector(
//                                                               onTap: (() {
//                                                                 Navigator.pop(
//                                                                     context);
//                                                                 Modals.showDialogModal(
//                                                                         context,
//                                                                         page: _getCurrency(
//                                                                             'flutterwave'))
//                                                                     .then(
//                                                                         (value) =>
//                                                                             {
//                                                                               //  amount = plan.price ?? '',
//                                                                               if (selectedCurrency == '')
//                                                                                 {}
//                                                                               else
//                                                                                 {
//                                                                                   if (selectedCurrency == 'NGN')
//                                                                                     {
//                                                                                       _handlePaymentInitialization(info: plan.unit ?? ''),
//                                                                                     }
//                                                                                   else
//                                                                                     {
//                                                                                       _handlePaymentInitialization(info: plan.unit ?? ''),
//                                                                                     }
//                                                                                 }
//                                                                             });

//                                                                 // Modals.showToast(
//                                                                 //     'Not available !!!',
//                                                                 //     messageType:
//                                                                 //         MessageType
//                                                                 //             .error);
//                                                                 ;
//                                                               }),
//                                                               child: Container(
//                                                                 color: AppColors
//                                                                     .lightBackground,
//                                                                 padding:
//                                                                     const EdgeInsets
//                                                                             .all(
//                                                                         12.0),
//                                                                 width: MediaQuery.of(
//                                                                         context)
//                                                                     .size
//                                                                     .width,
//                                                                 child: Row(
//                                                                   mainAxisSize:
//                                                                       MainAxisSize
//                                                                           .max,
//                                                                   children: [
//                                                                     const ImageView
//                                                                             .asset(
//                                                                         height:
//                                                                             35,
//                                                                         width:
//                                                                             35,
//                                                                         'assets/images/others/flutterwave.png'),
//                                                                     const SizedBox(
//                                                                         width:
//                                                                             12),
//                                                                     Text(
//                                                                         'Flutterwave',
//                                                                         style: TextStyle(
//                                                                             fontSize:
//                                                                                 18,
//                                                                             fontWeight:
//                                                                                 FontWeight.w700,
//                                                                             color: Theme.of(context).colorScheme.secondary)),
//                                                                   ],
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                             const Divider(),
//                                                             const SizedBox(
//                                                                 height: 5),
//                                                             const Divider(),
//                                                             GestureDetector(
//                                                               onTap: (() {
//                                                                 Navigator.pop(
//                                                                     context);
//                                                                 amount =
//                                                                     plan.price ??
//                                                                         '';
//                                                                 selectedCurrency =
//                                                                     'NGN';
//                                                                 makePayment(
//                                                                     email:
//                                                                         email,
//                                                                     info:
//                                                                         plan.unit ??
//                                                                             '');
//                                                               }),
//                                                               child: Container(
//                                                                 color: AppColors
//                                                                     .lightBackground,
//                                                                 padding:
//                                                                     const EdgeInsets
//                                                                             .all(
//                                                                         12.0),
//                                                                 width: MediaQuery.of(
//                                                                         context)
//                                                                     .size
//                                                                     .width,
//                                                                 child: Row(
//                                                                   children: [
//                                                                     const ImageView
//                                                                             .asset(
//                                                                         height:
//                                                                             35,
//                                                                         width:
//                                                                             35,
//                                                                         'assets/images/others/paystack.png'),
//                                                                     const SizedBox(
//                                                                         width:
//                                                                             12),
//                                                                     Text(
//                                                                         'PayStack',
//                                                                         style: TextStyle(
//                                                                             fontSize:
//                                                                                 18,
//                                                                             fontWeight:
//                                                                                 FontWeight.w700,
//                                                                             color: Theme.of(context).colorScheme.secondary)),
//                                                                   ],
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                             const SizedBox(
//                                                                 height: 5),
//                                                             const Divider(),
//                                                             const SizedBox(
//                                                                 height: 15),
//                                                             Padding(
//                                                               padding: const EdgeInsets
//                                                                       .symmetric(
//                                                                   horizontal:
//                                                                       10.0),
//                                                               child: Text(
//                                                                   'Paystack is available for Nigerians Only, while Flutterwave is available for Nigerians and Other available Countries.',
//                                                                   textAlign: TextAlign.justify,
//                                                                   style: TextStyle(
//                                                                       fontSize:
//                                                                           12,
//                                                                       fontWeight:
//                                                                           FontWeight
//                                                                               .w700,
//                                                                       color: Theme.of(
//                                                                               context)
//                                                                           .colorScheme
//                                                                           .primary)),
//                                                             ),
//                                                             Row(
//                                                               mainAxisAlignment:
//                                                                   MainAxisAlignment
//                                                                       .center,
//                                                               children: [
//                                                                 Icon(
//                                                                   Icons.lock,
//                                                                   color: Theme.of(
//                                                                           context)
//                                                                       .colorScheme
//                                                                       .primary,
//                                                                   size: 13,
//                                                                 ),
//                                                                 Text(
//                                                                     'Secured Payment',
//                                                                     style: TextStyle(
//                                                                         fontSize:
//                                                                             12,
//                                                                         fontWeight:
//                                                                             FontWeight
//                                                                                 .w700,
//                                                                         color: Theme.of(context)
//                                                                             .colorScheme
//                                                                             .primary)),
//                                                                 const SizedBox(
//                                                                   height: 120,
//                                                                 ),
//                                                                 const Divider(),
//                                                               ],
//                                                             ),
//                                                           ]));
//                                                 },
//                                                 processing: false,
//                                                 borderRadius: 30,
//                                                 expanded: true,
//                                                 disabled: false,
//                                                 color: Theme.of(context)
//                                                     .primaryColor,
//                                                 child: Text('Buy Unit',
//                                                     textAlign: TextAlign.center,
//                                                     style: TextStyle(
//                                                         fontSize: 18,
//                                                         fontWeight:
//                                                             FontWeight.w700,
//                                                         color: Theme.of(context)
//                                                             .colorScheme
//                                                             .secondary))),
//                                           ],
//                                         ),
//                                       ),
//                               ],
//                             ),
//                           );
//                         });
//               }

//               return const SizedBox.shrink();
//             }),
//       ),
//     );
//   }

//   Widget _getCurrency(String paymentType) {
//     List<String> currencies = [];
//     if (paymentType == 'flutterwave') {
//       currencies = [
//         "NGN",
//         "AUD",
//         "CAD",
//         "RWF",
//         "XAF",
//         "UGX",
//         "KES",
//         "ZAR",
//         "USD",
//         "GHS",
//         "TZS",
//       ];
//     } else {
//       currencies = [
//         "NGN",
//       ];
//     }
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(18.0),
//           child: Text(
//             'Choose currency to pay with...'.toUpperCase(),
//             textAlign: TextAlign.start,
//             style: TextStyle(
//                 color: Theme.of(context).colorScheme.primary,
//                 fontSize: 19,
//                 fontWeight: FontWeight.w700),
//           ),
//         ),
//         const SizedBox(height: 8),
//         const Divider(height: 1),
//         const SizedBox(height: 8),
//         Expanded(
//           child: ListView(
//             shrinkWrap: true,
//             children: currencies
//                 .map((currency) => ListTile(
//                       onTap: () => {_handleCurrencyTap(currency)},
//                       title: Column(
//                         children: [
//                           Text(
//                             currency,
//                             textAlign: TextAlign.start,
//                             style: TextStyle(
//                                 color: Theme.of(context).colorScheme.secondary,
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.w700),
//                           ),
//                           const SizedBox(height: 4),
//                           const Divider(height: 1)
//                         ],
//                       ),
//                     ))
//                 .toList(),
//           ),
//         ),
//       ],
//     );
//   }

//   _handleCurrencyTap(String currency) {
//     setState(() {
//       selectedCurrency = currency;
//       if (selectedPlan != '') {
//         if (selectedPlan == 'Starter Plan') {
//           amount = firstPricing[selectedCurrency] ?? '';
//         } else if (selectedPlan == 'Regular Plan') {
//           amount = secondPricing[selectedCurrency] ?? '';
//         } else if (selectedPlan == 'Community Leader') {
//           amount = thirdPricing[selectedCurrency] ?? '';
//         }
//       }
//     });
//     Navigator.pop(context);
//   }

//   showLoading(String message) {
//     return Container(
//       margin: const EdgeInsets.fromLTRB(30, 20, 30, 20),
//       width: double.infinity,
//       height: 50,
//       child: Text(message),
//     );
//   }
// }
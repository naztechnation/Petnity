import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petnity/ui/widgets/button_view.dart';
import 'package:provider/provider.dart';

import '../../../../blocs/user/user.dart';
import '../../../../handlers/secure_handler.dart';
import '../../../../model/view_models/account_view_model.dart';
import '../../../../model/view_models/user_view_model.dart';
import '../../../../requests/repositories/user_repo/user_repository_impl.dart';
import '../../../../res/app_colors.dart';
import '../../../../res/app_constants.dart';
import '../../../../res/app_strings.dart';
import '../../../../res/enum.dart'; 
import '../../../widgets/back_button.dart';
import '../../../widgets/custom_text.dart'; 
import 'track_service_body.dart';

class TrackServicesScreen extends StatelessWidget {
  final String sellerName;
  final String sellerImage;
  final String phone;
  final String serviceOffered;
  final String agentId;
  final String sellerId;
  final String startDate1;
  final String startDate2;
  final String amount;
  final String paymentId;
  



  const TrackServicesScreen({required this.sellerName,required this.phone,required this.serviceOffered,
  required this.agentId,required this.sellerId,required this.startDate1,required this.startDate2,required this.amount,required this.paymentId, required this.sellerImage});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (BuildContext context) => UserCubit(
          userRepository: UserRepositoryImpl(),
          viewModel: Provider.of<UserViewModel>(context, listen: false)),
      child: TrackServices(phone: phone, sellerName: sellerName,
       serviceOffered: serviceOffered, agentId: agentId, 
       startDate1: startDate1, startDate2: startDate2,
        amount: amount, paymentId: paymentId, sellerPhoto: sellerImage, sellerId: sellerId,),
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

  final String startDate1;
  final String startDate2;
  final String amount;
  final String paymentId;
  
  const TrackServices({super.key, required this.sellerName,
   required this.phone, required this.serviceOffered,
    required this.agentId, 
    required this.sellerId, 
    required this.startDate1,
     required this.startDate2, required this.amount,
      required this.paymentId, required this.sellerPhoto});

  @override
  State<TrackServices> createState() => _TrackServicesState();
}

class _TrackServicesState extends State<TrackServices> {
  late UserCubit _userCubit;
  String username = '';

  getUsername() async {
    username = await StorageHandler.getUserName();

    _userCubit = context.read<UserCubit>();

    _userCubit.orderList(username: username);
  }

  @override
  void initState() {
    getUsername();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider<UserCubit>(
      lazy: false,
      create: (_) => UserCubit(
          userRepository: UserRepositoryImpl(),
          viewModel: Provider.of<UserViewModel>(context, listen: false)),
      child: BlocConsumer<UserCubit, UserStates>(
        listener: (context, state) {
          if (state is ServicesLoaded) {
            if (state.services.status!) {
              //service = _userCubit.viewModel.services;
            } else {}
          } else if (state is UserNetworkErrApiErr) {
          } else if (state is UserNetworkErr) {}
        },
        builder: (context, state) => Stack(
          children: [
            Container(
              height: screenSize(context).height,
              width: screenSize(context).width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [AppColors.scaffoldColor, Colors.red.shade50],
                      begin: Alignment.topRight,
                      end: Alignment.topLeft)),
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
                          text: Provider.of<AccountViewModel>(context,
                                          listen: false)
                                      .selectedService ==
                                  Services.trainer
                              ? 'Service request'
                              : 'Track service',
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
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                textAlign: TextAlign.left,
                                maxLines: 2,
                                text: 'Service provider details',
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
                        TrackServicesBody(sellerName: widget.sellerName, 
                        phone: widget.phone,
                         agentId: widget.agentId,
                         sellerId: widget.sellerId,
                         startDate1: widget.startDate1, startDate2: widget.startDate2, 
                         amount: widget.amount, paymentId: widget.paymentId, sellerPhoto: widget.sellerPhoto, )
                      ],
                    )),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 30,
              left: 0,
              right: 0,
              child: Container(
                margin: const EdgeInsets.only(bottom: 50, left: 20, right: 20),
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
          ],
        ),
      ),
    ));
  }
}

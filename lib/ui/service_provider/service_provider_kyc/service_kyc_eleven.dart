import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petnity/ui/service_provider/service_provider_kyc/service_kyc_twelve.dart';
import 'package:provider/provider.dart';

import '../../../blocs/accounts/account.dart';
import '../../../model/view_models/service_provider_view_model.dart';
import '../../../model/view_models/account_view_model.dart';
import '../../../requests/repositories/account_repo/account_repository_impl.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_constants.dart';
import '../../../res/app_strings.dart';
import '../../../res/enum.dart';
import '../../../utils/navigator/page_navigator.dart';
import '../../widgets/back_button.dart';
import '../../widgets/button_view.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/image_view.dart';
import '../../widgets/modals.dart';

class KycServiceScreenEleven extends StatefulWidget {
  final String idType;
  KycServiceScreenEleven({
    super.key, required this.idType,
  });

  @override
  State<KycServiceScreenEleven> createState() => _KycServiceScreenElevenState(idType: idType);
}

class _KycServiceScreenElevenState extends State<KycServiceScreenEleven> {

  bool isLoading = false;
  final String idType;

  _KycServiceScreenElevenState({required this.idType});


  @override
  Widget build(BuildContext context) {
    final serviceProvider = Provider.of<ServiceProviderViewModel>(context, listen: true);
    final userDetails = Provider.of<AccountViewModel>(context, listen: true);
    userDetails.getUserId();

    return Scaffold(
        body: Container(
      height: screenSize(context).height,
      width: screenSize(context).width,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [AppColors.scaffoldColor, Colors.red.shade50],
              begin: Alignment.topRight,
              end: Alignment.topLeft)),
      child: BlocProvider<AccountCubit>(
        lazy: false,
        create: (_) => AccountCubit(
            accountRepository: AccountRepositoryImpl(),
            viewModel: Provider.of<AccountViewModel>(context, listen: false)),
        child: BlocConsumer<AccountCubit, AccountStates>(
          listener: (context, state) {
            if (state is AccountLoaded) {
              if (state.userData.status!) {
                AppNavigator.pushAndStackPage(context,
                        page: KycServiceScreenTwelve(

                        ));
                Modals.showToast(state.userData.message ?? '',
                    messageType: MessageType.success);
              } else {
                Modals.showToast(state.userData.message ?? '',
                    messageType: MessageType.success);
              }
            } else if (state is AccountApiErr) {
              if (state.message != null) {
                Modals.showToast(state.message!,
                    messageType: MessageType.error);
              }
            } else if (state is AccountNetworkErr) {
              if (state.message != null) {
                Modals.showToast(state.message!,
                    messageType: MessageType.error);
              }
            }
          },
          builder: (context, state) => GestureDetector(
            onTap: (){
          FocusScope.of(context).requestFocus(FocusNode());
        },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SafeArea(
                      child: SizedBox(height: (Platform.isAndroid) ? 30 : 0)),
                  Row(
                    children: [
                      backButton(context),
                      const SizedBox(
                        width: 40,
                      ),
                      CustomText(
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        text: 'KYC  Registration',
                        weight: FontWeight.w800,
                    size: 16,
                        fontFamily: AppStrings.interSans,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenSize(context).height * 0.11,
                  ),
                  CustomText(
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    text: 'Upload ID picture ',
                    weight: FontWeight.w700,
                    size: 24,
                    fontFamily: AppStrings.montserrat,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  if (serviceProvider.imageURl2 == null) ...[
                    Container(
                      padding: EdgeInsets.all(30),
                      height: 294,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color(0xFF424242),
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      width: MediaQuery.sizeOf(context).width,
                    ),
                  ],
                  if (serviceProvider.imageURl2 != null) ...[
                    Container(
                        height: 294,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color(0xFF424242),
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        width: MediaQuery.sizeOf(context).width,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: ImageView.file(
                              File(
                                serviceProvider.imageURl2!.path,
                              ),
                              fit: BoxFit.cover),
                        )),
                  ],
                  SizedBox(
                    height: 40,
                  ),
                  (state is PetProfileLoading)
                      ? SizedBox.shrink()
                      : TextButton(
                          onPressed: () async {
                            serviceProvider.loadImage(context, UploadType.photoId);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text('Choose from gallery'),
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: Color(0xFFEBF0FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: 70,
                  ),
                  if (serviceProvider.imageURl2 != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0.0, horizontal: 20),
                      child: ButtonView(
                        onPressed: () async{
                          if (serviceProvider.imageURl2 != null) {
                          //      AppNavigator.pushAndStackPage(context,
                          // page: KycServiceScreenTwelve(
          
                          // ));
                             setState(() {
                                isLoading = true;
                              });
                            String imgUrl = await serviceProvider.uploadImage(
                                serviceProvider.imageURl2!.path,
                                'petnity_service_provider');
                                setState(() {
                                isLoading = false;
                              });
                            _submit(ctx: context,agentId: userDetails.serviceProviderId,picture: imgUrl, idType: idType);
                          }
                        },
                        processing: (state is AccountLoading || isLoading),
                        color: AppColors.lightSecondary,
                        borderRadius: 32,
                        borderColor: Colors.white,
                        child: CustomText(
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          text: 'Submit',
                          weight: FontWeight.w400,
                    size: 16,
                          fontFamily: AppStrings.interSans,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }

  _submit(
      {required BuildContext ctx,
      required String agentId,
      required String idType,
     
      required String picture}) {
    ctx.read<AccountCubit>().uploadPhotoUrl(
        agentId: agentId,
        idType: idType,
        
        
        photoUrl: picture);
  }
}

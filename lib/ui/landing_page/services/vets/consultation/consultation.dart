import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/res/app_constants.dart';
import 'package:petnity/ui/widgets/back_button.dart';
import 'package:petnity/ui/widgets/button_view.dart';
import 'package:petnity/utils/navigator/page_navigator.dart';
import 'package:provider/provider.dart';

import '../../../../../blocs/service_provider/service_provider.dart';
import '../../../../../model/user_models/medium_types.dart';
import '../../../../../model/user_models/session_types.dart';
import '../../../../../model/view_models/service_provider_inapp.dart';
import '../../../../../requests/repositories/service_provider_repo/service_provider_repository_impl.dart';
import '../../../../../res/app_images.dart';
import '../../../../../utils/app_utils.dart';
import '../../../../widgets/empty_widget.dart';
import '../../../../widgets/image_view.dart';
import '../../../../widgets/loading_page.dart';
import '../../../../widgets/modals.dart';
import 'add_pice_page.dart';

class Consultation extends StatelessWidget {
  final List<VetSessionTypes> sessionTypesSelectedItems;

  const Consultation({Key? key, required this.sessionTypesSelectedItems})
      : super(key: key);

  @override
  Widget build(BuildContext context) => BlocProvider<ServiceProviderCubit>(
      create: (BuildContext context) => ServiceProviderCubit(
          serviceProviderRepository: ServiceProviderRepositoryImpl(),
          viewModel: Provider.of<ServiceProviderInAppViewModel>(context,
              listen: false)),
      child: ConsultationScreen(
        sessionTypesSelectedItems: sessionTypesSelectedItems,
      ));
}

class ConsultationScreen extends StatefulWidget {
  final List<VetSessionTypes> sessionTypesSelectedItems;

  const ConsultationScreen(
      {super.key, required this.sessionTypesSelectedItems});
  @override
  State<ConsultationScreen> createState() => _ConsultationScreenState();
}

class _ConsultationScreenState extends State<ConsultationScreen> {
  bool showButton = false;

  late ServiceProviderCubit _serviceProviderCubit;

  List<VetContactMediums> mediumType = [];

  getSessionMediums() async {
    _serviceProviderCubit = context.read<ServiceProviderCubit>();
    await _serviceProviderCubit.getMediumType();
  }

  @override
  void initState() {
    getSessionMediums();
    super.initState();
  }

  final List<String> image = [
    AppImages.messageIcon,
    AppImages.phoneIcon,
    AppImages.videoIcon,
  ];

  List<VetContactMediums> contactMediumSelectedItems = [];

  void toggleSelection(VetContactMediums selectedItem) {
    setState(() {
      if (contactMediumSelectedItems.contains(selectedItem)) {
        contactMediumSelectedItems.remove(selectedItem);
      } else {
        contactMediumSelectedItems.add(selectedItem);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(
        leading: backButton(context),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Vets',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: 'InterSans'),
        ),
      ),
      bottomNavigationBar: (contactMediumSelectedItems.isNotEmpty)
          ? Container(
              height: screenSize(context).height * .12,
              padding: EdgeInsets.symmetric(vertical: 23, horizontal: 20),
              child: ButtonView(
                  borderRadius: 50,
                  onPressed: () {
                    AppNavigator.pushAndStackPage(context,
                        page: AddPricePage(
                          sessionTypesSelectedItems:
                              widget.sessionTypesSelectedItems,
                          contactMediumsSelectedItems:
                              contactMediumSelectedItems,
                        ));
                  },
                  child: Text(
                    'Select',
                    style: TextStyle(color: Colors.white),
                  )),
            )
          : SizedBox.shrink(),
      body: BlocConsumer<ServiceProviderCubit, ServiceProviderState>(
          listener: (context, state) {
        if (state is MediumTypeLoaded) {
          mediumType = state.data.data?.vetContactMediums ?? [];
        } else if (state is CreateServiceNetworkErrApiErr) {
          Modals.showToast(state.message ?? '');
        } else if (state is CreateServiceNetworkErr) {
          Modals.showToast(state.message ?? '');
        }
      }, builder: (context, state) {
        if (state is MediumTypeLoading) {
          return const LoadingPage(length: 20);
        } else if (state is CreateServiceNetworkErr) {
          return EmptyWidget(
            title: 'Network error',
            description: state.message,
            onRefresh: () => _serviceProviderCubit.getMediumType(),
          );
        } else if (state is CreateServiceNetworkErrApiErr) {
          return EmptyWidget(
            title: 'Network error',
            description: state.message,
            onRefresh: () => _serviceProviderCubit.getMediumType(),
          );
        } else if (state is MediumTypeLoaded) {
          return (mediumType.isEmpty)
              ? const Center(child: Text('Failed to load contact Medium'))
              : Container(
                  height: screenSize(context).height * .9,
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: screenSize(context).width,
                        child: Text(
                          'Add Contact Medium',
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
                        'Multiple medium can be selected',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'InterSans',
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: mediumType.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final service = mediumType[index];
                            final isSelected =
                                contactMediumSelectedItems.contains(service);

                            return GestureDetector(
                              onTap: () {
                                toggleSelection(service);
                              },
                              child: buildSessionTypeWidget(index, image[index],
                                  mediumType[index].name ?? '', isSelected),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                );
        }

        return SizedBox.shrink();
      }),
    );
  }

  Widget buildSessionTypeWidget(
      int index, String image, String label, bool isSelected) {
    return Card(
      elevation: 1,
      color: isSelected ? AppColors.lightSecondary : Colors.white,
      child: Container(
        height: screenSize(context).height * .07,
        width: screenSize(context).width * .9,
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isSelected ? AppColors.lightSecondary : Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'InterSans'),
            ),
            ImageView.svg(
              image,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/res/app_images.dart';
import 'package:petnity/ui/widgets/button_view.dart';
import 'package:petnity/utils/navigator/page_navigator.dart';
import 'package:provider/provider.dart';

import '../../../../blocs/service_provider/service_provider.dart';
import '../../../../model/user_models/session_types.dart';
import '../../../../model/view_models/service_provider_inapp.dart';
import '../../../../requests/repositories/service_provider_repo/service_provider_repository_impl.dart';
import '../../../widgets/empty_widget.dart';
import '../../../widgets/image_view.dart';
import '../../../widgets/loading_page.dart';
import '../../../widgets/modals.dart';
import 'consultation/consultation.dart';


class VetService extends StatelessWidget {
  const VetService({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>  BlocProvider<ServiceProviderCubit>(
      create: (BuildContext context) => ServiceProviderCubit(
          serviceProviderRepository: ServiceProviderRepositoryImpl(),
          viewModel: Provider.of<ServiceProviderInAppViewModel>(context,
              listen: false)),
      child:    VetServiceScreen());
}
class VetServiceScreen extends StatefulWidget {
  @override
  _VetServiceScreenState createState() => _VetServiceScreenState();
}

class _VetServiceScreenState extends State<VetServiceScreen> {
  bool _isShowingNotification = false;


  late ServiceProviderCubit _serviceProviderCubit;

  List<VetSessionTypes> sessionType = [];

  getSessionTypes() async{

      _serviceProviderCubit = context.read<ServiceProviderCubit>();
    await _serviceProviderCubit.getSessionType(
     
    );

  }


  @override
  void initState() {

   getSessionTypes();
    super.initState();
  }

  final List<String> image = [
    AppImages.consult,
    AppImages.treat,
    AppImages.prescribe,
  ];
   
  List<VetSessionTypes> selectedItems = [];

  void toggleSelection(VetSessionTypes selectedItem) {
    setState(() {
      if (selectedItems.contains(selectedItem)) {
        selectedItems.remove(selectedItem);
      } else {
        selectedItems.add(selectedItem);
      }
    });
  }

  bool showButton = false;

  double screenSize(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  

  @override
  Widget build(BuildContext context) {
    
    return  Scaffold(
      appBar: AppBar(
        title: Text('Vets'),
        centerTitle: true,
      ),
      body: BlocConsumer<ServiceProviderCubit, ServiceProviderState>(
            listener: (context, state) {
             if (state is SessionTypeLoaded) {
              sessionType = state.data.data?.vetSessionTypes ?? [];

             } else if (state is CreateServiceNetworkErrApiErr) {
            Modals.showToast(state.message ?? '');
          
          }else if(state is CreateServiceNetworkErr){
            Modals.showToast(state.message ?? '');

          }
        }, builder: (context, state) {
              if (state is SessionTypeLoading) {
                return const LoadingPage(length: 20);
              }  else if (state is CreateServiceNetworkErr) {
               
                return EmptyWidget(
                  title: 'Network error',
                  description: state.message,
                  onRefresh: () => _serviceProviderCubit
                      .getSessionType()
                     ,
                );
              } else if (state is CreateServiceNetworkErrApiErr) {
                return EmptyWidget(
                  title: 'Network error',
                  description: state.message,
                  onRefresh: () => _serviceProviderCubit
                      .getSessionType()
                     ,
                );
              }  else if (state is SessionTypeLoaded) {
               
                return (sessionType.isEmpty)
                    ? const Center(child: Text('Failed to load sessionTypes'))
                    : Container(
          padding: EdgeInsets.all(20),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Add Session Type',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'InterSans',
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
                    height: 20,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: sessionType.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final service = sessionType[index];
                        final isSelected = selectedItems.contains(service);
        
                        return GestureDetector(
                          onTap: () {
                            toggleSelection(service);
                          },
                          child: buildSessionTypeWidget(
                              index, image[index], sessionType[index].name ?? '', isSelected),
                        );
                      },
                    ),
                  ),
                  const Spacer(),
                  if (selectedItems.isNotEmpty)
                    ButtonView(
                        onPressed: () {
                          AppNavigator.pushAndStackPage(context,
                              page: Consultation(
                                sessionTypesSelectedItems: selectedItems,
                              ));
                        },
                        child: Text(
                          'Continue',
                          style: TextStyle(color: Colors.white),
                        )),
                ],
              ),
              if (_isShowingNotification)
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: screenSize(context) * .15,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(
                        child: Text(
                          'Your pet\'s bio has been sent to Dera',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      Icon(
                        Icons.verified,
                        color: AppColors.lightSecondary,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
  }
  
    return SizedBox.shrink();
  }),
    );}
    
  

  Widget buildSessionTypeWidget(
      int index, String image, String label, bool isSelected) {
    return Card(
      elevation: 1,
      color: isSelected ? AppColors.lightSecondary : Colors.white,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isSelected ? AppColors.lightSecondary : Colors.white,
        ),
        child: Row(
          children: [
            SizedBox(
              width: 10,
            ),
            ImageView.asset(image),
            SizedBox(
              width: 20,
            ),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'InterSans',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

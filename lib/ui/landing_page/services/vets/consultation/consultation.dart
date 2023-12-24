import 'package:flutter/material.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/res/app_constants.dart'; 
import 'package:petnity/ui/widgets/back_button.dart';
import 'package:petnity/ui/widgets/button_view.dart';
import 'package:petnity/utils/navigator/page_navigator.dart';
import 'package:provider/provider.dart';

import '../../../../../model/view_models/service_provider_inapp.dart';
import '../../../../../res/app_images.dart';
import '../../../../widgets/image_view.dart';
import 'add_pice_page.dart'; 

class Consultation extends StatefulWidget {
  @override
  State<Consultation> createState() => _ConsultationState();
}

class _ConsultationState extends State<Consultation> {
   


  bool showButton = false;

  final List<String> image = [
    AppImages.messageIcon,
    AppImages.phoneIcon,
    AppImages.videoIcon,
  ];
  final List<String> item = [
    'Chat',
    'Voice call',
    'Video',
  ];
 
  @override
  Widget build(BuildContext context) {

    final serviceProvider = Provider.of<ServiceProviderInAppViewModel>(context, listen: true);

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
      bottomNavigationBar: (showButton) ? Container(
        height: screenSize(context).height * .12,
        padding: EdgeInsets.symmetric(vertical: 23, horizontal: 20),
        child: ButtonView(
            borderRadius: 50,
            onPressed: () {
              AppNavigator.pushAndStackPage(context, page: AddPricePage());
            },
            child: Text(
              'Select',
              style: TextStyle(color: Colors.white),
            )),
      ) : SizedBox.shrink(),
      body: Container(
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
                'Add medium',
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
                    itemCount: item.length,
                    shrinkWrap: true,
                    itemBuilder: (
                    
                    context, index) {
                    return GestureDetector(
                      onTap: () {
                             serviceProvider.addContactType(index, item, image);
                              
                            

                            if(serviceProvider.contactSelectedIndexes.isEmpty){
                              showButton = false;
                            }else{
                              showButton = true;
                              
                            }
                          },
                      child: buildSessionTypeWidget(
                      index,
                      image[index], 
                      item[index],
                      serviceProvider
                                        ),
                    );
                  },),
                ),
            SizedBox(
              height: 20,
            ),
            
          ],
        ),
      ),
    );
  }

  Widget buildSessionTypeWidget(int index, String image, String label, var services) {
    return Card(
      elevation: 1,
      color: services.contactSelectedIndexes.contains(index)
              ? AppColors.lightSecondary 
              : Colors.white,
      child: Container(
        height: screenSize(context).height * .07,
        width: screenSize(context).width * .9,
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: services.contactSelectedIndexes.contains(index) ? AppColors.lightSecondary : Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                  color: services.contactSelectedIndexes.contains(index) ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'InterSans'),
            ),
            ImageView.svg(
              image,
              color: services.contactSelectedIndexes.contains(index) ? Colors.white : Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}

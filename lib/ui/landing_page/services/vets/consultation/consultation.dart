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
 final List<Map<dynamic, dynamic>> sessionTypesSelectedItems;

  const Consultation({super.key, required this.sessionTypesSelectedItems});
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
  final List<Map<dynamic, dynamic>> item = [
                {
                    "_id": "6597e04e309a4c2018e880d2",
                    "name": "Chat",
                    "__v": 0
                },
                {
                    "_id": "6597e04e309a4c2018e880d2",
                    "name": "Video Call",
                    "__v": 0
                },
                {
                    "_id": "6597e04e309a4c2018e880d2",
                    "name": "Message",
                    "__v": 0
                }
            ];

              List<Map<dynamic, dynamic>> contactMediumSelectedItems = [];

  void toggleSelection(Map<dynamic, dynamic> selectedItem) {
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
    final serviceProvider =
        Provider.of<ServiceProviderInAppViewModel>(context, listen: true);

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
                        page: AddPricePage(sessionTypesSelectedItems: widget.sessionTypesSelectedItems, contactMediumsSelectedItems: contactMediumSelectedItems,));
                  },
                  child: Text(
                    'Select',
                    style: TextStyle(color: Colors.white),
                  )),
            )
          : SizedBox.shrink(),
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
                itemCount: item.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                   final service = item[index];
                      final isSelected = contactMediumSelectedItems.contains(service);

                  return GestureDetector(
                    onTap: () {
                       toggleSelection(service);
                    },
                    child: buildSessionTypeWidget(
                        index, image[index], item[index]['name'], isSelected),
                  );
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSessionTypeWidget(
      int index, String image, String label, bool isSelected) {
    return Card(
      elevation: 1,
      color: isSelected
          ? AppColors.lightSecondary
          : Colors.white,
      child: Container(
        height: screenSize(context).height * .07,
        width: screenSize(context).width * .9,
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isSelected
              ? AppColors.lightSecondary
              : Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                  color: isSelected
                      ? Colors.white
                      : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'InterSans'),
            ),
            ImageView.svg(
              image,
              color: isSelected
                  ? Colors.white
                  : Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}

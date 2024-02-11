import 'package:flutter/material.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/res/app_images.dart';
import 'package:petnity/ui/widgets/button_view.dart';
import 'package:petnity/utils/navigator/page_navigator.dart';
import 'package:provider/provider.dart';

import '../../../../model/view_models/service_provider_inapp.dart';
import '../../../widgets/image_view.dart';
import 'consultation/consultation.dart';

class VetService extends StatefulWidget {
  @override
  _VetServiceState createState() => _VetServiceState();
}

class _VetServiceState extends State<VetService> {
  bool _isShowingNotification = false;

  @override
  void initState() {
    super.initState();
  }

  final List<String> image = [
    AppImages.consult,
    AppImages.treat,
    AppImages.prescribe,
  ];
  final List<Map<dynamic, dynamic>> item = [
    {"_id": "659458e4b45cc82554bd0255", "name": "Consultations", "__v": 0},
    {"_id": "659458eab45cc82554bd0259", "name": "Treatments", "__v": 0},
    {"_id": "659458eab45cc82554bd0259", "name": "Prescription", "__v": 0}
  ];

  List<Map<dynamic, dynamic>> selectedItems = [];

  void toggleSelection(Map<dynamic, dynamic> selectedItem) {
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
    final serviceProvider =
        Provider.of<ServiceProviderInAppViewModel>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: Text('Vets'),
      ),
      body: Container(
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
                    itemCount: item.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final service = item[index];
                      final isSelected = selectedItems.contains(service);

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
      ),
    );
  }

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

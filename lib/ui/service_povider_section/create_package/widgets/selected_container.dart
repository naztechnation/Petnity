

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../model/view_models/service_provider_inapp.dart';
import '../../../../res/app_colors.dart';

class SelectLevelContainer extends StatefulWidget {
  @override
  _MyListState createState() => _MyListState();
}
class _MyListState extends State<SelectLevelContainer> {
  int selectedValue = -1;

  @override
  Widget build(BuildContext context) {
     final serviceProvider =
        Provider.of<ServiceProviderInAppViewModel>(context, listen: true);

    return  Align(
      child: Wrap(
        spacing: 16,
          children: List.generate(5, (index) {
            return GestureDetector(
              onTap: () {
    
                serviceProvider.setPackageLevelSelectedIndex(selectedIndex: selectedValue = index + 1);
                
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                width: 89,
                height: 40,
                decoration: BoxDecoration(
                  color: serviceProvider.selectedIndex == index + 1 ? AppColors.lightSecondary : Colors.white  ,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text(
                    (index + 1).toString(),
                    style: TextStyle(
                      color: serviceProvider.selectedIndex == index + 1 ? Colors.white : Colors.black  ,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            );
          }),
        
      ),
    );
  }
}
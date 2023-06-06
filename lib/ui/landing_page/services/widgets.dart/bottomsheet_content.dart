import 'package:flutter/material.dart';

import '../../../../res/app_colors.dart';
import '../../../../res/app_strings.dart';
import '../../../widgets/custom_multi_toogle.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/dropdown_view.dart';


class BottomSheetContent extends StatefulWidget {
  final List<String> addressSpinnerItems;
  final List<String> age;
  final List<String> gender;
  final  List<String> animals;
  const BottomSheetContent({super.key, required this.addressSpinnerItems, required this.age, required this.gender, required this.animals});

  @override
  State<BottomSheetContent> createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<BottomSheetContent> {
  String _bookieFromDropdownValue = 'State';
  String selectedAge = '';
  String selectedGender = '';
  String selectedAnimal = '';

  @override
  Widget build(BuildContext context) {
    return Container(
    padding: const EdgeInsets.symmetric(vertical:30, horizontal: 16),
    decoration: BoxDecoration(
    color: AppColors.cardColor,
    borderRadius: BorderRadius.horizontal(left: Radius.circular(30), right: Radius.circular(30))
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              textAlign: TextAlign.left,
              maxLines: 2,
              text: 'Filter',
              weight: FontWeight.w900,
              size: 24,
              fontFamily: AppStrings.montserrat,
              color: Colors.black,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: CustomText(
                textAlign: TextAlign.right,
                maxLines: 2,
                text: 'Close',
                weight: FontWeight.w700,
                size: 14,
                fontFamily: AppStrings.interSans,
                color: Colors.red[700],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        CustomText(
          textAlign: TextAlign.start,
          maxLines: 2,
          text: 'Filter by',
          weight: FontWeight.w700,
          size: 14,
          fontFamily: AppStrings.interSans,
          color: Colors.black,
        ),
        const SizedBox(
          height: 15,
        ),
        CustomText(
          textAlign: TextAlign.start,
          maxLines: 2,
          text: 'Location',
          weight: FontWeight.w500,
          size: 14,
          fontFamily: AppStrings.interSans,
          color: Colors.black,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
          child: GestureDetector(
            onTap: () {},
            child: Align(
              alignment: Alignment.center,
              child: DropdownView.form(
                  isExpanded: false,
                  labelText: '',
                  borderColor: Theme.of(context).colorScheme.secondary,
                  fillColor: Colors.white,
                  filled: true,
                  borderRadius: 15.0,
                  borderWidth: 1,
                  isDense: true,
                  value: _bookieFromDropdownValue,
                  items: widget.addressSpinnerItems
                      .map<DropdownMenuItem<String>>((String? value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value ?? ''),
                    );
                  }).toList(),
                  //  validator: Validator.validate,
                  hintText: '',
                  onChanged: (value) {
                    _bookieFromDropdownValue = value ?? 'State';

                    int index = widget.addressSpinnerItems.indexOf(value!);
                  }),
            ),
          ),
        ),
        const SizedBox(height: 10,),
        CustomText(
          textAlign: TextAlign.start,
          maxLines: 2,
          text: 'Age',
          weight: FontWeight.w500,
          size: 14,
          fontFamily: AppStrings.interSans,
          color: Colors.black,
        ),
        CustomMultiToggle(
                title: widget.age,
                fontSize: 11,
                color: AppColors.lightPrimary,
                selectedTextColor: AppColors.lightPrimary,
                height: 35,
                contentMargin: const EdgeInsets.all(5),
                onSelected: (index) {
                  setState(() {
                    selectedAge = widget.age[index];
                  });
                },
              ),
              const SizedBox(height: 10,),
        CustomText(
          textAlign: TextAlign.start,
          maxLines: 2,
          text: 'Gender',
          weight: FontWeight.w500,
          size: 14,
          fontFamily: AppStrings.interSans,
          color: Colors.black,
        ),
        CustomMultiToggle(
                title: widget.gender,
                fontSize: 11,
                color: AppColors.lightPrimary,
                selectedTextColor: AppColors.lightPrimary,
                height: 35,
                contentMargin: const EdgeInsets.all(5),
                onSelected: (index) {
                  setState(() {
                    selectedGender = widget.gender[index];
                  });
                },
              ),
              CustomText(
          textAlign: TextAlign.start,
          maxLines: 2,
          text: 'Animals',
          weight: FontWeight.w500,
          size: 14,
          fontFamily: AppStrings.interSans,
          color: Colors.black,
        ),
        CustomMultiToggle(
                title: widget.animals,
                fontSize: 11,
                color: AppColors.lightPrimary,
                selectedTextColor: AppColors.lightPrimary,
                height: 35,
                contentMargin: const EdgeInsets.all(5),
                onSelected: (index) {
                  setState(() {
                    selectedAnimal = widget.animals[index];
                  });
                },
              ),
      ],
    ),
  );
  }
}



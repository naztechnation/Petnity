
import 'package:flutter/material.dart';

import '../../res/app_colors.dart';
import '../../res/app_images.dart';
import 'image_view.dart';
import 'text_edit_view.dart';

class FilterSearchView extends StatelessWidget {
  final bool showFilter;
  final void Function()? onSearchTap;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;

  final void Function()? onFilterTap;
  final String hintText;
  final Color? fillColor;

  const FilterSearchView(
      {Key? key,
      this.showFilter = true,
      this.controller,
      this.onFilterTap,
      this.fillColor = AppColors.lightPrimary,
      this.hintText = 'Search',
      this.onSearchTap,
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: TextEditView(
            borderColor: Colors.white,
            fillColor: fillColor,
            borderRadius: 30,
            isDense: true,
            controller: controller ?? TextEditingController(text: ''),
            onTap: onSearchTap,
            onChanged: onChanged,
            prefixIcon: const Padding(
              padding: EdgeInsets.all(15.0),
              child: ImageView.svg(
                AppImages.searchIcon,
                
              ),
            ),
            hintText: hintText,
            
          ),
        ),
        if (showFilter) ...[
          const SizedBox(width: 0),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: onFilterTap ,
              child:   Column(
                children: [
          const SizedBox(height: 22),

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(child: ImageView.svg(AppImages.filterIcon, height: 22, width: 23,)),
                ),

                ],
              ),
            ),
          )
        ]
      ],
    );
  }
}

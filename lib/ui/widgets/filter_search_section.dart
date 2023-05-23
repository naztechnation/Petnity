
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
            borderColor: Theme.of(context).primaryColor,
            fillColor: fillColor,
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
          const SizedBox(width: 8),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: onFilterTap ,
              child: Material(
                color: Theme.of(context).primaryColor,
                elevation: 6,
                type: MaterialType.card,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                   child: ImageView.svg(AppImages.filterIcon, height: 35),
                ),
              ),
            ),
          )
        ]
      ],
    );
  }
}

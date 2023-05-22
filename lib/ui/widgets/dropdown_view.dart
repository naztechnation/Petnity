import 'package:flutter/material.dart';

import '../../res/enum.dart';

class DropdownView<T> extends StatelessWidget {
  final T? value;
  final List<DropdownMenuItem<T>>? items;
  final PopupMenuItemBuilder<T>? itemBuilder;
  final ValueChanged<T?> onChanged;
  final bool isExpanded;
  final DropdownType type;
  final FormFieldValidator<T>? validator;
  final double borderRadius;
  final double? borderWidth;
  final Color? borderColor;
  final Color? fillColor;
  final bool isDense;
  final bool filled;
  final String? labelText;
  final String? hintText;
  final Widget? icon;
  final Widget? prefixIcon;

  const DropdownView({Key? key,
    required this.value, required this.items,
    this.isDense=false,
    this.icon=const Icon(Icons.keyboard_arrow_down),
    required this.onChanged, this.isExpanded=true})
      : type=DropdownType.button, validator=null,
        borderRadius=0, borderColor=null, fillColor=null,
        labelText=null, filled=true,
        hintText=null, itemBuilder=null,
        prefixIcon=null, borderWidth=null, super(key: key);

  const DropdownView.form({Key? key,
    required this.value, required this.items,
    required this.onChanged, this.isExpanded=true,
    this.borderRadius=8.0,
    this.borderColor,
    this.fillColor,
    this.isDense=false,
    this.labelText,
    this.hintText,
    this.filled=true,
    this.borderWidth=1.5,
    this.icon=const Icon(Icons.keyboard_arrow_down),
    this.prefixIcon,
    this.validator})
      :  type=DropdownType.form,
        itemBuilder=null, super(key: key);

  const DropdownView.menu({Key? key,
    required this.itemBuilder,
    this.icon=const Icon(Icons.more_vert),
    required this.onChanged})
      :  type=DropdownType.menu, validator=null,
        borderRadius=0, borderColor=null, fillColor=null,
        labelText=null, hintText=null, value=null,
        items=null, isDense=false,
        isExpanded=false, filled=false,
        prefixIcon=null, borderWidth=null, super(key: key);

  OutlineInputBorder _border(BuildContext context) => OutlineInputBorder(
      borderSide: BorderSide(width: borderWidth!,
          color: borderColor ?? Theme.of(context).shadowColor.withOpacity(0.1),
          style: BorderStyle.solid),
      borderRadius: BorderRadius.all(Radius.circular(borderRadius)));

  @override
  Widget build(BuildContext context) {
    if(type==DropdownType.form){
      return Theme(
        data: Theme.of(context).copyWith(
            colorScheme:  ColorScheme.light(
                primary: Theme.of(context).colorScheme.secondary
            )
        ),
        child: DropdownButtonFormField<T>(
            isExpanded: isExpanded,
            value: value,
            icon: icon,
            iconSize: 24,
            elevation: 5,
            decoration: InputDecoration(
                border: _border(context),
                enabledBorder: _border(context),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                    borderSide: BorderSide(width: borderWidth!,
                        color: Theme.of(context).colorScheme.secondary,
                        style: BorderStyle.solid)
                ),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                    borderSide: BorderSide(width: borderWidth!,
                        color: borderColor ?? Theme.of(context).colorScheme.secondary,
                        style: BorderStyle.solid)
                ),
                errorBorder: _border(context),
                disabledBorder: _border(context),
                hintText: hintText,
                labelText: labelText,
                filled: filled,
                isDense: isDense,
                prefixIcon: prefixIcon,
                fillColor: fillColor??Theme.of(context).shadowColor.withOpacity(0.05)),
            style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Theme.of(context).textTheme.bodyText1!.color,
                fontSize: 14),
            validator: validator,
            onChanged: onChanged,
            items: items
        ),
      );
    }else if(type==DropdownType.menu){
      return PopupMenuButton<T>(
          icon: icon,
          elevation: 5,
        onSelected: onChanged,
        itemBuilder: itemBuilder!,
      );
    }
    return DropdownButton<T>(
      isExpanded: isExpanded,
      value: value,
      icon: icon,
      iconSize: 24,
      elevation: 5,
      style: TextStyle(
          fontWeight: FontWeight.w500,
          color: Theme.of(context).textTheme.bodyText1!.color,
          fontSize: 14),
      underline: Container(
        height: 0,
      ),
      onChanged: onChanged,
      items: items
    );
  }
}

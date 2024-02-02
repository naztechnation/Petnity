import 'package:flutter/material.dart';

import '../../res/app_colors.dart';
import 'progress_indicator.dart';

class ButtonView extends StatelessWidget {
  final void Function() onPressed;
  final Widget? child;
  final double fontSize;
  final Gradient? gradient;
  final Color? color;
  final Color? borderColor;
  final String title ;
  
  final double borderWidth;
  final double borderRadius;
  final bool disabled;
  final bool processing;
  final bool expanded;
  final EdgeInsets padding;

  const ButtonView(
      {required this.onPressed,
      required this.child,
      this.fontSize = 16,
      this.gradient,
    this.title = 'Loading...',

      this.color,
      this.borderColor,
      this.borderWidth = 0.0,
      this.disabled = false,
      this.processing = false,
      this.expanded = true,
      this.borderRadius = 16.0,
      this.padding =
          const EdgeInsets.symmetric(vertical: 14.0, horizontal: 8.0),
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (processing) {
      return SizedBox(
        width: double.maxFinite,
        child: ElevatedButton(
          
          onPressed: () {},
          child: Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 15,
                      width: 15,
                      child: ProgressIndicators.circularProgressBar()),
                      const SizedBox(width: 13,),
                  Text(title, style: TextStyle(color: Colors.white),)
                ],
              ),
            ),
          style: ElevatedButton.styleFrom(
            primary: disabled
                ? Theme.of(context).backgroundColor
                : (color ?? AppColors.lightSecondary),
            padding: EdgeInsets.symmetric(vertical: 20),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                side: BorderSide(
                    color: disabled
                        ? Theme.of(context).textTheme.caption!.color!
                        : (borderColor ??
                            AppColors.lightSecondary),
                    width: borderWidth)),
            textStyle: TextStyle(
              color: Theme.of(context).textTheme.bodyText1!.color,
            ),
          ),
        ),
      );
    } else {
      if (expanded) {
        return SizedBox(
          width: double.maxFinite,
          child: ElevatedButton(
            onPressed: disabled ? null : onPressed,
            child: child,
            style: ElevatedButton.styleFrom(
              primary: disabled
                  ? Theme.of(context).backgroundColor
                  : (color ?? AppColors.lightSecondary),
              padding: padding,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                  side: BorderSide(
                      color: disabled
                          ? Theme.of(context).textTheme.caption!.color!
                          : (borderColor ??
                              AppColors.lightSecondary),
                      width: borderWidth)),
              textStyle: TextStyle(
              fontSize: fontSize,
                
                color: Theme.of(context).textTheme.bodyText1!.color,
              ),
            ),
          ),
        );
      } else {
        return ElevatedButton(
          onPressed: disabled ? null : onPressed,
          child: child,
          style: ElevatedButton.styleFrom(
            elevation: 0,
            primary: disabled
                ? Theme.of(context).backgroundColor
                : (color ?? AppColors.lightSecondary),
            padding: padding,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                side: BorderSide(
                    color: disabled
                        ? Theme.of(context).textTheme.caption!.color!
                        : (borderColor ??
                            AppColors.lightSecondary),
                    width: borderWidth)),
            textStyle: TextStyle(
              fontSize: fontSize,
              color: Theme.of(context).textTheme.bodyText1!.color,
            ),
          ),
        );
      }
    }
  }
}

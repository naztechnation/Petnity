import 'package:flutter/material.dart';

import '../../res/app_colors.dart';
import 'image_view.dart';

class QuantityView extends StatefulWidget {
  final int? defaultCount;
  final int minCount;
  final int? maxCount;
  final Function(int, String)? onChange;
  const QuantityView(
      {this.defaultCount,
      this.minCount = 0,
      this.maxCount,
      this.onChange,
      Key? key})
      : super(key: key);

  @override
  State<QuantityView> createState() => _QuantityViewState();
}

class _QuantityViewState extends State<QuantityView> {
  late int _count;
  late String _state;

  void _increment() {
    if (widget.maxCount != null && _count >= widget.maxCount!) {
      return;
    }
    setState(() => _count++);
    if (widget.onChange != null) widget.onChange!(_count, _state = 'increment');
  }

  void _decrement() {
    if (_count <= widget.minCount) {
      return;
    }
    setState(() => _count--);
    if (widget.onChange != null) widget.onChange!(_count, _state = 'decrement');
  }

  @override
  void initState() {
    _count = widget.defaultCount ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 183,
      height: 62,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: AppColors.lightBackground),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        InkWell(
          onTap: _decrement,
          child: const ImageView.svg('AppImages.icRemove', height: 35),
        ),
        const SizedBox(
          width: 28.0,
        ),
        Text('$_count',
            style: TextStyle(
                fontSize: 32,
                color: Theme.of(context).textTheme.bodyText1!.color,
                fontWeight: FontWeight.w700)),
        const SizedBox(
          width: 28.0,
        ),
        InkWell(
          onTap: _increment,
          child: const ImageView.svg('AppImages.icAdd', height: 35),
        ),
      ]),
    );
  }
}

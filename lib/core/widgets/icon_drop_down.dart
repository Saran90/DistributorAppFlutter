import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'drop_down_widget.dart';

class IconDropDown<T> extends StatefulWidget {
  const IconDropDown({
    Key? key,
    required this.icon,
    required this.hint,
    required this.dropDownItems,
    required this.onChanged,
    this.selectedValue,
  }) : super(key: key);

  final String icon;
  final String hint;
  final List<T> dropDownItems;
  final T? selectedValue;
  final Function(T?)? onChanged;

  @override
  State<IconDropDown<T>> createState() => _IconDropDownState<T>();
}

class _IconDropDownState<T> extends State<IconDropDown<T>> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white10,
      ),
      height: 50,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            width: 45,
            child: Image.asset(
              widget.icon,
              height: 14,
              width: 14,
              color: Colors.white,
            ),
          ),
          Container(
            width: 1,
            height: double.infinity,
            color: Colors.white54,
          ),
          Expanded(
            child: DropDownWidget<T>(
              borderColor: Colors.transparent,
              dropDownItems: widget.dropDownItems,
              hint: widget.hint,
              onChanged: widget.onChanged,
              selectedValue: widget.selectedValue,
              fontSize: 12,
              showBorder: false,
            ),
          ),
        ],
      ),
    );
  }
}

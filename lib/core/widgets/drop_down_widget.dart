import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DropDownWidget<T> extends StatelessWidget {
  const DropDownWidget(
      {Key? key,
      required this.dropDownItems,
      required this.borderColor,
      this.hint = '',
      this.fontSize = 14,
      this.onChanged,
      this.selectedValue,
      this.showBorder = false})
      : super(key: key);

  final List<T> dropDownItems;
  final String hint;
  final T? selectedValue;
  final double fontSize;
  final Function(T?)? onChanged;
  final Color borderColor;
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
          color: showBorder ? const Color(0xffF8F8FB) : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
              color: showBorder ? borderColor : Colors.transparent,
              width: showBorder ? 1 : 0)),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButton<T>(
            underline: const SizedBox(),
            isExpanded: true,
            style: GoogleFonts.literata(
                fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),
            hint: Text(
              hint,
              style: GoogleFonts.literata(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
            ),
            iconEnabledColor: Colors.white,
            selectedItemBuilder: (context) => dropDownItems
                .map((T value) => DropdownMenuItem(
                      enabled: true,
                      value: value,
                      child: Text(
                        value.toString(),
                        style: GoogleFonts.literata(
                            color: Colors.white,
                            fontSize: fontSize,
                            fontWeight: FontWeight.w500),
                      ),
                    ))
                .toList(),
            // decoration: InputDecoration(border: InputBorder.none),
            items: dropDownItems
                .map((T value) => DropdownMenuItem(
                      enabled: true,
                      value: value,
                      child: Text(
                        value.toString(),
                        style: GoogleFonts.literata(
                            color: Colors.black87,
                            fontSize: fontSize,
                            fontWeight: FontWeight.w500),
                      ),
                    ))
                .toList(),
            onChanged: onChanged,
            value: selectedValue,
          ),
        ),
      ),
    );
  }
}

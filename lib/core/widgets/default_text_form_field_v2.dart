import 'package:flutter/material.dart';

class DefaultFormFieldV2 extends StatelessWidget {
  String? hintText;
  IconData? prefixIcon;
  IconData? suffixIcon;
  TextEditingController? controller;
  VoidCallback? onTapFunction;
  String? Function(String?)? onFieldSubmitted;
  TextInputType? textInputType;
  bool? showCursorFlag;

  DefaultFormFieldV2(
      {Key? key,
      this.hintText = "Search",
      this.prefixIcon = Icons.search,
      this.suffixIcon,
      this.onTapFunction,
      this.textInputType,
      this.showCursorFlag,
        this.controller,
        this.onFieldSubmitted,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(prefixIcon),
        suffixIcon: Icon(suffixIcon),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none),
        ),
        filled: true,
      ),
      onTap: onTapFunction,
      onFieldSubmitted: onFieldSubmitted,
      keyboardType: textInputType,
      showCursor: showCursorFlag,
    );
  }
}

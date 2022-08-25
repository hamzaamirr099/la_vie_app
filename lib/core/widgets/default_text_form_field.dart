import 'package:flutter/material.dart';

class DefaultTextFormField extends StatelessWidget {

  String? hintText;
  String? Function(String?)? validator;
  TextEditingController? controller;
  VoidCallback? onTapFunction;
  TextInputType? keyboardType;
  IconData? prefixIcon;
  IconData? suffixIcon;
  Widget? suffixWidget;
  String? Function(String?)? onFieldSubmitted;

  DefaultTextFormField({
    Key? key,
    this.hintText,
    this.controller,
    this.keyboardType,
    this.onTapFunction,
    this.suffixIcon,
    this.prefixIcon,
    this.suffixWidget,
    this.validator,
    this.onFieldSubmitted,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      validator: validator,
      onTap: onTapFunction,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        suffixIconConstraints: const BoxConstraints(maxWidth: 10),
        contentPadding: const EdgeInsets.all(5.0),
        prefixIconConstraints: const BoxConstraints(maxWidth: 20.0),
        prefixIcon: Icon(prefixIcon,),
        suffixIcon: Icon(suffixIcon,),
        suffix: suffixWidget,
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0),),

      ),
      textAlignVertical: TextAlignVertical.center,
    );
  }
}

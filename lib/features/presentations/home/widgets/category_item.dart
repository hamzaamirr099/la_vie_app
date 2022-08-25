import 'package:flutter/material.dart';

import '../../../../core/shared/constants.dart';

class CategoryItem extends StatelessWidget {
  final String labelText;
  VoidCallback? onTapFunction;

  CategoryItem(
      {Key? key, required this.labelText, this.onTapFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: mainGreyColor,
      ),
      child: MaterialButton(
        onPressed: onTapFunction,
        child: Text(
          labelText,
          style: const TextStyle(color: Colors.grey, fontSize: 15),
        ),
      ),
    );
  }
}

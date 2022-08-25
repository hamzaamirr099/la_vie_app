import 'package:flutter/material.dart';
import '../shared/constants.dart';

class DefaultButton extends StatelessWidget {
  final Widget childWidget;
  IconData? buttonIcon;
  Color? backgrounColor;
  final VoidCallback onPressed;
  double? height;
  double? width;
  double? borderRadius;

  DefaultButton({
    Key? key,
    required this.childWidget,
    this.backgrounColor = mainGreenColor,
    required this.onPressed,
    this.height = 40,
    this.width = double.infinity,
    this.borderRadius = 5.0,
    this.buttonIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgrounColor,
        borderRadius: BorderRadius.circular(borderRadius!),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: childWidget,
      ),
    );
  }
}

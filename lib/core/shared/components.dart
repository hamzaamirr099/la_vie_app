import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'constants.dart';

void showToastMessage({required String message, Color? toastColor = mainGreenColor})
{
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: toastColor,
      textColor: Colors.white,
      fontSize: 16.0
  );


}

void navigateAndRelease(context, Widget screen)
{
  Navigator. pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (BuildContext context) => screen,
    ),
        (route) => false,
  );
}

Widget buildNoInternetWidget() {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: mainGreenColor,
      title: const Text("No internet connection"),
    ),
  );
}
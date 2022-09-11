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

void showDialogMessage(
    {
      required BuildContext context,
      VoidCallback? firstChoiceFunction,
      VoidCallback? secondChoiceFunction,
      required String title,
      required String body,
      String? firstActionName,
      String? secondActionName,

    }) {
  showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(
            title,
            textAlign: TextAlign.center,

          ),
          content: Text(body, textAlign: TextAlign.center,),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: firstChoiceFunction,
                    child: Text(firstActionName ?? ""),
                  ),
                ),

                Expanded(
                  child: TextButton(
                    onPressed: secondChoiceFunction,
                    child: Text(secondActionName ?? ""),
                  ),
                ),
              ],
            ),
          ],
        );
      });
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
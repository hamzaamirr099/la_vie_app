import 'package:flutter/material.dart';

String baseUrl = "https://lavie.orangedigitalcenteregypt.com";

String userToken = ''; //to deal with it when the application starts

const MaterialColor mainGreenColor = MaterialColor(
  0xff1ABC00, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
  <int, Color>{
    50:  Color(0xff1ABC00 ),//10%
    100: Color(0xff1ABC00),//20%
    200: Color(0xff1ABC00),//30%
    300: Color(0xff1ABC00),//40%
    400: Color(0xff1ABC00),//50%
    500: Color(0xff1ABC00),//60%
    600: Color(0xff1ABC00),//70%
    700: Color(0xff1ABC00),//80%
    800: Color(0xff1ABC00),//90%
    900: Color(0xff1ABC00),//100%
  },
);

const Color mainGreyColor = Color.fromRGBO(248, 248, 248, 1);
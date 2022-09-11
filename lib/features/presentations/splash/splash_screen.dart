import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/shared/constants.dart';
import '../authorization/screens/authorization_screen.dart';
import '../main_app_layout/main_layout_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splash: Center(child: SvgPicture.asset("assets/images/logo.svg"),),
        nextScreen: userToken == ''? const AuthorizationScreen() : const MainLayout(),
      animationDuration: const Duration(seconds: 2),
      splashTransition: SplashTransition.slideTransition,
      curve: Curves.easeInBack,
    );
  }
}

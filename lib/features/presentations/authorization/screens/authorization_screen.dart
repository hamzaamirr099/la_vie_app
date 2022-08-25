import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:la_vie/features/presentations/authorization/authorization_states.dart';
import 'package:la_vie/features/presentations/authorization/widgets/login_form.dart';
import 'package:la_vie/features/presentations/authorization/widgets/sign_up_form.dart';
import '../authorization_cubit.dart';

class AuthorizationScreen extends StatelessWidget {
  const AuthorizationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthorizationCubit(),

      child: BlocConsumer<AuthorizationCubit, AuthorizationStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const Spacer(),
                      SvgPicture.asset("assets/images/cornerLeaves.svg"),
                    ],
                  ),
                  SvgPicture.asset("assets/images/logoMinimized.svg"),
                  const SizedBox(height: 30.0),
                  const TabBar(
                      indicatorSize: TabBarIndicatorSize.label,
                      tabs: [
                        Tab(
                          text: "Sign up",
                        ),
                        Tab(
                          text: "Login",
                        ),

                      ]
                  ),
                  const SizedBox(height: 30.0,),
                  Expanded(
                    child: TabBarView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        SignUpForm(),
                        LoginForm(),
                      ],
                    ),
                  ),

                  Row(
                    children: [
                      RotationTransition(
                        turns: const AlwaysStoppedAnimation(180/360),
                        child: SvgPicture.asset("assets/images/cornerLeaves.svg", fit: BoxFit.fill),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:la_vie/core/shared/constants.dart';
import 'package:la_vie/core/utils/network/local/cach_helper.dart';
import 'package:la_vie/core/widgets/default_text_form_field.dart';
import 'package:la_vie/features/presentations/authorization/authorization_states.dart';
import 'package:la_vie/features/presentations/home/screens/home_screen.dart';
import 'package:la_vie/features/presentations/main_app_layout/main_layout_screen.dart';
import '../../../../core/shared/components.dart';
import '../../../../core/widgets/default_button.dart';
import '../authorization_cubit.dart';

class LoginForm extends StatelessWidget {
  LoginForm({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var cubit = AuthorizationCubit.get(context);
    return BlocConsumer<AuthorizationCubit, AuthorizationStates>(
      listener: (context, state) async {
        if(state is SuccessLoginState)
        {

          // //save token in the global variable
          userToken = state.authorizationDataModel.data!.accessToken!;

          await CacheHelper.saveData(key: 'userToken', value: userToken);
          await CacheHelper.saveData(key: 'userId', value: state.authorizationDataModel.data!.user!.userId);
          navigateAndRelease(context, const MainLayout()); //need to navigate and release here

          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => HomeScreen()),
          // );
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 45.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Email"),
                  const SizedBox(
                      height: 3.8
                  ),
                  DefaultTextFormField(
                    validator: (value)
                    {
                      if(value == null || value.isEmpty) {
                        return 'Please enter email';
                      }

                    },
                    controller: cubit.loginEmailController,
                  ),
                  const SizedBox(
                      height: 30.96
                  ),
                  const Text("Password"),
                  const SizedBox(
                      height: 3.8
                  ),
                  DefaultTextFormField(
                    validator: (value)
                    {
                      if(value == null || value.isEmpty) {
                        return 'Please enter password';
                      }

                    },
                    controller: cubit.loginPasswordController,
                  ),
                  const SizedBox(
                      height: 36.37
                  ),
                  ConditionalBuilder(
                      condition: state is! LoadingState,
                      builder: (context) => DefaultButton(
                        childWidget: const Text("Login", style: TextStyle(color: Colors.white),),
                        onPressed: ()
                        {
                          print("pressed");
                          if(formKey.currentState!.validate())
                            {
                              cubit.login(cubit.loginEmailController.text, cubit.loginPasswordController.text);
                            }
                        },
                      ),
                      fallback: (context) => const Center(child: CircularProgressIndicator()),
                  ),

                  const SizedBox(height: 36.37,),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1.0,
                          color: const Color.fromRGBO(151, 151, 151, 1),
                        ),
                      ),
                      const Text(
                        "  Or continue with  ",
                        style: TextStyle(color: Color.fromRGBO(151, 151, 151, 1)),
                      ),
                      Expanded(
                        child: Container(
                          height: 1.0,
                          color: const Color.fromRGBO(151, 151, 151, 1),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24.15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: SvgPicture.asset(
                          'assets/images/google.svg',
                        ),
                        onPressed: (){}, //do something,
                      ),
                      IconButton(
                        icon: SvgPicture.asset(
                          'assets/images/facebook.svg',
                        ),
                        onPressed: (){}, //do something,
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
